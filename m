From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v9 4/9] mtd: nand: omap: enable auto-detection of
 bus-width for omap-nand drivers
Date: Thu, 17 Oct 2013 11:30:16 -0700
Message-ID: <20131017183016.GG23337@ld-irv-0074.broadcom.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-5-git-send-email-pekon@ti.com>
 <20131016222248.GZ23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA27917@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34289 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762397Ab3JQSaV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Oct 2013 14:30:21 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA27917@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Oct 17, 2013 at 04:42:23AM +0000, Pekon Gupta wrote:
> > From: Brian Norris [mailto:computersforpeace@gmail.com]
> > > On Tue, Oct 15, 2013 at 11:19:52AM +0530, Pekon Gupta wrote:
> > > Autodetection of NAND device bus-width was added in generic NAND
> > driver as
> [...]
> > > @@ -1904,6 +1903,21 @@ static int omap_nand_probe(struct
> > platform_device *pdev)
> > >  		nand_chip->chip_delay = 50;
> > >  	}
> > >
> > > +	/* scan for NAND device connected to chip controller */
> > > +	if (nand_scan_ident(mtd, 1, NULL)) {
> > > +		err = -ENXIO;
> > > +		goto out_release_mem_region;
> > > +	}
> > > +	if ((nand_chip->options & NAND_BUSWIDTH_16) !=
> > > +			(pdata->devsize & NAND_BUSWIDTH_16)) {
> > > +		pr_err("%s: detected %s device but driver configured for
> > %s\n",
> > > +			DRIVER_NAME,
> > > +			(nand_chip->options & NAND_BUSWIDTH_16) ?
> > "x16" : "x8",
> > > +			(pdata->devsize & NAND_BUSWIDTH_16) ? "x16" :
> > "x8");
> > 
> > I'm not sure on the policy choice here; if you're using BUSWIDTH_AUTO,
> > do you even want to try to configure the buswidth by platform data?
> > You're not really getting the full use out of NAND_BUSWIDTH_AUTO because
> > the platform data has to guess the same buswidth that nand_base.c
> > determines. This is worse than the previous behavior, in which you would
> > try both buswidths if the specified type failed.
> > 
> > IOW, what are you trying to achieve with auto-buswidth? Automatic
> > determination of the buswidth or just automatic validation? What do you
> > achieve with platform data's selection of buswidth? Specification of the
> > buswidth or just a hint? Do the goals conflict? Perhaps you can just
> > warn, and not error out if the two selections don't match? Or maybe you
> > really wanted to replace the platform data selection mechanism entirely
> > with auto-buswidth?
> > 
> This is 'automatic validation' of value set in DT binding "nand-bus-width"

You mean you intend for the patched driver to simply validate, not
configure the buswidth?

> So this approach is other way round, where controller is configured
> based on DT binding "nand-bus-width" and then it checks whether
> device actual buswidth matches DT binding value or not.

If this is the case, then you really don't want to use
NAND_BUSWIDTH_AUTO. The default nand_base.c just *validates* the
pre-selected buswidth and exits with an error, in much the same way that
you're doing here (you're just duplicating the functionality).
NAND_BUSWIDTH_AUTO is useful if you want to turn control of the buswidth
configuration entirely over to nand_base.c.

> - GPMC controller is pre-configured to support "x8" or "x16" device based
>    on DT binding "nand-bus-width".
>    Reference: $LINUX/arch/arm/mach-omap2/gpmc.c
>   @@gpmc_probe_nand_child()
> 	val = of_get_nand_bus_width(child);
> 
> - But, bus-width of NAND device is only known during NAND driver
>    Probe in nand_scan_ident().
> 
> Going forward when all NAND devices are compliant to ONFI,
> then we can deprecate "nand-bus-width".

Buswidth auto-detection is not actually restricted to ONFI. nand_base.c
has (corretly, AFAIK) been detecting buswidths for a long time, using
some form of ID decode detection. But it was just that: detection. It
did not actually configure the buswidth, since it left that
responsibility to the low-level driver to get right.

Another thing to consider: I think this current patch is a regression
from previous behavior. Previously, you would run nand_scan_ident()
twice if the first one failed; once with the platform-configured
buswidth and once with the opposite. But now, you only run
nand_scan_ident() once, and then you quit if it detects differently than
you expected.

My opinion: the platform- and device-tree-provided buswidth is
unnecessary; it was previouisly only a suggestion which your driver
would readily discard, and it isn't really needed now. You can probably
get by with just NAND_BUSWIDTH_AUTO and (at most) a warning if the
auto-configured buswidth is different than the platform specified.

But the real point: you need to clearly communicate what you are
choosing in this patch. Either you want to

 (1) strictly follow the buswidth provided by the platform or

 (2) use the nand_base.c BUSWIDTH_AUTO automatic configuration.

Trying to mix both (as your patch currently does) just makes everything
worse.

Brian
