From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: dts: Add support for OMAP4 Variscite OM44 family
Date: Fri, 18 Apr 2014 10:29:08 -0700
Message-ID: <20140418172907.GK5354@atomide.com>
References: <1397833849-22396-1-git-send-email-manabian@gmail.com>
 <1397833849-22396-2-git-send-email-manabian@gmail.com>
 <20140418155721.GC5354@atomide.com>
 <CAGhQ9VysdxGMd99CiVVh8YJt7KDAyy3Pe9YA2VM-G4mzn_6+0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21007 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753011AbaDRR3R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 13:29:17 -0400
Content-Disposition: inline
In-Reply-To: <CAGhQ9VysdxGMd99CiVVh8YJt7KDAyy3Pe9YA2VM-G4mzn_6+0g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

* Joachim Eastwood <manabian@gmail.com> [140418 09:18]:
> On 18 April 2014 17:57, Tony Lindgren <tony@atomide.com> wrote:
> > * Joachim Eastwood <manabian@gmail.com> [140418 08:11]:
> >> Add support for VAR-SOM-OM44[1] SODIMM system on module from Variscite. SoM
> >> features a OMAP4460, 1GB RAM, Gigabit Ethernet (LAN7500) and optional WLAN/BT.
> >>
> >> Also add support for VAR-STK-OM44 development board from Variscite. This kit
> >> features a VAR-SOM-OM44 and the carrier board VAR-OM44CustomBoard[2]. The
> >> VAR-STK-OM44 is the same as VAR-DVK-OM44 but without the LCD display.
> >>
> >> omap4-var-stk-om44.dts replace the old and very limited omap4-var-som.dts.
> >>
> >> [1] http://www.variscite.com/products/system-on-module-som/cortex-a9/var-som-om44-cpu-ti-omap-4-omap4460
> >> [2] http://www.variscite.com/products/single-board-computers/var-om44customboard
> >>
> >> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> >> ---
> >>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
> >>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> >>  arch/arm/boot/dts/Makefile                         |   2 +-
> >>  arch/arm/boot/dts/omap4-var-om44customboard.dtsi   | 235 ++++++++++++++
> >>  arch/arm/boot/dts/omap4-var-som-om44.dtsi          | 343 +++++++++++++++++++++
> >>  arch/arm/boot/dts/omap4-var-som.dts                |  96 ------
> >>  arch/arm/boot/dts/omap4-var-stk-om44.dts           |  16 +
> >>  7 files changed, 599 insertions(+), 97 deletions(-)
> >>  create mode 100644 arch/arm/boot/dts/omap4-var-om44customboard.dtsi
> >>  create mode 100644 arch/arm/boot/dts/omap4-var-som-om44.dtsi
> >>  delete mode 100644 arch/arm/boot/dts/omap4-var-som.dts
> >>  create mode 100644 arch/arm/boot/dts/omap4-var-stk-om44.dts
> >
> > Hmm don't you still need to keep omap4-var-som.dts to build just the
> > core SoC module without any add-on boards?
> 
> Since VAR-SOM-OM44 is a SODIMM module it is not possible to use
> without a carrier board. Variscite's carrier board is called
> OM44CustomBoard and I am in process of creating my own application
> specific one so the omap4-var-som-om44 should be a dtsi-file.

OK, thanks for clarifying that.
 
> > Also, you might want to use the OMAP4_CORE_IOPAD and OMAP4_WKUP_IOPAD
> > macros in include/dt-bindings/pinctrl/omap.h to be able to check the
> > registers against the TRM easier as you can use the physical register
> > offset listed in the TRM.
> 
> I don't see any other OMAP4 using these macros. Is there a plan for a
> mass conversion?

Makes sense to do while doing other clean-up to avoid extra churn,
but no mass conversion planned so far.

> It's really a job for an automated script. But the macro are indeed
> nice. That offset has bothered me more than once.

Yeah and we can also add some range checking to the OMAP_IOPAD_OFFSET
macro eventually :)

I did a check script when we split omap3 pinctrl core instance into
two separate instance to deal with the large hole in the register
space. Some parts of that might be usable for a generic conversion
script too. The script I used is below for reference.

Regards,

Tony

8< --------------
#!/usr/bin/perl
use strict;


# usage: grep omap3_pmx_core *.dts* | pinctrl-check-offsets

sub check_soc($) {
	my($file) = @_;
	my $revision = 0;

	my @includes;

	open(IN, "<$file") or die("Could not read $file\n");
	while (<IN>) {
		if (!/\#include/) {
			next;
		}

		if (/\#include \"/) {
			if (!/skeleton.dtsi/ && !/omap34xx.dtsi/ && !/omap36xx.dtsi/) {
				my ($junk, $include) = split(" ", $_);
				$include =~ s/\"//g;
				push(@includes, $include);
			}
		}

		if (/omap34xx.dtsi/) {
			$revision = 3430;
			last;
		};

		if (/omap36xx.dtsi/) {
			$revision = 3630;
			last;
		};
	}
	close(IN);

	if (!$revision) {
		foreach my $include (@includes) {
			$revision = check_soc($include);
			if ($revision) {
				last;
			}
		}
	}

	return $revision;
}

sub check_file($ $) {
	my ($revision, $file) = @_;

	my $line = 0;
	my $check = 0;
	my $core2_base = 0;
	my $base_offset = 0;

	if ($revision == 3430) {
		$core2_base = 0x25d8;
	} elsif ($revision = 3630) {
		$core2_base = 0x25a0;
	}
	$base_offset = $core2_base - 0x2030;

	open(IN, "$file") or die("Could not open file $file\n");
	while(<IN>) {
		$line++;

		if (/omap3_pmx_core {/) {
			$check = 1;
		}

		if (/omap3_pmx_core2/ || /omap3_pmx_wkup/) {
			$check = 0;
		}

		if ($check && / \(PIN_/) {
			my ($offset, $rest) = split(" \\(PIN_", $_);
			$offset =~ s/\t+//g;
			$offset =~ s/ +//g;
			$offset = hex($offset);
			$rest = "PIN_".$rest;
			$rest =~ s/\)/\);/;
			$rest =~ s/\n//;

			if ($offset >= $base_offset) {
				my $fixed;
				my $val = $offset + 0x2030;

				if ($revision == 3430) {
					$fixed = sprintf("OMAP3430_CORE2_IOPAD(0x%04x, %s",
							  $val, $rest);
				} elsif ($revision = 3630) {
					$fixed = sprintf("OMAP3630_CORE2_IOPAD(0x%04x, %s",
							  $val, $rest);
				}

				printf("%s:%i: 0x%04x should be %s\n",
				       $file, $line, $offset, $fixed);
			}
		}

	}
	close(IN);
}

while (<STDIN>) {
	my($file, $junk) = split(":", $_);

	if ($file =~ /omap3.dtsi/) {
		next;
	}

	my $revision = check_soc($file);
	if (!$revision) {
		printf("WARNING: unknown revision for %s\n", $file);
	}
	check_file($revision, $file);
}
