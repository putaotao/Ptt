package UA;
use LWP::UserAgent;
use Debug;

sub new {
    my $class = shift;
    my $self = {
	@_,
    };
    bless $self, $class;
    $self->init();
    return $self;
}

sub init {
    my $self = shift;
    $self->{ua} = LWP::UserAgent->new();
}

sub save {
    my $self = shift;
    my $from_file = shift;
    my $to_file = shift;
    my $resp = $self->{ua}->get($from_file, ':content_file' =>  $to_file);
    debug("download $from_file to $to_file down, status: " . $resp->status_line);
}

sub get {
    my ($self, $url) = @_;

    my $ua = $self->{ua};
    my $max_retries = 5; my $retries = 1;
    my $resp = $ua->get($url);
    while (1) {
        sleep 2 * $retries;
        last if $resp->is_success;
        $retries++;
        last if $retries > $max_retries;
        $resp = $ua->get($url);
    }
    return $resp;
}

1;
