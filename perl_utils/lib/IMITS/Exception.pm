package IMITS::Exception;
## no critic(RequireUseStrict,RequireUseWarnings)
{
    $IMITS::Exception::VERSION = '0.044';
}
## use critic


use Moose;
use namespace::autoclean;

extends 'Throwable::Error';

__PACKAGE__->meta->make_immutable( inline_constructor => 0 );

1;
