package Acme::Ook;

use strict;
use vars qw($VERSION);
$VERSION = '0.02';

my %code = (
	    '.?'	=> '$i++;',
	    '?.'	=> '$i--;',
	    '..'	=> '$s[$i]++;',
	    '!!'	=> '$s[$i]--;',
	    '!.'	=> 'print chr$s[$i];',
	    '.!'	=> '$s[$i]=read(STDIN,$s[$i],1)?ord$s[$i]:0;',
	    '!?'	=> 'while($s[$i]){',
	    '?!'	=> '}',
	    );

sub compile {
    my $self = shift;
    my $prog = join "\n", @_;
    $prog =~ s/(?:Ook(.)\s*Ook(.)\s*|\s*\#(.*)|(\S+))/defined($1)&&defined($2)?$code{$1.$2}:(defined($3)?"#$3\n":die"OOK? $. '$4'\n")/eg;
    return '{my$i;my@s;local$^W = 0;' . $prog . '}';
}

sub Ook {
    eval &compile;
}

sub new {
    my $class = shift;
    bless { }, ref $class || $class;
}

1;
__END__
=pod

=head1 NAME

Acme::Ook - the Ook programming language

=head1 SYNOPSIS

    ook ook.ook

or

    use Acme::Ook;
    my $Ook = Acme::Ook->new;
    $Ook->Ook($Ook);

=head1 DESCRIPTION

As described in http://www.dangermouse.net/esoteric/ook.html

    Since the word "ook" can convey entire ideas, emotions, and
    abstract thoughts depending on the nuances of inflection, Ook!
    has no need of comments. The code itself serves perfectly well to
    describe in detail what it does and how it does it. Provided you
    are an orang-utan.

Here's for example how to print a file in reverse order:

    Ook. Ook. Ook! Ook? Ook. Ook? Ook. Ook! Ook? Ook!
    Ook? Ook. Ook! Ook! Ook! Ook? Ook. Ook. Ook! Ook.
    Ook? Ook. Ook! Ook! Ook? Ook!

The language specification can be found from the above URL.

Despite the above, the interpreter does understand comments,
the #-until-end-of-line kind.

=head1 MODULE

The Acme::Ook is the backend for the Ook interpreter.

=head2 Methods

=over 4

=item new

The constructor.

=item Ook

The interpreter.

=item compile

The compiler.

=back

=head1 INTERPRETER

The interpreter is the frontend to the Acme::Ook module.  It is used
as one would imagine: given one (or more) Ook input files (or none, in
which case stdin is expected to contain Ook), the interpreter compiles
and executes the Ook.

=head2 Command Line Options

There are two command line options:

=over 4

=item -l

Some example programs look better if an extra newline is shown
after the execution.

=item -S

If you want to see the intermediate code.

=back

=head1 DIAGNOSTICS

If your code doesn't look like proper Ook, the interpreter will
make its confusion known.

=head1 AUTHOR, COPYRIGHT, LICENSE

Jarkko Hietaniemi <jhi@iki.fi>

Copyright (C) 2002 Jarkko Hietaniemi 

This is free software; you may redistribute it and/or modify
it under the same terms as Perl itself.

The sample programs are Copyright (C) 2002 Lawrence Pit (BlueSorcerer),
from http://bluesorcerer.net/esoteric/ook.html

=head1 DISCLAIMER

I never called anyone a monkey.  Honest.

=cut
