Simulation configurations
=========================

This directory contains the configurations of the [GEOS-Chem](https://geoschem.github.io/) simulations of atmospheric microplastic emissions, transport, and deposition described in [TODO PAPER REF].

The outputs and restart files from these simulations are written to [../outputs](../outputs) via symlinks.

See the [main README](../README.md) for instructions to run the simulations.


Contents
--------

### alt

Alternate simulation using the configuration described by Fu et al. (2023)

### main

Main simulation using a power law particle size distribution for atmospheric microplastic emissions

### setup

Configuration and scripts to build the GEOS-Chem model and download needed input data.


References
----------

Fu, Y., Pang, Q., Ga, S. L. Z., Wu, P., Wang, Y., Mao, M., Yuan, Z., Xu, X., Liu, K., Wang, X., Li, D., & Zhang, Y. (2023). Modeling atmospheric microplastic cycle by GEOS-Chem: An optimized estimation by a global dataset suggests likely 50 times lower ocean emissions. *One Earth*, *6*(6), 705–714. https://doi.org/10.1016/j.oneear.2023.05.012
