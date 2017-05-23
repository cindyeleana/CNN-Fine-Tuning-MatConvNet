run  C:/matconvnet-1.0-beta16/matlab/vl_setupnn


net = load('cnn_fall.mat');
% Ruta de la carpeta con im?genes a evaluar
miFolder='../code/imgs';

if ~isdir(miFolder)
errorMensaje = sprintf('Error: El folder no existe:\n%s', miFolder);
uiwait(warndlg(errorMensaje));
return;
end
filePatron = fullfile(miFolder, '*.jpg');
jpegFil = dir(filePatron);

%Ruta a guardar archivo txt con los resultados (Scores de las im?genes)
fid=fopen('pruebafalls.txt','w'); 
c=0;
for k = 1:length(jpegFil)
    baseFN = jpegFil(k).name;
    fullFN = fullfile(miFolder, baseFN);
    I=imread(fullFN);
    im_ = single(I) ; % note: 0-255 range
    im_ = imresize(im_, net.net.meta.normalization.imageSize(1:2)) ;
    im_ = im_ - net.net.meta.normalization.averageImage ;
    % vl_simplenn_display(net.net, 'inputSize', [224 224 3 50])
    net.net.layers{23} = struct('type', 'softmax') ;
    % run the CNN
    res = vl_simplenn(net.net, im_) ;
    % show the classification result
    scores = squeeze(gather(res(end).x)) ;
    [bestScore, best] = max(scores) ;

    switch best
       case  1
        c=c+1;
        fprintf(fid,'Imagen: %s    Class: Fall(%d)  Score: %.3f \n',baseFN, best, bestScore); 
        case 2
        fprintf(fid,'Imagen: %s    Class: notFall(%d)  Score: %.3f \n',baseFN, best, bestScore); 
    end 
%   
     
end
fprintf(fid,'\n\n\n Num predicciones correctas: %d ', c); 
fclose(fid);





