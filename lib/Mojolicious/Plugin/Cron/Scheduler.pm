package Mojolicious::Plugin::Cron::Scheduler;
use v5.26;
use warnings;

# ABSTRACT: Mojolicious Plugin that extends Mojolicious::Plugin::Cron for additional job configuration

=head1 SYNOPSIS

# For a full Mojo app
$self->plugin('Cron::Scheduler',
  tasks => {
    do_a_athing => {
      minute => 0,
      hour => '*',
      day => '*',
      month => '*',
      weekday => '*'
    }
  },
  jobs => {
    do_a_thing => sub {
      ...
    }
  }
);

=head1 DESCRIPTION

This module makes it simple to separately add jobs (named anonymous subs) and 
tasks (cron-like schedules)

The intention here is that the jobs are hardcoded into the application while 
the tasks are derived from an environment-specific configuration.

Tasks are required to specify all 5 time-unit hash keys or the task will be ignored.

Each job is "debug" logged when it is scheduled and "info" logged when it is
run, negating the need to include a log message in each job's implementation.

=cut

use Mojo::Base 'Mojolicious::Plugin';
use Mojolicious::Plugin::Cron;

use List::Util qw(min max);

use experimental qw(signatures);

sub register ($self, $app, $args) {
}

=head1 AUTHOR

Mark Tyrrell C<< <mark@tyrrminal.dev> >>

=head1 LICENSE

Copyright (c) 2024 Mark Tyrrell

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

=cut

1;

__END__

