Alternate simulation
====================

Simulate microplastic emissions using the configuration described by Fu et al. (2023):

- Five emissions sources (oceans, mismanaged plastic waste, agriculture, residences roads)
- Six size bins (0.1-100 µm) represented by tracers of diameter 0.3, 2.5, 7, 15, 35, 70 µm
- Initial emissions factors (e.g. [HEMCO_Config:66](2-mmpw/spinup/HEMCO_Config.rc#L66)) are arbitrary; they will be adjusted a posteriori to match simulation outputs to observations.
- Initial size distribution factors (e.g. [HEMCO_Config:68-73](2-mmpw/spinup/HEMCO_Config.rc#L68-73)) distribute the emissions equally over the six tracer sizes *except* for the ocean PST1 tracer (0.3 µm diameter), which has about 1.65% the mass of the other ocean tracers. This is because PST1 emissions are computed from accumulation-mode sea salt emissions (SALA) while all other tracers are computed from coarse-mode sea salt emissions (SALC). The size distribution factors will be adjusted a posteriori to match simulation outputs to observations.


Contents
--------

We simulate emissions from each source separately. Each source has a dedicated subdirectory:

- `1-ocen`: emissions from oceans
- `2-mmpw`: emissions from mismanaged plastic waste
- `3-agri`: emissions from agriculture
- `4-resi`: emissions from residences
- `5-road`: emissions from roads

Each source directory configures two timeperiods:

- `spinup`: spinup simulation from 2017-11-01 to 2018-01-01
- `2018-01-01_2021-01-01`: simulation for 2018-01-01 to 2021-01-01

The `2018-01-01_2021-01-01` simulation uses the restart file produced by the `spinup` simulation.


References
----------

Fu, Y., Pang, Q., Ga, S. L. Z., Wu, P., Wang, Y., Mao, M., Yuan, Z., Xu, X., Liu, K., Wang, X., Li, D., & Zhang, Y. (2023). Modeling atmospheric microplastic cycle by GEOS-Chem: An optimized estimation by a global dataset suggests likely 50 times lower ocean emissions. *One Earth*, *6*(6), 705–714. https://doi.org/10.1016/j.oneear.2023.05.012
