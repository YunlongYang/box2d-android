#!/usr/bin/perl

# TODO: add license

use warnings;
use strict;

use FindBin qw($Bin);
my $ROOT = $Bin;
use File::Copy;
use File::Copy::Recursive qw(dircopy fcopy);
use File::Basename;
use File::Find;
use File::Path qw(make_path remove_tree);

$| = 1;

die "Usage: $0 <gdx_base_dir>\n" if scalar @ARGV < 1;
my $gdx = shift @ARGV;

my $author = &prompt("Author", "Christof Krüger <jniBox2d\@christof-krueger.de>");

my $base = "$gdx/gdx";
print "Importing box2d jni implementation from gdx source directory '$base'\n";
die("No gdx subdirectory in '$gdx'\n") if not -d $base;

# ================ LICENSE STUFF ================

&copy_only("$gdx/gdx/LICENSE",      "$ROOT/LICENSE");
&copy_only("$gdx/gdx/CC-LICENSE",   "$ROOT/CC-LICENSE");

&copy_and_prepend_default("$gdx/gdx/NOTICE",        "$ROOT/NOTICE");
&copy_and_prepend_default("$gdx/gdx/AUTHORS",       "$ROOT/AUTHORS");
&copy_and_prepend_default("$gdx/gdx/CONTRIBUTORS",  "$ROOT/CONTRIBUTORS");

# ================ JAVA SRC ================
my $java_package_from = "com.badlogic.gdx.physics.box2d";
my $java_package_to   = "box2d";

#my $java_package_path_from = $java_package_from;
#$java_package_path_from =~ s[\.][/]g;
my $java_package_path_to = $java_package_to;
$java_package_path_to =~ s[\.][/]g;

#my $java_path_from = "$gdx/gdx/src/$java_package_path_from";
#my $java_path_to   = "$ROOT/src/$java_package_path_to";

# copy
#print "Recursively copying '$java_path_from' to '$java_path_to'... ";
#dircopy($java_path_from, $java_path_to) or die "failed! Check paths and permissions!\n";
#print "ok!\n";

my %package_changes = ( "com.badlogic.gdx.physics.box2d" => "box2d" );
# Move some classes/interfaces around. No renames, please.
my %class_changes = ( "com.badlogic.gdx.math.Vector2"     => "$java_package_to.Vector2",
                      "com.badlogic.gdx.math.MathUtils"   => "$java_package_to.MathUtils",
                      "com.badlogic.gdx.math.Matrix3"     => "$java_package_to.Matrix3",
                      "com.badlogic.gdx.utils.Array"      => "$java_package_to.Array",
                      "com.badlogic.gdx.utils.Disposable" => "$java_package_to.Disposable",
                      "com.badlogic.gdx.utils.ComparableTimSort"     => "$java_package_to.ComparableTimSort",
                      "com.badlogic.gdx.utils.GdxRuntimeException"   => "$java_package_to.GdxRuntimeException",
                      "com.badlogic.gdx.utils.LongArray"  => "$java_package_to.LongArray",
                      "com.badlogic.gdx.utils.LongMap"    => "$java_package_to.LongMap",
                      "com.badlogic.gdx.utils.Pool"       => "$java_package_to.Pool" ,
                      "com.badlogic.gdx.utils.Sort"       => "$java_package_to.Sort",
                      "com.badlogic.gdx.utils.TimSort"    => "$java_package_to.TimSort" );

# copy packages
&copy_packages(%package_changes);
&copy_classes(%class_changes);

print "Removing box2d.Box2DDebugRenderer as it pulls too many libgdx dependencies... ";
unlink "$ROOT/src/$java_package_path_to/Box2DDebugRenderer.java" or die "FAILED\n";
print "ok!\n";

print "Fixing copied .java files...\n";
find(\&fix_changes_in_java_files, "$ROOT/src/");

# ================ JAVA TEST-COMPILE ================
print "Test-compiling *.java files...\n";
my $builddir = "$ROOT/build_java/";
make_path($builddir);
if (system("CLASSPATH='$ROOT/src' javac -d '$builddir' \$(find '$ROOT/src/' -name \*.java -printf %p\\ ) > '$builddir/log.txt' 2>&1"))
{
    warn "Java test-compile failed! See $builddir.\n";
}
else
{
    remove_tree($builddir);
}

# ================ COPY JNI ================
print "Copying Box2D JNI files... ";
dircopy("$gdx/gdx/jni/Box2D", "$ROOT/jni/Box2D")
    or die "FAILED\n";
print "ok!\n";

print "Removing all files that are not *.{h,cpp}... ";
find(sub {unlink if not /\.(h|cpp)$/}, "$ROOT/jni/Box2D");
print "ok!\n";

print "Rename Box2D jni functions to reflect package renames...\n";
find(\&fix_changes_in_c_files, "$ROOT/jni/Box2D");

# ================ Android.mk ================
print "Constructing Android.mk file... ";
open(my $android_mk, '>', "$ROOT/jni/Android.mk")
        or die "Failed opening file '$ROOT/Android.mk'\n";

