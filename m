From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 5/7][RFC] OMAP4: Update common omap machine specific
	sources.
Date: Wed, 22 Apr 2009 10:10:20 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F3EA@dbde02.ent.ti.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com>
 <20090421183644.GL25864@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41269 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbZDVEka convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 00:40:30 -0400
In-Reply-To: <20090421183644.GL25864@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Regards,
Santosh
 

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Wednesday, April 22, 2009 12:07 AM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 5/7][RFC] OMAP4: Update common omap 
> machine specific sources.
> 
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [090421 06:08]:
> > This patch updates the common machine spcific source files 
> for OMAP4430.
> > Few OMAP4 peripherals are common with OMAP3 architecture. 
> Lot of code
> > gets re-used because of this.
> > 
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-omap2/gpmc.c     |    3 ++
> >  arch/arm/mach-omap2/id.c       |    5 +++-
> >  arch/arm/mach-omap2/io.c       |   48 
> ++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/timer-gp.c |    6 ++++-
> >  4 files changed, 60 insertions(+), 2 deletions(-)
> > 

  
> >  void __init omap2_map_common_io(void)
> >  {
> > @@ -183,6 +225,10 @@ void __init omap2_map_common_io(void)
> >  	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
> >  #endif
> >  
> > +#if defined(CONFIG_ARCH_OMAP44XX)
> > +	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
> > +#endif
> > +
> 
> This will break multi-omap. The cpu_is_omap44xx() works very early
> during the boot nowadays as the omap2_set_globals_44xx() initializes
> that, so please use that instead.

Looks possible to correct this. But I need to do this for OMAP2 and OMAp3 as well because for both the compile time switch is used. It was done for OMAP2/3 and hence I just maintained same way for OMAP4


/* Normally devicemaps_init() would flush caches and tlb after
> >  	 * mdesc->map_io(), but we must also do it here because 
> of the CPU
> >  	 * revision check below.
> > @@ -198,9 +244,11 @@ void __init omap2_map_common_io(void)
> >  void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
> >  {
> >  	omap2_mux_init();
> > +#ifndef CONFIG_ARCH_OMAP4 /* REVISIT: to avoid build errors */
> >  	pwrdm_init(powerdomains_omap);
> >  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
> >  	omap2_clk_init();
> >  	omap2_sdrc_init(sp);
> > +#endif
> >  	gpmc_init();
> >  }
> 
> Please use cpu_is_omap44xx() here too instead of the ifndef.

If I use cpu_is_omap44xx(), then I need to write stub functions under OMAP4 macro. Kevin also suggested to write stubs. So this can be done.

Regards
Santosh