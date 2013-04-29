#!/bin/bash
start=$(date +%s)
echo -e "Current repo: $TRAVIS_REPO_SLUG\n"

function error_exit
{
	echo -e "\e[01;31m$1\e[00m" 1>&2
	exit 1
}

if [ "$TRAVIS_PULL_REQUEST" == "false" ] ; then
	#Set git user
	git config --global user.email "laurent.goderre@gmail.com"
	git config --global user.name "Travis"

	#Set remotes
	git remote add examples https://${GH_TOKEN}@github.com/LaurentGoderre/wcag2_techniques_failures.git 2> /dev/null > /dev/null
	
	#Update working example
	if [ "$TRAVIS_BRANCH" == "master" ]; then
		echo -e "Updating working examples...\n"

		git checkout -B gh-pages
		git push -fq examples gh-pages 2> /dev/null || error_exit "Error updating working examples"

		echo -e "Finished updating the working examples\n"
	fi
fi

end=$(date +%s)
elapsed=$(( $end - $start ))
minutes=$(( $elapsed / 60 ))
seconds=$(( $elapsed % 60 ))
echo "Post-Build process finished in $minutes minute(s) and $seconds seconds"