my @source_files;
my $src_dir = "$ROOT/jni/";
find( {wanted => sub {return if not /\.cpp$/; s/^$src_dir//; push(@source_files, $_); },
       no_chdir => 1},
      $src_dir);

my $SRC_FILES = join(" \\\n    ", @source_files);

print $android_mk <<__EOF__;
LOCAL_PATH := \$(call my-dir)

include \$(CLEAR_VARS)

LOCAL_MODULE := jniBox2d
LOCAL_SRC_FILES := \\
    $SRC_FILES

include \$(BUILD_SHARED_LIBRARY)
__EOF__
close($android_mk);
print "ok!\n";

# ================ Application.mk ================
print "Constructing Application.mk file ... ";
open (my $application_mk, '>', "$ROOT/jni/Application.mk")
        or die "Failed opening file '$ROOT/jni/Application.mk'\n";

print $application_mk <<__EOF__;
APP_ABI := armeabi armeabi-v7a
__EOF__

close($application_mk);
print "ok!\n";

# ================ SUBROUTINES ================
sub copy_packages
{
    my %package_changes = @_;

    while (my ($from, $to) = each %package_changes)
    {
        my $from_package_path = $from;
        my $to_package_path = $to;
        $from_package_path =~ s[\.][/]g;
        $to_package_path =~ s[\.][/]g;
        my $from_path = "$gdx/gdx/src/$from_package_path";
        my $to_path = "$ROOT/src/$to_package_path";
        print "Recursively copying '$from_path' to '$to_path'... ";
        dircopy($from_path, $to_path) or die "failed! Check paths and permissions!\n";
        print "ok!\n";
    }

}

sub copy_classes
{
    my %class_changes = @_;

    while (my ($from, $to) = each %class_changes)
    {
        my $from_java_path = $from;
        my $to_java_path = $to;
        $from_java_path =~ s[\.][/]g;
        $to_java_path =~ s[\.][/]g;
        my $from_path = "$gdx/gdx/src/$from_java_path.java";
        my $to_path = "$ROOT/src/$to_java_path.java";
        print "Recursively copying '$from_path' to '$to_path'... ";
        fcopy($from_path, $to_path) or die "failed! Check paths and permissions!\n";
        print "ok!\n";
    }
}

sub fix_changes_in_java_files
{
    my $filename = $_;
    return if not /\.java$/; # only see java files
    open(my $file, '<', $filename);
    my @lines = <$file>;
    my $modified = 0;
    LINE: for my $line (@lines)
    {
        if ($line =~ /^(package|import)/)
        {
            while (my ($from, $to) = each %package_changes)
            {
                $line =~ s/$from/$to/;
                $modified = 1;
            }

            while (my ($from, $to) = each %class_changes)
            {
                # strip last component
                $from =~ s/\.[^.]*$//;
                $to   =~ s/\.[^.]*$//;
                $line =~ s/$from/$to/;
                $modified = 1;
            }
        }
    }
    close($file);

    if ($modified)
    {
        print "Rewriting $File::Find::dir/$filename...\n";
        open($file, '>', $_);
        &print_modified_notice($file);
        for (@lines)
        {
            chomp;
            s/\r//;
            print $file "$_\n";
        }
        close($file);
    }
}

sub fix_changes_in_c_files
{
    my $filename = $_;
    return if not /\.(h|cpp)$/; # only see .h and .cpp files
    open(my $file, '<', $filename);
    my @lines = <$file>;
    my $modified = 0;
    LINE: for my $line (@lines)
    {
        while (my ($from, $to) = each %package_changes)
        {
            $from =~ s/\./_/;
            $to =~ s/\./_/;
            my $prevline = $line;
            $line =~ s/$from/$to/;
            $modified = $modified || ($line ne $prevline);
        }
    }
    close($file);

    if ($modified)
    {
        print "Rewriting $File::Find::dir/$filename...\n";
        open($file, '>', $_);
        &print_modified_notice($file);
        for (@lines)
        {
            chomp;
            s/\r//;
            print $file "$_\n";
        }
        close($file);
    }
}

sub prompt
{
    my ($prompt, $default) = @_;
    print "$prompt [$default] ";
    my $value = <STDIN>;
    $value =~ s/^\s*(.*?)\s*$/$1/ms;
    if (length($value) == 0)
    {
        return $default;
    }
    else
    {
        return $value;
    }
}

sub copy_and_prepend
{
    my ($from, $to, $prepend_desc, $prepend_string) = @_;

    my $p = (defined $prepend_desc) ? " and prepending $prepend_desc" : "";
    print "Copying '$from' to '$to'$p... ";

    die "NOT FOUND!\n" if not -f $from;
    open(my $fh_from, '<', $from) or die "Cannot open file '$from'\n";
    open(my $fh_to, '>', $to) or die "Cannot open file '$to'\n";

    print $fh_to $prepend_string if defined $prepend_string;

    while (<$fh_from>)
    {
        chomp;
        s/\r$//;
        print $fh_to "$_\n";
    }

    close($fh_to);
    close($fh_from);

    print "ok!\n";
}

sub copy_only
{
    &copy_and_prepend(@_);
}

sub copy_and_prepend_default
{
    my ($from, $to) = @_;

    my $basename = basename $from;

    my $prepend_string = <<__EOF__;
This box2d JNI implementation has been imported from the libgdx library
by $author.

The original contents of this $basename file follows.

------------8<---------------------------------------------------------

__EOF__

    &copy_and_prepend($from, $to, "own author information", $prepend_string);
}

sub print_modified_notice
{
    my $fh = shift;
    print $fh <<__EOF__;
//
// This file has been modified by $author.
//

__EOF__
}
