 /**
  * Separate Nuclei
  * 
  * Use image scaling and binary watershed to separate the nuclei in the image
  *
  * written 2013 by Volker Baecker (INSERM) at Montpellier RIO Imaging (www.mri.cnrs.fr)
*/

var SCALE_FACTOR = 5;
var helpURL = "http://dev.mri.cnrs.fr/projects/imagej-macros/wiki/Separate_Nuclei_Tool";

macro "separate nuclei [f8]" {
  separateNuclei();
}

macro "separate nuclei (f8) Action Tool - C222D0bD1dD3eD6bD6dD8dDc3De6C000C909D89Dd4C777D4cD59Dd5Dd8DdaCa2aD86D87D88C727D38D68D69D7bD8eD9cCb0bD9dC888D2cD95D99Da4Da7Da8DaaDb8Dc7Dc9Dd7Dd9CaaaD5bDa9Db9C555D29D39D3bD3cD49D5cD6cD8bC919D19D1aD1bD1cD28D2dD3dD48D4eD58D5eD6eD78D7dD85D8aD94D9aDa3DabDb3DbbDc4DcbDd6DdbDe7De8De9DeaC888D2bD4aD5aD7aDa6Db4Db5Db6Dc5Dc6C999D96D97D98Da5Db7DbaDc8C777D2aD3aD4bD4dD5dD6aD79D7cD8cDcaCc0cD9bDe5"{
  separateNuclei();
}

macro "separate nuclei (f8) Action Tool Options" {
	 Dialog.create("Separate Nuclei Options");
	 Dialog.addNumber("scale factor:", SCALE_FACTOR);
	 Dialog.addMessage("Press the help button below to open the online help!");
     	 Dialog.addHelp(helpURL);
     	 Dialog.show();
	SCALE_FACTOR = Dialog.getNumber();
}

function separateNuclei() {
	setBatchMode(true);
	run("Scale...", "x="+(1.0/SCALE_FACTOR)+" y="+(1.0/SCALE_FACTOR)+" interpolation=Bilinear create title=small_tmp");
	setAutoThreshold("Huang dark");
	run("Convert to Mask");
	run("Fill Holes");
	run("Watershed");
	run("Scale...", "x="+SCALE_FACTOR+" y="+SCALE_FACTOR+" interpolation=Bilinear create title=big_tmp");
	setAutoThreshold("Huang dark");
	roiManager("Reset");
	run("Analyze Particles...", "size=0-Infinity circularity=0.00-1.00 show=Nothing exclude add");
	selectWindow("small_tmp");
	close();
	selectWindow("big_tmp");
	close();
	roiManager("Show All");
	setBatchMode(false);
}
