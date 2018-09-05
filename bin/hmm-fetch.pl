#!/usr/bin/env perl
# Created: 21 Aug 2017
# Author: Thomas Hackl, thackl@lim4.de

# Extract profiles from hmm based on list of ACCs

use warnings;
use strict;

if (@ARGV != 2) {
    die "Usage:\n  hmm-filter.pl HMM.hmm ACC.txt\n";    
}

open(HMM, $ARGV[0]) or die $!;
open(ACC, $ARGV[1]) or die $!;

my %ACC;

while(<ACC>){
    chomp();
    $ACC{$_}++ if length($_); # no empty lines
}

print STDERR "Looking for ", scalar keys %ACC, " hmms\n";

my $hmm_c = 0;
my $hmm_f = 0;
my $acc;
my $r="";
while(<HMM>){
    $r.= $_;
    if(/^ACC\s+(\S+)/){
        $acc = $1;
    }
    if(m{^//}){
        $hmm_c++;
        if (exists $ACC{$acc}){
            $hmm_f++;
            print $r;
        }
        $r="";
    }
}

print STDERR "Scanned $hmm_c profiles\n";
print STDERR "Found $hmm_f out of ", scalar keys %ACC, " target records\n"
