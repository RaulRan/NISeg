function Bb = kGabor
% kernels de Gabor
jcol = 1:1:31;
icol = 1:1:31;
[icol,jcol] = meshgrid(icol,jcol);
ic = 16;
jc = 16;
da = 2; % desviaciones estandar, ancho - largo
db = 6;
l = 3;
Bb = zeros(31,31,4);
for n=0:3
phi = (n)*pi/4;
Bb(:,:,n+1) = exp(-(((icol-ic)*cos(phi)+(jcol-jc)*sin(phi)).^2)/(da^2)-...
(((jcol-jc)*cos(phi)-(icol-ic)*sin(phi)).^2)/(db^2))...
.*cos(2*pi*((icol-ic)*cos(phi)+(jcol-jc)*sin(phi))/l)+...
1i*exp(-(((icol-ic)*cos(phi)+(jcol-jc)*sin(phi)).^2)/(da^2)-...
(((jcol-jc)*cos(phi)-(icol-ic)*sin(phi)).^2)/(db^2)).*...
sin(2*pi*((icol-ic)*cos(phi)+(jcol-jc)*sin(phi))/l);
end
end