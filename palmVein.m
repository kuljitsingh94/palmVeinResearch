%read image
I=imread('1_01_s.jpg');
figure;
subplot(3,3,1)
    imshow(I)
    title('Grayscale image') 

%applying median filter to remove noise
K = medfilt2(I);
subplot(3,3,2)
    imshow(K)
    title('median filtering')

%applying CLAHE
J = adapthisteq(I,'clipLimit',0.075,'Distribution','rayleigh');
subplot(3,3,3)
    imshow(J)
    title('CLAHE')

%median filtering to remove the noise
K1 = medfilt2(J);
subplot(3,3,1)
    imshow(K1)
    title('median filtering2')

   K1 = medfilt2(K1);
subplot(3,3,4)
    imshow(K1)
    title('median filtering2') 
    
%blurring images for accuracy
%Adaptive thresholding
T = adaptthresh(K1, 0.7);
BW = imbinarize(K1,T);
subplot(3,3,5)
    imshow(BW)
    title('Adaptive threshold')

%T1 = adaptthresh(K1,0.5,'ForegroundPolarity','dark');
%figure,imshow(T1), title('foreground');
%BW = imbinarize(K1,T1);
%figure,imshow(BW), title('new thresholding');

se1 = strel('line',6,20);
erodedBW = imdilate(BW,se1);
subplot(3,3,6) 
    imshow(erodedBW,[])
    title('dilated image')

BW3 = bwperim(erodedBW);
subplot(3,3,7) 
    imshow(BW3,[])
    title('perimeter extraction')
    
bipoints = bwmorph(BW3, 'branchpoints');
subplot(3,3,8)
    imshow(bipoints, [])
    title('bifurcation points')

endpoints = bwmorph(BW3,'endpoints');
subplot(3,3,9)
    imshow(endpoints)
    title('endpoints')
    