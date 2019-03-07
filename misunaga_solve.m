function [coef R_new p1_new p2_new]=misunaga_solve(Point1,Point2,R,N)
M=zeros(numel(R),N);
for i=1:N
    M(:,i)=Point1(:).^i-Point2(:).^i.*R(:);
end

D=[diag(ones(N-1,1)); -ones(N-1,1)'];
A=M'*M*D;
b = A(end,:)';
B=bsxfun(@minus, A(1:end-1,:),b');

% robust
%coeff = pinv(B')*(-b);

% non-robust
coeff = B'\(-b);


coeff_n = 1 - sum(coeff);

coef=[coeff; coeff_n];
p1_new=0;
p2_new=0;
for i=1:N
    p1_new=p1_new+coef(i)*Point1.^i;
    p2_new=p2_new+coef(i)*Point2.^i;    
end
R_new=p1_new./p2_new;
