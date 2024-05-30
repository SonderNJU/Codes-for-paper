function a=actfunc(x,name)%%x为数据，name为激活函数的名称
[xz,yz]=size(x);
a=zeros(xz,yz);

if strcmp(name,'ReLu')
   for i=1:xz
        for j=1:yz
        a(i,j)=max(0,x(i,j));
        end
   end
end
if strcmp(name,'Sigmoid')
    a=1./(1+exp(-x));
end
if strcmp(name,'Softmax')
    ss=sum(sum(exp(x)));
   for i=1:xz
        for j=1:yz
            a(i,j)=exp(x(i,j))/ss;
        end
   end
end
if strcmp(name,'Tanh')
    a=(exp(x)-exp(-x))./(exp(x)+exp(-x));
end
end