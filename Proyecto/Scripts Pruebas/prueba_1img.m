run  C:/matconvnet-1.0-beta16/matlab/vl_setupnn


net = load('cnn_fall.mat');
im = imread('prueba_img.jpg') ;
im_ = single(im) ; % note: 0-255 range
im_ = imresize(im_, net.net.meta.normalization.imageSize(1:2)) ;
im_ = im_ - net.net.meta.normalization.averageImage ;
% vl_simplenn_display(net.net, 'inputSize', [224 224 3 50])
net.net.layers{23} = struct('type', 'softmax') ;

% run the CNN
res = vl_simplenn(net.net, im_) ;
% show the classification result
scores = squeeze(gather(res(end).x)) ;

disp(scores);
[bestScore, best] = max(scores) ;
figure(1) ; clf ; imagesc(im) ;

% 
switch best
   case  1
   title(sprintf('Fall (%d), score %.3f',...
     best, bestScore));
    case 2
    title(sprintf('NotFall (%d), score %.3f',...
    best, bestScore));
end

