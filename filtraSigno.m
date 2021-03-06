function [y signo] = filtraSigno(x)
% Esta funcion se fija el signo de la mayoria de los elementos de un
% arreglo de nx2 y elimina los que tienen el signo contrario o cero. Para
% los negativos, les aplica modulo

n = size(x,1);
i = 0;
for k = 1:n
    if x(k,2) < 0
        i = i+1;
    end
end

% i me dice cuantos negativos hay
if i <= n/2
    y = x(x(:,2)>0,:);
    signo = 1;
else
    y = abs(x(x(:,2)<0,:));
    signo = -1;
end

end

