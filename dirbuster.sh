#!/bin/bash

if [ $# -lt 2 ]
then
echo "Modo de uso: ./dirbuster.sh <url alvo> <wordlist> [extensao]"
echo "extensao - verifica existencia de arquivos a extensao especificada"
exit 1
fi

for word in $(cat $2)
do
response=$(curl -s -H "User-agent: RBTool" -o /dev/null -w "%{http_code}" http://$1/$word/)
if [ $response == "200" ]
then
echo "Diretorio Encontrado - http://$1/$word/"
fi
done

for word in $(cat $2)
do
response=$(curl -s -H "User-agent: RBTool" -o /dev/null -w "%{http_code}" http://$1/$word)
if [ $response == "200" ]
then
echo "Arquivo Encontrado - http://$1/$word"
fi
done

if [ $3 ]
then

for word in $(cat $2)
do
response=$(curl -s -H "User-agent: RBTool" -o /dev/null -w "%{http_code}" http://$1/$word.$3)
if [ $response == "200" ]
then
echo "Arquivo Encontrado - http://$1/$word.$2"
fi
done

fi
