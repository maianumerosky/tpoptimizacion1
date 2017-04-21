%%      TP 1
%Ingreso y procesamiento inicial de datos
load('datosTP1-2017.mat')
datosInp = datos1; %Ingresar datos de entradas. 1 columna var indep.
logDatosInp = log(datosInp);
n = size(datosInp,1);
A = ones(n,2);
A(:,1) = logDatosInp(:,1);
y = logDatosInp(:,2);

%% Calculo
[q r] = qr(A);
qy = q'*y;
logSol = despluu(r,qy);

%% Recupero parametros
a = exp(logSol(1));
k = exp(logSol(2));