function values = histo(ret_img, a, b, bin)
%Los intervalos se obtuvieron experimentalmente en la pagina colorizer.org
abedges = 0:389/bin:389;
% Solo para ilustrar
% a2 = (a + 87)/2;
% b2 = (b + 108 + 186)/2;
% Original
a2 = a + 87;
b2 = b + 108 + 186;
values = zeros(numel(unique(ret_img)),bin);
counter = 1;
for jj = unique(ret_img)'
[rows,cols] = find(ret_img == jj);
ind = sub2ind(size(ret_img),rows,cols);
va = a2(ind);
vb = b2(ind);
vab = [va(:) vb(:)];
[values(counter,:),~] = histcounts(vab,abedges);
counter = counter + 1;
end
values = values/max(values(:));
% Para visualizar
% bar(values(1,:))
% pause();
end