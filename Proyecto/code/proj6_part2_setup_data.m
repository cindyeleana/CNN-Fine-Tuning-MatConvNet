function imdb = proj6_part2_setup_data(averageImage)


SceneJPGsPath='..\data\Falls';



num_train_per_category = 35;
num_test_per_category  = 35; %can be up to 110 28
total_images = 2*num_train_per_category + 2 * num_test_per_category;
image_size = [227 227]; %downsampling data for speed and because it hurts
% accuracy surprisingly little

imdb.images.data   = zeros(image_size(1), image_size(2), 3, total_images, 'single');
imdb.images.labels = zeros(1, total_images, 'single');
imdb.images.set    = zeros(1, total_images, 'uint8');
image_counter = 1;
  

categories = {'fall', 'notfall'};
          
sets = {'train', 'test'};

fprintf('Loading %d train and %d test images from each category\n', ...
          num_train_per_category, num_test_per_category)
fprintf('Each image will be resized to %d by %d\n', image_size(1),image_size(2));

%Read each image and resize it to 224x224
for set = 1:length(sets)
    for category = 1:length(categories)
        cur_path = fullfile( SceneJPGsPath, sets{set}, categories{category});
        cur_images = dir( fullfile( cur_path,  '*.jpg') );
        
        if(set == 1)
            fprintf('Taking %d out of %d images in %s\n', num_train_per_category, length(cur_images), cur_path);
            cur_images = cur_images(1:num_train_per_category);%change here for train all
        elseif(set == 2)
            fprintf('Taking %d out of %d images in %s\n', num_test_per_category, length(cur_images), cur_path);
            cur_images = cur_images(1:num_test_per_category); %change here to train all
        end

        for i = 1:length(cur_images)

            cur_image = imread(fullfile(cur_path, cur_images(i).name));
            cur_image = single(cur_image);
            %mean edited juan andres
            %cur_image=cur_image-mean2(cur_image);
            if(size(cur_image,3) > 1)
                %fprintf('color image found %s\n', fullfile(cur_path, cur_images(i).name));
                %fprintf('image 3 channels \n');
            end
            cur_image = imresize(cur_image, image_size);
             
            %cur_image=cat(3, cur_image, cur_image, cur_image);

                       
            % Stack images into a large 224 x 224 x 1 x total_images matrix
            % images.data
            imdb.images.data(:,:,:,image_counter) = cur_image;            
            imdb.images.labels(  1,image_counter) = category;
            imdb.images.set(     1,image_counter) = set; %1 for train, 2 for test (val?)
            
            image_counter = image_counter + 1;
            
            
        end
    end
end

   
% VGG-F accepts 3 channel (RGB) images. The 15 scene database contains
% grayscale images. There are two possibilities: modify the first layer of
% VGG-F to accept 1 channel images, or concatenate the grayscale images
% with themselves (e.g. cat(3, im, im, im)) to make an RGB image. The
% latter is probably easier and safer.
  
% VGG-F expects input images to be normalized by subtracting the average
% image, just like in Part 1. VGG-F provides a 224x224x3 average image in
% net.normalization.averageImage.
