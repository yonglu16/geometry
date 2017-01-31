
function y=derivative(x)
    sigma=1;
    l0=1:14;
    sizemiu=size(x);
    for i=1:sizemiu(1)
        y(i,:)=(-2./x(i,:).^3.-2*(x(i,:)-l0)./(x(i,:).^2*10.^2)).*exp(-(x(i,:)-l0).^2/sigma^2);
    end
end