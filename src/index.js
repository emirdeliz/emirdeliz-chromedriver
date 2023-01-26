import { exec } from '@actions/exec';
import { getInput } from '@actions/core';

async function run() {
	const version = getInput('version', { required: false });
	const arch = getInput('arch', { required: false });
	const downloadPath = getInput('download-path', { required: false });
	await exec('bash dist/download.sh', [version, arch, downloadPath]);
}

run();
