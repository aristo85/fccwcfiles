#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "truncate teams,games")

cat games.csv | while IFS="," read Y R W O WG OG
do
  if [[ $W != "winner" ]]
  then
    #get winner ID
    WID=$($PSQL "select team_id from teams where name='$W'")
    #get opponent ID
    OID=$($PSQL "select team_id from teams where name='$O'")
    #if winner not found
    if [[ -z $WID ]]
    then
      #insert new team
      INSERTED_W_TEAM=$($PSQL "insert into teams(name) values('$W')")
    fi
    #if opponent not found
    if [[ -z $OID ]]
    then
      #insert new team
      INSERTED_O_TEAM=$($PSQL "insert into teams(name) values('$O')")
    fi
    #get winner ID
    GET_WID=$($PSQL "select team_id from teams where name='$W'")
    #get opponent ID
    GET_OID=$($PSQL "select team_id from teams where name='$O'")
    if [[ $GET_WID && $GET_OID ]]
    then
      INSERTED_GAME=$($PSQL "insert into games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) values($Y, '$R', $GET_WID, $GET_OID, $WG, $OG)")
      echo $INSERTED_GAME
    fi
  fi
  
done
