%%1st layer=784; 2nd layer=layernum_2;output layer=10;

clc
clear

num=60000;% images number
ratio=0.8;

[I,L]=loadMNIST_Train(num);

[ix,iy,~]=size(I); %%ix=iy=28;
im_sz=ix*iy;
%%transform I (28x28) to (1x784);
Its=reshape(I,1,im_sz,num);

for k=1:num;
Its(1,:,k)=im2bw(Its(1,:,k));
end

%%transform L (num,1) to (numx10)
Lts=zeros(num,10);

for i=1:num;
     Lts(i,L(i)+1)=1;
end

tranum=floor(num*ratio);
tstnum=num-tranum;

Its_train=Its(1,:,1:tranum);
Lts_train=Lts(1:tranum,:);

Its_test=Its(1,:,tranum+1:tranum+tstnum);
Lts_test=Lts(tranum+1:tranum+tstnum,:);

%%build a network
lr=0.01;%learning rate
trainnum=30;
layernum_2=28;

outputnum=10;

w1=2*rand(layernum_2,im_sz)-1;
b1=2*rand(layernum_2,1)-1;
actfunc1='Sigmoid';


w2=2*rand(outputnum,layernum_2)-1;
b2=2*rand(outputnum,1)-1;
actfunc2='Softmax';

%I=Its;O=Lts;
loss_history=[];
recog=zeros(1,trainnum);
ConMatrix = cell(1, trainnum);
tic
for epoch=1:trainnum

%       [w1,w2,b1,b2,loss_history]=TrainANN_2Layers_multibit(w1,w2,b1,b2,actfunc1,actfunc2,Its_train,Lts_train,lr,epoch,loss_history,10);%%%
      [w1,w2,b1,b2,loss_history]=TrainANN_2Layers_multibit_real(w1,w2,b1,b2,actfunc1,actfunc2,Its_train,Lts_train,lr,epoch,loss_history);
       %if loss_history(epoch)<=1e-5;break;end

%test recognition rate
n=0;
Con=[];
for i=1:tstnum

      i_test=Its_test(:,:,i);
      l_test=Lts_test(i,:);

      v1=w1*i_test'+b1;
      y1=actfunc(v1,actfunc1);
      v2=w2*y1+b2;
      y=actfunc(v2,actfunc2);
     
     [~,L_cal]=max(y);
     [~,L_tst]=max(l_test);
   
     if L_cal==L_tst
        n=n+1;
     end
     Con(1,i)=L_cal;
     Con(2,i)=L_tst;
end

ConMatrix{1, epoch}=Con;
recog(epoch)=n/tstnum;

 %dynamic display
    hold on
    plot(epoch,recog(epoch),'go');
    grid on;
    pause(0.01);
end

toc
%t=toc;
fprintf('中间层使用的激活函数是 %s\n',actfunc2)
fprintf('最大识别率为 %f\n',max(recog))
