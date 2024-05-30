function a=update_multibit_real(a,da,lr)

dw_inc=[0
0.01881
0.03918
0.05914
0.07851
0.09724
0.11568
0.13406
0.15168
0.16959
0.18715
0.20464
0.22184
0.23939
0.25663
0.2739
0.29119
0.30841
0.3256
0.3426
0.35986
0.37693
0.39394
0.41098
0.4278
0.44467
0.46143
0.47812
0.49493
0.51151
0.52789
0.54438
0.56079
0.57716
0.59313
0.60897
0.62466
0.64035
0.65616
0.67194
0.68727
0.70291
0.71845
0.73377
0.74899
0.76369
0.77846
0.79289
0.80745
0.82137
0.83541
0.84929
0.86277
0.87634
0.88949
0.90268
0.91557
0.92802
0.94068
0.95285
0.96502
0.97677
0.98851
1
];

dw_dec=[1
0.91771
0.8504
0.79187
0.7406
0.69384
0.65174
0.61391
0.57938
0.54958
0.5208
0.49339
0.46789
0.44451
0.42243
0.40166
0.38323
0.36529
0.34884
0.33229
0.31772
0.30386
0.29027
0.27807
0.26609
0.25607
0.24594
0.23535
0.22427
0.21371
0.20507
0.19623
0.18726
0.17829
0.17057
0.16216
0.15426
0.14575
0.13781
0.13058
0.12332
0.1167
0.10981
0.10367
0.09806
0.09189
0.08692
0.08147
0.07588
0.07161
0.06723
0.0625
0.05724
0.05026
0.04503
0.04084
0.03659
0.03136
0.02674
0.02168
0.01764
0.01229
0.00397
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
