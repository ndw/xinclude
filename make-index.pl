#!/usr/bin/perl -- # -*- Perl -*-

use strict;
use English;

# Hack hack hack

print "<html xmlns=\"http://www.w3.org/1999/xhtml\">\n";
print "<head>\n";
print "<title>ndw/xinclude</title>\n";
print "</head>\n";
print "<body>\n";
print "<h1>Published files from ndw/xinclude</h1>\n";
print "\n";
print "<p>This site hosts Norman Walsh&apos;s “private” drafts of\n";
print "<cite>XInclude 1.1</cite> baked fresh\n";
print "automagically by <a href=\"http://travis-ci.org/\">Travis CI</a> after\n";
print "every commit.</p>\n";

my @branches = ();
opendir(DIR, "xinclude");
while (readdir(DIR)) {
    next if /^\.\.?$/;
    next if ! -d "xinclude/$_";
    push (@branches, $_)
}
closedir(DIR);

print "<dl>\n";
foreach my $branch (sort { $a cmp $b } @branches) {
    my $fn = "xinclude/$branch/head/index.html";
    my $date = pubdate($fn);
    print "<dt>The <em>$branch</em> branch, $date:</dt>\n";
    print "<dd>\n";
    &showspec($branch);
    print "</dd>\n";
}
print "</dl>\n";

print <<EOF3;
<p>These documents have all the normative force one would expect of the
scribblings of a mad man.</p>

<p>If you have a question or comment about the XProc xinclude, please
raise it as
<a href="https://github.com/xproc/xinclude/issues">an issue</a>
on the xinclude repository.</p>

</body>
</html>
EOF3

exit 0;

sub pubdate {
    my $spec = shift;
    open (F, $spec) || return "date unknown";
    read (F, $_, 4096);
    close (F);
    s/^.*?<h2>(.*?)<\/h2>.*$/$1/s;

    if (/\d+\s+\S+\s+\d+/) {
        $_ = $MATCH;
    } else {
        $_ = "";
    }

    return $_;
}

sub title {
    my $spec = shift;
    open (F, $spec) || return "date unknown";
    read (F, $_, 4096);
    close (F);
    s/^.*?<h1>(.*?)<\/h1>.*$/$1/s;
    s/<a\s+.*?>//sg;
    return $_;
}

sub showspec {
    my $branch = shift;
    print "<ul>\n";
    foreach my $name ("head") {
        my $href = "xinclude/$branch/$name/";
        my $fn = "$href/index.html";
        my $title = title($fn);
        print "<li><a href=\"$href\">$title</a></li>\n";
    }
    print "</ul>\n";
}
