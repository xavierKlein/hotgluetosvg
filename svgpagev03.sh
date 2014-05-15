#!/bin/bash

echo "Please write your files location"
read url


newfile=$(date +"%d%M%S")
mkdir $newfile
 cd ./$newfile
 wget -r -np -nH --no-directories -N -S -R index.html* -A * $url

echo $url


backgroundColor=$(cat page | grep page-background-color | cut -d: -f2)
if [ -z $backgroundColor ]
then
backgroundColor = 'rgb(255, 255, 255)'
fi
Xaxis=$(xrandr | grep \* | cut -d' ' -f4 | cut -d'x' -f1)
Yaxis=$(xrandr | grep \* | cut -d' ' -f4 | cut -d'x' -f2)

 
file=page${newfile}.svg

			

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
 echo "width='${Xaxis}'"																	>>$file
 echo "height='${Yaxis}'"																	>>$file
 echo "version='1.1'"																>>$file
 echo "sodipodi:docname='${file}'>"												>>$file
 

#Background

Xaxis=$(xrandr | grep \* | cut -d' ' -f4 | cut -d'x' -f1)
Yaxis=$(xrandr | grep \* | cut -d' ' -f4 | cut -d'x' -f2)

 echo "<g"																				>>$file
 echo "inkscape:groupmode='layer'"												>>$file
 echo "id='layer1'"																	>>$file
 echo "inkscape:label='fond'"														>>$file
 echo "style='display:inline'>"													>>$file
 echo "<rect"																			>>$file
 echo "style='fill:${backgroundColor};'"										>>$file
 echo "id='rect2987'"																>>$file
 echo "width='${Xaxis}'"															>>$file
 echo "height='${Yaxis}'"															>>$file
 echo "x='0'"																>>$file
 echo "y='0'/>"															>>$file
 echo "</g>"																			>>$file
 
 
 
GLOBIGNORE="1*~"
#Boxes 
 for i in 1*
 do
 


left=$(cat $i | grep object-left | cut -d: -f2 |sed "s/.$//"| sed "s/.$//")
top=$(cat $i | grep object-top | cut -d: -f2 | sed "s/.$//"| sed "s/.$//")
color=$(cat $i  | grep text-background | cut -d: -f2)
alpha=$(cat $i  | grep object-opacity | cut -d: -f2)
if [ -z $alpha ]
then
alpha=1
fi

fontSize=$(cat $i | grep text-font-size: | cut -d: -f2)
if [ -z $fontSize ]
then
fontSize='1.2em'

fi
     fontStyle=$(cat $i  | grep text-font-style: | cut -d: -f2) 
     fontWeight=$(cat $i | grep text-font-weight: | cut -d: -f2) 
     lineHeight=$(cat $i | grep text-line-height: | cut -d: -f2)
 if [ -z $lineHeight ]
then
fontSize=$(bc <<< "scale=2;1.2*${fontSize}")

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
 
echo $twidth 
 
 #width=$(( $twidth + $(($textPaddingX * 2)) ))
width=$(bc <<< "scale=2;${twidth}+${textPaddingX}+${textPaddingY}" )
#width=$(echo 'scale=2; (2.5+3.5)' | bc )
 #height=$(( $theight + $(($textPaddingY * 2)) ))
#height=$(echo 'scale=2; ($height+$textPaddingY)' | bc)
height=$(bc <<< "scale=2;${theight}+${textPaddingY}+${textPaddingY}")





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
 
 
 
 
		
if grep image-resized-file $i
then

imageSource=$(cat $i | grep image-resized-file | cut -d: -f2)
imageWidth=$(cat $i | grep image-resized-width| cut -d: -f2)
imageHeight=$(cat $i | grep image-resized-height| cut -d: -f2)

echo "<image"									>>$file
    echo "y='${top}'"				>>$file
    echo "x='${left}'"				>>$file
    echo "id='image$i'"				>>$file
    echo "xlink:href='${imageSource}'"		>>$file
    echo "height='${imageHeight}'"			>>$file
    echo "width='${imageWidth}' />"			>>$file
  
 		fi
 		
if grep image-file-height: $i
then

imageSourceb=$(cat $i | grep image-file: | cut -d: -f2)
imageWidthb=$(cat $i | grep object-width:| cut -d: -f2)
imageHeightb=$(cat $i | grep object-height:| cut -d: -f2)

echo "<image"									>>$file
    echo "y='${top}'"				>>$file
    echo "x='${left}'"				>>$file
    echo "id='image$i'"				>>$file
    echo "xlink:href='${imageSourceb}'"		>>$file
    echo "height='${imageHeightb}'"			>>$file
    echo "width='${imageWidthb}' />"			>>$file
  
 		fi
	
		
		
		if grep ^$ "$i";
then
     
     
 echo "<flowRoot xml:space='preserve' id='flowRoot'">>$file
 echo "style='font-size:${fontSize};font-style:${fontStyle};font-variant:normal;font-weight:${fontWeight};font-stretch:normal;text-align:${textAlign};line-height:${lineHeight};letter-spacing:${fontSpacing};word-spacing:${wordSpacing};writing-mode:lr-tb;text-anchor:middle;fill:${fontColor};fill-opacity:1;stroke:none;font-family:${textFont};'" >>$file
 echo "transform='translate(${textPaddingX},${textPaddingY})'><flowRegion id='flowRegion'>">>$file
 echo "<rect id='rect' width='${twidth}' height='${theight}' x='${left}' y='${top}'/>">>$file
echo "</flowRegion>"					>>$file

 
cat $i | grep  -A10000 "^$"| grep -v "^$" | while read line  
do   
echo -e "${line}" 

echo "<flowPara id='flowPara'><flowSpan id='flowSpan'>${line}</flowSpan></flowPara>"  >>$file


done

echo "</flowRoot>" >>$file

fi           
									

echo "</g>"	>>$file	
														

done 
 echo "</svg>"																		>>$file

#sed -i ':a;N;$!ba;s/\n//g' $file
sed -i ':a;N;$!ba;s/>\n/>/g' $file

$(inkscape -f $file -A page${newfile}.pdf)

echo "${width}"
echo $width 

