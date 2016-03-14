#!/usr/bin/perl
use strict;
use warnings;

# File  : Pubmed record file
# Author: Yasin ZOR
# Date  : 22 Dec 2014
#
#Purpose: Read pubmed record

my $filename = 'oku.txt';
open(INFILE, $filename)
or die "Could not open file '$filename' $!";
my @sequence = ();
my $count = 0;	 	
my $n = -1;	
my @list = ();
my %data=();
	
while (my $row = <INFILE>) {
chomp $row;

if ($row=~/^$/){ 
    $n++;			   
	$sequence[$n] = "";	    # start a new (empty) sequence
    }
    else {
	$sequence[$n] .= $row;     # append to end of current sequence
    }
}
close INFILE;
$count = $n+1;
for (my $i = 0; $i < $count; $i++) {
   $sequence[$i] =~s/(\s\s)+/ /g;
   my %data=();
   if ($sequence[$i]=~/PMID\-(\s)*(\d+)/){
    open(FILE,">>PMID$2.out");
    #print $2,"\n";
    }
   if ($sequence[$i] =~/TI(\s*+\-\s)((\w+\s)+(\w+\.)*(\w+\-\w+.)*)/){
    #print "$2\n";
    print FILE "Title:$2\n";   
    }
   if ($sequence[$i] =~/AB\s*\-(.+)(AD)/) {
        #print $1,"\n";
        @list=  split / /,$1;
        #print $list[1],"\n";
    for(my $j=0;$j<scalar(@list);$j++){  
       # print $list[$i],"\n";
        $data{$list[$j]}++;
        } 
        foreach my $key (sort keys %data){
        # print $key," ",$data{$key},"\n";
        print FILE $key," ",$data{$key},"\n";
        }
        
}
close FILE;


}

