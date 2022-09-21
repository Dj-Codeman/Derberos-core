    source "/media/system/Developer Disk/deberos/user_functions"
    source "/opt/encore/config"
            
            # echo -e "new one \n"
            # password="$( compare_passwd_external )"
            # password="$( echo $password | tr -d '\n' )"
            # password="\"passwd\": \"$password\","

            # # sed -i "s/$old_pass/$password/" ./tmp
            # echo -e "\n the old one"
            # compare_passwd_internal "$1"
            # if [[ "$valid" == "1" ]]; then
            #     pwd="$( echo $pwd | tr -d '\n' )"
            #     pwd="\"passwd\": \"$pwd\","

            #     echo -e "$pwd\n$password"
            #     echo "yup"
            #     exit 0
            # fi
            
            # echho "nope"
            # exit 1


# ! Writing password 

# Password tmp dir

# draft password validation 

# # ? Getting username 
# uname="$1"
# uname="$( echo $uname | sed 's/ //g' )"
# # ? username hash
# name0="$(echo -n $uname | md5sum | sed 's/ -//')"
# name0="$(echo -n $name0 | sed 's/ //')"
# tmp_dir="/tmp/$name0-pass"

# password="$(compare_passwd_external)"
# password="$(echo $password | tr -d '\n')"

# echo $password | tee "$tmp_dir" > /dev/null

# encore write "$tmp_dir" $name0 dbros

### WORKING NEW PASSWD VALIDATION INTERNAL

# read -r -p "USERNAME : " uname
# echo -e "\n"
# password="$(capture_passwd | tr -d '\n')"

# uname="$( echo $uname | sed 's/ //g' )"
# name0="$(echo -n $uname | md5sum | sed 's/ -//')"
# tname="$( echo $uname | base64 | sed 's/ //g' )"

# encore read $name0 dbros

# pass_dir="/opt/encore/data/dbros-$name0"
# test_dir="/tmp/$tname"


# touch $test_dir
# cat "$(echo $pass_dir | tr -d '\n')" > "$test_dir"
# echo -e "$password" >> "$test_dir"


# ## variables recived 

# ## creating comparison test


##### WHO AM I TEST

    # uname="$1"
    # compare_passwd_internal "$uname"

    # if [[ "$valid" == "1" ]]; then
        
    #     encore read $uname dbros

    #     tmp="/opt/encore/data/dbros-$uname"

    #     username="$(cat "$tmp" | jq ' .Username' | sed 's/"//g')"

    #     clear 
    #     echo "You authenticated as $username"

    #     clean_data $uname

    # else

    #     error_msg="Password validation failed"
    #     echo $error_msg
    #     exit 1
    # fi 

## system counter
    # command="$1"

    # if [[ "$command" != "+" ]] && [[ "$command" != "-" ]]; then

    #     echo -e "The \"'$1'\" argument is not valid \nYou can only use + or -"
    
    # else 

    # encore read count dbros

    # count_dir="/opt/encore/data/dbros-count"

    # # ? if the count file does not exist create is and pay ? #
    # if [[ ! -f $count_dir ]]; then
    #     touch $count_dir
    #     echo "0" > $count_dir
    #     encore write $count_dir count dbros
    #     echo "Count file didnt exist? Good luck. "
    #     exit 0
    # fi

    # count="$(cat $count_dir)"
    # count="$(echo $count | sed 's/ //' | tr -d '\n')"


    # # one line if:  if (condition); THEN command; fi
    # if [[ "$command" == "+" ]]; then ((count = count + 1)); fi
    # if [[ "$command" == "-" ]]; then ((count = count - 1)); fi

    # echo $count > $count_dir
    # encore write $count_dir count dbros

    # clear 
    # echo "Current count is $count"    

    # fi

# PASSWORD DEBUGGING ?

#     uname="$1"
#     echo -e "\n"
#     capture_passwd
#     echo -e "\n"

#     uname="$(echo $uname | sed 's/ //g')"
#     name0="$(echo -n $uname | md5sum | sed 's/ -//')"
#     tname="$(echo $uname | base64 | sed 's/ //g')"

#     encore read $name0 dbros

#     pass_dir="/opt/encore/data/dbros-$name0"
#     test_dir="/tmp/$tname"

#     touch $test_dir
#     # cat "$pass_dir" >$test_dir
#     passwd1="$(cat $pass_dir | sed 's/  / /')"
#     #cat $pass_dir >$test_dir
#     echo -e "$( echo $passwd1 | sed 's/ //')" > $test_dir
#     echo -e "$( echo $passwd0 | sed 's/ //')" >>$test_dir


#     pass_test="$(grep -c "$( echo $passwd0 | sed 's/ //')" $test_dir)"
#     echo "$pass_test"

#     # ! Whatever calls the validate passwd function has to delete the decrypted jn file

#     # ! lazy fix
#     # TODO why does grep -c passowrd return 3 ?

#     if [[ $pass_test -eq 2 ]]; then
#         valid=1
#         echo "passed"
#         if [[ -z $2 ]]; then
#             # rm "/opt/encore/data/dbros-$name0" > /dev/null
#             unset $passwd0
#         else
#             # pwd=$pass
#             relax
#         fi
#     else
#         error_msg="Password validation failed"
#         echo $error_msg
#         exit 1
#     fi

# if [[ "$valid" == "1" ]]; then echo "Valid"; fi

# create_user
# delete_user darrionw
identify $1
# change_passwd darrionw