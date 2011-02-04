package Test::Routine::Common;
BEGIN {
  $Test::Routine::Common::VERSION = '0.008';
}
use Moose::Role;
# ABSTRACT: a role composed by all Test::Routine roles


use Test::More ();

use namespace::autoclean;

sub run_test {
  my ($self, $test) = @_;

  my $name = $test->name;
  Test::More::subtest($test->description, sub { $self->$name });
}

1;

__END__
=pod

=head1 NAME

Test::Routine::Common - a role composed by all Test::Routine roles

=head1 VERSION

version 0.008

=head1 OVERVIEW

Test::Routine::Common provides the C<run_test> method described in L<the docs
on writing tests in Test::Routine|Test::Routine/Writing Tests>.

=head1 AUTHOR

Ricardo Signes <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo Signes.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

