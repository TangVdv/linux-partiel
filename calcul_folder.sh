declare -i octet
arr=()
sorted_arr=()
user_arr=()
#TODO: Changer la valeur de la variable 'name'
name="Tanguy"
for h in "users"/*; do
	for f in "$h"/*
		do 
			octet=0		
			[ -f "$f" ] && octet+=$(stat -c%s "$f")
			arr+=($octet)
			sorted_arr+=($octet)
			user_arr+=($h)
	done
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

#TODO: Limiter l'affichage des consomateurs à 5

for f in "users/$name"/*
do 
	octet=0	
	[ -f "$f" ] && octet+=$(stat -c%s "$f")
	((Ko=$octet/1000))
	((Mo=$octet/1000000))
	((Go=$octet/1000000000))
	echo "echo '$Go go, $Mo mo, $Ko ko et $octet octets'" > users/$name/.bashrc
	if [ $Mo -gt 100 ]
	then
		echo "echo 'Attention, votre répertoire personnel occupe plus de 100Mo'" >> users/$name/.bashrc
	fi
done