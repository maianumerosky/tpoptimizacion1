%%      TP 1
clear all, close all

%Ingreso y procesamiento inicial de datos
load('datosTP1-2017.mat')
datosInp = datos2; %Ingresar datos de entrada. Primer columna variable independiente.
X = datosInp(:,1);
Y = datosInp(:,2);

%% %% Ejercicio 1: 

%% Chequeamos signos y eliminamos los otros datos
[filtrados signo] = filtraSigno3(datosInp);
%Se puede elegir entre tres metodos de filtrados: filtraSigno;
%filtraSigno2; filtraSigno3. En el informe se detalla que toma en cuenta
%cada una de las funciones.

%Observar que la funcion filtrados devuelve los datos de la variable
%dependiente con signo positivo. Todo el problema se resuelve como si
%fueran valores positivos. Al final, segun el signo asociado a la variable
%"k" se adecúa a los datos originales.

%% Linealizamos
DatosFiltLog = [filtrados(:,1) log(filtrados(:,2))];

%% Matriz para cuadrados minimos
n = size(filtrados,1);
A = ones(n,2);
A(:,1) = DatosFiltLog(:,1); %En la primer columna van los datos de la variable independiente, la segunda columna son unos.
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
% Si los datos eliminados fueron los positivos entonces k es negativo,
% sino es positivo.

%% Calculo error
er = sum((Y - k*a.^X).^2); %Miro la suma de los cuadrados de las desviaciones.

%% %% Ejercicio 1bis: Utilizando Gauss-Newton para f(x) = k*e^bx 
% Notar que con b = log(a) este problema se reduce al caso anterior
% permitiendo su comparacion.

%% Esta es la funcion que mide el error
d = @(tita) Y-tita(2).*exp(tita(1).*X);

%% Gauss - Newton
tita0_ej1b = [log(a) k]; %Comienzo con los valores iniciales arrojados por la estimacion anterior
tita_ej1b = tita0_ej1b;
iterador = 0;
err1 = sum(d(tita_ej1b).^2); %Yo quiero minimizar la suma de los cuadrados de las desviaciones
err = err1+1; %artilugio para entrar al ciclo

while iterador<1000 && norm(err-err1)>0.001 %Notar que el ciclo termina porque hay una cantidad maxima de iteraciones
    % Gauss-Newton propiamente dicho
    err = err1;
    J = [-tita_ej1b(2).*X.*exp(tita_ej1b(1).*X), -exp(tita_ej1b(1).*X)]; %tita = [a,k]
    % Matriz jacobiana cuya expresion resulta del calculo analitico.
    [q r] = qr(J);
    qy = q'*(-d(tita_ej1b));
    h = (r\qy)';
    tita_ej1b = tita_ej1b + h;
    iterador = iterador + 1;
    err1 = sum(d(tita_ej1b).^2);
end


%% %% Ejercicio 2
d = @(tita) Y-tita(2).*exp(tita(1).*X)-tita(3);

%% Gauss - Newton
tita0_ej2 = [log(a), k, 0]; %Comienzo con los valores iniciales arrojados por la estimacion del ejercicio 1.
tita_ej2 = tita0_ej2;
iterador = 0;
errr1 = sum(d(tita_ej2).^2); %Yo quiero minimizar la suma de los cuadrados de las desviaciones
errr = errr1+1; %artilugio para entrar al ciclo

while iterador<1000 && norm(errr-errr1)>0.001
    %Gauss-Newton propiamente dicho
    errr = err1;
    J = [-X*tita_ej2(2).*exp(tita_ej2(1)*X), -exp(tita_ej2(1)*X), -1*ones(length(X),1)]; %tita = [b,k,c]
    % Matriz jacobiana cuya expresion resulta del calculo analitico.
    [q r] = qr(J);
    qy = q'*(-d(tita_ej2));
    h = (r\qy)';
    tita_ej2 = tita_ej2 + h;
    iterador = iterador + 1;
    errr1 = sum(d(tita_ej2).^2);
end

%% Salida grafica
figure
hold all
plot(X,Y,'.') %Ploteo datos crudos.
x1 = min(X):0.002:max(X); 
%Creo un vector cuyos valores esten comprendidos dentro del rango de la
%variable independiente de los datos crudos. Sobre este vector calculo la
%estimacion y comparo.
y1 = k.*a.^x1; %Estimacion ejercicio 1
plot(x1,y1,'Linewidth',3)
y1bis = tita_ej1b(2).*exp(tita_ej1b(1).*x1); %Estimacion ejercicio 1 bis
plot(x1,y1bis,'Linewidth',3)
y2 = tita_ej2(2).*exp(tita_ej2(1).*x1)+tita_ej2(3); %Estimacion ejercicio 2
plot(x1,y2,'Linewidth',3)
legend('Datos', 'Regresion exponencial por linealizacion', 'Regresion exponencial Gauss-Newton','Regresion exponencial generalizada')

if errr1 <= err1 && errr1 <= er
    text(.5,.1,{['Error Ej 1= ',num2str(er)],['Error Ej 1bis= ',num2str(err1)],['\color{red}','Error Ej 2= ',num2str(errr1)]},'Units','normalized')
elseif err1 <= errr1 && err1 <= er
    text(.5,.1,{['Error Ej 1= ',num2str(er)],['\color{red}','Error Ej 1bis= ',num2str(err1)],['\color{black}''Error Ej 2= ',num2str(errr1)]},'Units','normalized')
elseif er <= err1 && er <= errr1
    text(.5,.1,{['\color{red}','Error Ej 1= ',num2str(er)],['\color{black}''Error Ej 1bis= ',num2str(err1)],['Error Ej 2= ',num2str(errr1)]},'Units','normalized')
end
