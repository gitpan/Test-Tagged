#!/usr/bin/env perl
package Test::Tagged;
use strict;
use warnings;

our $VERSION = '0.01_01';

sub import {
    my $class   = shift;
    my %has_tag = map { lc($_) => 1 } @_;

    # no wanted tags? then we're not excluding any tests based on tags
    return unless $ENV{TEST_TAGGED_TAGS};

    for my $wanted (split ' ', $ENV{TEST_TAGGED_TAGS}) {
        return if $has_tag{lc $wanted};
    }

    require Test::Builder;
    my $TB = Test::Builder->new;

    if ($TB->has_plan) {

        # XXX: Test::Builder 0.80 does not have skip_rest yet, but it has doc for it, so here's to hoping.
        $TB->skip_rest("Test did not have a desired tag.") if $TB->can('skip_rest');

        $TB->BAIL_OUT("Test did not have a desired tag. Use Test::Tagged before setting a test plan to avoid bailout.");
    }
    else {
        Test::Builder->new->skip_all("Test did not have a desired tag.");
    }
}

1;

__END__

=head1 NAME

Test::Tagged - tag your tests so they can be run selectively

=head1 SYNOPSIS

    use Test::Tagged qw/IM email/;
    use Test::More tests => 10;
    # ...

    # then run them
    prove -PTagged=im
    prove -PTagged=EMail
    prove

    # or don't run them
    prove -PTagged=web
    prove -PTagged=api,auth

=head1 DESCRIPTION

Tests are often split into many different files. You may have C<t/oauth.t> to
test your application's OAuth support, C<t/rest.t> to test your REST API, and
so on. This has served us well for a long while.

Unfortunately things are rarely so cleanly cut. Perhaps your OAuth tests are
using your REST API, or your date/time tests are using your IM interface. If
you make a change to one part of your system, you of course run your tests to
make sure nothing broke.

But what if your entire test suite takes twenty minutes to run? You must love
testing as much as I do! But unfortunately it'd be prohibitively expensive to
run tests after every little change. If you can't run your tests after every
change, then they've lost a lot of their potency.

C<Test::Tagged> alleviates this by letting you tag your tests (with as many
tags as you want!), then letting you specify which tags to run tests in
L<prove>.

If you're working on your REST API, then you can use C<prove -PTagged=REST>
to run all tests with the "REST" tag (which would include C<t/oauth.t> because
it uses the REST API).

=head1 DIAGNOSTICS

=over 4

=item C<Use Test::Tagged before setting a test plan to avoid bailout.>

This indicates that you used C<< Test::More tests => N >> before using
C<Test::Tagged>. Unfortunately, in current versions of L<Test::Builder>, it's
impossible to skip all tests after a plan has been set. The best we can do is
use L<Test::Builder/BAILOUT> which aborts the B<rest of the test suite>. Future
versions of L<Test::Builder> will hopefully have a C<skip_rest> procedure.

For best results, use C<Test::Tagged> before L<Test::More> (or any other test
module).

=back

=head1 SEE ALSO

L<App::Prove>, L<App::Prove::Plugin::Tagged>

=head1 THANKS

Hiveminder's extensive (but unfortunately slow) test suite for driving
innovation. :)

=head1 AUTHOR

Shawn M Moore, C<< <sartak@bestpractical.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-test-tagged at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Tagged>.

=head1 LICENSE

Copyright 2008 Best Practical Solutions, LLC.
Test::Tagged is distributed under the same terms as Perl itself.

=cut

