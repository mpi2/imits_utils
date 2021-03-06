package IMITS::Exception::InvalidConfiguration;
## no critic(RequireUseStrict,RequireUseWarnings)
{
    $IMITS::Exception::InvalidConfiguration::VERSION = '0.044';
}
## use critic


use Moose;
use MooseX::Types::Path::Class;
use namespace::autoclean;

extends 'IMITS::Exception';

has conffile => (
    is       => 'ro',
    isa      => 'Path::Class::File',
    coerce   => 1,
    required => 1
);

has errors => (
    is       => 'ro',
    isa      => 'ArrayRef[Str]',
    required => 1
);

has '+message' => (
    builder    => '_build_message'
);

sub _build_message {
    my $self = shift;

    return join ( "\n  ", 'Errors detected in configuration file ' . $self->conffile . ':',
           @{ $self->errors } );
}

__PACKAGE__->meta->make_immutable( inline_constructor => 0 );

1;

__END__
