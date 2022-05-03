declare -i octet
arr=()
sorted_arr=()
user_arr=()
for h in "/home"/*; do
	octet=0	
	for f in "$h"/*
	do 	
			[ -f "$f" ] && octet+=$(stat -c%s "$f")
	done
	arr+=($octet)
	sorted_arr+=($octet)
	user_arr+=($h)
done
  
# Performing Bubble sort 
for ((i = 0; i<${#sorted_arr[@]}; i++))
do
      
    for((j = 0; j<${#sorted_arr[@]}-i-1; j++))
    do
      
        if [ ${sorted_arr[j]} -lt ${sorted_arr[$((j +1))]} ]
        then
            # swap
            temp=${sorted_arr[j]}
            sorted_arr[$j]=${sorted_arr[$((j+1))]}  
            sorted_arr[$((j+1))]=$temp
        fi
    done
done

#echo ${arr[*]}
#echo ${user_arr[*]}
#echo ${sorted_arr[*]}

for (( i = 0; i < ${#user_arr[@]}; i++ )); do

	for (( j = 0; j < ${#user_arr[@]}; j++ )); do
		if [ ${sorted_arr[i]} -eq ${arr[j]} ]
		then
			((res=$i+1))
			echo "$res - ${user_arr[j]} - ${sorted_arr[i]} octets"
		fi
	done

done

for f in "$user_arr"/*
do 
	octet=0	
	[ -f "$f" ] && octet+=$(stat -c%s "$f")
	((Ko=$octet/1000))
	((Mo=$octet/1000000))
	((Go=$octet/1000000000))
	echo "echo '$Go go, $Mo mo, $Ko ko et $octet octets'" > $user_arr/.bashrc
	if [ $Mo -gt 100 ]
	then
		echo "echo 'Attention, votre répertoire personnel occupe plus de 100Mo'" >> $user_arr/.bashrc
	fi
done