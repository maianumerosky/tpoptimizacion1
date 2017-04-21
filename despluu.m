function x = despluu(U,y)
n = length(y);
x(n) = y(n)/U(n,n);
for i=2:n
    k = n-i+1;
    x(k) = (y(k) - sum(U(k,k+1:n).*x(k+1:n)))/U(k,k);
end