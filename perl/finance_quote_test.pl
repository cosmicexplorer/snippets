#!/usr/bin/env perl

# NOT MINE: https://finance-quote.sourceforge.net/tpj/finance-quote.txt

use strict;
use warnings;
use Finance::Quote;

@ARGV >= 2 or die "Usage: $0 exchange symbol symbol symbol ...\n";

my $exchange = shift;           # where we fetch our stocks from
my @symbols = @ARGV;            # which stocks we're interested in

my $quoter = Finance::Quote->new; # Create the F::Q object.

$quoter->timeout(30);		# Cancel fetch operation if it takes
				# longer than 30 seconds.

# Grab our information and place it into %info.
my %info = $quoter->fetch($exchange,@symbols);

foreach my $stock (@symbols) {
  unless ($info{$stock,"success"}) {
    warn "Lookup of $stock failed - ".$info{$stock,"errormsg"}.
      "\n";
    next;
  }
  print "$stock:\t\t",
    "Volume: ",$info{$stock,"volume"},"\t",
    "Price: " ,$info{$stock,"price"},"\n";
}
__END__
