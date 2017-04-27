%%      TP 1
clear all, close all

%Ingreso y procesamiento inicial de datos
load('datosTP1-2017.mat')
datosInp = datos2; %Ingresar datos de entradas. 1 columna var indep.
X = datosInp(:,1);
Y = datosInp(:,2);

%% %% Ejercicio 1

%% Chequeamos signos y eliminamos los otros datos
[filtrados signo] = filtraSigno2(datosInp);

%% Linealizamos
DatosFiltLog = [filtrados(:,1) log(filtrados(:,2))];
%Observar que la funcion filtrados devuelve los datos de la variable
%dependiente con signo positivo. Todo el problema se resuelve como si
%fueran valores positivos.

%% Matriz para cuadrados minimos
n = size(filtrados,1);
A = ones(n,2);
A(:,1) = DatosFiltLog(:,1); %En la primer columna van los datos de la variable independiente, la segunda columna son unos
y = DatosFiltLog(:,2);

%% Calculo
[q r] = qr(A);
qy = q'*y;
logSol = r\qy; %Los valores obtenidos son los logaritmos de los que se buscan
% Por como fue definida A, el primer valor corresponde a log(a) y el
% segundo valor a log(k)

%% Recupero parametros
a = exp(logSol(1));
k = exp(logSol(2))*signo;
% Si los datos eliminados fueron los positivos, entonces k es negativo,
% sino es positivo.

%% Calculo error
er = sum((Y - k*a.^X).^2);


%% %% Utilizando Gauss-Newton para f(x) = k*a^x
%% Esta es la funcion que mide el error

d = @(tita) Y-tita(2).*tita(1).^X;

%% Gauss - Newton
tita0 = [a k]; %Comienzo con los valores iniciales arrojados por la estimacion anterior
tita = tita0;
iterador = 0;
err1 = sum(d(tita).^2); %Yo quiero minimizar la suma de los cuadrados de las desviaciones
err = err1+1; %artilugio para entrar al ciclo

while iterador<1000 && norm(err-err1)>0.001
    err = err1;
    J = [-tita(2)*log(tita(1))*tita(1).^X, -tita(1).^X];
    [q r] = qr(J);
    qy = q'*(-d(tita));
    h = (r\qy)';
    tita = tita + h;
    iterador = iterador + 1;
    err1 = sum(d(tita).^2);
end

%% Ejercicio 2
d = @(tita) Y-tita(2).*exp(tita(1).*X)-tita(3);

%% Gauss - Newton
tita0 = [log(a), k, 0];
tita = tita0;
iterador = 0;
errr1 = sum(d(tita).^2);
errr = errr1+1; %artilugio para entrar al ciclo

while iterador<1000 && norm(errr-errr1)>0.001
    errr = err1;
    J = [-X*tita(2).*exp(tita(1)*X), -exp(tita(1)*X), -1*ones(length(X),1)];
    [q r] = qr(J);
    qy = q'*(-d(tita));
    h = (r\qy)';
    tita = tita + h;
    iterador = iterador + 1;
    errr1 = sum(d(tita).^2);
end

%% Salida grafica
figure
hold all
plot(X,Y,'.')
x1 = min(X):0.002:max(X);
y1 = k.*a.^x1;
% Estas dos ultimas sirven para graficar la funcion estimada por sobre los
% datos de base
plot(x1,y1)
y1bis = tita(2).*tita(1).^x1;
plot(x1,y1bis)
y2 = tita(2).*exp(tita(1).*x1)+tita(3);
plot(x1,y2)
legend('Datos', 'Regresión exponencial por linealizacion', 'Regresion exponencial Gauss-Newton','Regresion exponencial generalizada')
title('Datos 2')
text(.5,.1,{['Error = ',num2str(er)],['Error = ',num2str(err1)],['Error = ',num2str(errr1)]},'Units','normalized')
