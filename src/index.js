import path from 'path';
import { exec } from '@actions/exec';
import { getInput } from '@actions/core';

async function run() {
	const version = getInput('version', { required: false });
	const arch = getInput('arch', { required: false });
	const downloadPath = getInput('download-path', { required: false });
	const scriptPath = path.join(process.cwd(), 'src/download.sh');
	await exec(`bash ${scriptPath}`, [version, arch, downloadPath]);
}

run();
