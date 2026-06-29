Main simulation
===============

Simulate atmospheric microplastic emissions with a power law particle size distribution:

- Five emissions sources (oceans, mismanaged plastic waste, agriculture, residences roads)
- Six size bins (0.1-100 µm) represented by tracers of diameter 0.3, 2.5, 7, 15, 35, 70 µm
- Initial base emissions factors (e.g. [HEMCO_Config.rc:76](2-mmpw/spinup/HEMCO_Config.rc#L76)) are set so that each source emits approximately 1 Gg/yr. These will be adjusted a posteriori to match simulation outputs to observations.
- Size distribution factors (e.g. [HEMCO_Config.rc:78-84](2-mmpw/spinup/HEMCO_Config.rc#L78-84)) distribute the emissions over tracer sizes following a power law particle number size distribution with slope -2.8.


Contents
--------

We simulate emissions from each source separately. Each source has a dedicated subdirectory:

- [1-ocen/](1-ocen/): emissions from oceans
- [2-mmpw/](2-mmpw/): emissions from mismanaged plastic waste
- [3-agri/](3-agri/): emissions from agriculture
- [4-resi/](4-resi/): emissions from residences
- [5-road/](5-road/): emissions from roads

Each source directory configures two timeperiods:

- `spinup`: spinup simulation from 2017-11-01 to 2018-01-01
- `2018-01-01_2021-01-01`: simulation for 2018-01-01 to 2021-01-01

The `2018-01-01_2021-01-01` simulation uses the restart file produced by the `spinup` simulation.
