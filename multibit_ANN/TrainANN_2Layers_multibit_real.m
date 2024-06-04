function [w1,w2,b1,b2,loss_history]=TrainANN_2Layers_multibit_real(w1,w2,b1,b2,actfunc1,actfunc2,I,O,lr,epoch,loss_history)
num=size(I,3);
lossn=0;

for k=1:num    
    v1=w1*I(1,:,k)'+b1;      
    y1=actfunc(v1,actfunc1);  

    v2=w2*y1+b2;      
    y=actfunc(v2,actfunc2);

    e=O(k,:)-y';      
       
    db2=e';
    dw2=e'*y1';
     
    db1=actfunc_diff(y1,actfunc1).*(w2'*db2);
    dw1=db1*I(1,:,k);
 
    w1=update_multibit_real(w1,dw1,lr);
    b1=update_multibit_real(b1,db1,lr);
    w2=update_multibit_real(w2,dw2,lr);
    b2=update_multibit_real(b2,db2,lr);
    
    loss = sqrt(sum(e.*e)); 
    lossn =lossn+loss;        
   if k==num;
       loss_history(epoch)=lossn/num;
       lossn=0;
   end
                  
end
end
