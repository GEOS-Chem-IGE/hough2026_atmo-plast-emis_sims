Atmospheric microplastic cycling with GEOS-Chem
-----------------------------------------------

This repository contains the code to simulate global atmospheric microplastic cycling as described in [TODO PAPER REF].


To reproduce
------------

> [!Note]
> These instructions assume you are familiar with configuring and running [GEOS-Chem](https://geoschem.github.io/index.html) simulations. Refer to the [GEOS-Chem user guide](https://geos-chem.readthedocs.io/en/14.1.1/) for help.

1. Clone this repository and its submodules

```bash
git clone --recurse-submodules git@github.com:GEOS-Chem-IGE/hough2026_atmo-plast-emis_sims.git
```

2. Patch HEMCO to enable simulating microplastic emissions

```bash
git apply --directory=GCClassic/src/HEMCO HEMCO-plastics.patch
```

3. Unzip the plastic emissions input data (`plastics-input-data.zip`) into the HEMCO subdirectory of your GEOS-Chem input data directory (`ExtData`)

```bash
unzip plastics-input-data.zip -d "$GC_DATA_ROOT"/HEMCO
```

> [!TIP]
> `$GC_DATA_ROOT` stores the path to `ExtData`. It is set in `~/.geoschem/config`.

4. Create the simulation environment

> [!NOTE]
> You will need [micromamba](https://mamba.readthedocs.io/en/latest/installation/micromamba-installation.html) and [conda-lock](https://conda.github.io/conda-lock/). You may also use [mamba](https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html) or [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html) instead of micromamba.

```bash
conda-lock install --micromamba -n hough2026_atmo-plast-emis_sims environment.lock
```

5. Update the environment activation script

The script `activate_env.sh` activates the simulation environment and sets configuration and variables needed to run GEOS-Chem (e.g. path to compilers, OMP maximum stack size). You must update this script with the path to your system's micromamba root prefix. Change this line:

```bash
MAMBA_ROOT_PREFIX="/home/PROJECTS/pr-geoschem/micromamba"
```

to the correct path for your system.

6. Build the GEOS-Chem executable

> [!NOTE]
> Our computing system uses the [OAR](https://oar.imag.fr/documentation) job scheduler. You should adapt the following commands / scripts as needed for your system. For example, if your system does not use a job scheduler, you can execute the build script directly with `./run-build.sh` rather than using `oarsub -S ./run-build.sh` to submit it as a job to the OAR scheduler.

```bash
cd simulations/setup
oarsub -S ./run-build.sh
```

7. Execute a dryrun and download any missing input data

```bash
oarsub -S ./run-dryrun.sh
```

This will generate a log file `dryrun.log` identifying missing input data. You can download any missing input data with:

```bash
oarsub -S ./run-download.sh
```

8. Run the main simulation

The main simulation models atmospheric microplastic emissions that have a power law particle size distribution. See [simulations/main/README.md] for details.

We run a separate simulation for each of the five emissions sources (oceans, mismanaged plastic waste, agriculture, residences, roads). Each source's simulations are grouped in a directory with subdirectories for the spinup period and study timeperiod. First run the spinup simulation, then the main simulation. Simulations for different sources may be run in parallel.

> [!NOTE]
> The path to the GEOS-Chem input data directory is hardcoded in each simulation's `geoschem_config.yml`, `HEMCO_Config.rc`, and `HEMCO_Config.rc.gmao_metfields` configuration files. You must edit these files and replace every occurence of `/summer/geoschem/COMMON/ExtData` with the path to your `ExtData` directory.

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

9. Run the alternate simulation

The alternate simulation models atmospheric microplastic emissions using the same configuration as Fu et al. (2023). See [simulations/alt/README.md](simulations/alt/README.md) for details.

Run the alternate simulation using the same procedure as for the main simulation.

> [!NOTE]
> Don't forget to set the path to your `ExtData` directory in each simulation's `geoschem_config.yml`, `HEMCO_Config.rc`, and `HEMCO_Config.rc.gmao_metfields` configuration files.


Contents
--------

### GCClassic

GEOS-Chem 14.1.1 model code, patched (see `HEMCO-plastics.patch`) to simulate emissions of microplastics to the atmosphere from oceans, mismanaged plastic waste, agriculture, residences, and roads.

### outputs

Simulation outputs

### simulations

Simulation configurations


References
----------

Fu, Y., Pang, Q., Ga, S. L. Z., Wu, P., Wang, Y., Mao, M., Yuan, Z., Xu, X., Liu, K., Wang, X., Li, D., & Zhang, Y. (2023). Modeling atmospheric microplastic cycle by GEOS-Chem: An optimized estimation by a global dataset suggests likely 50 times lower ocean emissions. *One Earth*, *6*(6), 705–714. https://doi.org/10.1016/j.oneear.2023.05.012
