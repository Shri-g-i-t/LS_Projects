<< Documentation
Name	      : Shridhar Pujar 
Date 	      :
Description   :
Sample input  :
Sample output :
Documentation
#!/bin/bash


# The file names
#TODO Define all file names used for this project
# The file paths
#TODO Define all file paths here
# The globals
#TODO Define all global variables required
# Time out periods
#TODO Define all timeout values here

function log()
{
	#TODO Write activities to log files along with timestamp, pass argument as a string
	echo "`date` : $1" >> log.txt
}
<<c
function answer_file_creaton()
{
	#TODO create answer csv file. If its already exists create a back up
}
c
function menu_header()
{
	# TODO Just to print welcome menu presntation and menu
	echo -ne "\e[95m\e[1m<---------------------Menu---------------------------->\e[0m"
	echo -e "\e[0m"
	echo
	echo -ne "1.Sign Up \n2.Sign In \n3.Exit\nEnter your choice : "; read choice

	case $choice in
		1) 
			sign_up
			;;
		2)
			sign_in
			;;
		3)
			exit
			;;
		*)
			echo "Invalid input!!!....Choose correct one"
			menu_header
	esac

}

function test_screen()
{
	# TODO UI for view a test.
	# 1. Display all questions from test to user with options answered by user.
	# 2. If it was not answered by user, show message 
	# 3. Read answers from csv file
	# 4. Do appropriate activities to log files
	echo
	echo -ne "\e[95m<--------------------------Welcome to Test------------------------->"
	echo -e "\e[0m"
	log "$username Started test."

	for i in `seq 5 5 20`; do
		cat questions.txt | head -$i| tail -5
		echo
		for time in `seq 10 -1 1`;do
			echo -n -e "\r Enter your option in $time seconds : "
			read -t 1 option
			if [ -n "$option" ]; then
				break
			fi
		done
		if [ -z "$option" ];then
			option=e
		fi
		#echo "Sending $option to user_answers.txt"
		if [ $i -eq 5 ];then
			echo "$option" > user_ans/$username.txt
		else
			echo "$option">> user_ans/$username.txt
		fi
	done
	log "$username Completed test"
	test_menu
}

function view_test_screen()
{
	# TODO UI for test.
	# 1. Implement time out
	# 2. Pick and display random question from question bank
	# 3. Answers stores to csv files
	# 4. Do appropriate activities to log files
	echo;echo;echo
	echo -ne "\e[95m<--------------------Test View Screen-----------------------> "
	echo -e "\e[0m"
	user_ans_array=(`cat user_ans/$username.txt`)
	correct_ans_array=(`cat correct_answers.txt`)
	line=0
	marks=0

	for i in `seq 5 5 20`; do
		head -$i questions.txt | tail -5
		echo
		if [ "${user_ans_array[$line]}" = "${correct_ans_array[$line]}" ];then
			echo -ne "\e[32mCorrect answer"
			echo -e "\e[0m"
			marks=$(($marks+1))
		elif [ "${user_ans_array[$line]}" = e ]; then
			echo -ne "\e[34mTime up"
			echo -e "\e[0m"
			echo "Correct option is ${correct_ans_array[$line]}"
		else
			echo -ne "\e[31m\e[5mWrong answer"
			echo -e "\e[0m"
			echo "Correct option is ${correct_ans_array[$line]}"
		fi
		line=$(($line+1))
	done
	echo Marks : $marks
	menu_header

}

function test_menu()
{
	# TODO Provide a menu for user for taking test and viewing test.
	# Read input from user and call respective function
	echo;echo
	echo -ne "\e[95m<------------------Test Menu--------------------------------->"
	echo -e "\e[0m"
	echo -e "1. Take test \n2. View your Test \n3.Exit"
	read -p "Enter your choice : " choice
	case "$choice" in 
		1)
			test_screen
			;;
		2) 
			view_test_screen
			;;
		3) 
			exit
			;;
	esac

}

