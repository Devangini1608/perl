##!/usr/bin/perl
# Purpose: compare two files and show differences
# usage: file_compare.pl filename1 filename2

use strict;
use Text::Diff;
use warnings;
my $f1 =$ARGV[0];
chomp $f1;

my $f2 =$ARGV[1];
chomp $f2;

print "1.Compare files line by line\n";
print "2.Compare files in terms of Context\n";

my $res=<STDIN>;

open( f1, "< $f1" ) or die "Can not read file $f1: $! \n";
my @f1_contents = <f1>;    # read entire contents of file
close(f1);

open( f2, "< $f2" ) or die "Can not read file $f2: $! \n";
my @f2_contents = <f2>;    # read entire contents of file
close(f2);


my $len1=$#f1_contents;    # number of lines in first file
my $len2=$#f2_contents;    # number of lines in second file

my $ans=1;
my $x=0;

while($ans==1){


if($x==1){
	
	print "Enter the filenames:\nFirst Filename: ";
	$f1=<STDIN>;
	chomp $f1;
	print"Second Filename: ";
	$f2=<STDIN>;
	chomp $f2;	
	print "1.Compare files line by line\n";
	print "2.Compare files in terms of Context\n";
	$res=<STDIN>;
	chomp $res;	
	}
if($res==1){
	print "LINE BY LINE COMPARISON OF FILES\n";
	print "-----------------------------------------------------\n";



if ($len1>$len2) {
    #first file given as the argument has more no of lines than the second file
	
    print "$f1 contains more lines than $f2\n";
    print "----------------------------------------------------------------------\n";


    my $l2=0;
    
    foreach my $line_f1 (@f1_contents) {
        chomp($line_f1);
        if ( defined( $f2_contents[$l2] ) ) {

            # line exists in second file
            chomp( my $line_f2 = $f2_contents[$l2] );
            if ( $line_f1 ne $line_f2 ) {
                print "\nline " . ( $l2 + 1 ) . " \n";
                print "< $line_f1 \n" if ( $line_f1 ne "" );
                print "--- \n";
                print "> $line_f2 \n\n" if ( $line_f2 ne "" );
            }
        }
        else {

            # there is no line in second file
            print "\nline " . ( $l2 + 1 ) . " \n";
            print "< $line_f1 \n" if ( $line_f1 ne "" );
            print "--- \n";
            print "> \n";    
        }
        $l2++;         
    }
}
else {
    if($len1==$len2){
	#second file given as the argument has more no of lines than the first file
	print "$f1 and $f2 contain equal no. of lines\n";
	print "----------------------------------------------------------------------\n";    
}
    else{
	#both the files have equal no of lines
    	print "$f2 contains more lines than $f1\n";
        print "----------------------------------------------------------------------\n";
	} 
    
    my $l1 = 0;
    foreach my $line_f2 (@f2_contents) {
        chomp($line_f2);
        if ( defined( $f1_contents[$l1] ) ) {

            # line exists in first file
            chomp( my $line_f1 = $f1_contents[$l1] );
            if ( $line_f1 ne $line_f2 ) {
                print "\nline " . ( $l1 + 1 ) . " \n";
                print "< $line_f1 \n" if ( $line_f1 ne "" );
                print "--- \n";
                print "> $line_f2 \n" if ( $line_f2 ne "" );
            }
        }
        else {

            # there is no line in first file
            print "\nline " . ( $l1 + 1 ) . " \n";
            print "< \n";    # this line does not exist in f1
            print "--- \n";
            print "> $line_f2 \n" if ( $line_f2 ne "" );
        }
        $l1++;         # point to next line in f1
    }
}
}
if($res==2){
my $diff= diff($f1,$f2,{STYLE => "OldStyle"});
print $diff;
}
print "Do you want to continue?(yes=1,no=0)\n";
$ans=<STDIN>;
if($ans==1){
	$x=1;
}
else{
	last;
	exit();
}
}
