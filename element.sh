#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

GET_RES() {
  if [[ -z $1 ]]
  then
    echo "I could not find that element in the database."
  else
    IFS="|" read -r an sym name type am mp bp <<< $1
    echo "The element with atomic number $an is $name ($sym). It's a $type, with a mass of $am amu. $name has a melting point of $mp celsius and a boiling point of $bp celsius."
  fi
}

if [[ $1 ]]
then
  if [[ "$1" =~ ^[0-9]+$ ]]
  then
    ELEMENTS=$($PSQL "select atomic_number,symbol,name,type,atomic_mass,melting_point_celsius,boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) WHERE atomic_number = $1")
    GET_RES $ELEMENTS
  else
    ELEMENTS=$($PSQL "select atomic_number,symbol,name,type,atomic_mass,melting_point_celsius,boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) WHERE symbol = '$1' OR name = '$1'")
    GET_RES $ELEMENTS
  fi
  
else
  echo "Please provide an element as an argument."
fi
