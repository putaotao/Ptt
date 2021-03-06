#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'Ptt';
all_from 'lib/Ptt.pm';

requires 'Catalyst::Runtime' => '5.90007';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
requires 'Catalyst::Plugin::Unicode::Encoding';
requires 'Catalyst::View::TT';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Session::Store::Memcached';
requires 'Catalyst::Plugin::Authentication';
requires 'DBIx::Class';
requires 'Catalyst::Model::DBIC::Schema';
requires 'XML::Simple';
requires 'MooseX::MarkAsMethods';
requires 'MooseX::NonMoose';
requires 'DBIx::Class::Schema::Loader';
requires 'Domain::PublicSuffix';
requires 'Image::OCR::Tesseract';
requires 'Business::ISBN';
requires 'Date::Calc';
requires 'Catalyst::Helper::View::JSON';
requires 'AnyEvent::HTTP';

test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
