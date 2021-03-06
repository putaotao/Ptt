package Ptt::Controller::Compare;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

use utf8;
use Data::Page;
use Page;
use Debug;
use Date::Calc;
use URI::Escape;

sub compare : Chained("/") : PathPart("compare") : Args(0) {
    my ( $self, $c ) = @_;

    my $q    = $c->req->params->{q};

    debug("param q: $q");

    my $qh = $c->model('Analysis::Query')->parse_q($q);
    
    if ( $qh->{k} ) {
	if ( $c->model('Analysis::Model')->is_model($qh->{k}) ) {
	    my $now = "now()";
	    $c->model('PttDB::Model')->find_or_create({dt_created => \$now, dt_updated => \$now, value => $qh->{k}}, {key => 'value'});
	}
    }

    my $p = $c->req->params->{p} || 1;
    $qh->{p} = $p;
    $qh->{page_size} = $c->config->{page_size};
    $qh->{p1} = $c->req->params->{p1};
    $qh->{p2} = $c->req->params->{p2};
    $qh->{sort} = $c->req->params->{sort} || "price";

    # NOTE: stock is 0, include: all
    #       stock is 1, only include: in stock
    #       stock is 2, only include: out of stock
    #       stock is 3, only include: pre order

    if ( defined $c->req->params->{stock} && $c->req->params->{stock} ne '' ) {
	$qh->{stock} = $c->req->params->{stock};
    } else {
	$qh->{stock} = 1;
    }

    my ( $total_results, $results );
    if ( $qh->{ean} ) {
        $results = $c->model('ImmediateSearch')->search($qh);
        $total_results = @$results;
    }

    my @now = localtime;
    my ( $y2, $m2, $d2, $hh2, $mm2, $ss2 ) = ($now[5]+1900, $now[4]+1, $now[3], $now[2], $now[1], $now[0]);

    my %site_seen;
    if ( $results ) {
	foreach my $item ( @$results ) {
	    if ( $item->{price} ) {
		$item->{price} = sprintf("%.2f", $item->{price});
	    }

            $item->{url} = "/t?site_id=$item->{site_id}&to=" . uri_escape($item->{url});

	    $site_seen{$item->{site_id}}++;
            if ( my $dt_created = $item->{dt_created} ) {
                my ( $y1, $m1, $d1, $hh1, $mm1, $ss1 ) = ($dt_created =~ m{(\d+)-(\d+)-(\d+)T(\d+):(\d+):(\d+)Z});
                $hh1 =~ s{^0+}{};
                my @deltas = Date::Calc::N_Delta_YMDHMS( $y1, $m1, $d1, $hh1, $mm1, $ss1, $y2, $m2, $d2, $hh2, $mm2, $ss2 );
                my $i = 0;
                foreach ( @deltas ) {
                    if ( $_ ) {
                        if ( $i == 0 ) {
                            $item->{dt_delta} = $_ . "年前";
                            last;
                        } elsif ( $i == 1 ) {
                            $item->{dt_delta} = $_ . "月前";
                            last;
                        } elsif ( $i == 2 ) {
                            $item->{dt_delta} = $_ . "天前";
                            last;
                        } elsif ( $i == 3 ) {
                            $item->{dt_delta} = $_ . "小时前";
                            last;
                        } elsif ( $i == 4 ) {
                            $item->{dt_delta} = $_ . "分钟前";
                            last;
                        } elsif ( $i == 5 ) {
                            $item->{dt_delta} = $_ . "秒前";
                            last;
                        }
                    }
                    $i++;
                }
            }
	}
    }
     
    my $rs = $c->model("PttDB::Site")->search({}, { site_id => { -in => [keys %site_seen] } } );
    while ( my $site =  $rs->next ) {
	$site_seen{$site->site_id} = $site->site_name;
    }


    my $data_page = Data::Page->new($total_results, $c->config->{page_size}, $p);
    my $page = Page->new(data_page => $data_page);
    $page->paging;

    $c->stash(results => $results, 
	      total_results => $total_results, 
	      page => $page, 
	      site_seen => \%site_seen,
	      qh => $qh,
	      template => 'compare.tt'
        );
}

__PACKAGE__->meta->make_immutable;

1;


