HOTGLUE TO SVG
Xavier Klein in collaboration with LAFKON.

licensed under GNU GPL version 3 (or later)
see http://www.gnu.org/licenses/

BASH script who's turning an Hotglue page to a fully editable SVG on Inkscape and to a pdf.
You can turn your website into a book !

What you need :
-Inkscape
-PDFTK
-An hotglue website on your server. The pages directly host by hotglue don't work with the script.

How to do :
Install Hotglue (http://hotglue.org/) on your server.
Put the .htaccess file from my Github into the "content" folder of Hotglue on your server.
Run the "canvashotglue.sh" on a terminal ("cd script directory" and "bash canvashotglue.sh")
Choose the name of your document and the number of canvas.
Now you've got a canvas (by default, A4 72 dpi) on your website (www.yoursite.com/hotglue/documentname).

MAKE SOMETHING

When it's done, run one of the 3 script :
-svgpage.sh, you will have a only what is in the pages.
-svgpage-noresize, force the element outside a page to come in the page without resize.
-svgpage-resize, force the element outside a page to come in the page and resize it to fit in the page.

Your terminal will ask you to enter the URL of your Hotglue page content 
(www.yoursite.com/hotglue/content/yourpage/head).
Push enter and wait for the result, it gives you all the files + a svg and a pdf files.

Known issues :
If you using some text, never use the standarts parameters, try to set a new font style, new font size etc. //Now it's supposed to work.
Don't use the flip, mirror mode.
Don't use the space-word mode.
The svg will seems crappy, you have to use Inkscape to see it correctly. I use Flowroot for the text in the svg and it's readable only with Inkscape.
