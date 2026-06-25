Main simulation
===============

Simulate atmospheric microplastic emissions using a power law particle size distribution

Notes:

- Initial emissions factors are set so that each source emits approximately 1 Gg/yr. For example, `HEMCO_Config.rc:76` sets the initial emission factor for the mismanaged plastic waste source.
- Size distribution factors are set to distribute emissions over tracer sizes following a power law particle mass distribution with slope 0.2 (corresponds to a power law particle number size distribution with slope -2.8). For example, `HEMCO_Config.rc:78-83` sets the size distribution factors for the mismanaged plastic waste source.


Contents
--------

We simulate emissions from each source separately. Each source has a dedicated subdirectory:

- `1-ocen`: emissions from oceans
- `2-mmpw`: emissions from mismanaged plastic waste (MMPW)
- `3-agri`: emissions from agriculture
- `4-resi`: emissions from residences
- `5-road`: emissions from roads

Each source directory configures two timeperiods:

- `spinup`: spinup simulation from 2017-11-01 to 2018-01-01
- `2018-01-01_2021-01-01`: simulation for 2018-01-01 to 2021-01-01

Each source's `2018-01-01_2021-01-01/Restarts` directory contains a symlink to the restart file produced by the spinup simulation.
