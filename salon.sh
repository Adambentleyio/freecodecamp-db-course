#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  
    echo "Welcome to My Salon, how may I help you?"
    AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services")

    if [[ -z $AVAILABLE_SERVICES ]]
    then
      MAIN_MENU "I'm sorry we don't available services right now"
    else
      echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
      do
        if [[ SERVICE_ID != "service_id" ]]
          then
          echo "$SERVICE_ID) $SERVICE_NAME"
          fi
      done
      # Prompt user to type the service number
      echo "Please enter the number of the service you'd like"

      read SERVICE_ID_SELECTED

      SERVICE_NAME_SELECTED=$($PSQL "SELECT name FROM services where service_id = $SERVICE_ID_SELECTED")
      
      if [[ -z $SERVICE_NAME_SELECTED ]]
        then
          MAIN_MENU "I'm sorry, you entered a number that doesn't exist"
        else
        # START SCHEDULING APPOINTMENT
          SCHEDULE_APPOINTMENT
      fi
    fi

}

SCHEDULE_APPOINTMENT(){

  echo -e "\nStarting the appointment..."
  # ask the customer to enter a phone number
  echo "What is your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # if no customer in the database
  if [[ -z $CUSTOMER_ID ]] 
    then
    echo -e "I don't seem to have you on file\nPlease enter your name:"
    # get customer name
    read CUSTOMER_NAME
    # Insert customer into database
    INSERTED_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    # if successful get the customer ID
    if [[ $INSERTED_CUSTOMER == "INSERT 0 1" ]]; then
      echo "I've added you to our database"
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name = '$CUSTOMER_NAME'")   
    fi
    else 
    echo "Welcome back"
  fi
  echo "What time would you like?"
  read SERVICE_TIME
  APPT_INSERTED=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  if [[ $APPT_INSERTED == "INSERT 0 1" ]]
  then
    echo -e "I have put you down for a $(echo $SERVICE_NAME_SELECTED | sed 's/ *$//') at $SERVICE_TIME, $CUSTOMER_NAME."
  fi

}


MAIN_MENU
