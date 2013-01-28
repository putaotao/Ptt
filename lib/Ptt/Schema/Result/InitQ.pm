use utf8;
package Ptt::Schema::Result::InitQ;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Ptt::Schema::Result::InitQ

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<init_q>

=cut

__PACKAGE__->table("init_q");

=head1 ACCESSORS

=head2 q_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 active

  data_type: 'enum'
  default_value: 'y'
  extra: {list => ["y","n"]}
  is_nullable: 0

=head2 dt_created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 dt_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 value

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "q_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "active",
  {
    data_type => "enum",
    default_value => "y",
    extra => { list => ["y", "n"] },
    is_nullable => 0,
  },
  "dt_created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "dt_updated",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "value",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</q_id>

=back

=cut

__PACKAGE__->set_primary_key("q_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<value>

=over 4

=item * L</value>

=back

=cut

__PACKAGE__->add_unique_constraint("value", ["value"]);


# Created by DBIx::Class::Schema::Loader v0.07017 @ 2013-01-28 12:46:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xisNy03gHhfSaUWV4IhzLg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
