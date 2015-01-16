#!/bin/sh
## Class.sh for Class in /home/allee_r
## 
## Made by romain allée
## Login   <allee_r@epitech.net>
## 
## Started on  Fri Jan 16 09:49:39 2015 romain allée
## Last update Fri Jan 16 15:35:20 2015 romain allée
##

JOUR=$(date +"%a")
MOI=$(date +"%b")
JOURNB=$(date +"%d")
TIME=$(date +"%T")

MET=""
GETSET=""
PROT=""
TYPE=""
PS3='Please enter your member type: '
options=("std::string" "int" "void" "float" "" "char" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "std::string")
            TYPE="std::string"
	    ;;
        "int")
            TYPE="int"
	    ;;
        "void")
            TYPE="void"
	    ;;
	"float")
            TYPE="float"
	    ;;
	"")
            TYPE=""
	    ;;
	"char")
            TYPE="char"
	    ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
echo "Please enter your Member name: "
read MEM
ALLMEM=$ALLMEM" "$TYPE"|"$MEM
MET=$MET$TYPE"\t\t"$MEM";\n"
MEMC=$MEM
MEM=`sed 's/\(.\)/\U\1/' <<< "$MEM"`
PROT=$PROT$TYPE"\t\tget"$MEM"() const;\n"
PROT=$PROT"void\t\tset"$MEM"("$TYPE");\n"
GETSET=$GETSET$TYPE"\t\t$1::get"$MEM"() const\n{\nreturn (this->$MEMC);\n}\n\n"
GETSET=$GETSET"void\t\t$1::set"$MEM"("$TYPE" var)\n{\nthis->$MEMC = var;\n}\n\n"
done

PS3='Please enter your member for the construtor: '
options=($ALLMEM "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Quit")
            break
            ;;
        *) 
if [[ $Const == "" ]];then
	Const=$Const$opt
else    
	Const=$Const","$opt    
fi
VAR=$(echo $opt | cut -d '|' -f 2);
PARAM=$PARAM"this->$VAR = $VAR;\n";
	    ;;
    esac

done

Const=${Const//['|']/' '};


HH="//\n// $1.hh for project in /home/allee_r\n//
\n// Made by romain allée
\n// Login   <allee_r@epitech.net>
\n//
\n// Started on  $JOUR $MOI $JOURNB $TIME 2015 romain allée
\n// Last update $JOUR $MOI $JOURNB $TIME 2015 romain allée
\n//\n\n"
CPP="//\n// $1.cpp for project in /home/allee_r\n//
\n// Made by romain allée
\n// Login   <allee_r@epitech.net>
\n//
\n// Started on  $JOUR $MOI $JOURNB $TIME 2015 romain allée
\n// Last update $JOUR $MOI $JOURNB $TIME 2015 romain allée
\n//\n\n"

HH=$HH"#ifndef\t\t\t${1^^}_H_\n#define\t\t\t${1^^}_H_\n\n#include\t\t<iostream>\n#include\t\t<string>\n\n"

HH=$HH"class\t\t\t$1\n{\npublic:\n  $1($Const);\n  ~$1();\n$PROT\nprivate:\n$MET};\n\n"

HH=$HH"#endif"

CPP=$CPP"#include\t\t\t\"$1.hh\"\n\n$1::$1($Const)\n{\n$PARAM\n}\n\n$1::~$1()\n{\n\n}\n\n$GETSET\n"

echo -e $HH > "$1.hh"
echo -e $CPP > "$1.cpp"
