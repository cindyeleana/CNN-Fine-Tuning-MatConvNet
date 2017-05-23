  run C:/matconvnet-1.0-beta16/matlab/vl_setupnn
  
  
  net = load('cnn_fall.mat');

  %Leo el video
  obj = VideoReader('vtest.mp4');

  nframes = get(obj, 'NumberOfFrames');
  c=0;
  isF=0;
  depVideoPlayer = vision.DeployableVideoPlayer;
  bestAnt=0;
  c2=0;
  for k = 1 : nframes
  frame = read(obj, k);
  [y,x,z] = size(frame);
  %frame=imresize(frame,[y*0.5,x*0.5]);
  frame1=frame;
  if(c==1)
          c=0;

          
          if(c2==11)
              best = red(frame1, net);
              c2=0;
              if(bestAnt==best && best==1)

                isF=1;
              else
                isF=0;
              end
              bestAnt=best;
              
          end
          c2=c2+1;
  end
  
  if(isF==1)
    frame=insertText(frame,[50 50 ],'FALL','FontSize',25,'TextColor','white');
  end
  step(depVideoPlayer, frame);
  c=c+1;
  end
  
  
  