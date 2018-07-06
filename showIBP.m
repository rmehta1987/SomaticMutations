clear themat tempmat 

%Set Params
cust = 30; %Customers
n = 10; %eta, first customer tries Poisson(n) dishes
d = [1,10]; %delta
o=[.2,.5,.9]; %sigma controls power law behavior

for i = 1:cust
    if i == 1
        themat(i,1:poissrnd(n)) = 1;
    else
        dish = size(themat,2);
        for k = 1:dish
            mk = sum(themat(:,k));
            tryit = (mk - o(1))/(i - 1 + d(1));
            if tryit > rand
                themat(i,k)=1;
            else
                themat(i,k)=0;
            end
        end
          newd = (n*gamma(1+d(1))*gamma(i-1+d(1)+o(1)))/(gamma(i+d(1))*gamma(d(1)+o(1)));
            newd = poissrnd(newd);
            tempmat = zeros(i,newd);
            tempmat(i,:)=1;
            themat = horzcat(themat,tempmat);
    end
end



%%Plot the Matrix with a grey colormap
[r, c] = size(themat);                          % Get the matrix size
imagesc((1:c)+0.5, (1:r)+0.5, themat);          % Plot the image
colormap(gray);                              % Use a gray colormap
axis equal                                   % Make axes grid sizes equal

title('Binary Mutation Representation');
xlabel('Mutation');
ylabel('Samples');
set(gca,  ... % Change some axes properties
         'XLim', [1 c+1], 'YLim', [1 r+1], ...
         'GridLineStyle', '-', 'XGrid', 'on', 'YGrid', 'on');
        