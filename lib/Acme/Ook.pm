package Acme::Ook;

use strict;
use vars qw($VERSION);
$VERSION = '0.04';

my %Ook = (
	    '.?'	=> '$Ook++;',
	    '?.'	=> '$Ook--;',
	    '..'	=> '$Ook[$Ook]++;',
	    '!!'	=> '$Ook[$Ook]--;',
	    '!.'	=> 'print chr$Ook[$Ook];',
	    '.!'	=> '$Ook[$Ook]=read(STDIN,$Ook[$Ook],1)?ord$Ook[$Ook]:0;',
	    '!?'	=> 'while($Ook[$Ook]){',
	    '?!'	=> '}',
	    );

sub _compile {
    $_[0] =~ s/(?:\s*Ook(.)\s*Ook(.)\s*|\s*\#(.*)|(\S.*))/defined($1)&&defined($2)?$Ook{$1.$2}:(defined($3)?"#$3\n":die"OOK? $_[1]:$_[2] '$4'\n")/eg;
    return $_[0];
}

sub compile {
    my $self = shift;
    my $prog;
    $prog .= _compile($$self, "(new)", 0) if defined $$self && length $$self;
    if (@_) {
	local *OOK;
	while (@_) {
	    my $code = shift;
	    if (ref $code eq 'IO::Handle') {
		while (<$code>) {
		    $prog .= _compile($_, $code, $.);
		}
		close(OOK);
	    } else {
		if (open(OOK, $code)) {
		    while (<OOK>) {
			$prog .= _compile($_, $code, $.);
		    }
		    close(OOK);
		} else {
		    die "OOK! $code: $!\n";
		}
	    }
	}
    } else {
	while (<STDIN>) {
	    $prog .= _compile($_, "(stdin)", $.);
	}
    }
    return '{my($Ook,@Ook);local$^W = 0;' . $prog . '}';
}

sub Ook {
    eval &compile;
}

sub new {
    my $class = shift;
    bless \$_[0], ref $class || $class;
}

1;
__END__
=pod

=head1 NAME

Acme::Ook - the Ook! programming language

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

The constructor.  One optional argument, a string of Ook! that will
be executed before any code supplied in Ook().

=item Ook

The interpreter.  Compiles and executes the Ook! code.  Takes one or
more arguments, either filenames or IO globs, or no arguments, in which
case the stdin is read.

=item compile

The compiler.  Takes the same arguments as Ook().  Normally not used
directly but instead via Ook() that also executes the code.  Returns
the intermediate code.

=back

=head1 INTERPRETER

The interpreter is the frontend to the Acme::Ook module.  It is used
as one would imagine: given one (or more) Ook! input files (or none,
in which case stdin is expected to contain Ook!), the interpreter
compiles and executes the Ook.

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

If your code doesn't look like proper Ook!, the interpreter will
make its confusion known, similarly if an input file cannot be read.

At least Perl 5.6.0 is recommended but not required, but that's
only because of a bug in Perl 5.00503 that makes the hello.t test
to moan like this:

	t/hello.............untie attempted while 1 inner references still exist at t/hello.t line 7, <OOK> chunk 26.

The test is fine, Perl 5.00503 is not.

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
