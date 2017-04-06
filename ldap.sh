#!/bin/bash
# Get AD account for LDAP authentication
echo -e "Please enter your AD user name:"
read user
echo "Your Username is: $user"
echo -e "is this correct? (y, or n)"
read answer
if [[ "$answer" = "y" ]]; then
    # Get AD account for person being searched
    echo -e "Please enter the AD name of the user you would like to search:"
    read usersearch
    # See if the user would like to search for specifics
    echo -e "Any grep parameters? (y, or n)"
    read grepans
    if [[ "$grepans" = "y" ]]; then
        # Get the search parameters
        echo -e "Please enter the grep search parameters"
        read grepparams
    # Ldap search string with grep parameters
    ldapsearch -LLL -o ldif-wrap=no -H ldap://ldap.body.local -x -D 'body\'$user'' -W -E pr=1000/noprompt -b 'ou=bbcom,dc=body,dc=local' '(&(objectClass=person) (sAMAccountName='$usersearch'))' SAMAccountName memberOf | grep $grepparams
else
    # Ldap search string with no grep parameters
    ldapsearch -LLL -o ldif-wrap=no -H ldap://ldap.body.local -x -D 'body\'$user'' -W -E pr=1000/noprompt -b 'ou=bbcom,dc=body,dc=local' '(&(objectClass=person) (sAMAccountName='$usersearch'))' SAMAccountName memberOf
fi
else
    # Run the script again from the top if the user entered their AD username improperly
    eval '/Users/brighton/scripts/ldap.sh'
fi
