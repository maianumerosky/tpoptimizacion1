function [y signo] = filtraSigno3(x)
% Esta funcion se fija el signo del 10% de los elementos de mayor modulo y
% se queda con aquellos datos que tengan el mismo signo que la mayoria de
% este.

porcent = 10;
n = size(x,1);
cantDatos = round(n*porcent/100); %Se corresponde con la cantidad de datos a ser 
%mirados

absx = abs(x(:,2)); %Obtengo el modulo de la componente "y" de los elementos.
[orden ind] = sort(absx,'descend'); %Los ordeno de mayor a menor.

yMayoresMod = x(ind(1:cantDatos),2); %Me quedo con el 10% de los datos

cantPos = sum(yMayoresMod>0); %Cuento cuantos positivos
cantNeg = sum(yMayoresMod<0); %Cuento cuantos negativos

if cantPos >= cantNeg
    y = x(x(:,2)>0,:);
    signo = 1;
else
    y = abs(x(x(:,2)<0,:));
    signo = -1;
end

% Nota x(x(:,2)>0,:) Significa que me quedo con las filas que en las
% cumplen con la condicion x(:,2)>0. O sea los pares de datos cuya
% coordenada y es positiva. Analogo con x(x(:,2)<0,:) y los datos cuya
% componente y es negativa.

end

