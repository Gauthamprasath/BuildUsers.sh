#!/bin/bash

#
# Gets a list with `firstname lastname` and formats them into the following:
# 	NameSurname, Name.Surname, NamSur (3letters of each), Nam.Sur, NSurname, N.Surname, SurnameName, Surname.Name, SurnameN, Surname.N,
#

if [[ $ == "-h" || $# != 1 ]]; then
	echo "Usage: buildusers user-names-file"
	exit
fi

if [ -f possible-users.txt ]; then
    echo "Removed previously generated list"
    rm possible-users.txt
fi

echo "Generating possible usernames..."

cat $1 | while read line; do
	firstname=$(echo $line | cut -d ' ' -f1 | tr '[:upper:]' '[:lower:]')
	lastname=$(echo $line | cut -d ' ' -f2 | tr '[:upper:]' '[:lower:]')
	echo "$firstname.$lastname
$(echo $firstname | cut -c1).$lastname
$(echo $firstname | cut -c1)-$lastname
$firstname$lastname
$firstname-$lastname
$firstname
$lastname
$(echo $firstname | cut -c1-3)$(echo $lastname | cut -c1-3)
$(echo $firstname | cut -c1-3).$(echo $lastname | cut -c1-3)
$(echo $firstname | cut -c1)$lastname
$lastname$firstname
$lastname-$firstname
$lastname.$firstname
$lastname$(echo $firstname | cut -c1)
$lastname-$(echo $firstname | cut -c1)
$lastname.$(echo $firstname | cut -c1)" >>  possible-users.txt
done

echo administrator >> possible-users.txt
echo guest >> possible-users.txt

echo "Done! Check possible-users.txt"
