# plots2subplots #


### What is this repository for? ###

Copy multiple Matlab figures to a single subplot-formatted figure.


### Getting Started ###
You can download the files in one of two ways:

* using `git clone git://github.com/keelanc/plots2subplots.git`
* using the **Download** button to get the ZIP file and extracting the files to
  a folder

Once the files are on your PC, add the folder `plots2subplots` to your Matlab 
path or **copy** the file file `plots2subplots.m` it to your working folder.


### Usage

The `plots2subplots.m` script can be run from the Matlab command window. The file must be in current working directory or in another directory that is in your path. 

`plots2subplots(haxes)` creates a single subplot-formatted figure from
the axes handles specified in `haxes`.

`plots2subplots()` creates a single subplot-formatted figure from copies of all open figures.

Type `help plots2subplots` in the command window for the description of its usage.


### Useful References ###

* [Organization of Graphics Objects](http://www.mathworks.com/help/matlab/creating_plots/organization-of-graphics-objects.html)
* [Object Properties](http://www.mathworks.com/help/matlab/creating_plots/object-properties.html)
* [How can I move several existing plots to one subplot in MATLAB?](http://stackoverflow.com/questions/5807834/)


### License ###

This project is licensed under the terms of the MIT license. See LICENSE.txt