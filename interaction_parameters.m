function [int] = interaction_parameters
%% Defines the tight-binding parameters.
%% hydro_pres  0.58	 0.585	 0.59	0.595	 0.6	 0.61	 0.62	 0.63	 0.64	 GS
%% Tight binding hoppings
yEs	   =	[-1.04	-1.13	-1.14	-1.13	-1.06	-0.96	-0.89	-0.77	-0.65	-0.62];
yEp	   =	[3.45	3.48	3.48	3.48	3.51	3.63	3.78	3.84	3.9	3.96];
ytss_s	=	[-0.227	-0.217	-0.212	-0.202	-0.187	-0.167	-0.152	-0.132	-0.112	-0.107];
ytsp_s	=	[0.568	0.552	0.528	0.52	0.512	0.48	0.44	0.424	0.408	0.4];
ytpp_s	=	[0.97	0.955	0.949	0.913	0.883	0.841	0.835	0.793	0.757	0.769];
ytpp_p	=	[0.123	0.123	0.121	0.117	0.115	0.109	0.097	0.089	0.083	0.083];
%% Asymmetric hoppings due to presence of electric polarization
yGsp_x	=	[0.045	0.045	0.045	0.045	0.045	0.045	0.045	0.045	0.045	0.045];
yGsp_y	=	[0.03	0.015	0	0	0	0	0	0	0	0];
yGsp_z	=	[0.03	0.03	0.03	0.03	0.03	0.03	0.03	0.03	0.03	0.03];
yGpp_x	=	[-0.045	-0.045	-0.045	-0.045	-0.045  -0.045	-0.045	-0.045	-0.045	-0.045];
yGpp_y	=	[0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12];
yGpp_z	=	[0.06	0.06	0.06	0.06	0.06	0.06	0.06	0.06	0.06	0.06];
ys	=	[0.49	0.49	0.49	0.49	0.49	0.49	0.49	0.49	0.49	0.49];

%% select the pressure applied
q = 1;

Es      =   yEs(q);
Ep      =   yEp(q);
tss_s	=   ytss_s(q);
tsp_s	=   ytsp_s(q);
tpp_s	=   ytpp_s(q);
tpp_p	=   ytpp_p(q);
Gsp_x	=   yGsp_x(q);
Gsp_y	=   yGsp_y(q);
Gsp_z	=   yGsp_z(q);
Gpp_x	=   yGpp_x(q);
Gpp_y	=   yGpp_y(q);
Gpp_z	=   yGpp_z(q);
spin    =   ys(q);

%% interaction matrix
int = [Es,Ep,tss_s,tsp_s,tpp_s,tpp_p,Gsp_x,Gsp_y,Gsp_z,Gpp_x,Gpp_y,Gpp_z,spin];