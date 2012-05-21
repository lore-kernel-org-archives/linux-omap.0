From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 09:11:21 -0700
Message-ID: <20120521161120.GL17852@atomide.com>
References: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
 <1337593277-13822-2-git-send-email-tomi.valkeinen@ti.com>
 <4DA41490-EF90-40A5-B3EE-E6281B4F1313@dominion.thruhere.net>
 <1337598763.2078.28.camel@lappyti>
 <8607C2E0-C1C0-49C6-9563-4CE1BF291E82@dominion.thruhere.net>
 <1337600181.2078.32.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40732 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab2EUQL0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 12:11:26 -0400
Content-Disposition: inline
In-Reply-To: <1337600181.2078.32.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120521 04:40]:
> On Mon, 2012-05-21 at 13:28 +0200, Koen Kooi wrote:
> > Op 21 mei 2012, om 13:12 heeft Tomi Valkeinen het volgende geschreven:
> > 
> > > On Mon, 2012-05-21 at 12:59 +0200, Koen Kooi wrote:
> > >> Op 21 mei 2012, om 11:41 heeft Tomi Valkeinen het volgende geschreven:
> > >> 
> > >>> Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
> > >>> remove custom PD GPIO handling for DVI output") moved TFP410 chip's
> > >>> powerdown-gpio handling from the board files to the tfp410 driver. One
> > >>> gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
> > >>> the Beagle board file. This causes the tfp410 driver to fail to request
> > >>> the gpio on Beagle, causing the driver to fail and thus the DVI output
> > >>> doesn't work.
> > >>> 
> > >>> This patch removes the gpio_request_one() from the board file.
> > >>> 
> > >>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > >>> ---
> > >>> arch/arm/mach-omap2/board-omap3beagle.c |    3 +--
> > >>> 1 file changed, 1 insertion(+), 2 deletions(-)
> > >>> 
> > >>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> > >>> index 8ede8d2..72ad1f6 100644
> > >>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > >>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> > >>> @@ -510,9 +510,8 @@ static void __init omap3_beagle_init(void)
> > >>> 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
> > >>> 				  mt46h32m32lf6_sdrc_params);
> > >>> 
> > >>> +	/* DVI power down GPIO */
> > >>> 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> > >> 
> > >> Wouldn't it be an output rather than an input?
> > > 
> > > Indeed. Note that I didn't change the line above =).
> > > 
> > > It seems this was changed last December:
> > > 
> > > -       omap_cfg_reg(J25_34XX_GPIO170);
> > > +       omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> > > 
> > > I wonder if the mux init is even necessary. Shouldn't the bootloader set
> > > the muxes?
> > 
> > It'd rather have the kernel reset the muxes to the proper value to ensure a known state.
> 
> Well, I think all this needs to be handled differently anyway with
> device tree. If I've understood correctly the driver using the GPIO
> should configure the pin when the driver starts. But if the driver is
> not loaded/compiled-in, then it's again up to the bootloader.
> 
> Or is there going to be a board specific mux-init with devtree?

For device tree the mux setting will come from devicetree. Until
that works, it's best to keep the omap_mux_init_gpio() calll.

Regards,

Tony

