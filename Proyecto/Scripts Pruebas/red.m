function best= red(img, net)

im_ = single(img) ; % note: 0-255 range
im_ = imresize(im_, net.net.meta.normalization.imageSize(1:2)) ;
im_ = im_ - net.net.meta.normalization.averageImage ;
% vl_simplenn_display(net.net, 'inputSize', [224 224 3 50])
net.net.layers{23} = struct('type', 'softmax') ;
% run the CNN
res = vl_simplenn(net.net, im_) ;
% show the classification result
scores = squeeze(gather(res(end).x)) ;
[bestScore, best] = max(scores) ;
%disp(best); 