Simulate atmospheric microplastic cycling
-----------------------------------------

This repository contains code to simulate global atmospheric microplastic cycling for the paper "Reduced global atmospheric microplastic emissions from size-harmonized observations" (Hough et al., 2026).

The raw outputs of these simulations are available at [doi:10.5281/zenodo.20847720](https://doi.org/10.5281/zenodo.20847720).

Related code and data:

- Code to size-harmonize observations and constrain the raw simulation outputs: TODO
- Constrained simulation outputs: [doi:10.5281/zenodo.20922804](https://doi.org/10.5281/zenodo.20922804)
- Code for the paper figures: TODO


To reproduce
------------

> [!Tip]
> These instructions assume you are familiar with configuring and running GEOS-Chem simulations. Refer to the [GEOS-Chem user guide](https://geos-chem.readthedocs.io/en/14.1.1/) for help.

### Clone this repository and its submodules

```bash
git clone --recurse-submodules git@github.com:GEOS-Chem-IGE/hough2026_atmo-plast-emis_sims.git
```

### Patch HEMCO to enable simulating microplastic emissions

```bash
git apply --directory=GCClassic/src/HEMCO HEMCO-plastics.patch
```

### Unzip the plastic emissions input data into the HEMCO subdirectory of your GEOS-Chem input data directory (`ExtData`)

```bash
unzip plastics-input-data.zip -d "$GC_DATA_ROOT"/HEMCO
```

> [!TIP]
> `$GC_DATA_ROOT` stores the path to your `ExtData` directory. It is set in `~/.geoschem/config`.

### Create the simulation environment

You will need [micromamba](https://mamba.readthedocs.io/en/latest/installation/micromamba-installation.html) and [conda-lock](https://conda.github.io/conda-lock/) to create the environment. You may also use [mamba](https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html) or [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html) instead of micromamba.

```bash
conda-lock install --micromamba -n hough2026_atmo-plast-emis_sims environment.lock
```

### Update the environment activation script

The script `activate_env.sh` activates the simulation environment and sets configuration and variables needed to run GEOS-Chem (e.g. path to compilers, OMP maximum stack size). You must update this script with the path to your system's micromamba root prefix. Change this line:

```bash
MAMBA_ROOT_PREFIX="/home/PROJECTS/pr-geoschem/micromamba"
```

to the correct path for your system.

### Build the GEOS-Chem executable

> [!NOTE]
> Our computing system uses the [OAR](https://oar.imag.fr/documentation) job scheduler. You should adapt the following commands / scripts as needed for your system. For example, if your system does not use a job scheduler, you can execute the build script directly with `./run-build.sh` rather than using `oarsub -S ./run-build.sh` to submit it as a job to the OAR scheduler.

```bash
cd simulations/setup
oarsub -S ./run-build.sh
```

### Execute a dryrun and download any missing input data

```bash
oarsub -S ./run-dryrun.sh
```

This will generate a log file `dryrun.log` identifying missing input data. You can download any missing input data with:

```bash
oarsub -S ./run-download.sh
```

### Run the *main* simulation

> [!NOTE]
> The path to the GEOS-Chem input data directory is hardcoded in each simulation's `geoschem_config.yml`, `HEMCO_Config.rc`, and `HEMCO_Config.rc.gmao_metfields` configuration files. You must edit these files and replace every occurence of `/summer/geoschem/COMMON/ExtData` with the path to your `ExtData` directory.

The *main* simulation models atmospheric microplastic emissions with a power law particle size distribution. See the *main* simulation [README](simulations/main/README.md) for details.

We run a separate simulation for each of the five emissions sources (oceans, mismanaged plastic waste, agriculture, residences, roads). Simulations for different sources may be run in parallel. Each source's simulation is split into a spinup period (2017-11-01 to 2018-01-01) and the study timeperiod (2018-01-01 to 2021-01-01). You must spin up the simulation before running the study timeperiod.

For example, to spin up the ocean simulation:

```bash
cd simulations/main/1-ocen/spinup
oarsub -S ./run.sh
```

Once the spinup completes, you can simulate the study timeperiod:

```bash
cd simulations/main/1-ocen/2018-01-01_2021-01-01
oarsub -S ./run.sh
```

### Run the *alternate* simulation

The *alternate* simulation models atmospheric microplastic emissions using the same configuration as Fu et al. (2023). See the *alternate* simulation [README](simulations/alt/README.md) for details.

Run the *alternate* simulation using the same procedure as for the main simulation.


Contents
--------

### [GCClassic/](GCClassic/)

GEOS-Chem 14.1.1 model code

### [outputs/](outputs/)

Simulation outputs

### [simulations/](simulations/)

Simulation configurations


References
----------

Fu, Y., Pang, Q., Ga, S. L. Z., Wu, P., Wang, Y., Mao, M., Yuan, Z., Xu, X., Liu, K., Wang, X., Li, D., & Zhang, Y. (2023). Modeling atmospheric microplastic cycle by GEOS-Chem: An optimized estimation by a global dataset suggests likely 50 times lower ocean emissions. *One Earth*, *6*(6), 705–714. https://doi.org/10.1016/j.oneear.2023.05.012

Hough, I., Angot, H., Price, R., Dobiasova, N., Segur, T., Jahangir, E., Zhang, Y., Voisin, D., Sonke, J.E., & Thomas, J.L. (2026) Reduced global atmospheric microplastic emissions from size-harmonized observations. TODO DOI URL
