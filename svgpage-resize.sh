#!/bin/bash

echo "Please write your files location"
read url


newfile=$(date +"%d%M%S")
mkdir $newfile
 cd ./$newfile
GLOBIGNORE="auto*"
 wget -r -np -nH --no-directories -N -S -R index.html* -A * $url

echo $url


for pageN in pages*
 do

backgroundColor=$(cat $pageN | grep text-background-color: | cut -d: -f2)
if test -z "$backgroundColor"
then
backgroundColor = 'rgb(255, 255, 255)'
fi

leftB=$(cat $pageN | grep object-left | cut -d: -f2 |sed "s/.$//"| sed "s/.$//")
topB=$(cat $pageN | grep object-top | cut -d: -f2 | sed "s/.$//"| sed "s/.$//")



widthB=$(cat $pageN  |  grep object-width: | cut -d: -f2 | sed "s/.$//"| sed "s/.$//")
heightB=$(cat $pageN  |  grep object-height: | cut -d: -f2 | sed "s/.$//"| sed "s/.$//")


 
file=page${pageN}.svg

			

echo "<?xml version='1.0' encoding='UTF-8' standalone='no'?>"			>$file
echo "<svg"																				>>$file
 echo "xmlns:dc='http://purl.org/dc/elements/1.1/'">>$file
 echo "xmlns:cc='http://creativecommons.org/ns#'">>$file
 echo "xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'">>$file
 echo "xmlns:svg='http://www.w3.org/2000/svg'">>$file
 echo "xmlns='http://www.w3.org/2000/svg'">>$file
 echo "xmlns:xlink='http://www.w3.org/1999/xlink'"	>>$file
 echo "xmlns:sodipodi='http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd'" >>$file
 echo "xmlns:inkscape='http://www.inkscape.org/namespaces/inkscape'"	>>$file
 echo "width='${widthB}'"																	>>$file
 echo "height='${heightB}'"																	>>$file
 echo "version='1.1'"																>>$file
 echo "sodipodi:docname='${file}'>"												>>$file
 

#Background



 echo "<g"																				>>$file
 echo "inkscape:groupmode='layer'"												>>$file
 echo "id='layer1'"																	>>$file
 echo "inkscape:label='fond'"														>>$file
 echo "style='display:inline'>"													>>$file
 echo "<rect"																			>>$file
 echo "style='fill:${backgroundColor};'"										>>$file
 echo "id='rect2987'"																>>$file
 echo "width='${widthB}'"															>>$file
 echo "height='${heightB}'"															>>$file
 echo "x='0'"																>>$file
 echo "y='0'/>"															>>$file
 echo "</g>"																			>>$file
 

 
GLOBIGNORE="1*~"
#Boxes 
 for i in 1*
 do
 
 

color=$(cat $i  | grep text-background | cut -d: -f2)
alpha=$(cat $i  | grep object-opacity | cut -d: -f2)
if [ -z $alpha ]
then
alpha=1
fi

fontSize=$(cat $i | grep text-font-size: | cut -d: -f2)
if [ -z $fontSize ]
then
fontSize="1.2em"
fontSize2="1.2"
fi

     fontStyle=$(cat $i  | grep text-font-style: | cut -d: -f2) 
     fontWeight=$(cat $i | grep text-font-weight: | cut -d: -f2) 
     lineHeight=$(cat $i | grep text-line-height: | cut -d: -f2)
 if [ -z $lineHeight ]
then
fontSize=$(python -c "print 1.2*$fontSize2")em

fi
     
fontSpacing=$(cat $i | grep text-letter-spacing: | cut -d: -f2)

wordSpacing=$(cat $i | grep text-word-spacing:| cut -d: -f2)
fontColor=$(cat $i | grep text-font-color: | cut -d: -f2)

textAlign=$(cat $i | grep  text-align: | cut -d: -f2)
if [ -z $textAlign ]
then
textAlign='left'
fi

textFont=$(cat $i | grep  text-font-family: | cut -d: -f2 | sed "s|['']||g")
#flipFont=$(cat $i | grep  transform-flip: | cut -d: -f2 )
   	
textPaddingX=$(cat $i | grep  text-padding-x: | cut -d: -f2| sed "s/.$//"| sed "s/.$//")
if [ -z $textPaddingX ]
then
textPaddingX=0
fi

textPaddingY=$(cat $i | grep  text-padding-y: | cut -d: -f2| sed "s/.$//"| sed "s/.$//")
if [ -z $textPaddingY ]
then
textPaddingY=0
fi

 twidth=$(cat $i |  grep object-width: | cut -d: -f2 | sed "s/.$//"| sed "s/.$//")
 theight=$(cat $i |  grep object-height: | cut -d: -f2 | sed "s/.$//"| sed "s/.$//")
 




width=$(python -c "print $twidth+$textPaddingX+$textPaddingY")
height=$(python -c  "print $theight+$textPaddingY+$textPaddingY")
 

