#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

use Test::WWW::Mechanize;
use LWP::Protocol::PSGI;

use App::Mousable;

use JSON::XS qw(decode_json);

# Thanks to haarg for the tip
$ENV{PLACK_ENV} = 'test';

{
    my $psgi_app = App::Mousable::dance;

    LWP::Protocol::PSGI->register($psgi_app);

    my $mech = Test::WWW::Mechanize->new;

    $mech->get_ok( 'http://localhost/api/hello' );

    # TEST
    is ($mech->content_type(), 'application/json',
        "/api/hello returned JSON");

    # TEST
    my $json = decode_json( $mech->content() );

    # TEST
    is_deeply(
        $json,
        { reply => "Hello", },
        "/api/hello returned the proper JSON.",
    );
}

