#!/usr/bin/env perl
# Copyright 2013 Kevin Spencer <kevin@kevinspencer.org>
#
# Permission to use, copy, modify, distribute, and sell this software and its
# documentation for any purpose is hereby granted without fee, provided that
# the above copyright notice appear in all copies and that both that
# copyright notice and this permission notice appear in supporting
# documentation. No representations are made about the suitability of this
# software for any purpose. It is provided "as is" without express or
# implied warranty.
#

use strict;
use warnings;

our $VERSION = '0.01';

my $plist_file = '/Applications/iTunes.app/Contents/Resources/English.lproj/TextStyles.plist';
my $tmp_file   = "$plist_file.tmp";

open(my $fh, '<', $plist_file) || die "Could not open $plist_file - $!\n";
open(my $tfh, '>', $tmp_file) || die "Could not create $tmp_file - $!\n";
while(<$fh>) {
    my $line = $_;
    if ($line =~ /<string>HelveticaNeue<\/string>/) {
        $line =~ s/HelveticaNeue/LucidaGrande/;
    } elsif ($line =~ /<string>HelveticaNeue-Bold<\/string>/) {
        $line =~ s/HelveticaNeue/LucidaGrande/;
    } elsif ($line =~ /<integer>12<\/integer>/) {
        $line =~ s/12/11/;
    } elsif ($line =~ /<integer>13<\/integer>/) {
        $line =~ s/13/12/;
    }

    print $tfh $line;
}
close($fh);
close($tfh);
rename($tmp_file, $plist_file) || die "Could not rename $tmp_file to $plist_file - $!\n";
