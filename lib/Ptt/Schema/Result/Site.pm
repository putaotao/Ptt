use utf8;
package Ptt::Schema::Result::Site;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Ptt::Schema::Result::Site

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<site>

=cut

__PACKAGE__->table("site");

=head1 ACCESSORS

=head2 site_id

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

=head2 site_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 domain

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 track_url

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 1024

=cut

__PACKAGE__->add_columns(
  "site_id",
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
  "site_name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "domain",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "track_url",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 1024 },
);

=head1 PRIMARY KEY

=over 4

=item * L</site_id>

=back

=cut

__PACKAGE__->set_primary_key("site_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<domain>

=over 4

=item * L</domain>

=back

=cut

__PACKAGE__->add_unique_constraint("domain", ["domain"]);


# Created by DBIx::Class::Schema::Loader v0.07017 @ 2013-01-23 16:04:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tKJiUtcOpAfGS+NGF6c6fw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
