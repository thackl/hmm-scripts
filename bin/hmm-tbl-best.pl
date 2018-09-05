#!/usr/bin/env perl
# Created: 05 Sep 2018
# Author: Thomas Hackl, thackl@lim4.de
use warnings;
use strict;
use Getopt::Long  qw(:config no_ignore_case bundling);
use Data::Dumper;

GetOptions (
    "tsv|t!" => \(my $as_tsv),
    "out|o=s" => sub { '-' ne $_[1] and open(STDOUT, '>', $_[1]) || die $! },
    "help|h!" => \(my $help),
    "debug|D!" => \(my $debug),
) or die("Error in command line arguments\n");

if ($help || @ARGV > 2){
    print "Usage: hmm-tbl-best.pl < in > out\n";
    printf " %-19s  %s\n", "-o/--out", "write to this file [STDOUT]";
    printf " %-19s  %s\n", "-h/--help", "show this help";
    printf " %-19s  %s\n", "-D/--debug", "show debug messages";
    exit 0;
}

my $prev = "";
while (<>) {
    if (/^#/){$as_tsv || print; next;}
    my @r = split(/\s+/, $_, 19);

    # assume sorted, so best is just first
    if ($r[2] ne $prev){
        print $as_tsv ? join("\t", @r) : $_;
    }
    $prev = $r[2];
}
