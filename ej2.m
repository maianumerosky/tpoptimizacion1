%% Cargo datos
load('datosTP1-2017.mat')
datosInp = datos5;
main
x = datosInp(:,1);
y = datosInp(:,2);

%% Esta es la funciòn a minimizar

d = @(tita) y-tita(2).*exp(tita(1).*x)-tita(3);

%% Gauss - Newton
tita0 = [log(a), k, 0];
tita = tita0;
iterador = 0;
err1 = d(tita);
err = err1+10; %artilugio para entrar al ciclo

while norm(err)>0.001 && iterador<100 && norm(err-err1)>0.001
    err = err1;
    J = [-x*tita(2).*exp(tita(1)*x), -exp(tita(1)*x), -1*ones(length(x),1)];
    [q r] = qr(J);
    qy = q'*(-d(tita));
    h = (r\qy)';
    tita = tita + h;
    iterador = iterador + 1;
    err1 = d(tita);
end

hold all
plot(x,y,'.')
xx = min(x):0.001:max(x);
yy = tita(2).*exp(tita(1).*xx)+tita(3);
plot(xx,yy)
figure