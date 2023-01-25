import { exec as _exec } from '@actions/exec';
import { getInput } from '@actions/core';

const version = getInput('version', { required: false });
const arch = getInput('arch', { required: false });
const downloadPath = getInput('download-path', { required: false });

await _exec(path.join(__dirname, 'download.sh'), [version, arch, downloadPath]);
