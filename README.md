Video Object Segmentation Algorithm with spatial and temporal coherence based on the Visual Cortex Structure.

This project segment objects in video sequences using the method explained in the paper with this same title, tested in the database of VSB100 and evaluated using the metrics from the project “A Unified Video Segmentation Benchmark: Annotation, Metrics and Analysis” by Fabio Galasso.

Before using this project ensure having downloaded the whole files incluiding the BenchmarBseg.rar file that is in the master branch and have them in the same folder. To run this project, open the ppal.m file, when click “run” it will show an interface to choose a video example to segmentate or chose a custom one, to evaluate the segmentation uncomment the lines 152 to 158 to save the segmentations in the folder …\NISeg\BenchmarkBseg\Evaluation\Algorithm_Bseg\ Ucm2 (here is needed to create the folders where the segmentations are going to be saved) ensure to have the corresponding groundtruth at …\NISeg\BenchmarkBseg\Evaluation\Algorithm_Bseg\Groundtruth and then run ppal_eval.m file to get the metrics of spatial coherency and temporal coherency in the MATLAB command window.

This project run in the MATLAB version R2016a.

For any questions you can contact us by email: raul.rng07@gmail.com and juan.rq@chihuahua.tecnm.mx.
