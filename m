From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RESUBMIT][PATCH 5/7] OMAP4: Update common omap machine
	specific sources.
Date: Sun, 17 May 2009 01:47:40 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49042A2@dbde02.ent.ti.com>
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
Received: from arroyo.ext.ti.com ([192.94.94.40]:34750 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbZEPUSE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 16:18:04 -0400
In-Reply-To: <20090516100732.GK15328@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Saturday, May 16, 2009 3:38 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> linux-omap@vger.kernel.org
> Subject: Re: [RESUBMIT][PATCH 5/7] OMAP4: Update common omap 
> machine specific sources.
> 
> I think this is going to take several separate reviews to group stuff
> together.
 Do you mean this patch or CLKDEV related work ?

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
> 2. you don't leave sdrc.c, clockdomain.c and powerdomain.c 
> alone and just
>    disable the three initialisation calls inside 
> omap2_init_common_hw().

Because to have omap2_clk_init() under run time check needs clock.h
Rest of the problem as mentioned below, you know already. 
***********************************************************************************************
> @@ -30,7 +32,9 @@
>  #include <mach/sdrc.h>
>  #include <mach/gpmc.h>
>  
> +#ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready */
>  #include "clock.h"
> +#endif

Hmm.  Tony: we really need to eliminate data inside header files.  It's
not nice to have data structures created by merely including some header
file that also contains function prototypes.
*********************************************************************************************** 

Regards,
Santosh
 
