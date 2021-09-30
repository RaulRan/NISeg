Video Object Segmentation Algorithm with spatial and temporal coherence based on the 
Visual Cortex Structure.

This project segment objects in video sequences using the method explained in the 
paper with this same title, tested in the database of VSB100 and evaluated using the 
metrics from the project A Unified Video Segmentation Benchmark: Annotation, Metrics 
and Analysis by Fabio Galasso.

Before using this project ensure having downloaded the whole files incluiding the 
BenchmarBseg.rar file that is in the master branch and have them in the same folder.
To run this project, open the ppal.m file. It has 2 parts, the first one is to 
segment the videos which will show a menu to test one example video or use a folder 
of videos. The second part is to evaluate the segmentations of the video sequences. 
For this make a folder for each video in …\NISeg\BenchmarkBseg\Evaluation\Algorithm_Bseg\Ucm2 
with the same names, uncomment the line codes from 138 to 144 in the ppal.m file and 
run the first part to save the segmentations in the folders just created, then 
comment this part and uncomment the second one and run it to get the metrics of 
spatial coherency and temporal coherency in the MATLAB command window.

This project run in the MATLAB version R2016a.

For any questions you can contact us by email: raul.rng07@gmail.com and juan.rq@chihuahua.tecnm.mx.
