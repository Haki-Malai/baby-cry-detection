clear;
clf;

% Extract melspectogram images of ESC-50 dataset

sourceFolder = fullfile('./ESC-50');
targetFolder = fullfile('ESC-50-MelSpec/');
ads = audioDatastore(sourceFolder, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

% Read audio and get mel spectogram data of the audio
while hasdata(ads)
  % Read audio
  [audioInput, info] = read(ads);
  newFileName = strrep(info.FileName, 'ESC-50', 'ESC-50-MelSpec');
  
  if exist(newFileName, "file")
    continue;
  end
  
  % Generate mel spectogram of the audio data
  [S, cF, t] = melSpectrogram(audioInput, info.SampleRate);
  
  % Convert dB for plotting
  s = 10*log10(S+eps);
  
  % Show melspectogram image
  ah = axes('Units', 'normalized', 'Position', [0 0 1 1]);
  for j = 1:size(S, 3)
    figure(j);
    surf(t, cF, S(:,:,j), 'EdgeColor', 'none');
    view([0, 90])
    axis(ah, 'tight')
  end
  drawnow;
  
  filedir = fileparts(newFileName);
  if ~exists(filedir, 'dir')
    mkdir(filedir);
  end
  
  % Save image to 'ESC-50-MelSpec' folder
  imwrite(getframe(gcf).cdata, fullfule(newFileName));
end
