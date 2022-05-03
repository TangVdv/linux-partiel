#apt install pwgen
clear
#input="/home/oui/Bureau/Projet_linux/source.txt"
input="./source.txt"
while IFS= read -r line
do
  IFS=':' read -ra ADDR <<< "$line"

  if ! id -u "${ADDR[0]}" >/dev/null 2>&1; then
    useradd -m -c "${ADDR[1]} ${ADDR[2]}" -p "${ADDR[3]}" "${ADDR[0]}"
    passwd --expire "${ADDR[0]}"

    for i in `seq 1 $(( $RANDOM % 6 + 5 ))`; do
      randomString=$(pwgen 8 1)
      dd if=/dev/random of=$randomString bs=1000000 count=$(( ( RANDOM % 46 )  + 5 ))
      mv $randomString /home/${ADDR[0]}/
    done

  fi


done < "$input"
