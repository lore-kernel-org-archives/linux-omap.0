From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v7 1/6] mtd: nand: omap: combine different flavours of
 1-bit hamming ecc schemes
Date: Fri, 11 Oct 2013 10:17:48 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA2122E@DBDE04.ent.ti.com>
References: <1380916188-24206-1-git-send-email-pekon@ti.com>
 <1380916188-24206-2-git-send-email-pekon@ti.com>
 <20131007112728.GA15365@e106331-lin.cambridge.arm.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA1F3DC@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57603 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132Ab3JKKSd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 06:18:33 -0400
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA1F3DC@DBDE04.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "tony@atomide.com" <tony@atomide.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "olof@lixom.net" <olof@lixom.net>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>

Dear MTD Maintainers,

> >
> > If I have my NAND formatted with one of the existing ECC schemes (e.g.
> > OMAP_ECC_HAMMING_CODE_DEFAULT) will it work with the new
> > OMAP_ECC_HAM1_CODE_HW scheme?
> >
> > Are they all compatible?
> >
> Yes, they all are 1-bit hamming code, the only difference between
> xx_Default and xx_HW was who was doing the ECC calculation.
> For xx_DEFAULT: ECC calculation was done on CPU via s/w library
> For xx_HW: ECC calculation was done by in-build h/w engine.
> So, all HAMMING_xx can be replaced by HAM1_HW.
> 
> [snip]
> 
> > > @@ -1342,9 +1342,7 @@ static void __maybe_unused
> > gpmc_read_timings_dt(struct device_node *np,
> > >  #ifdef CONFIG_MTD_NAND
> > >
> > >  static const char * const nand_ecc_opts[] = {
> > > -	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "sw",
> > > -	[OMAP_ECC_HAMMING_CODE_HW]		= "hw",
> > > -	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hw-
> > romcode",
> > > +	[OMAP_ECC_HAM1_CODE_HW]			= "ham1",
> > >  	[OMAP_ECC_BCH4_CODE_HW]			= "bch4",
> > >  	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
> >
> > Won't this break existing dts which have "sw", "hw", or "hw-romcode"?
> >
> > Someone may try to use a new kernel with an old dt, and we marked them
> > as deprecated, not removed.
> >
> HAMMING_xx ECC scheme was used only on legacy platforms, when
> BCH8 was not available, I have not seen anyone using this scheme
> *from mainline kernel* from quite a long time. So, it's safe to remove them.
> 
> This is what was concluded as per below email.
> http://lists.infradead.org/pipermail/linux-mtd/2013-September/048876.html
> 

This patch-series and its follow-on series has already missed many merge
windows, And the above discussion has reached a stalled state (infinite loop)
where, I cannot revert some DT binding updates to and fro to keep all legacy
DT bindings backward compatible forever.
However, I can assure that these DT updates make binding stable for long-term.

So now it's your discretion to whether to accept or leave following 2 series:

http://lists.infradead.org/pipermail/linux-mtd/2013-October/048983.html

http://lists.infradead.org/pipermail/linux-mtd/2013-October/049008.html


AFAIK no-one is using Hamming based ecc-scheme on OMAP platforms
*from mainline kernel*. So this DT update actually does not affect users
I know of. Rather these patch series was intended for long term scalability
and clean-up so that more OMAP users migrate to mainline kernel easily.


with regards, pekon 
