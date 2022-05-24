# Baby Cry Detection
A MATLAB app that used CNNs to train a neural network to detect a baby crying on an audio input.
### 1. Dataset

[ESC-50](https://github.com/karolpiczak/ESC-50) was used as the dataset to train the network in the project. The dataset was preprocessed before being used in training. In the preprocessing, mel spectogram data of the audios in the dataset were extracted. The preprocessing process consists of two steps. 
  - In the first step, the files in the raw dataset are placed in folders according to their categories.
  - In the second step, the data to be trained was obtained by running the [prepareData.m](https://github.com/Haki-Malai/baby-cry-detection/blob/main/code/prepareData.m) matlab file. As a result, the ESC-50-MelSpec folder is obtained.

### 2. Training
For training, [train.m](https://github.com/Haki-Malai/baby-cry-detection/blob/main/code/train.m) should run the matlab file. This file uses [resizeImage.m](https://github.com/Haki-Malai/baby-cry-detection/blob/main/code/resizeImage.m) to resize images. Before starting the train process, make sure the ESC-50-MelSpec folder is prepared.

#### Epoch Results in Training
<a href="https://ibb.co/X4KbKJm"><img src="https://i.ibb.co/W3M6MKS/temp1.png" alt="temp1" border="0"></a>

#### Training Progress Chart
<a href="https://ibb.co/SssPbLp"><img src="https://i.ibb.co/vwwHpt8/temp2.png" alt="temp2" border="0"></a>

#### Confusion Matrix For Test Data
<a href="https://ibb.co/LJYhjXf"><img src="https://i.ibb.co/KLbz4pH/temp3.png" alt="temp3" border="0"></a>

### 3. Baby Cry Detection Application
In this application, it has been determined whether the sound coming from the microphone is the baby crying sound. Before starting the application, trainedNet.mat (Trained network) file must be in the same path as BabyCryDetection.mlapp. There are two buttons in the application.
  - Start: It is used to start listening from the microphone. After clicking the button, Microphone Listening color turns green. When stopped, it turns white. 
  - Stop: It is used to stop listening from the microphone.<br>
<a href="https://imgbb.com/"><img src="https://i.ibb.co/Gd6z1LY/temp4.png" alt="temp4" border="0"></a>

If a baby cry is detected after the microphone starts to listen, the "Baby Cry" color will be red, otherwise it will be white. In addition, Mel Spectogram of microphone audio is displaying in Application.
