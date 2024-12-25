#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

SERVICES=$($PSQL "select * from services")

mainServices () {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e "\nPlease choose a service!\n"
  echo "$SERVICES" | sed 's/|/) /g'
  read SERVICE_ID_SELECTED

  if [[ $SERVICE_ID_SELECTED  =~ ^[0-9]+$ ]]
  then
    SERVICE_NAME=$($PSQL "select name from services where service_id=$SERVICE_ID_SELECTED")
    echo $SERVICE_NAME
    if [[ -z $SERVICE_NAME ]]
    then
      mainServices 'Wrong selection!'
    else
      echo -e '\nEnter your phone\n'
      read CUSTOMER_PHONE
      # echo $CUSTOMER_PHONE

      CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
      echo $CUSTOMER_NAME
      if [[ -z $CUSTOMER_NAME ]]
      then
        echo -e '\nEnter your name\n'
        read CUSTOMER_NAME
        
        RESULT_INSERT_COSTOMER=$($PSQL "insert into customers(phone,name) values('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
        echo $RESULT_INSERT_COSTOMER
      fi

      CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
      

      echo -e '\nEnter appointment time!\n'
      read SERVICE_TIME
      RESULT_INSERT_APPOINTMENT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
      echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
      EXIT
    fi
    # echo $SERVICES | while read SERVICE_ID BAR NAME
    # do
    #   echo $SERVICE_ID
    # done
  else
    mainServices 'Wrong selection, not a number!'
  fi
}


EXIT() {
  echo -e "\nThank you for stopping in.\n"
}


mainServices
