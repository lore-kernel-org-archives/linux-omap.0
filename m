From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v9 4/9] mtd: nand: omap: enable auto-detection of
 bus-width for omap-nand drivers
Date: Thu, 17 Oct 2013 04:42:23 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA27917@DBDE04.ent.ti.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-5-git-send-email-pekon@ti.com>
 <20131016222248.GZ23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40364 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab3JQEnP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Oct 2013 00:43:15 -0400
In-Reply-To: <20131016222248.GZ23337@ld-irv-0074.broadcom.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Brian,

> From: Brian Norris [mailto:computersforpeace@gmail.com]
> > On Tue, Oct 15, 2013 at 11:19:52AM +0530, Pekon Gupta wrote:
> > Autodetection of NAND device bus-width was added in generic NAND
> driver as
[...]
> > @@ -1904,6 +1903,21 @@ static int omap_nand_probe(struct
> platform_device *pdev)
> >  		nand_chip->chip_delay = 50;
> >  	}
> >
> > +	/* scan for NAND device connected to chip controller */
> > +	if (nand_scan_ident(mtd, 1, NULL)) {
> > +		err = -ENXIO;
> > +		goto out_release_mem_region;
> > +	}
> > +	if ((nand_chip->options & NAND_BUSWIDTH_16) !=
> > +			(pdata->devsize & NAND_BUSWIDTH_16)) {
> > +		pr_err("%s: detected %s device but driver configured for
> %s\n",
> > +			DRIVER_NAME,
> > +			(nand_chip->options & NAND_BUSWIDTH_16) ?
> "x16" : "x8",
> > +			(pdata->devsize & NAND_BUSWIDTH_16) ? "x16" :
> "x8");
> 
> I'm not sure on the policy choice here; if you're using BUSWIDTH_AUTO,
> do you even want to try to configure the buswidth by platform data?
> You're not really getting the full use out of NAND_BUSWIDTH_AUTO because
> the platform data has to guess the same buswidth that nand_base.c
> determines. This is worse than the previous behavior, in which you would
> try both buswidths if the specified type failed.
> 
> IOW, what are you trying to achieve with auto-buswidth? Automatic
> determination of the buswidth or just automatic validation? What do you
> achieve with platform data's selection of buswidth? Specification of the
> buswidth or just a hint? Do the goals conflict? Perhaps you can just
> warn, and not error out if the two selections don't match? Or maybe you
> really wanted to replace the platform data selection mechanism entirely
> with auto-buswidth?
> 
This is 'automatic validation' of value set in DT binding "nand-bus-width"
So this approach is other way round, where controller is configured
based on DT binding "nand-bus-width" and then it checks whether
device actual buswidth matches DT binding value or not.

- GPMC controller is pre-configured to support "x8" or "x16" device based
   on DT binding "nand-bus-width".
   Reference: $LINUX/arch/arm/mach-omap2/gpmc.c
  @@gpmc_probe_nand_child()
	val = of_get_nand_bus_width(child);

- But, bus-width of NAND device is only known during NAND driver
   Probe in nand_scan_ident().

Going forward when all NAND devices are compliant to ONFI,
then we can deprecate "nand-bus-width".


with regards, pekon
