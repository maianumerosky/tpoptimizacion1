function [y signo] = filtraSigno2(x)
% Esta función se fija el signo de la del elemento de mayor módulo de un
% arreglo de nx2 y elimina los que tienen el signo contrario o cero. Para
% los negativos, les aplica módulo

n = size(x,1);

[maximo arg] = max(abs(x(:,2)));

if  x(arg,2)> 0
    y = x(x(:,2)>0,:);
    signo = 1;
else
    y = abs(x(x(:,2)<0,:));
    signo = -1;
end

end

