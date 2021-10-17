A Visual Object Segmentation Algorithm with Spatial and Temporal Coherence Inspired by the Architecture of the Visual Cortex.

This project segment objects in video sequences using the SegNI method explained in:

Juan A. Ramirez-Quintana, Raul Rangel-Gonzalez, Mario I. Chacon-Murguia,  Graciela Ramirez-Alonso, A Visual Object Segmentation Algorithm with Spatial and Temporal Coherence Inspired by the Architecture of the Visual Cortex, Cognitive Processing.

SegNI was tested in the database of VSB100 and evaluated using the metrics from the project “A Unified Video Segmentation Benchmark: Annotation, Metrics and Analysis” by Fabio Galasso [1]. 

To run SegNI follow the next instructions
1.	Download the repository of SegNI in a zip file.
2.	Uncompress the zip file in a folder wich name doesn’t have spaces.
3.	Open the file ppal.m and run it. This file will show a window with the options of “Video example” (to segment a video example) and “Load video” (to segment a custom video). 
4.	Chose Video example to ensure the project is working correctly.
5.	To run and evaluate SegNI in the Benchmark of VSB100 follow the next steps:
  5.1.	Download the file BenchmarkBseg.rar that is in the master branch of the repository.
  5.2.	Uncompress the file in the same directory of SegNI.
  5.3.	Uncomment the lines 152 to 158 to save the segmentations.
  5.4.	Run ppal.m and chose Load video option and then select the folder …\NISeg\BenchmarkBseg\Evaluation\Algorithm_Bseg\Images.
  5.5.	Open ppal_eval.m file and run it to evaluate the segmentations.
  5.6.	When the evaluation finishes the console will show the metrics of spatial coherency as Boundary PR global and temporal coherency as Volume PR global.

This project runs in the MATLAB version R2016a.

For any questions you can contact us by email: raul.rng07@gmail.com and juan.rq@chihuahua.tecnm.mx.

[1] F. Galasso, N. S. Nagaraja, T. J. Cárdenas, T. Brox and B. Schiele, "A Unified Video Segmentation Benchmark: Annotation, Metrics and Analysis," 2013 IEEE International Conference on Computer Vision, 2013, pp. 3527-3534, doi: 10.1109/ICCV.2013.438.
