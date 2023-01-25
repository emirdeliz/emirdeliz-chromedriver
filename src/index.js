import fs from 'fs';
import { exec as _exec } from '@actions/exec';
import { getInput } from '@actions/core';

async function run() {
	const version = getInput('version', { required: false });
	const arch = getInput('arch', { required: false });
	const downloadPath = getInput('download-path', { required: false });

	console.log({
		version,
		arch,
		downloadPath,
	});

	const shPath = `${fs.realpathSync('.')}/src/download.sh`;
	await _exec('sh', shPath, [version, arch, downloadPath]);
}

run();
