function [y signo] = filtraSigno2(x)
% Esta funcion se fija el signo de la del elemento de mayor modulo de un
% arreglo de nx2 y elimina los que tienen el signo contrario o cero. Para
% los negativos, les aplica modulo

n = size(x,1);

[maximo arg] = max(abs(x(:,2))); 
% "maximo" es el valor de mayor modulo, "arg" es el indice.

if  x(arg,2)> 0 %Si la componente "y" de mayor modulo es positivo
    y = x(x(:,2)>0,:); %Entonces quedarse solo con los datos positivos
    signo = 1;
else
    y = abs(x(x(:,2)<0,:)); %Sino quedarse solo con los datos negativos
    signo = -1; 
end

% Nota x(x(:,2)>0,:) Significa que me quedo con las filas que en las
% cumplen con la condicion x(:,2)>0. O sea los pares de datos cuya
% coordenada y es positiva. Analogo con x(x(:,2)<0,:) y los datos cuya
% componente y es negativa.

end



