% nn from zero


clear
clc

load data.mat

n=0.1;   % learning rate

nbrOfNodes=10;
nbrOfEpochs=2;

pos=[pos pos];
sizePos=size(pos);
sizePdp=size(pdp);

H=rand(nbrOfNodes,sizePos(2));
W=rand(sizePdp(2),nbrOfNodes);

for i=1:nbrOfEpochs
    for j=1:sizePos(1)
        % forth propagation
        I=pos(j,:);
        D=pdp(j,:);
        for k=1:nbrOfNodes
            l(k)=sqrt(sum((H(k,:)-I).^2));
            miu(k,:)=f(l(k));
        end
            out=sum(W.*miu',2);
        % back propagation
        % output layer error
        
        dedw=miu*repmat((D'-out),1,sizePdp(2));
        dedmiu=repmat((D'-out),1,sizePdp(2))*W;
        dmiudl=derivative(miu);
        dldh=(repmat(I,nbrOfNodes,1)-H)./repmat(l,sizePos(2),1)';
        dedh=dedmiu'*dmiudl'*dldh;
                
        % update
        W = W - n.*dedw'
        H = H - n.*dedh
        % error
        % Calculate RMS error
    RMS_Err=0;
    for m=1:sizePos(1)
        I=pos(j,:);
        D=pdp(j,:)';
        for k=1:nbrOfNodes
            l(k)=sqrt(sum((H(k,:)-I).^2));
            miu(k,:)=f(l(k));
        end
        RMS_Err = RMS_Err + norm(D-sum(W.*miu',2),2);
    end  
    y = RMS_Err/sizePos(1);
    plot(i,log(y),'*');
    drawnow();
        %}
    end
       
end
