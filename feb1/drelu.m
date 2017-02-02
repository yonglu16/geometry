
% derivative of ReLU

function y=drelu(x)
    a=size(x);
    for i=1:a(1)
        for j=1:a(2)
            if x(i,j)>=0
                y(i,j)=1;
            else 
            y(i,j)=0;
            end
        end
    end
end