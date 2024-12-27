#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

GEN_NUM=$((RANDOM % 100))
NUM_OF_GUESSES=0
echo "Enter your username:"
read USERNAME

START_GAME() {
  CURRENT_USER=$($PSQL "select * from users where username='$USERNAME'")

  if [[ -z $CURRENT_USER ]]
  then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    INSERT_USER_RESULT=$($PSQL "insert into users(username,games_played, best_game) values('$USERNAME',0,100)")
  else
    IFS="|" read -r uID uName gPlayd bestG <<< $CURRENT_USER
    echo "Welcome back, $uName! You have played $gPlayd games, and your best game took $bestG guesses."
  fi
  GUESS_NUMBER
}

GUESS_NUMBER() {
  if [[ $1 ]]
  then
    echo -e "$1\n"
  else
    echo -e "\nGuess the secret number between 1 and 1000:\n"
  fi
  read GUESSED

  if [[ $GUESSED =~ ^[0-9]+$ ]]
  then
    ((NUM_OF_GUESSES++))
    if [[ $GUESSED -gt $GEN_NUM ]]
    then
      GUESS_NUMBER "It's lower than that, guess again:"
    elif [[ $GUESSED -lt $GEN_NUM ]]
    then
      GUESS_NUMBER "It's higher than that, guess again:"
    else
      FIN_RESULT=$($PSQL "update users set 
      best_game = case when best_game > $NUM_OF_GUESSES then $NUM_OF_GUESSES else best_game end,
       games_played = games_played+1 where username='$USERNAME'")
      echo "You guessed it in $NUM_OF_GUESSES tries. The secret number was $GEN_NUM. Nice job!"
    fi
  else
    GUESS_NUMBER "That is not an integer, guess again:"
  fi 

  
}

START_GAME
