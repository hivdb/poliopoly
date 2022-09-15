PolioPoly

Installation
============

PolioPoly is simple to use. All of its dependencies and runtime environment has
been packed into one Docker image. To run PolioPoly, you just need to install
Docker following [this instruction](https://docs.docker.com/engine/install/).

Once Docker is installed, you can download the command line script `poliopoly`
using following command. Note this script is written in `bash` which is natively
supported by MacOS and Linux. If you are using Windows, you need to [install
Linux on Windows with WSL](https://docs.microsoft.com/en-us/windows/wsl/install)
for using this script.

```bash
sudo curl -sSL -o /usr/local/bin/poliopoly https://raw.githubusercontent.com/hivdb/poliopoly/main/bin/poliopoly
sudo chmod +x /usr/local/bin/poliopoly
```

Usage
=====

A directory of Illumina paired Polio FASTQ files and a primer FASTA file are
required for running the command `poliopoly`. Replace the following options:

```bash
poliopoly \
  -i path/to/fastq/files \
  -o path/to/output/directory \
  -t S3 \
  -p path/to/primers.fa \
  -n run_name
```

The options:
```
-i <input_dir>     input directory which includes paired FASTQ files
-o <output_dir>    output directory
-t <S1|S2|S3>      reference polio serotype, can be S1, S2, or S3
-p <primer_fasta>  location of FASTA file of primers
-n <resume_name>   resume of NextFlow, see https://bit.ly/3xpKmEK
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
