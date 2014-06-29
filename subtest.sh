#!/bin/bash

#   locale
export LC_ALL="C"
export LANG="C"
export LANGUAGE="C"

#   verbose
export SAFE_EXECUTE_VERBOSE=0

#   source
source base_func.sh

#   global variable
program="${0}"
verbose=0
print_option=0
root_dir="$(pwd)"
skip_config="subtest.skip"
make_opt=""

#   Usage
function Usage
{
    echo "Usage:" 1>&2
    echo "    ${0} [OPTION]" 1>&2
    echo "Function: " 1>&2
    echo "    Enter sub-directories and run test." 1>&2
    echo "Option:" 1>&2
    echo "        --help                Display this message and exit." 1>&2
    echo "        --verbose             Verbose mode." 1>&2
    echo "        --print-option        Print command line options." 1>&2
    echo "    -r, --root-dir [P]        Set root directory, default \"${root_dir}\"." 1>&2
    echo "    -s, --skip-config [F]     Set file name containing directories to skip, default \"\${root_dir}/${skip_config}\"." 1>&2
    exit 1
}

#   parse argument
eval set -- "$(getopt -n "$0" -o "r:s:" -l "help,verbose,print-option,root-dir:,skip-config:" "--" "$@")"
if  [ "$?" -ne 0 ]
then
    Usage
fi
while [ "$#" -ge 1 ]
do
    o="${1}"
    case "${o}" in
       --help) Usage; shift;;
       --verbose) verbose=1; shift;;
       --print-option) print_option=1; shift;;
    -r|--root-dir) shift; root_dir="${1}"; shift;;
    -s|--skip-config) shift; skip_config="${1}"; shift;;
    --) shift; break;;
    esac
done
if [ "$#" -lt 0 ]
then
    Usage
fi
if [ "$#" -ne 0 ]
then
    echo "${0}: extra operand: ${1}" 1>&2
    exit 1
fi

#   print option
if [ "${print_option}" -ne 0 ]
then
    echo "root_dir          : ${root_dir}" 1>&2
    echo "skip_config       : ${skip_config}" 1>&2
fi

#   get directory to skip
skip_dir_set=""
if [ -e "${root_dir}/${skip_config}" ]
then
    skip_dir_set=$( sed '/^#/d' < ${root_dir}/${skip_config} | sed "s/ /\n/g" | sed "s/ //g" | sed "/^$/d" )
else
    echo "${program}: [warning] can not find skip config: ${root_dir}/${skip_config}." 1>&2
fi

#   get directory to enter
all_dir_cmd="ls -l ${root_dir} | awk '/^d/{print \$NF}'"
for skip_dir in ${skip_dir_set}
do
    all_dir_cmd="${all_dir_cmd} | sed '/^${skip_dir}$/d'"  
done
all_dir="$( safe_execute "${all_dir_cmd}" )"

#   test
for i in ${all_dir}
do
    echo "=========================== test for ${i} ===========================" 1>&2
    if [ -e ${root_dir}/${i}/run_test.sh ]
    then
        safe_execute "cd ${root_dir}/${i} && ./run_test.sh && pwd && cd ${root_dir} && pwd"
    fi
done

exit 0

