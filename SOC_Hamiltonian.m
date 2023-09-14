function [HSO,HR,HR_z] = SOC_Hamiltonian(int,k,a)
%% Strength of ISB field
Gsp_x	=   int(7);
Gsp_y	=   int(8);
Gsp_z	=   int(9);
Gpp_x	=   int(10);
Gpp_y	=   int(11);
Gpp_z	=   int(12);
spin    =   int(13); ... atomistic SOC strength

%% kpoints

kx = k(1);ky = k(2);

%% H (inversion symmetry breaking)

H1 = [0, 2*Gsp_x*(cos(ky*a)), 2*Gsp_y*(cos(kx*a)),  2*Gsp_z*(cos(kx*a)+cos(ky*a));
    
    2*Gsp_x*(cos(ky*a)), 0, (2*1j*Gpp_y*sin(kx*a)-2*1j*Gpp_x*sin(ky*a)), Gpp_z*2*1j*sin(kx*a);

    2*Gsp_y*(cos(kx*a)), -(2*1j*Gpp_y*sin(kx*a)-2*1j*Gpp_x*sin(ky*a)), 0, 2*1j*Gpp_z*sin(ky*a);

    2*Gsp_z*(cos(kx*a)+cos(ky*a)), -Gpp_z*2*1j*sin(kx*a), -2*1j*Gpp_z*sin(ky*a), 0];

HR = [H1,zeros(4);
    zeros(4),H1];

%% H atomistic SOC (\lambda \vec{L} \cdot \vec{S})

HSO = [0, 0, 0, 0,       0,  0,0,0;...
    0, 0,-1j*spin,0,  0,  0,0,spin;...
    0, 1j*spin,0,0,   0,  0,0,-1j*spin;...
    0, 0, 0, 0,  0,  -spin,1j*spin,0;...
    
    0, 0, 0, 0,         0, 0, 0, 0;...
    0, 0, 0, -spin,     0, 0, 1j*spin, 0;...
    0, 0, 0, -1j*spin,  0, -1j*spin, 0, 0;...
    0, spin, 1j*spin,0, 0, 0, 0, 0];

%% HR_z

H2 = [0, Gsp_x, Gsp_y,  0;
        Gsp_x, 0,0, -Gpp_x;
        Gsp_y, 0, 0,-Gpp_y;
        0, Gpp_x, Gpp_y, 0];

HR_z= [H2,zeros(4);
    zeros(4),H2];
