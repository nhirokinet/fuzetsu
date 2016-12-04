.PHONY: all test-bf

export PATH := ..:$(PATH)

all: test-c11 test-cpp11 test-java8 test-scala test-php7.0 test-perl5 test-ruby2.3 test-python2 test-python3 test-bf test-perl6-rakudostar test-npiet-base64

test-c11:
	sudo -H -u flamehaze fuzetsu lxc build lxc-c11 ./fizzbuzz.c testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm 3 < ./fizzbuzz.in > /tmp/fuzetsutestout  
	diff /tmp/fuzetsutestout fizzbuzz.out
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm

	
test-cpp11:
	sudo -H -u flamehaze fuzetsu lxc build lxc-cpp11 ./fizzbuzz.cpp testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm 3 < ./fizzbuzz.in > /tmp/fuzetsutestout  
	diff /tmp/fuzetsutestout fizzbuzz.out
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm

	
test-java8:
	sudo -H -u flamehaze fuzetsu lxc build lxc-java8 ./Main.java testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm 3 < ./fizzbuzz.in > /tmp/fuzetsutestout  
	diff /tmp/fuzetsutestout fizzbuzz.out
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm

	
test-scala:
	sudo -H -u flamehaze fuzetsu lxc build lxc-scala ./Main.scala testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm 3 < ./fizzbuzz.in > /tmp/fuzetsutestout  
	diff /tmp/fuzetsutestout fizzbuzz.out
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm

	
test-php7.0:
	sudo -H -u flamehaze fuzetsu lxc build lxc-php7.0 ./fizzbuzz.php testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm 3 < ./fizzbuzz.in > /tmp/fuzetsutestout  
	diff /tmp/fuzetsutestout fizzbuzz.out
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm

	
test-perl5:
	sudo -H -u flamehaze fuzetsu lxc build lxc-perl5 ./fizzbuzz.pl testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm 3 < ./fizzbuzz.in > /tmp/fuzetsutestout  
	diff /tmp/fuzetsutestout fizzbuzz.out
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm

	
test-ruby2.3:
	sudo -H -u flamehaze fuzetsu lxc build lxc-ruby2.3 ./fizzbuzz.rb testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm 3 < ./fizzbuzz.in > /tmp/fuzetsutestout  
	diff /tmp/fuzetsutestout fizzbuzz.out
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm

	
test-python2:
	sudo -H -u flamehaze fuzetsu lxc build lxc-python2 ./fizzbuzz_python2.py testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm 3 < ./fizzbuzz.in > /tmp/fuzetsutestout  
	diff /tmp/fuzetsutestout fizzbuzz.out
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm

	
test-python3:
	sudo -H -u flamehaze fuzetsu lxc build lxc-python3 ./fizzbuzz_python3.py testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm 3 < ./fizzbuzz.in > /tmp/fuzetsutestout  
	diff /tmp/fuzetsutestout fizzbuzz.out
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm

test-bf:
	sudo -H -u flamehaze fuzetsu lxc build lxc-brainfuck ./hi.bf testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm > /tmp/fuzetsutestout 3
	echo -n 'Hi' | diff /tmp/fuzetsutestout -
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm

test-perl6-rakudostar:
	sudo -H -u flamehaze fuzetsu lxc build lxc-perl6-rakudostar ./hi.p6 testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm > /tmp/fuzetsutestout 3
	echo 'Hi' | diff /tmp/fuzetsutestout -
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm

test-npiet-base64:
	wget -O hi.png https://www.bertnase.de/npiet/hi.png
	base64 hi.png > ./hi.png.base64
	sudo -H -u flamehaze fuzetsu lxc build lxc-npiet-base64 ./hi.png.base64 testcode-testvm
	sudo -H -u flamehaze fuzetsu lxc run testcode-testvm > /tmp/fuzetsutestout 3
	echo 'Hi' | diff /tmp/fuzetsutestout -
	sudo -H -u flamehaze fuzetsu lxc destroy testcode-testvm
