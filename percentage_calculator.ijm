inputDir = getDirectory("Choose a Directory ");


list = getFileList(inputDir);
     for (i=0; i<list.length; i++) {
        

var fileName= list[i];
//var fileName = "A1.czi";
open(fileName);
wait(100);
//setResult("Area",nResults, fileName);
selectWindow(fileName+" - C=0");
run("Make Binary");
var c0measure= 0.0;
run("Measure");
c0measure = getResult("Area",nResults-1 );
Table.deleteRows(i,i);
selectWindow(fileName+" - C=2");
//getRawStatistics(mean); 
run("8-bit");
setAutoThreshold("Default dark");
run("Threshold...");
setThreshold(50, 255);
run("Make Binary", "thresholded remaining black");
run("Make Binary");
imageCalculator("AND create", fileName+" - C=0",fileName+" - C=2");
selectWindow("Result of "+fileName+" - C=0");
run("Make Binary");
var andedmeasure= 0.0;
run("Measure");
andedmeasure = getResult("Area",nResults-1 );
Table.deleteRows(i,i);
var percentage = 0.00;
if (andedmeasure > c0measure) {
	percentage = 0.0;
}
else {
percentage = (andedmeasure/c0measure)*100;
}
//if (percentage > 99) {
//	percentage = 0.0;
//}
selectWindow(fileName+" - C=0");
close();
selectWindow(fileName+" - C=1");
close();
selectWindow(fileName+" - C=2");
close();
selectWindow("Result of "+fileName+" - C=0");
close();
setResult("Label",i, fileName);
setResult("Area",i, percentage); // sets the value in the last line of the results table
updateResults(); 
wait(100);
     }
