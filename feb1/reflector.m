% learning the reflectors' geometry
clear
clc

n=1e-10;  % learning rate
load data
nbrOfVirtualSource=10;
nbrOfHiddenNodes=100;
nbrOfEpochs=1000;

%pdp=tof;
pos=[pos pos];
sizePos=size(pos);
sizePdp=size(pdp);

Wij=-3+10*rand(nbrOfVirtualSource,sizePos(2));
Wjk=rand(nbrOfHiddenNodes,nbrOfVirtualSource);
Wko=rand(sizePdp(2),nbrOfHiddenNodes);

figure; hold on
for i=1:nbrOfEpochs
    for j=1:sizePos(1)
        I=pos(j,:);   % input
        D=pdp(j,:)';  % target
% Propagate the signals through network
        ai=relu(sqrt(sum((Wij-repmat(I,nbrOfVirtualSource,1)).^2,2))); 
        aj=relu(Wjk*ai);
        ak=relu(Wko*aj);
        %H = relu(sum((W-repmat(I,nbrOfNodes,1)).^2,2));
        %O = relu(U*H);
% Output layer error
        delta_k =(D-ak).*drelu(ak);
% Calculate error for each node in layer_(n-1)
        delta_j=drelu(aj).*(Wko.'*delta_k);
        delta_i=drelu(ai).*(Wjk.'*delta_j);
        %delta_j =((O-D)'*U)'*drelu(H)'*2*(W-repmat(I,nbrOfNodes,1));
 % Adjust weights in matrices sequentially
        Wij=Wij + n.*delta_i*I.*(Wij-repmat(I,nbrOfVirtualSource,1))./repmat(sqrt(sum((Wij-repmat(I,nbrOfVirtualSource,1)).^2,2)),1,sizePos(2))
        Wjk=Wjk + n.*delta_j*(ai.');
        Wko=Wko + n.*delta_k*(aj.');
        %U = U + n.*delta_i*(H.')
        %W = W + n.*delta_j*(I.')
        %2*(W-repmat(I,nbrOfNodes,1))
    end
     RMS_Err = 0;

    % Calculate RMS error
    for m=1:sizePos(1)
        I=pos(j,:);
        D=pdp(j,:)';
        RMS_Err = RMS_Err + norm(D-relu(Wko*relu(Wjk*relu(sum((Wij-repmat(I,nbrOfVirtualSource,1)).^2,2)))),2);
    end
    
    y = RMS_Err/sizePos(1);
    plot(i,log(y),'*');
    drawnow();
end   
 

