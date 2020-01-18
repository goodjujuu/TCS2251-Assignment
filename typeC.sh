#!/bin/bash
set -f

#LIST is the list of characters to try

LIST1="A B C D E F G H I J K L M N O P Q R S T U V W X Y Z "
LIST2="0 1 2 3 4 5 6 7 8 9 "
LIST3="a b c d e f g h i j k l m n o p q r s t u v w x y z "
LIST4="~ @ # $ % ^ * _ + - = { } [ ] ? ; : "
LIST5="~ @ # $ % ^ * _ + - = { } [ ] ? ; : "

echo "Select number from c15 to c21"
read number

encr=`grep $number shadow.test | cut -d":" -f2 | cut -d"$" -f4`

salt=`grep $number shadow.test | cut -d":" -f2 | cut -d"$" -f3`

echo "Hash is " $encr
echo "Salt is " $salt

for i in $LIST1
  do
   for j in $LIST2
    do
      for k in $LIST3
       do
         for l in $LIST4
          do
	    for m in $LIST5
	     do
	       echo -n "$i$j$k$l$m "
	   
  test=`mkpasswd -m sha-256 "$i$j$k$l$m" -s $salt | cut -d":" -f2 | cut -d"$" -f4`

		if [ $test == $encr ] ; then
			echo "Password for $number is: "$i$j$k$l$m" "
			exit
		fi
	    done
         done
      done
   done
done
