#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw/sum/;
use Test::More;
use Test::Warnings;
use Getopt::Alt;

build();
done_testing();

sub build {
    my $opt = eval { Getopt::Alt->new({ helper => 0 }, []) };
    ok $opt;

    $opt = eval {
        Getopt::Alt->new(
            {
                helper      => 0,
                conf_prefix => 't/.',
            },
            ['foo|f']
        )
    };
    ok $opt, "Conf read with out error";
    ok $opt->default->{foo}, "--foo read";
    is $opt->aliases->{bar}[0], 'baz', "bar is baz";

    $opt = eval {
        Getopt::Alt->new(
            {
                helper      => 0,
                conf_prefix => 't/.',
                name        => 'other',
            },
            ['foo|f']
        )
    };
    ok $opt, "Conf read with out error";
    ok !$opt->default->{foo}, "--foo not read";
}

