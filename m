From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v5 1/5] omap gpmc: enable irq mode in gpmc
Date: Tue, 16 Nov 2010 20:02:36 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0356E0F690@dbde02.ent.ti.com>
References: <1285594634-19277-1-git-send-email-s-ghorai@ti.com>
 <1285594634-19277-2-git-send-email-s-ghorai@ti.com>
 <20100928222727.GS3117@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0356AEEDE2@dbde02.ent.ti.com>
 <20101105211238.GT9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38870 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749Ab0KPOcr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 09:32:47 -0500
In-Reply-To: <20101105211238.GT9264@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Saturday, November 06, 2010 2:43 AM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v5 1/5] omap gpmc: enable irq mode in gpmc
> 
> * Ghorai, Sukumar <s-ghorai@ti.com> [101028 07:02]:
> > Tony,
> >
> > > -----Original Message-----
> > > From: Ghorai, Sukumar
> > > Sent: Wednesday, September 29, 2010 12:08 PM
> > > To: 'Tony Lindgren'
> > > Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-
> arm-
> > > kernel@lists.infradead.org
> > > Subject: RE: [PATCH v5 1/5] omap gpmc: enable irq mode in gpmc
> > >
> > >
> > [..snip..]
> >
> > > > > diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-
> > > > omap2/board-3430sdp.c
> > > > > index 67b95b5..549cd62 100644
> > > > > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > > > > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > > > > @@ -328,6 +328,7 @@ static void __init omap_3430sdp_init_irq(void)
> > > > >  	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
> > > > >  	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
> > > > >  	omap_init_irq();
> > > > > +	gpmc_init();
> > > > >  	omap_gpio_init();
> > > > >  }
> > > > ...
> > > >
> > > > You can avoid adding gpmc_init() by making it a subsys_initcall().
> > > > Just make sure you return early from it with if
> (!cpu_class_is_omap2()).
> > > [Ghorai] will do
> > > >
> > [Ghorai] I was trying this and no success, as nand_init() get called
> before  subsys_initcall(gpmc_init);
> >
> > 126 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
> > ..
> > 130         .init_irq       = omap_zoom_init_irq,
> > 131         .init_machine   = omap_zoom_init,
> > ..
> >
> > Step-(n):
> > 	kernel_init() -> customize_machine()
> >              -> omap_zoom_init() -> gpmc_nand_init() -> which call gpmc
> >                 functions, that's crashing, as gpmc is not initialized.
> >
> > Step-(n+1):
> > 	Followed by subsys_initcall(gpmc_init)
> >
> > So I will incorporate the other input and will re-submit.
> > [..snip..]
> 
> I don't see why you could not make gpmc_nand_init happen later?
> Also, some of these calls can be moved to omap2_init_common_hw()?
> 
[Ghorai] is it that gpmc_nand_init() better to call inside omap2_init_common_hw()? 
27 files used the omap2_init_common_hw(); including omap4, and 
15 files used the gpmc_nand_init directly or via board_nand_init()
Just thinking how to put gpmc_nand_init() inside omap2_init_common_hw(), when board may not have the nand.
