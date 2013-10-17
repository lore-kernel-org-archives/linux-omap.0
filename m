From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v9 4/9] mtd: nand: omap: enable auto-detection of
 bus-width for omap-nand drivers
Date: Thu, 17 Oct 2013 14:43:49 -0700
Message-ID: <20131017214349.GH23337@ld-irv-0074.broadcom.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-5-git-send-email-pekon@ti.com>
 <20131016222248.GZ23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA27917@DBDE04.ent.ti.com>
 <20131017183016.GG23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA280A4@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:44122 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762374Ab3JQVny (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Oct 2013 17:43:54 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA280A4@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Oct 17, 2013 at 09:00:27PM +0000, Pekon Gupta wrote:
> > From: Brian Norris [mailto:computersforpeace@gmail.com]
> > > On Thu, Oct 17, 2013 at 04:42:23AM +0000, Pekon Gupta wrote:
> > > > From: Brian Norris [mailto:computersforpeace@gmail.com]
> > > > > On Tue, Oct 15, 2013 at 11:19:52AM +0530, Pekon Gupta wrote:
> [snip]
> > > So this approach is other way round, where controller is configured
> > > based on DT binding "nand-bus-width" and then it checks whether
> > > device actual buswidth matches DT binding value or not.
> > 
> > If this is the case, then you really don't want to use
> > NAND_BUSWIDTH_AUTO. The default nand_base.c just *validates* the
> > pre-selected buswidth and exits with an error, in much the same way that
> > you're doing here (you're just duplicating the functionality).
> > NAND_BUSWIDTH_AUTO is useful if you want to turn control of the
> > buswidth
> > configuration entirely over to nand_base.c.
> > 
> > > - GPMC controller is pre-configured to support "x8" or "x16" device based
> > >    on DT binding "nand-bus-width".
> > >    Reference: $LINUX/arch/arm/mach-omap2/gpmc.c
> > >   @@gpmc_probe_nand_child()
> > > 	val = of_get_nand_bus_width(child);
> > >
> > > - But, bus-width of NAND device is only known during NAND driver
> > >    Probe in nand_scan_ident().
> > >
> > > Going forward when all NAND devices are compliant to ONFI,
> > > then we can deprecate "nand-bus-width".
> > 
> > Buswidth auto-detection is not actually restricted to ONFI. nand_base.c
> > has (corretly, AFAIK) been detecting buswidths for a long time, using
> > some form of ID decode detection. But it was just that: detection. It
> > did not actually configure the buswidth, since it left that
> > responsibility to the low-level driver to get right.
> > 
> > Another thing to consider: I think this current patch is a regression
> > from previous behavior. Previously, you would run nand_scan_ident()
> > twice if the first one failed; once with the platform-configured
> > buswidth and once with the opposite. But now, you only run
> > nand_scan_ident() once, and then you quit if it detects differently than
> > you expected.
> > 
> Actually having nand_scan_ident() called again if first time it fails, is 
> _not_ the right way, it was a quick-fix work-around.
> It should not have been approved..

OK, fair enough. I agree.

> > My opinion: the platform- and device-tree-provided buswidth is
> > unnecessary; it was previouisly only a suggestion which your driver
> > would readily discard, and it isn't really needed now. You can probably
> > get by with just NAND_BUSWIDTH_AUTO and (at most) a warning if the
> > auto-configured buswidth is different than the platform specified.
> > 
> > But the real point: you need to clearly communicate what you are
> > choosing in this patch. Either you want to
> > 
> >  (1) strictly follow the buswidth provided by the platform or
> > 
> >  (2) use the nand_base.c BUSWIDTH_AUTO automatic configuration.
> > 
> Ideally, I would like to go with (2), but that would need other changes
> in-order to re-configure GPMC with newly parsed ONFI data, which
> can be a separate patch-set.

What exactly needs changed to support this? It looks like this omap2
NAND driver doesn't make assumptions about 8-bit vs. 16-bit until after
nand_scan_ident(). But maybe there is something I missed.

> Thus, I would drop this patch for now. And go with (1),

OK, but to drop this patch entirely would still not be (1); it would
still leave the possibility of calling nand_scan_ident() twice, and it
puts you in a middle ground between (1) and (2). That's fine if it works
for you, but I just want to acknowledge that now: this driver requires
changes to become either (1) or (2).

Does your series need a rebase if we're removing this patch? Or you're
rewriting/simplifying it to the following two points? (Perhaps it's
best to separate this portion to its own patch (set) and discussion,
since it is independent of your ECC rewrite.)

> with following
> updates in  omap_nand_probe().
> 
> (a) perform nand_scan_ident() in "x8" mode, so that ONFI params are
>     read and device-info (chip->writesize, chip->oobsize) are populated.

OK.

> (b) Then switch to "x8" or "x16" mode based on "nand-bus-width"
>     as passed from GPMC driver to NAND driver via platform-data.
>    And re-populate mtd->byte, mtd-read_buf, mtd->write_buf.

I'm not sure if switching buswidth after nand_scan_ident() is really
supported, but I'll hold off until I see the code you're proposing.

Brian
