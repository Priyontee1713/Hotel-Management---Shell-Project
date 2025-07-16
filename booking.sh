#!/bin/bash

ROOMS="data/rooms.txt"
GUESTS="data/guests.txt"
BOOKINGS="data/bookings.txt"

add_guest() {
  echo "Enter Guest ID:"
  read gid
  echo "Enter Name:"
  read name
  echo "Enter Phone:"
  read phone
  echo "$gid,$name,$phone" >> $GUESTS
  echo "Guest added!"
}

add_room() {
  echo "Enter Room ID:"
  read rid
  echo "Enter Room Type (Single/Double):"
  read type
  echo "$rid,$type,Available" >> $ROOMS
  echo "Room added!"
}

book_room() {
  echo "Enter Guest ID:"
  read gid
  echo "Enter Room ID:"
  read rid
  echo "Enter Start Date (YYYY-MM-DD):"
  read start
  echo "Enter End Date (YYYY-MM-DD):"
  read end
  status=$(grep "^$rid" $ROOMS | cut -d',' -f3)
  if [[ "$status" == "Available" ]]; then
    echo "$gid,$rid,$start,$end" >> $BOOKINGS
    sed -i "s/^$rid,\([^,]*\),Available/$rid,\1,Booked/" $ROOMS
    echo "Room booked!"
  else
    echo "Room not available!"
  fi
}

view_bookings() {
  echo "All Bookings:"
  cat $BOOKINGS
}

while true; do
  echo -e "\n--- Hostel Room Booking Menu ---"
  echo "1. Add Guest"
  echo "2. Add Room"
  echo "3. Book Room"
  echo "4. View Bookings"
  echo "5. Exit"
  read -p "Choose an option: " choice

  case $choice in
    1) add_guest ;;
    2) add_room ;;
    3) book_room ;;
    4) view_bookings ;;
    5) exit ;;
    *) echo "Invalid choice!" ;;
  esac
done
