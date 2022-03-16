<< Documentation
Name	      : Shridhar Pujar 
Date 	      :
Description   :
Sample input  :
Sample output :
Documentation
#!/bin/bash

#!/bin/bash
# The file names
#TODO Define all file names used for this project
# The file paths
#TODO Define all file paths here
# The globals
#TODO Define all global variables required
# Time out periods
#TODO Define all timeout values here


<<a
function log()
{
#	TODO Write activities to log files along with timestamp, pass argument as a string
}
a
function menu_header()
{
	# TODO Just to print welcome menu presntation
	echo;echo
	echo -e "\e[1m\e[34m**********************WELCOME****************************\e[0m"
	echo -e "1. Add Entry\n2. Search / Edit Entry\n3. List all contacts\n\e[91mx. Exit\e[0m\n"
	read -p "Please choose your option : " op
	case $op in
		1)
			add_entry
			;;
		2)
			search_operation
			;;
		3)
			list_all_contacts
			;;
			
		'x')
			exit
			;;
		*)
			echo -e "\e[91mPlease enter valid input\e[0m"
			exit

	esac


}

function field_menu()
{
	# TODO to print a selected user information
	# Name, Email, Tel no, Mob num, Address, Message
	echo;echo
	echo -e "\e[1m\e[34m*********************New Contact Menu**************************\e[0m"
	name=""
	mob_no=""
	email=""
	address=""
	while [ 1 ]; do 
		echo -en "\n1. Name      : $name\n2. Mob num   : $mob_no\n3. Email ID  : $email\n4. Address   : $address\n\e[1m\e[92ms. Save\e[0m\n\e[91mx. Exit\e[0m \n\nPlease choose your option : "
		read option
		case $option in
			1)
				while [ 1 ]; do
					echo -n "Please enter the name : "
					read name
					reg='^[A-Za-z ]*$'
					if [[ "$name" =~ $reg ]]; then
						break
					else
						echo -e "\e[31mOnly alphabets and space allowed....Retry\e[0m"
						continue
					fi
				done
				name_first_letter=`echo ${name:0:1} | tr [a-z] [A-Z]`
				name_rest_letters=`echo ${name:1} | tr [A-Z] [a-z]`
				name="$name_first_letter$name_rest_letters"
				continue
				;;
			2)
				while [ 1 ]; do
					echo -n "Please enter the mob_no : "
					read mob_no
					echo $mob_no | grep -q "[0-9]"
					if [ ${#mob_no} -eq 10 -a $? -eq 0 ]; then
						break
					else
						echo -e "\e[31mOnly 10 numbers allowed....Retry\e[0m"
						continue
					fi
				done
				mob_no="+91-$mob_no"
				continue
				;;
			3)
				while [ 1 ]; do
					echo -n "Please enter the email Id : "
					read email
					reg='^([A-Za-z0-9]+)[@]([a-z]+)[\.](com|in)$'
					if [[ $email =~ $reg ]]; then
						break
					else
						echo -e "\e[31mInvalid email!!!!\nEx: shri@gmail.com pra@yahoo.in\e[0m"
						continue
					fi
				done
				continue
				;;

			4)
				echo -n "Please enter the address : "
				read address
				continue
				;;
			s)
				str=""$name",$mob_no,$email,"$address""
				#echo "$str"
				database_entry "$str"
				echo -e "\e[1m\e[92mContact Saved successfully.....\e[0m"
				menu_header
				;;
			x)
				menu_header
				;;
			*)
				echo -e "\e[91mPlease choose correct option\e[0m\n"
				continue
				;;
		esac
	done
}
function edit_operation()
{
	# TODO Provide an option to change fields of an entry
	# 1. Ask user about the field to edit
	# 2. As per user selection, prompt a message to enter respected value
	# 3. Verify the user entry to field for matching. Eg mob number only 10 digits to enter
	# 4. Prompt error in case any mismatch of entered data and fields

	echo
	echo -e "\e[34m*************************Edit Screen********************************\e[0m"
	line_no=$1
	total_line_nos=`wc -l < address_book.csv`
	if [ $line_no -gt $total_line_nos ]; then
		echo -e "\e[91mPlease enter valid contact option.!!!!!\e[0m"
		search_operation
	fi
	line=`sed -n "$line_no"p address_book.csv`
	#echo "line=$line"
	name=`echo $line | cut -d "," -f 1`
	mob_no=`echo $line | cut -d "," -f 2`
	email=`echo $line | cut -d "," -f 3`
	address=`echo $line | cut -d "," -f 4`
	echo;echo

	while [ 1 ]; do 
		echo -en "1. Name      : $name\n2. Mob num   : $mob_no\n3. Email     : $email\n4. Address   : $address\n\e[1m\e[92ms. Save\e[0m \n\e[91mx. Exit\e[0m \n\nPlease choose your option : "
		read option
		case $option in
			1) 
				while [ 1 ]; do
					echo -n "Please enter the name : "
					read name
					reg='^[A-Za-z ]*$'
					if [[ "$name" =~ $reg ]]; then
						break
					else
						echo -e "\e[31mOnly alphabets and space allowed....\e[0m"
						continue
					fi
				done
				name_first_letter=`echo ${name:0:1} | tr [a-z] [A-Z]`
				name_rest_letters=`echo ${name:1} | tr [A-Z] [a-z]`
				name="$name_first_letter$name_rest_letters"
				continue
				;;
			2)
				while [ 1 ]; do
					echo -n "Please enter the mob_no : "
					read mob_no
					echo $mob_no | grep -q "[0-9]"
					if [ ${#mob_no} -eq 10 -a $? -eq 0 ]; then
						break
					else
						echo -e "\e[31mOnly 10 numbers allowed....\e[0m"
						continue
					fi
				done
				mob_no="+91-$mob_no"
				continue
				;;
			3)
				while [ 1 ]; do
					echo -n "Please enter the email Id : "
					read email
					reg='^([A-Za-z0-9]+)[@]([a-z]+)[\.](com|in)$'
					if [[ $email =~ $reg ]]; then
						break
					else
						echo -e "\e[31mInvalid email!!!!\nEx: shri@gmail.com pra@yahoo.in\e[0m"
						continue
					fi
				done
				continue
				;;
			4)
				echo -n "Please enter the address : "
				read address
				continue
				;;
			s)
				str=""$name",$mob_no,$email,"$address""
				sed -i "${line_no}"s/.*/"${str}"/ address_book.csv
				echo -e "\e[1m\e[32mContact Updated successfully\e[0m"
				break
				;;
			x)
				field_menu
				;;
			*)
				echo -e "\e[91mPlease choose correct option\e[0m\n"
				continue
				;;
		esac
	done
	menu_header
}

