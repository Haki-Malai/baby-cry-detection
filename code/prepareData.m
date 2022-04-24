clear;
clf;

% Extract melspectogram images of ESC-50 dataset

sourceFolder = fullfile('./ESC-50);
targetFolder = fullfile('ESC-50-MelSpec/');
ads = audioDatastore(sourceFolder, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
