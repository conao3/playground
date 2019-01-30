
SSHKEY = ~/.ssh/id_rsa

##################################################

.PHONY: all commit log

all:
preinstall: install-cpan install-po4a

install-cpan:
	perl -E 'say for @INC'
	echo yes | cpan
	eval `perl -I$HOME/perl5/lib/perl5 -Mlocal::lib`
	perl -Mlocal::lib
	perl -E 'say for @INC'
	cpan Module::Build

install-po4a:
	curl -LO https://github.com/mquinson/po4a/releases/download/v${PO4A_VERSION}/po4a-${PO4A_VERSION}.tar.gz
	tar zxvf po4a-${PO4A_VERSION}.tar.gz
	cd po4a-${PO4A_VERSION} && perl Build.PL && yes | ./Build installdeps && perl Build.PL

commit: SSHKEY melpa-archive
	git remote -v
	git remote set-url origin git@github.com:conao3/playground.git

	git checkout master
	git add .
	git commit -m "by Travis CI (job $$TRAVIS_JOB_NUMBER) [skip ci]"

	git push origin master

log:
	echo "Commit by Travis-CI (job $$TRAVIS_JOB_NUMBER)" >> commit.log

SSHKEY:
	openssl aes-256-cbc -K $$encrypted_c34d5bfe7b07_key -iv $$encrypted_c34d5bfe7b07_iv -in travis_rsa.enc -out ~/.ssh/id_rsa -d
	chmod 600 ~/.ssh/id_rsa

