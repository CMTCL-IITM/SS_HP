clear
clc
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% lattice parameter
a = 1; ... Lattice constant

rvec = [a   0   0
        0   a   0
        0   0   a];  ... for cubic lattice

%% Reciprcal translation vectors
Vol = dot(rvec(1,:),cross(rvec(2,:),rvec(3,:)));

b1 =  2*pi*cross(rvec(2,:),rvec(3,:))/Vol;
b2 =  2*pi*cross(rvec(3,:),rvec(1,:))/Vol;
b3 =  2*pi*cross(rvec(1,:),rvec(2,:))/Vol;

recip = [b1;b2;b3];
%% design of kpath
kpath =[];

n = 100;
for j = 1:n
    kpath = [kpath;j*0.5/n,-j*0.5/n,0];
end
for j = 1:n
    kpath = [kpath;0.5-j*0.5/n,-0.5+j*0.5/n,0];
end

kpts = [];
for j = 1: length(kpath)
    kpts = [kpts;sum(recip.*transpose(kpath(j,1:3)))];
end
nkpt = length(kpts);
%% no. of layers
nlayer = 26;
%% calculation of eigenvalues
eigE = zeros(length(kpts),8*nlayer);

for i = 1:size(kpts,1)
    
    %% k-points
    kx = kpts(i,1);
    ky = kpts(i,2);
    
    k = [kx,ky];
    %%
    int = interaction_parameters;
    %% TB Hamiltonian
    [HTB1,HTB2] = TB_Hamiltonian(int,k,a);
    [HSO,HR,HR_z] = SOC_Hamiltonian(int,k,a);
    %% SOC Hamiltonian
    H11 = HTB1+HSO+HR;
    %% Interlayer Hamiltonian
    H12 = HTB2+HR_z;
    
    H = kron(diag(ones(1,nlayer)),H11) + kron(diag(ones(1,nlayer-1),1),H12) + kron(diag(ones(1,nlayer-1),-1),H12');
    
    [eigvec,e] = eig(H);
    
    eigE(i,:) = diag(e);
end

%% k-length calculation
kpts = [];
for j = 1: length(kpath)
    kpts = [kpts;sum(recip.*transpose(kpath(j,1:3)))];
end
s = zeros(1,size(kpts,1));
for i = 1:size(kpts,1)-1
    d = sqrt(sum((kpts(i,:)-kpts(i+1,:)).^2));
    s(i+1) = s(i) + d;
end
%% plotting od surface states

plot(s,eigE,'Color', 'b','LineWidth',0.5);

%% plot settings
set(gcf,'color','w');
ax = gca;
ax.Box = 'on';
ax.LineWidth = 1;
ax.FontSize = 22;
ax.TickDir = 'in';
ax.TickLength = [0.01 0.001];
ax.YLim = [-2 2];
ax.XLim = [0 s(end)];

toc