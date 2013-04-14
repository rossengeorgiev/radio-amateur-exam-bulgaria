use strict;
use warnings;
use utf8;

my $file = $ARGV[0];
open my $info, $file or die "Could not open $file: $!";
my $lasta;
my $first_a = 1;
my $first_q = 1;

while( my $line = <$info>)  { 
    if($line =~ /^(\d+)\. (.*) ?\((.{2})/) {
		if($first_q==1) { $first_q = 0; }
		else { print "\n],\n\"correct\":\"<p><span>Верен отговор</span></p>\",\n\"incorrect\":\"<p><span>Грешен</span></p>\"\n},"; }

		$lasta = $3;
		print "\n{\n \"q\": \"". $2 ."<br>(";
		print "Раздел ".$ARGV[1]." / №";
		print "". $1 .")\",\n \"a\": [";
		$first_a = 1;
	}
	elsif ($line =~ /^(.{2})\. (.*)(;|\.)/) {
		if($first_a==1) { $first_a = 0; }
		else { print ","; }

		print "\n\t{\"option\": \"".$2."\",\"correct\": ".(($1 eq $lasta)?'true':'false')."}";
	}
}
print "\n],\n\"correct\":\"<p><span>Верен отговор</span></p>\",\n\"incorrect\":\"<p><span>Грешен</span></p>\"\n}";

close $info;
