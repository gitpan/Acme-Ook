use Acme::Ook;
print "1..1\n";
if (open(OOK, "hello.ook")) {
  my $Ook = Acme::Ook->new;
  my $out = tie *STDOUT, 'FakeOut';
  $Ook->Ook(<OOK>);
  untie *STDOUT;
  print $$out eq "Hello World!" ? "ok 1\n" : "not ok 1 # $$out\n";
} else {
  die "$0: failed to open 'hello.ook' for reading: $!\n";
}
package FakeOut;
sub TIEHANDLE {
  bless(\(my $text), $_[0]);
}
sub clear {
  ${ $_[0] } = '';
}
sub PRINT {
  my $self = shift;
  $$self .= join('', @_);
}
