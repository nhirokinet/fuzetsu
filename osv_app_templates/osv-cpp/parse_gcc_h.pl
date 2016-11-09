#!/usr/bin/env perl

sub check_include_dir {
	($dir, @dir_list) = @_;

	foreach my $d (@dir_list) {
		if (substr($dir, 0, length($d)) eq $d) {
			return 0;
		}
	}

	return 1;
}

my $result = 0;
my @include_list = ('/usr/include/', '/usr/lib/gcc/');

while (<STDIN>) {
	my $line = $_;
	chomp $line;

	if ($line =~ /^\.+ /) {
		$line =~s/^\.+ //g;

		if (check_include_dir($line, @include_list)) {
			exit 3;
		}
	} elsif ($line =~ /^\//) {
		if (check_include_dir($line, @include_list)) {
			exit 3;
		}
	} elsif ($line =~ /^Multiple include guard/) {
		# Nothing to do currently.
	} else {
		print STDERR "Unexpected output from header check.\n";
		exit 2;
	}
}

exit $result;