function delete_operation()
{
	line_no=$1
	sed -i "$line_no"d address_book.csv
	echo -e "\e[91mDeleted successfully...........\e[0m"
	sed -i '/^[[:blank:]]*$/d' address_book.csv
	menu_header

}
function edit_or_delete()
{
	line_no=$1
	echo -en "\n\e[1m\e[93m1. Edit\e[0m\n\e[91m2. Delete\e[0m\nPlease choose operation : "
	read op
	case $op in 
		1)
			edit_operation $line_no
			;;
		2)
			delete_operation $line_no
			;;
		*)
			field_menu
			;;
	esac

}

function search_operation()
{
	# TODO Ask user for a value to search
	# 1. Value can be from any field of an entry.
	# 2. One by one iterate through each line of database file and search for the entry
	# 3. If available display all fiels for that entry
	# 4. Prompt error incase not available

	echo
	echo -e "\e[1m\e[94m************************Search Screen*************************\e[0m"
	name=""
	mob_no=""
	email=""
	address=""
	echo -en "1. Name      : $name\n2. Mob num   : $mob_no\n3. Email Id   : $email\n4. Address   : $address\n\e[91mx. Exit\e[0m \n\nPlease choose your option : "
	read search_op
	case $search_op in
		1) 
			echo -n "Please enter the name : "
			read name
			grep -q -win $name address_book.csv
			if [ $? = 0 ]; then
				name_line_nos=(`grep -win $name address_book.csv | cut -d ":" -f 1`) 
				for i in ${name_line_nos[*]}; do
					echo "$i : `sed -n "$i"p address_book.csv`"
				done

				echo -n "Please select contact : "
				read selected
				flag=0
				for j in ${name_line_nos[*]}; do
					if [ $selected -eq $j ];then
						flag=1
						edit_or_delete $selected
					fi
				done
				if [ $flag -eq 0 ];then
					echo -e "\e[91mInvalid input!!!!\e[0m"
					search_operation
				fi


			else
				echo -e "\n\e[91mNot found!!!!!!!!\e[0m\n\n"
				search_operation
			fi

			;;
		2)
			echo -n "Please enter the mob_no : "
			read mob_no
			grep -q -win $mob_no address_book.csv
			if [ $? = 0 ]; then
				mob_line_nos=(`grep -win $mob_no address_book.csv | cut -d ":" -f 1`) 
				for i in ${mob_line_nos[*]}; do
					echo "$i : `sed -n "$i"p address_book.csv`"
				done
				echo -n "Please select contact : "
				read selected
				flag=0
				for j in ${mob_line_nos[*]}; do
					if [ $selected -eq $j ];then
						flag=1
						edit_or_delete $selected
					fi
				done
				if [ $flag -eq 0 ]; then
						echo -e "\e[91mInvalid input!!!!\e[0m"
						search_operation
				fi
			else
				echo -e "\n\e[91mNot found\e[0m\n\n"
				search_operation
			fi
			;;
		3)
			echo -n "Please enter the email Id : "
			read email
			grep -q -win $email address_book.csv
			if [ $? = 0 ]; then
				email_line_nos=(`grep -win $email address_book.csv | cut -d ":" -f 1`) 
				for i in ${email_line_nos[*]}; do
					echo "$i : `sed -n "$i"p address_book.csv`"
				done

				echo -n "Please select contact : "
				read selected
				flag=0
				for j in ${email_line_nos[*]}; do
					if [ $selected -eq $j ];then
						flag=1
						edit_or_delete $selected
					fi
				done
				if [ $flag -eq 0 ]; then
					echo -e "\e[91mInvalid input!!!!\e[0m"
					search_operation
				fi


			else
				echo -e "\n\e[91mNot found!!!!!!!!\e[0m\n\n"
				search_operation
			fi
			;;
		4)

			echo -n "Please enter the address : "
			read address
			grep -q -win $address address_book.csv
			if [ $? = 0 ]; then
				address_line_nos=(`grep -win $address address_book.csv | cut -d ":" -f 1`) 
				for i in ${address_line_nos[*]} ; do
					echo "$i : `sed -n "$i"p address_book.csv`"
				done
				echo -n "Please select contact : "
				read selected
				flag=0
				for j in ${address_line_nos[*]}; do
					if [ $selected -eq $j ];then
						edit_or_delete $selected
						flag=1
					fi
				done
				if [ $flag -eq 0 ]; then
					echo -e "\e[91mInvalid input!!!!\e[0m"
					search_operation
				fi

			else
				echo -e "\n\e[91mNot found\e[0m\n\n"
				search_operation
			fi
			;;
		x)
			field_menu
			;;
		*)
			echo -e "Please choose correct option\n"
			search_operation
			;;
	esac
}
<<a
		function search_and_edit()
		{
			# TODO UI for editing and searching
			# 1. Show realtime changes while editing
			# 2. Call above functions respectively
		}
