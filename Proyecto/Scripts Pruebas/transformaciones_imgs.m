

%--- Carpeta de origen donde se leer?n los archivos a transfromar
miFolder='C:\Users\usercidis\Documents\ImagenesDataset';
if ~isdir(miFolder)
errorMensaje = sprintf('Error: La carpeta no existe: \n%s', miFolder);
uiwait(warndlg(errorMensaje));
return;
end

%--- Lectura de archivos con extensi?n .jpg
filePatron = fullfile(miFolder, '*.jpg');
jpegFil = dir(filePatron);

for k = 1:length(jpegFil)
baseFN = jpegFil(k).name;
fullFN = fullfile(miFolder, baseFN);
I=imread(fullFN);


%--------------------------rename-----------------------------

 Resultados='C:\Users\usercidis\Documents\rename\';
 %Nombre de la imagen resultante
 newFileName = sprintf('obstacle_%d.jpg',k);
 imwrite(I,[Resultados newFileName]);
 
%--------------------------resize-----------------------------
[y,x,z] = size(I);
 I2=imresize(I,[y*0.5,x*0.5]);
 Resultados='C:\Users\usercidis\Documents\resize\';
 newFileName = sprintf('obstacle_rz1%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);

 
% %---------------------------blur------------------------------
 I2 = imgaussfilt(I, 2); 
 Resultados='C:\Users\usercidis\Documents\blur\';
 newFileName = sprintf('obstacle_blur_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);
 
   
% -------------------------Flip--------------------------------

 I2 = flip(I ,2);           %# horizontal flip
 Resultados='C:\Users\usercidis\Documents\fliph\';
 newFileName = sprintf('obstacle_fliph_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);

 

 I2 = flip(I ,1);           %# vertical flip
 Resultados='C:\Users\usercidis\Documents\flipv\';
 newFileName = sprintf('obstacle_flipv_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);
 
 
% -------------------------Rotate------------------------------
 I2=imrotate(I,45);
 Resultados='C:\Users\usercidis\Documents\rot45\';
 newFileName = sprintf('obstacle_rot45_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);
 
 I2=imrotate(I,90);    
 Resultados='C:\Users\usercidis\Documents\rot90\';
 newFileName = sprintf('obstacle_rot90_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);
 
 I2=imrotate(I,135);   
 Resultados='C:\Users\usercidis\Documents\rot135\';
 newFileName = sprintf('obstacle_rot135_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);
 
 I2=imrotate(I,180);    
 Resultados='C:\Users\usercidis\Documents\rot180\';
 newFileName = sprintf('obstacle_rot180_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);
 
 I2=imrotate(I,250);   
 Resultados='C:\Users\usercidis\Documents\rot250\';
 newFileName = sprintf('obstacle_rot250_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);

 
% --------------------salt-pepper-noise------------------------
 I2=imnoise(I,'salt & pepper', 0.1);
 Resultados='C:\Users\usercidis\Documents\salt_pepper1\';
 newFileName = sprintf('obstacle_sp1_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);
 
 I2=imnoise(I,'salt & pepper', 0.02);
 Resultados='C:\Users\usercidis\Documents\salt_pepper2\';
 newFileName = sprintf('obstacle_sp2_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);
 
 
% % ----------------------Gaussian Noise-------------------------
 I2 = imnoise(I, 'gaussian', 0,0.05);
 Resultados='C:\Users\usercidis\Documents\gaussNoise1\';
 newFileName = sprintf('obstacle_gauss1_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);
 
 I2 = imnoise(I, 'gaussian', 0,0.02);
 Resultados='C:\Users\usercidis\Documents\gaussNoise2\';
 newFileName = sprintf('obstacle_gauss2_%d.jpg',k);
 imwrite(I2,[Resultados newFileName]);
%I2 = imcrop(I,[100 25 400 300]);

end




