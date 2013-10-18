From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v9 1/9] mtd: nand: omap: combine different flavours of
 1-bit hamming ecc schemes
Date: Fri, 18 Oct 2013 11:48:31 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA284F4@DBDE04.ent.ti.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-2-git-send-email-pekon@ti.com>
 <20131018105917.GE29779@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52467 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481Ab3JRLtQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 07:49:16 -0400
In-Reply-To: <20131018105917.GE29779@e106331-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "olof@lixom.net" <olof@lixom.net>, "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "robherring2@gmail.com" <robherring2@gmail.com>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Mark,

> From: Mark Rutland
> [...]
> 
> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-
> omap2/gpmc.c
> > index 579697a..c9fb353 100644
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -1342,9 +1342,7 @@ static void __maybe_unused
> gpmc_read_timings_dt(struct device_node *np,
> >  #ifdef CONFIG_MTD_NAND
> >
> >  static const char * const nand_ecc_opts[] = {
> > -	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "sw",
> > -	[OMAP_ECC_HAMMING_CODE_HW]		= "hw",
> > -	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hw-
> romcode",
> > +	[OMAP_ECC_HAM1_CODE_HW]			= "ham1",
> >  	[OMAP_ECC_BCH4_CODE_HW]			= "bch4",
> >  	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
> >  };
> 
> As the parsing isn't updated until the next patch, doesn't this
> temporarily break DTBs with the deprecated ti,nand-ecc-opt values?
> 
Ok then I'll swap the [Patch 1/9] and [Patch 2/9] so that DT parsing updates
(with backward compatibility) happen before the deprecation of DT values.
This way old DT binding would work all through.

And as DT parsing is kept backward compatible, so .dts changes would not
break the DTBs even if updated in separate patch.

with regards, pekon
