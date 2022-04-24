clear;
clf;

% Extract melspectogram images of ESC-50 dataset

sourceFolder = fullfile('./ESC-50');
targetFolder = fullfile('ESC-50-MelSpec/');
ads = audioDatastore(sourceFolder, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

% Read audio and get mel spectogram data of the audio
