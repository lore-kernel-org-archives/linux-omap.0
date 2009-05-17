From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RESUBMIT][PATCH 5/7] OMAP4: Update common omap machine
	specific sources.
Date: Sun, 17 May 2009 18:30:27 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B4904319@dbde02.ent.ti.com>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-5-git-send-email-santosh.shilimkar@ti.com>
 <20090516100732.GK15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48942 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbZEQNAo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 May 2009 09:00:44 -0400
In-Reply-To: <20090516100732.GK15328@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russell,

> > diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> > index 916fcd3..6db7791 100644
> > --- a/arch/arm/mach-omap2/io.c
> > +++ b/arch/arm/mach-omap2/io.c
> > @@ -200,7 +247,9 @@ void __init omap2_init_common_hw(struct 
> omap_sdrc_params *sp)
> >  	omap2_mux_init();
> >  	pwrdm_init(powerdomains_omap);
> >  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
> > +#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the 
> clkdev is ready */
> >  	omap2_clk_init();
> > +#endif
> >  	omap2_sdrc_init(sp);
> >  	gpmc_init();
> >  }
> 
> I'm not sure why:
> 
> 1. you're using a (possible) run time check in sdrc.c, 
> clockdomain.c and
>    powerdomain.c, but a compile time check in io.c
This one I explained in the last email. And till we have the clean up done on clock.h I can't remove the compile time switch even though it looks ugly.

> 2. you don't leave sdrc.c, clockdomain.c and powerdomain.c 
> alone and just
>    disable the three initialisation calls inside 
> omap2_init_common_hw().
My initial patch actually had the compile time option but Kevin and Tony had a opinion to stub these respective files for OMAP4.
Is something like this acceptable then ?

void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
{
	omap2_mux_init();
	if (!cpu_is_omap44xx()) {
		pwrdm_init(powerdomains_omap);
		clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
	}
#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Ones the framework is available */
	omap2_clk_init();
#endif
	if (!cpu_is_omap44xx())
		omap2_sdrc_init(sp);
	gpmc_init();
}

With this I don't need to stub sdrc.c, clockdomain.c and powerdomain.c for OMAP4
 

Regards,
Santosh
  