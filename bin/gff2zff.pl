#!/usr/bin/env perl
use strict;
use warnings FATAL => 'all';

my %gene;
my @chr;
my %chr;
while (<>) {
	my @f = split;
	if (not defined $chr{$f[0]}) {
		push @chr, $f[0];
		$chr{$f[0]} = 1;
	}
	next unless $f[2] eq 'CDS';
	my ($name) = $f[8] =~ /Name=(.+)_CDS/;
	if (not defined $name) {
		die ">>$_";
	}
	push @{$gene{$f[0]}{$name}}, {beg => $f[3], end => $f[4]}
}

foreach my $chr (@chr) {
	print ">$chr\n";
	foreach my $name (keys %{$gene{$chr}}) {
		foreach my $exon (@{$gene{$chr}{$name}}) {
			print join("\t", 'Exon', $exon->{beg}, $exon->{end}, $name), "\n";
		}
	}
}

__END__

ID=YAL069W;Name=YAL069W
chrI    SGD     gene    335     649     .       +       .       ID=YAL069W;Name=YAL069W;Ontology_term=GO:0003674,GO:0005575,GO:0008150;Note=Dubious%20open%20reading%20frame%20unlikely%20to%20encode%20a%
