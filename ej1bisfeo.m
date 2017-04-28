%% %% Ejercicio 1bis: Utilizando Gauss-Newton para f(x) = k*a^x 
%% Esta es la funcion que mide el error
d = @(tita) Y-tita(2).*tita(1).^X;

%% Gauss - Newton
tita0_ej1b = [a k]; %Comienzo con los valores iniciales arrojados por la estimacion anterior
tita_ej1b = tita0_ej1b;
iterador = 0;
err1 = sum(d(tita_ej1b).^2); %Yo quiero minimizar la suma de los cuadrados de las desviaciones
err = err1+1; %artilugio para entrar al ciclo

while iterador<1000 && norm(err-err1)>0.001 %Notar que el ciclo termina porque hay una cantidad maxima de iteraciones
    % Gauss-Newton propiamente dicho
    err = err1;
    J = [-tita_ej1b(2)*log(tita_ej1b(1))*tita_ej1b(1).^X, -tita_ej1b(1).^X]; %tita = [a,k]
    % Matriz jacobiana cuya expresion resulta del calculo analitico.
    [q r] = qr(J);
    qy = q'*(-d(tita_ej1b));
    h = (r\qy)';
    tita_ej1b = tita_ej1b + h;
    iterador = iterador + 1;
    err1 = sum(d(tita_ej1b).^2);
end
