#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess -t --no-align -c"

# START OF SCRIPT
# prompt user for input

echo -e "\nEnter your username:"
read USERNAME

# if username then check database
GET_USER=$($PSQL "SELECT username FROM players WHERE username = '$USERNAME'")
    # if no user
    if [[ -z $GET_USER ]]
    then
    # add user to database
    ADD_USER=$($PSQL "INSERT INTO players (username) VALUES ('$USERNAME')")
    # if successful print confirmation
      if [[ $ADD_USER == "INSERT 0 1" ]] 
      then
      echo "Welcome, $USERNAME! It looks like this is your first time here."
      fi
      else
      # get number of games played and best guess information
      GET_GAMES=$($PSQL "SELECT p.username, p.games_played, 
                          (SELECT MIN(g.guesses) FROM games g WHERE g.user_id = p.user_id)
                 FROM players p
                 WHERE p.username = '$USERNAME'")
      
      while IFS="|" read -r username games_played guesses; do
      # print welcome
      echo "Welcome back, $username! You have played $games_played games, and your best game took $guesses guesses."
      done <<< $GET_GAMES
    fi


## START OF GAME
GAME_RANDOM_NUMBER=$(( $RANDOM % 1000 + 1 ))
GUESS=0
NUM_GUESSES=1

  echo "Guess the secret number between 1 and 1000:"
  read GUESS

  while [ "$GUESS" -ne "$GAME_RANDOM_NUMBER" ] 
  do
  # increment count
  (( NUM_GUESSES++ ))
  # if guess is not a number
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
  echo "That is not an integer, guess again:"
  else
    # if GUESS is lower than random number
    if [ "$GUESS" -lt "$GAME_RANDOM_NUMBER" ]; then
    echo "It's higher than that, guess again:"
    # echo and read
    else
    echo "It's lower than that, guess again:"
    # echo and read
    fi
  fi
  read GUESS
  done
  
  # get user_id
  USER_ID=$($PSQL "SELECT user_id FROM players WHERE username = '$USERNAME'")
  # add guesses to DB
  ADD_NUM_GUESSES_TO_DB=$($PSQL "INSERT INTO games (user_id, guesses) VALUES($USER_ID, $NUM_GUESSES)")
  if [[ $ADD_NUM_GUESSES_TO_DB == "INSERT 0 1" ]]
  then
  echo "Added $NUM_GUESSES to your scoreboard"
  else 
  echo "I tried adding to the db but did not work"
  fi
  # increment games
  INCREMENT_GAMES_TOTAL=$($PSQL "UPDATE players SET games_played = games_played + 1 WHERE user_id = $USER_ID")

  #winning message
  echo "You guessed it in $NUM_GUESSES tries. The secret number was $GAME_RANDOM_NUMBER. Nice job!"

