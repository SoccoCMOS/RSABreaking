#!/bin/bash

#géneration de la cle privée

openssl genrsa -out /home/TP1/keys/rsa_privkey.pem 256 

echo
echo 
cat /home/TP1/keys/rsa_privkey.pem
echo
echo 

#géneration de la  cle publique

echo 
echo
openssl rsa -in /home/TP1/keys/rsa_privkey.pem -pubout -out /home/TP1/keys/rsa_pubkey.pem
cat /home/TP1/keys/rsa_pubkey.pem
echo 

#chiffrement 

echo "Hello 2CS SIQ" >/home/TP1/temp.txt

openssl rsautl -encrypt -pubin -inkey /home/TP1/keys/rsa_pubkey.pem \-in /home/TP1/temp.txt -out /home/TP1/cipher1/cipher.txt


#get n and e from text file pubkeyNE AND SAVE IT in stdout buff 
#then pass it to argv argument to GetNE function > result = n&e
gcc /home/TP1/getNE.c -o /home/TP1/getNE 
stdout="$(openssl rsa -in /home/TP1/keys/rsa_pubkey.pem -pubin -text -modulus)"
/home/TP1/getNE "$stdout"
#get MODULUS AND CONVERT IT TO INT FROM HEX FORMAT
gcc /home/TP1/hex2dec.c -o /home/TP1/hex2dec -lssl -lcrypto
mHEX="$(cat /home/TP1/Modulus.txt)"
mINT="$(/home/TP1/hex2dec "$mHEX")"
#PASS N ( int) and get all message from msieve 
/home/debian/msieve-1.52/msieve -v "$mINT" >/home/TP1/resultofFactoring.txt
#extract just p q from message in file resultofFactoring file
gcc /home/TP1/getFactors.c -o /home/TP1/getFACT
/home/TP1/getFACT
#get result of cat in buff Q and Q 
P="$(cat /home/TP1/broken/brokenP.txt)"
Q="$(cat /home/TP1/broken/brokenQ.txt)"

#compile and execut listings 2 to generate priv key with parameters p & q & e IN BUFF P & Q
gcc /home/TP1/get_priv_key.c -o /home/TP1/getprivkey -lssl -lcrypto
/home/TP1/getprivkey "$P" "$Q" "65537" >/home/TP1/hacked/priv_key.pem

echo "modulus : "
cat /home/TP1/Modulus.txt
echo 
echo "facteur P"
cat /home/TP1/broken/brokenP.txt
echo 
echo "facteur Q"
cat /home/TP1/broken/brokenQ.txt
echo 

#decrypt with priv_key 
openssl rsautl -decrypt -inkey /home/TP1/priv_key.pem -in /home/TP1/cipher.txt










