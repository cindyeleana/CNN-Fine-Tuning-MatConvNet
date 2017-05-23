run ../scripts/matconvnet-1.0-beta16/matlab/vl_setupnn


  net = load('cnn_fall.mat');

  %Leo el video
% obj = VideoReader('videos/v2.avi');
% cam = ipcam('http://200.126.19.93/cgi-bin/mjpeg?session_id=1&buffer=0&prio=high&frame=4');
% cam = ipcam('http://200.126.19.126/cgi-bin/mjpeg?session_id=1&buffer=0&prio=high&frame=4');
  cam = ipcam('http://200.126.19.126/cgi-bin/mjpeg?session_id=1&buffer=0&prio=high&frame=4');
% cam = ipcam('rtsp://200.126.19.126/jpeg?stream=0&mode=live');
  %nframes = get(obj, 'NumberOfFrames');
  c=0;
  isF=0;
  depVideoPlayer = vision.DeployableVideoPlayer;
  bestAnt1=0;
  bestAnt2=0;
  c2=0;
% for k = 1 : nframes
 while(1)
      k=1;
    % frame = read(obj, k);
      frame=snapshot(cam);
      [y,x,z] = size(frame);
    % frame=imresize(frame,[y*0.5,x*0.5]);
      frame1=frame;
      if(c2==7)
        bestAnt1=red(frame1, net);
      end
      if(c2==14)
        best = red(frame1, net);
        c2=0;
          if(bestAnt2==best && bestAnt1==best && best==1)
            isF=1;
          else
            isF=0;
          end
          bestAnt=best;

      end
  c2=c2+1;

  if(isF==1)
    frame=insertText(frame,[50 50 ],'FALL Detected','FontSize',25,'TextColor','white');
  end
  step(depVideoPlayer, frame);
  c=c+1;
  k=k+1;
end