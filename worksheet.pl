#! /bin/perl

use FindBin;
use lib $FindBin::Bin;
use HTTP::Lite;

$beg = shift @ARGV;
$end = shift @ARGV;
for ($beg, $end) { s/\:/\\:/ }

$ARGV[0] =~ /^(\w+)\.\w+$/;
$bookname = $1;

$book = join '', (<>);

if ($book =~ /( +$beg.+?)$end/s) {
  $verses = $1;
  $verses =~ s!\|\s+(.+?)\|.*?END\s*\|!$1!s;
  while ($verses =~ /(?<=\s)(\d+)(?=\s)/gs) { #/\s(\d+)(?!\:)/g) {
    if ($1 < 5625) { $words{$1}++ }
    else           { $extra{$1}++ }
  }
}

print "<center><h2>Text</h2></center>\n";
$greekOf{a} = '&alpha;';
$greekOf{b} = '&beta;';
$greekOf{g} = '&gamma;';
$greekOf{d} = '&delta;';
$greekOf{e} = '&epsilon;';
$greekOf{z} = '&zeta;';
$greekOf{h} = '&eta;';
$greekOf{y} = '&theta;';
$greekOf{i} = '&iota;';
$greekOf{k} = '&kappa;';
$greekOf{l} = '&lambda;';
$greekOf{m} = '&mu;';
$greekOf{n} = '&nu;';
$greekOf{x} = '&xi;';
$greekOf{o} = '&omicron;';
$greekOf{p} = '&pi;';
$greekOf{r} = '&rho;';
$greekOf{v} = '&sigmaf;';
$greekOf{s} = '&sigma;';
$greekOf{t} = '&tau;';
$greekOf{u} = '&upsilon;';
$greekOf{f} = '&phi;';
$greekOf{c} = '&chi;';
$greekOf{q} = '&psi;';
$greekOf{w} = '&omega;';

$verses =~ s/([a-z])/$greekOf{$1}/g;
print "$bookname $verses";

for $i (0..10) {
  $sp{"lex$i"} = '&nbsp;&nbsp;' x ($i+1);
}


sub getBlb {
  my $strong = shift;
  if (-r "strongs/blb$strong.html") {
    open HTML, "strongs/blb$strong.html";
    $html = join '', (<HTML>);
  } else {
    $url = "http://www.blueletterbible.org/lang/lexicon/lexicon.cfm?strongs=G$strong";
    $http = new HTTP::Lite;
    $req = $http->request($url);
    $html = $http->body();
    open HTML, ">strongs/blb$strong.html";
    print HTML $html;
    close HTML;
  }
  return $html;
}

sub getSgw {
  my $strong = shift;
  if (-r "strongs/sgw$strong.html") {
    open HTML, "strongs/sgw$strong.html";
    $html = join '', (<HTML>);
  } else {
    if ($strong < 5625) {
      $url = "http://unbound.biola.edu/index.cfm?method=strongsLex.showEntry&entry_lang=greek&search_type=number&entry_word=$strong";
      #$url = "http://www.searchgodsword.org/lex/grk/view.cgi?number=$strong";
    } else {
      $url = "http://classic.studylight.org/lex/grk/extras.cgi?number=$strong";
      #$url = "http://www.searchgodsword.org/lex/grk/extras.cgi?number=$strong";
    }
    $http = new HTTP::Lite;
    $req = $http->request($url);
    $html = $http->body();
    open HTML, ">strongs/sgw$strong.html";
    print HTML $html;
    close HTML;
  }
  return $html;
}
  


print "<center><h2>Vocabulary</h2></center>\n";
for $strong (sort {$a<=>$b} keys %words) {
  print STDERR "Strong's $strong\n";
  $blb = getBlb($strong);
  #$blb =~ m!Lexicon Results.*?<span class\=\"lexTitleGk\">(.*?)</span>!s;
  if ($blb =~ m!Lexicon Results for <em>(.*?)</em>!s) {
    $greek = $1;
  } elsif ($blb =~ m!Strong.s G$strong.*?<em>(.*?)</em>!s) {
    $greek = $1;
  }

  $sgw = getSgw($strong);
  #$sgw =~ m!Definition.*?(<OL.*?)</TD>!s;
  $sgw =~ m!Definition:(<br />.*?)<br />!s;
  $def = $1;
  #$def =~ s!(.*</OL>).*!$1!s;
  $def =~ s!<A HREF.*?>(.*?)</A>!$1!gs;

  print "<p><b>$strong: $greek</b>\n$def\n\n";
}

print "<center><h2>Grammar</h2></center>\n";
for $strong (sort {$a<=>$b} keys %extra) {
  print STDERR "Vocab $strong\n";
  # if (-r "strongs/$strong.html") {
  #   open HTML, "strongs/$strong.html";
  #   $html = join '', (<HTML>);
  # } else {
  #   $url = "http://www.searchgodsword.org/lex/grk/extras.cgi?number=$strong";
  #   $http = new HTTP::Lite;
  #   $req = $http->request($url);
  #   $html = $http->body();
  #   open HTML, ">strongs/$strong.html";
  #   print HTML $html;
  #   close HTML;
  # }
  $html = getSgw($strong);

  print "<p><b>$strong:</b>\n";
  @ary = ();
  while ($html =~ m!Word (Tense|Mood|Voice).*?<B>(.+?)</B>.*?<P>(.+?)<P>!gs) {
    $grammar{"$2 $1"} = $3;
    push @ary, "$2 $1";
  }
  print join ', ', @ary;
  print "\n";
}

for $type (sort keys %grammar) {
  print "<p><b>$type:</b> $grammar{$type}\n";
}




#   $url = "http://www.searchgodsword.org/lex/grk/view.cgi?number=$strong";
#   $http = new HTTP::Lite;
#   $req = $http->request($url);
#   $html = $http->body();
#   $html =~ m!<TITLE>(\w+)!;
#   $greek = $1;

#   $sgw =~ m!Outline of Biblical Usage.*?(<p class=.*?)<br!s;
#   $def = $1;
#   $def =~ s!<p class\=\'(lex\d)\'>!<p>$sp{$1}!gs;
#   print "<p>$def\n";
