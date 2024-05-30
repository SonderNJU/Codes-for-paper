function a=actfunc_diff(x,name)%%x为数据，name为激活函数的名称
[xz,yz]=size(x);
a=zeros(xz,yz);

if strcmp(name,'ReLu')
   a=(x>0);
end
if strcmp(name,'Sigmoid')
    a=x.*(1-x);
end
if strcmp(name,'Softmax')
    ss=sum(sum(exp(x)));
   for i=1:xzQ
        for j=1:yz
            a(i,j)=exp(y(i,j))/ss;
        end
   end
end
if strcmp(name,'Tanh')
    a=1-x.^2;
end
end