#!/usr/bin/env perl
use warnings FATAL => 'all';
use strict;

use IMITS::Util::SiteSpecificRecombination qw( apply_cre apply_flp apply_flp_cre );
use Bio::SeqIO;
use IO::Handle;
use Getopt::Long;
use Pod::Usage;

GetOptions(
    'help'        => sub { pod2usage( -verbose   => 1 ) },
    apply_cre     => \my $apply_cre,
    apply_flp     => \my $apply_flp,
    apply_flp_cre => \my $apply_flp_cre,
) or pod2usage(2);

my $stream = Bio::SeqIO->newFh( -fh => \*ARGV, -format => 'genbank' );

while (  my $seq = <$stream> ) {
    my $modified_seq;
    if ( $apply_cre ) {
        $modified_seq = apply_cre( $seq );
    }
    elsif ( $apply_flp ) {
        $modified_seq = apply_flp( $seq );
    }
    elsif ( $apply_flp_cre ) {
        $modified_seq = apply_flp_cre( $seq );
    }
    else {
        pod2usage( 'Must specify a recombinse to apply' );
    }

    my $ofh = IO::Handle->new->fdopen( fileno(STDOUT), 'w' );
    my $seq_out = Bio::SeqIO->new( -fh => $ofh, -format => 'genbank' );
    $seq_out->write_seq( $modified_seq );
}

__END__

=head1 NAME

recombinate_sequence.pl - Driver script for IMITS::Util::SiteSpecificRecombination

=head1 SYNOPSIS

recombinate_sequence.pl [options] input_file | STDIN

      --help            Display a brief help message
      --apply_cre       Apply cre to sequence
      --apply_flp       Apply flp to sequence
      --apply_flp_cre   Apply flp then cre to sequence

You must specify just one recombinase to apply to the sequence.

=head1 DESCRIPTION

Takes a GenBank file ( through STDIN or ARGV ) and applies the specified recombinase(s) to the sequence.
Returns a the modfied sequence ( as GenBank file ) to STDOUT.

=head1 AUTHOR

Sajith Perera
Peter Matthews

=head1 BUGS

None reported... yet.

=cut
