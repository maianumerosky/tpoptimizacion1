%%      TP 1
%Ingreso y procesamiento inicial de datos
load('datosTP1-2017.mat')
datosInp = datos1; %Ingresar datos de entradas. 1 columna var indep.
%DatosInpLog = [datosInp(:,1) log(datosInp(:,2))];
%n = size(datosInp,1);

%% Chequeamos signos y eliminamos los otros datos
[filtrados signo] = filtraSigno2(datosInp);

%%
DatosFiltLog = [filtrados(:,1) log(filtrados(:,2))];

%% cuadrados mínimos
n = size(filtrados,1);
A = ones(n,2);
A(:,1) = DatosFiltLog(:,1);
y = DatosFiltLog(:,2);

%% Calculo
[q r] = qr(A);
qy = q'*y;
logSol = r\qy;

%% Recupero parametros
a = exp(logSol(1));
k = exp(logSol(2))*signo;

%% Salida grafica
figure
hold all
plot(datosInp(:,1),datosInp(:,2),'.')
xx = min(datosInp(:,1)):0.002:max(datosInp(:,1));
yy = k.*a.^xx;
plot(xx,yy)