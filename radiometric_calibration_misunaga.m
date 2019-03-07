function [curve_misu, coef_misu]=radiometric_calibration_misunaga(point1, point2, ratio, Ndim, dthresh,iter)


disp(['misunaga method with ' num2str(numel(point1(:))) ' Points'])
R=ratio;

for i=1:iter
    [coef_misu, R_new]=misunaga_solve(point1, point2,R,Ndim);
    R=R_new;
    disp(i)
    if i~=1 && max(abs(coef_old-coef_misu))<dthresh
        disp('no change break!')
        break;
    end
    coef_old=coef_misu;
    
end

x=linspace(0,1,1024);
curve_misu=0;
for i=1:numel(coef_misu)
    curve_misu=curve_misu+coef_misu(i)*x.^(i);
end
