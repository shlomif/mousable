#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

use Test::WWW::Mechanize;
use LWP::Protocol::PSGI;

use JSON::XS qw(decode_json);

{
    my $psgi_app = require App::Mousable;

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

