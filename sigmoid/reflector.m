% learning the reflectors' geometry
clear
clc

n=1;
load data
nbrOfNodes=10;
nbrOfEpochs=1000;

pos=[zeros(1,length(pos))' pos];
sizePos=size(pos);
sizePdp=size(pdp);

W=rand(nbrOfNodes,sizePos(2));
U=rand(sizePdp(2),nbrOfNodes);
figure; hold on
for i=1:nbrOfEpochs
    for j=1:sizePos(1)
        I=pos(j,:);
        D=pdp(j,:)';
% Propagate the signals through network
        H = ff(sum((W-repmat(I,nbrOfNodes,1)).^2,2));
        O = ff(U*H);
% Output layer error
        delta_i = O.*(ones(sizePdp(2),1)-O).*(O-D)*H';
% Calculate error for each node in layer_(n-1)
        delta_j = H.*(ones(nbrOfNodes,1)-H)*(O.*(ones(sizePdp(2),1)-O).*(O-D))'*U*2*(W-repmat(I,nbrOfNodes,1));
 % Adjust weights in matrices sequentially
        U = U - n.*delta_i
        W = W - n.*delta_j
    end
     RMS_Err = 0;

    % Calculate RMS error
    for m=1:sizePos(1)
        I=pos(j,:);
        D=pdp(j,:)';
        RMS_Err = RMS_Err + norm(D-ff(U*ff(sum((W-repmat(I,nbrOfNodes,1)).^2,2))),2);
    end
    
    y = RMS_Err/sizePos(1);
    plot(i,log(y),'*');
    drawnow();
end   
 

