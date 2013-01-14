use utf8;
package Ptt::Schema::Result::ItemPrice;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Ptt::Schema::Result::ItemPrice

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<item_price>

=cut

__PACKAGE__->table("item_price");

=head1 ACCESSORS

=head2 id

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 22

=head2 dt_created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 price

  data_type: 'decimal'
  default_value: 0.00
  is_nullable: 0
  size: [10,2]

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "char", default_value => "", is_nullable => 0, size => 22 },
  "dt_created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "price",
  {
    data_type => "decimal",
    default_value => "0.00",
    is_nullable => 0,
    size => [10, 2],
  },
);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2013-01-12 21:50:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OXzpgj4bO3DT9S13bcOBpQ

__PACKAGE__->belongs_to(item => 'Ptt::Schema::Result::Item', 'id');

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
