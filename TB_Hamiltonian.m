function [HTB1,HTB2] = Hamiltonian(int,k,a)

%% Interaction parameters
Es      =   int(1);
Ep      =   int(2);
tss_s	=   int(3);
tsp_s	=   int(4);
tpp_s	=   int(5);
tpp_p	=   int(6);

%% kpoints

kx = k(1);ky = k(2);

%% hopping integrals

f0 = 2*tss_s*(cos(kx*a)+cos(ky*a));
f1 = 2*1j*tsp_s*sin(kx*a);
f2 = 2*1j*tsp_s*sin(ky*a);

f4 = 2*tpp_s*cos(kx*a)+2*tpp_p*cos(ky*a);
f5 = 2*tpp_s*cos(ky*a)+2*tpp_p*cos(kx*a);
f8 = 2*tpp_p*cos(kx*a)+2*tpp_p*cos(ky*a);

%% Hamiltonian intralayer (Hamiltonian for jth layer of the slab. See Section IV(C) of PRB,101,155102(2020))

HTB1 = [Es+f0, f1, f2, 0,     0,  0,0,0;
       -f1,  Ep+f4, 0, 0,     0,  0,0,0;
       -f2,  0, Ep+f5, 0,     0,  0,0,0;
         0,  0, 0, Ep+f8,     0,  0,0,0;
    
        0, 0,0,0,         Es+f0,    f1,f2,0;
        0, 0,0,0,           -f1,    Ep+f4,0,0;
        0, 0,0,0,           -f2,    0,Ep+f5,0;
        0, 0,0,0,             0,    0,0,Ep+f8];

%% Hamiltonian intralayer (Hamiltonian for interaction between layer j and j − 1)

HTB2 = [tss_s, 0,0,tsp_s,    0,  0,0,0;
        0, tpp_p,0,0,        0,  0,0,0;
        0, 0,tpp_p,0,        0,  0,0,0;
        -tsp_s,0,0,tpp_s,    0,  0,0,0;

        0, 0,0,0,     tss_s, 0,0,tsp_s;
        0, 0,0,0,         0, tpp_p ,0,0;
        0, 0,0,0,         0, 0,tpp_p,0;
        0, 0,0,0,    -tsp_s, 0,0,tpp_s];