a
function database_entry()
{
	# TODO user inputs will be written to database file
	# 1. If some fields are missing add consicutive ','. Eg: user,,,,,

	str=$1
	echo $str >> address_book.csv
}
<<a
function validate_entry()
{
	# TODO Inputs entered by user must be verified and validated as per fields
	# 1. Names should have only alphabets
	# 2. Emails must have a @ symbols and ending with .<domain> Eg: user@mail.com
	# 3. Mobile/Tel numbers must have 10 digits .
	# 4. Place must have only alphabets
}
a
function list_all_contacts()
{
	OLD_IFS=$IFS
	IFS=","
	echo
	echo -e "\e[1m\e[32m********************ADDRESS BOOK*************************\e[0m"
	echo -e "\e[1m\e[34mName >> Mobile_num >> Email Id >> Address\e[0m"
	echo "--------------------------------------------------------------------------"
	while read n m e a;do
		echo -e "$n >> $m >> $e >> $a"
	done < address_book.csv
	IFS=$OLD_IFS

	menu_header
}

function add_entry()
{
	# TODO adding a new entry to database
	# 1. Validates the entries
	# 2. Add to database
	field_menu
}

# TODO Your main scropt starts here
# 1. Creating a database directory if it doesn't exist
# 2. Creating a database.csv file if it doesn't exist
# Just loop till user exits
# TODO call the appropriate functions in order
clear
menu_header
