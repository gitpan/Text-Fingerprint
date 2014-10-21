#!/usr/bin/env perl
use autodie;
use strict;
use warnings qw(all);

use Text::Fingerprint qw(fingerprint_ngram);

my %clusters;
open my $fh, q(<), q(/usr/share/dict/words);
while (<$fh>) {
    chomp;
    ++$clusters{fingerprint_ngram($_)}->{$_};
}
close $fh;

while (my ($key, $cluster) = each %clusters) {
    next if 2 > keys %$cluster;
    my @word = sort keys %$cluster;

    local ($\, $,) = (qq(\n), q(, ));
    print @word;
}
