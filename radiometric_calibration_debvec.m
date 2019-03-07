%clear;
function [curve_debvec ] = radiometric_calibration_debvec(point1, exposure,lambda)
Z=[];
l=lambda;%default 10-100


Z=point1;
Z=double(Z);

%init weight
for i=0:255
    if(i<255/2)
        w(i+1)=i;
    else
        w(i+1)=255-i;
    end
end

if(size(exposure,1)==1)
    B=repmat(log(exposure(:)'),size(Z,1),1);
else
    B=log(exposure);
end
[g,lE]=gsolve(Z,B,l,w);
curve_debvec=exp(g)/max(exp(g));
