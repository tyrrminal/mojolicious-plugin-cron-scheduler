use v5.26;
use warnings;

use Test::Mock::Time;
use Test2::V0;
use Test::Mojo;
use Mojolicious::Lite;
use File::Path qw(rmtree);
use File::Spec;

use experimental qw(signatures);

# clear job locks so tests can be re-run statelessly
rmtree($_) foreach(glob(File::Spec->tmpdir."/mojo_cron_*"));

my %record;

plugin 'Cron::Scheduler' => {
  schedules => {
    job1 => [{
      schedule => {
        hour   => 12,
        minute => 6,
      },
      parameters => [qw(red)]
    }, {
      schedule => {
        hour   => 18,
        minute => 0
      },
      parameters => [qw(blue)]
    } 
    ]
  },
  tasks => {
    job1 => sub($color) { push($record{job1}->@*, $color); Mojo::IOLoop->stop }
  }
};

get '/' => {text => 'Hello, world'};
my $t = Test::Mojo->new;
# needed to kickstart event loop, for some reason
$t->get_ok('/')->status_is(200);

ff(24*60*60); # go forward one day

is(\%record, {job1 => [qw(red blue)]}, 'test multi params');

done_testing;
