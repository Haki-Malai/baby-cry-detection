clear;
clf;

% TRAIN CNN for ESC-50 dataset.

% Create datasource from folders
sourceFolder = fullfile('./ESC-50-MelSpec');
imds = imageDatastore(sourceFolder,"IncludeSubfolders",true,"LabelSource","foldernames");
% Resize image
imds.ReadFcn = @resizeImage;
labelTable = countEachLabel(imds);
numClasses = size(labelTable,1);

% Split data for train, validation and test
[imdsTrain, imdsVal, imdsTest] = splitEachLabel(imds,0.7,0.2);

% efficientnetb0 CNN
net = efficientnetb0;

lgraph = layerGraph(net);

% Change efficientnetb0 network for ESC-50 
lgraph = removeLayers(lgraph,{'efficientnet-b0|model|head|dense|MatMul', 'Softmax', 'classification'});
lgraph.Layers(end)

lgraph = addLayers(lgraph,fullyConnectedLayer(numClasses,'Name','FCFinal'));
lgraph = addLayers(lgraph,softmaxLayer('Name','softmax'));
lgraph = addLayers(lgraph,classificationLayer('Name','classOut'));

lgraph = connectLayers(lgraph,'efficientnet-b0|model|head|global_average_pooling2d|GlobAvgPool','FCFinal');
lgraph = connectLayers(lgraph,'FCFinal','softmax');
lgraph = connectLayers(lgraph,'softmax','classOut');

% Create training options
miniBatchSize = 128;
options = trainingOptions('adam', ...
    'MaxEpochs',20, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsVal, ...
    'ValidationFrequency',5, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.5, ...
    'LearnRateDropPeriod',2, ...
    "ExecutionEnvironment","parallel", ...
    "Plots", "training-progress");

% Start training
[trainedNet, netInfo] = trainNetwork(imdsTrain,lgraph,options);

% Test network with test data
YPred = classify(trainedNet,imdsTest);
YTest = imdsTest.Labels;

idx = 1;
validationPredictionsPerFile = categorical;
for ii = 1:numel(imdsTest.Files)
    validationPredictionsPerFile(ii,1) = mode(YPred(ii));
end

% Create confusion matrix
figure('Units','normalized','Position',[0.2 0.2 0.5 0.5]);
cm = confusionchart(imdsTest.Labels,validationPredictionsPerFile);
cm.Title = sprintf('Confusion Matrix for Test Data \nAccuracy = %0.2f %%',mean(validationPredictionsPerFile==imdsTest.Labels)*100);
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';

% Save trained network
save trainedNet;
