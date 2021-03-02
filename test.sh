#!/bin/bash

USER="root"
PASS="mysql"
basename=$(basename $1 '.sql')
echo "digraph Enron {"
echo " graph [ overlap ) scale , splines = true , rankdir = LR ];"

mysql -u $USER --password=$PASS < $1

recup_id=$(mysql $basename -u $USER --password=$PASS -se "SELECT DISTINCT user_to FROM exchanges INNER JOIN users ON exchanges.user_from = users.id WHERE users.mail='$2'")

recup_id_array=($recup_id)

echo "\"$2\" -> {"
for index in "${!recup_id_array[@]}"
do
       recup_mail=$(mysql $basename -u $USER --password=$PASS -se "SELECT mail from users WHERE id=${recup_id_array[index]}")
       echo "\"$recup_mail\" "
done
echo "}}";
