function [mag, phase] = CeNNGabor(L,Bb,n)
% imrgb = imread('peppers.png'); % Ejemplo
% im = imrgb;
% im1 = rgb2lab(im);
% L = im1(:,:,1)./100;
L = double(L);
y = L;
[row, col] = size(L);

Ab = zeros(31,31);
xa = zeros(row, col);
z = 0;

for i=1:n % Neural Network processing
    
    x = -xa + conv2(y,Ab,'same')+conv2(L,Bb(:,:,i),'same')-z;
    y = 0.5*(abs(x+1)-abs(x-1));
%     y = x;
    xa = x;  
end
mag = subplus(y);
% mag = abs(y);
phase = angle(y);
% y2 = conv2(L,Bb,'same');
% y3 = abs(y2/max(y2(:))); 
% y4 = y3-mean2(y3);

% subplot 221,imshow(abs(y),[]);title('red');
% subplot 222,imshow(abs(y4),[]);title('gabor');
% subplot 223,imshow(real(Bb),[]);title('filtro');

% imshow(real(Bb),[]);title('Filtro con orientaci?n de 135?');

end
