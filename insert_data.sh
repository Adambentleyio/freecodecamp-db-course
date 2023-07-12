#!/bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

$PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY;"

echo "Starting insert script"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do 
  # INSERT TEAMS INTO TEAMS TABLE
    # get all winners 
    if [[ $WINNER != "winner" ]]
      then
      ## find existing team name in teams table
      TEAM_NAME=$($PSQL "SELECT name FROM teams WHERE name = '$WINNER'")
        if [[ -z $TEAM_NAME ]] 
          then 
            INSERT_WINNER_ID=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
            if [[ $INSERT_WINNER_ID == "INSERT 0 1" ]]
              then
                echo "Inserted team: $WINNER into teams table"
            fi
        fi
    fi
    # get all opponents
    if [[ $OPPONENT != "opponent" ]]
      then
      ## find existing team name in teams table
      TEAM_NAME=$($PSQL "SELECT name FROM teams WHERE name = '$OPPONENT'")
        if [[ -z $TEAM_NAME ]] 
          then 
            INSERT_OPPONENT_ID=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
            if [[ $INSERT_OPPONENT_ID == "INSERT 0 1" ]]
              then
                echo "Inserted team: $OPPONENT into teams table"
            fi
        fi
    fi
  done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    # INSERT GAMES INFO INTO GAMES TABLE
    # get winner and opponent id
    if [[ $WINNER != "winner" ]]
      then
        MATCH_WINNER=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
        MATCH_OPPONENT=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
        if [[ -z $MATCH_WINNER || -z $MATCH_OPPONENT ]]
          then
            echo "No match team names found"
        fi
    # check to see if round and teams have played
        DUPLICATE_GAME_MATCH=$($PSQL "SELECT round, winner_id, opponent_id FROM games WHERE round='$ROUND' AND winner_id=$MATCH_WINNER AND opponent_id=$MATCH_OPPONENT")
          if [[ -z $DUPLICATE_GAME_MATCH ]]
            then 
              echo "Inserting match details..."
              SUCCESS_MATCH_INSERTION=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $MATCH_WINNER, $MATCH_OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS)")
              if [[ $SUCCESS_MATCH_INSERTION == "INSERT 0 1" ]]
                then 
                  echo -e "\n~~~~~~~~~~~~\n~~ Match inserted ~~\nRound: $ROUND Year: $YEAR\nWinner: $WINNER Opponent: $OPPONENT\n~~~~~~~~~~~~"
              fi
          fi 
    fi
  done
