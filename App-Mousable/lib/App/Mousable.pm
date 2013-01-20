package App::Mousable;

use strict;
use warnings;

use JSON::XS qw(encode_json);

use Dancer ':syntax';

our $VERSION = '0.0.1';

get '/api/hello' => sub {
    content_type 'application/json';
    return encode_json({reply => 'Hello', });
};

true;
# dance;

=head1 NAME

App::Mousable - the main dancer application implementing an AJAX-based
commenting engine.