function sign_in()
{
	# TODO For user sign-in
	# 1. Read all user credentials and verify
	# 2. Time-out for entering password
	# 3. Do appropriate activities to log files

	usernames_array=(`cat usernames.csv`)
	passwords_array=(`cat passwords.csv`)
	echo -ne "\e[95m<---------------------Sign In Screen-------------------------->"
	echo -e "\e[0m"
	flag=0
	read -p "Enter Username : " username
	for i in `seq 0 $((${#usernames_array[*]}-1))`;do
		if [ $username = ${usernames_array[$i]} ];then
			while [ 1 ];do
				echo -n "Enter Password : "
				read -s password
				if [ $password = ${passwords_array[$i]} ];then
					echo
					echo -ne "\e[32mLogin successfull"
					echo -e "\e[0m"
					log "${username} Logged in"
					test_menu
					break
				else
					echo
					echo -ne "\e[31mWrong Password....Please Re-enter password."
					echo -e "\e[0m"
					continue
				fi
			done
			flag=1
		fi
	done
	if [ $flag -eq 0 ];then
		echo "$username doesn't exist...Please signup"
		menu_header
	fi



}

function sign_up()
{
	# TODO For user sign-up
	# 1. Read all user credentials and verify
	# 2. Time-out for entering password
	# 3. Set minimum length and permitted characters for username and password, prompt error incase not matching
	# 4. Check for same user name already exists.
	# 5. Do appropriate activities to log files

	usernames_array=(`cat usernames.csv`)
	passwords_array=(`cat passwords.csv`)
    
    echo -ne "\e[95m<----------------------SignUp Screen------------------------->"
    echo -e "\e[0m"
	read -p "Enter Username : " username
	for i in `seq 0 $((${#usernames_array[*]} - 1))`;do
		if [ ${usernames_array[$i]} = $username ]; then
			echo
			echo -ne "\e[91m$username username already exists...Choose another"
			echo -e "\e[0m"
			sign_up
		fi
	done
	 
	while [ 1 ]; do
	echo -e "\e[2mPassword must be more than 8 characters and should contain atleast\n one Upper case letter\nOne Lower case letter\nOne Number\nOne symbol.\e[0m "	
	echo
	echo  -n "Enter password : "
	read -s temp_password
	echo
	if [ ${#temp_password} -ge 8 ];then
		echo $temp_password | grep -q [A-Z]
		if [ $? -eq 0 ]; then
			echo $temp_password | grep -q [a-z]
			if [ $? -eq 0 ];then
				echo $temp_password | grep -q [0-9]
				if [ $? -eq 0 ];then
					echo $temp_password | grep -q "[~!#@$%^&*()_+:;'<>/?/*-+]"
					if [ $? -eq 0 ];then
						while [ 1 ]; do
							echo -ne "\e[7mRe-enter\e[0m password : "
							read -s password
							echo
							if [ $temp_password = $password ];then
								echo $username >> usernames.csv
								echo $password >> passwords.csv	    
								echo "Username created successfully"
								log "New user created : $username"
								menu_header
								break
							else
								continue
							fi
							echo
						done
					else
						echo -e "\e[91mMissing symbol..Password must include atleast one symbol\e[0m"
						continue
					fi
				else
					echo -e "\e[91mMissing number..Password must incluude atleast one number.\e[0m"
					continue
				fi
			else
				echo -e "\e[91mMissing Lower case letter..Password must include atleast one lower case letter.\e0m"
				continue
			fi
		else
			echo -e "\e[91mMissing Upper case letter..Password must include atleast one Upper case letter.\e[0m"
			continue
		fi
	else
		echo -e "\e[91mPassword must be more than 8 characters.\e[0m"
		continue
	fi
done
}
# TODO Your main scropt starts here 

# TODO call the appropriate functions in order
clear
menu_header

