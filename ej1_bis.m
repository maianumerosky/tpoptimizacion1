%% Cargo datos
load('datosTP1-2017.mat')
datosInp = datos1;
main
x = filtrados(:,1);
y = filtrados(:,2);

%% Esta es la funciòn a minimizar

d = @(tita) y-tita(2).*tita(1).^x;

%% Gauss - Newton
tita0 = [a, 2];
tita = tita0;
iterador = 0;
err1 = d(tita);
err = err1+10; %artilugio para entrar al ciclo

while norm(err)>0.001 && iterador<100 && norm(err-err1)>0.001
    err = err1;
    J = [-tita(1).^x, -tita(2)*log(tita(1))*tita(1).^x];
    [q r] = qr(J);
    qy = q'*(-d(tita));
    h = (r\qy)';
    tita = tita + h;
    iterador = iterador + 1;
    err1 = d(tita);
end

hold all

xx = min(x):0.001:max(x);
yy = tita(2).*exp(tita(1).*xx);
plot(xx,yy)
figure