leftA=$(cat $i | grep object-left | cut -d: -f2 |sed "s/.$//"| sed "s/.$//")
left=$(python -c "print $leftA-$leftB")
leftG=$(python -c "print $left+$width")
widthW=$(python -c "print $leftG-$widthB")

topA=$(cat $i | grep object-top | cut -d: -f2 | sed "s/.$//"| sed "s/.$//")
top=$(python -c "print $topA-$topB" )
topG=$(python -c "print $topA+$height")
heightY=$(python -c "print $topB+$heightB")


#if [ $(bc <<< "$topG > $heightB") -eq 1 ] && [ $(bc <<< "$topA > $topB") -eq 1 ] && [ $(bc <<< "$topA < $heightY") -eq 1 ]
#then
#top=$(python -c "print $heightB-$height")
#fi

#if [ $(bc <<< "$top < 0") -eq 1 ] && [ $(bc <<< "$topA > $topB") -eq 1 ] && [ $(bc <<< "$topA < $heightY") -eq 1 ]
#then
#top=0
#fi

if  [ $(bc <<< "$leftG > $widthB") -eq 1 ]
then
width=$(python -c "print $width-$widthW")
fi

if [ $(bc <<< "$left < 0") -eq 1 ]
then
width=$(python -c "print $width+$left")
left=0
fi



echo $widthW
echo $widthB
echo $width
echo $left
echo $heightY

 echo "<g "																				>>$file
 echo "inkscape:groupmode='layer'"												>>$file
 echo "id='layer${i}'"																	>>$file
 echo "inkscape:label='${i}'"													>>$file
 echo "style='display:inline'>"												>>$file
 echo "<rect style='fill:${color};fill-opacity:${alpha};stroke-width:10;stroke-miterlimit:4;stroke-dasharray:none'"	>>$file
 echo "id='rect${i}'"																>>$file
 echo "width='${width}'"															>>$file
 echo "height='${height}'"															>>$file
 echo "x='${left}'"																>>$file
 echo "y='${top}'/>"																>>$file
 
 
 
 
		
if grep image-resized-file $i || grep image-file-height: $i || [ $(bc <<< "$leftG > $widthB") -eq 1 ]
then

imageSource=$(cat $i | grep image-resized-file: | cut -d: -f2) 
if test -z "$imageSource"
then
imageSource=$(cat $i | grep image-file: | cut -d: -f2)
fi

#imageWidth=$(cat $i | grep image-resized-width| cut -d: -f2)
#imageHeight=$(cat $i | grep image-resized-height| cut -d: -f2)
imageWidth=$width
imageHeight=$height

#if  [ $(bc <<< "$leftG > $widthB") -eq 1 ]
#then
#imageWidth=$(python -c "print $width-$widthW")
 #fi

if [ $(bc <<< "$left < 0") -eq 1 ]
then
imageWidth=$(python -c "print $width+$left")
left=0
fi

echo "<image"									>>$file
    echo "y='${top}'"				>>$file
    echo "x='${left}'"				>>$file
    echo "id='image$i'"				>>$file
    echo "xlink:href='${imageSource}'"		>>$file
    echo "height='${imageHeight}'"			>>$file
    echo "width='${imageWidth}' />"			>>$file
  
 		fi
 		

	
		
		
		if grep ^$ "$i";
then
     
     
echo "<flowRoot xml:space='preserve' id='flowRoot'">>$file
echo "style='font-size:${fontSize};font-style:${fontStyle};font-variant:normal;font-weight:${fontWeight};font-stretch:normal;text-align:${textAlign};line-height:${lineHeight};letter-spacing:${fontSpacing};word-spacing:${wordSpacing};writing-mode:lr-tb;text-anchor:middle;fill:${fontColor};fill-opacity:1;stroke:none;font-family:${textFont};'" >>$file
echo "transform='translate(${textPaddingX},${textPaddingY})'><flowRegion id='flowRegion'>">>$file
echo "<rect id='rect' width='${twidth}' height='${theight}' x='${left}' y='${top}'/>">>$file
echo "</flowRegion>"					>>$file

 
cat $i | grep  -A10000 "^$" | sed '1d'| while read line  
do   
echo -e "${line}" 

echo "<flowPara id='flowPara'><flowSpan id='flowSpan'>${line}</flowSpan></flowPara>"  >>$file

#if cat $i | grep  -A10000 "^$"| grep "^$"


done

echo "</flowRoot>" >>$file

fi           
									

echo "</g>"	>>$file	
														

done 

 echo "</svg>"																		>>$file

#sed -i ':a;N;$!ba;s/\n//g' $file
sed -i ':a;N;$!ba;s/>\n/>/g' $file

$(inkscape -f $file -A page${pageN}.pdf)
 done
 
 $(pdftk *.pdf cat output ${newfile}.pdf)




