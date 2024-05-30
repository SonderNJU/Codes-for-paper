function a=update_multibit(a,da,lr)

dw_inc=[0
1/63
2/63
3/63
4/63
5/63
6/63
7/63
8/63
9/63
10/63
11/63
12/63
13/63
14/63
15/63
16/63
17/63
18/63
19/63
20/63
21/63
22/63
23/63
24/63
25/63
26/63
27/63
28/63
29/63
30/63
31/63
32/63
33/63
34/63
35/63
36/63
37/63
38/63
39/63
40/63
41/63
42/63
43/63
44/63
45/63
46/63
47/63
48/63
49/63
50/63
51/63
52/63
53/63
54/63
55/63
56/63
57/63
58/63
59/63
60/63
61/63
62/63
1
];

dw_dec=[1
62/63
61/63
60/63
59/63
58/63
57/63
56/63
55/63
54/63
53/63
52/63
51/63
50/63
49/63
48/63
47/63
46/63
45/63
44/63
43/63
42/63
41/63
40/63
39/63
38/63
37/63
36/63
35/63
34/63
33/63
32/63
31/63
30/63
29/63
28/63
27/63
26/63
25/63
24/63
23/63
22/63
21/63
20/63
19/63
18/63
17/63
16/63
15/63
14/63
13/63
12/63
11/63
10/63
9/63
8/63
7/63
6/63
5/63
4/63
3/63
2/63
1/63
0
];

% LTP
positive_values = da(da > 0);
positive_max = max(max(positive_values));
positive_min = min(min(positive_values));
ruler_pos=dw_inc*(positive_max-positive_min)+positive_min;

 
% LTD
negative_values = da(da < 0);
negative_max = max(max(negative_values));
negative_min = min(min(negative_values)); 
ruler_neg=dw_dec*(negative_max-negative_min)+negative_min;

% Ó³Éä
[zx,zy]=size(da);
zdw_inc=max(size(dw_inc));
zdw_dec=max(size(dw_dec));
for i=1:zx
     for j=1:zy
          if da(i,j)>0
             for k=1:zdw_inc-1
                  if da(i,j)>=ruler_pos(k)&&da(i,j)<ruler_pos(k+1)
                     da(i,j)=ruler_pos(k);
                  end
             end
          elseif da(i,j)<0
             for k=1:zdw_dec-1
                  if da(i,j)>=ruler_neg(k)&&da(i,j)<ruler_neg(k+1)
                     da(i,j)=ruler_neg(k);
                  end
             end
          end
      end
end

a=a+da*lr;

end