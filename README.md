# PolioPoly

## Installation

PolioPoly is simple to use. All of its dependencies and runtime environment has
been packed into one Docker image. To run PolioPoly, you just need to install
Docker following [this instruction](https://docs.docker.com/engine/install/).

Once Docker is installed, you can download the command line script `poliopoly`
using following command. Note this script is written in `bash` which is natively
supported by MacOS and Linux. If you are using Windows, you need to [install
Linux on Windows with WSL](https://docs.microsoft.com/en-us/windows/wsl/install)
for using this script.

```bash
sudo curl -sSL -o /usr/bin/poliopoly https://raw.githubusercontent.com/hivdb/poliopoly/main/bin/poliopoly
sudo chmod +x /usr/bin/poliopoly
```

## Usage

A directory of Illumina paired Polio FASTQ files and a primer BED file are
required for running the command `poliopoly`. Replace the following options:

```bash
poliopoly \
  -i path/to/fastq/directory \
  -o path/to/output/directory \
  -t S3 \
  -p path/to/primers.bed \
  -n run_name
```

The options:
```
-i <input_dir>     input directory which includes paired FASTQ files
-o <output_dir>    output directory
-t <S1|S2|S3>      reference polio serotype
-b <primer_bed>    location of BED file of primers
-n <resume_name>   resume of NextFlow, see https://bit.ly/3xpKmEK
```

Optional environment variables:
```
IVAR_VARIANTS_MIN_FREQ    minimum frequency of `ivar variants` (default: 0.75)
IVAR_VARIANTS_MIN_QUAL    minimum quality of `ivar variants` (default: 20)
IVAR_VARIANTS_MIN_COV     minimum coverage of `ivar variants` (default: 10)
IVAR_CONSENSUS_MIN_FREQ   minimum frequency of `ivar consensus` (default: 0.5)
IVAR_CONSENSUS_MIN_QUAL   minimum quality of `ivar consensus` (default: 20)
IVAR_CONSENSUS_MIN_COV    minimum coverage of `ivar consensus` (default: 50)
```

**For Linux users only:** you may need to add `sudo` in front of the `poliopoly`
command since Docker by default requires sudo privileges. If you wish to not add
`sudo`, you can instead add the user who runs the `poliopoly` command to user
group `docker`:

```bash
sudo usermod -aG docker $USER
```

Replace "$USER" to other user name if it's not the user who runs the `usermod`
command. The user need to logout and login again for activating the new group.

Troubleshooting
===============

### Memory requirement

The script requires at least **8GB** minimum of free memory that dedicated for
Docker.

For Linux users, since the Docker runs as a native program, the limit is the
total free memory of the system:

```bash
free -h
```

For MacOS/Windows users, Docker runs in a virtual machine with allocated amount
of memory. For both systems the default memory is 2GB which is insufficient.
Follow the corresponding instruction for increasing the RAM/Memory:

- [MacOS](https://docs.docker.com/desktop/settings/mac/#advanced)
- [Windows](https://docs.docker.com/desktop/settings/windows/#advanced)

### Disk space requirement

At least **30GB** free disk space is required for running `poliopoly`. For Linux
user this is the free space of where `/var/lib/docker` located:

```bash
df -h
```

For MacOS/Windows users, please follow the same [instruction for
memory](#memory-requirement) to increase the "disk image size".

### Clean up cache

You may want to clean up the cache files if you found `poliopoly` takes too much
disk space or not functional properly. To do so, just run a single command:

```bash
docker volume rm poliopoly-work
```
