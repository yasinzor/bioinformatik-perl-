#!/usr/bin/perl
use strict;
use warnings;

# File: hw1YasinZor.pl
# Author: Yasin Zor
# Date: 30 OCT 2014
#
# Purpose: Read sequences from a FASTA format file

# the argument list should contain the file name
die "usage: fasta.pl filename\n" if scalar @ARGV < 1;

# get the filename from the argument list
my ($filename) = @ARGV;

# Open the file given as the first argument on the command line
open(INFILE, $filename) or die "Can't open $filename\n";

# variable declarations:
my @header = ();		    # array of headers
my @sequence = ();		    # array of sequences
my $count = 0;	           	    # number of sequences
my $min=0; my $len=0; my $ave=0;
my $max=0; my $sum=0;

# read FASTA file
my $n = -1;			    # index of current sequence
while (my $line = <INFILE>) {
    chomp $line;		    # remove training \n from line
    if ($line =~ /^>/) { 	    # line starts with a ">"
	$n++;			    # this starts a new header
	$header[$n] = $line;	    # save header line
	$sequence[$n] = "";	    # start a new (empty) sequence
    }
    else {
	next if not @header;	    # ignore data before first header
	$sequence[$n] .= $line     # append to end of current sequence
    }
}
$count = $n+1;			  # set count to the number of sequences
close INFILE;

# remove white space from all sequences
for (my $i = 0; $i < $count; $i++) {
    $sequence[$i] =~ s/\s//g;
}

########## Sequence processing starts here:
##### REST OF PROGRAM


for (my $i=0; $i<$count;$i++){
$len = length($sequence[$i]);
$min = $len if (!$min || $len < $min); # find shortest sequence
$max = $len if (!$max || $len > $max); # find longest sequence
$sum += $len; 			       # find total sequence
$ave =($sum / $count);		       # find average sequence
}
print "Report for file $filename.\n";
print "There are $count sequences in the file.\n";
print "Total sequence length = $sum\n";
print "Maximum sequence length = $max\n";
print "Minimum sequence length = $min\n";
print "Average sequence length = $ave\n";
print "\n";


my $base="";
# process the sequences
for (my $i = 0; $i < $count; $i++) {
    my $count_of_A=0; my $count_of_C=0; my $count_of_G=0;my $count_of_T=0;my $count_of_CG=0;
    print "$header[$i]\n";
    $len = length($sequence[$i]);
    print "Length : $len\n";
    #print "$sequence[$i]\n";
   for(my $j = 0; $j<$len;$j++) {
    $base = substr($sequence[$i], $j, 1);
    if     ( $base eq 'A' ) {
        $count_of_A++;
    } elsif ( $base eq 'C' ) {
        $count_of_C++;
    } elsif ( $base eq 'G' ) {
        $count_of_G++;
    } elsif ( $base eq 'T' ) {
        $count_of_T++;
    } 
    $base = substr($sequence[$i], $j, 2);
    if ( $base eq "CG") {
        $count_of_CG++;
    } 
}
printf ("A = %4.2f\n", $count_of_A);
printf ("C = %4.2f\n", $count_of_C);
printf ("G = %4.2f\n", $count_of_G);
printf ("T = %4.2f\n", $count_of_T);
printf ("CG = %4.2f\n", $count_of_CG);
}

exit;

