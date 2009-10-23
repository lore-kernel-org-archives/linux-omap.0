From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH]Omap3630: Add hsmmc related checks
Date: Fri, 23 Oct 2009 12:13:19 -0500
Message-ID: <006901ca5404$1e563910$544ff780@am.dhcp.ti.com>
References: <62121.192.168.10.89.1256233132.squirrel@dbdmail.itg.ti.com> <20091022174408.GO16230@atomide.com> <001001ca534b$a55bcd30$544ff780@am.dhcp.ti.com> <FCCFB4CDC6E5564B9182F639FC35608702FA23EF2A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37255 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbZJWRNR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Oct 2009 13:13:17 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA23EF2A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Pandita, Vikram'" <vikram.pandita@ti.com>, 'Tony Lindgren' <tony@atomide.com>
Cc: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Pandita, Vikram [mailto:vikram.pandita@ti.com]
> Sent: Thursday, October 22, 2009 7:08 PM
> To: Chikkature Rajashekar, Madhusudhan; 'Tony Lindgren'
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH]Omap3630: Add hsmmc related checks
> 
> Madhu/Tony
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of
> >Chikkature Rajashekar, Madhusudhan
> >> From: Tony Lindgren [mailto:tony@atomide.com]
> >> Sent: Thursday, October 22, 2009 12:44 PM
> >> To: Madhusudhan Chikkature
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: [PATCH]Omap3630: Add hsmmc related checks
> >>
> >> * Madhusudhan Chikkature <madhu.cr@ti.com> [091022 10:38]:
> >> > From 661b13474a7af62c54f7df7a33a818c5e782cc59 Mon Sep 17 00:00:00
> 2001
> >> > From: Madhu <madhu.cr@ti.com>
> >> > Date: Wed, 21 Oct 2009 16:16:31 -0400
> >> > Subject: [PATCH] Omap3630: Add HSMMC related checks.
> >> >
> >> > Add omap3630 conditional checks to devices.c to allow HSMMC3 addition
> >> and
> >> > mux configuration for HSMMC1/2.
> >> >
> >> > Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> >> > ---
> >> >  arch/arm/mach-omap2/devices.c |    5 +++--
> >> >  1 files changed, 3 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
> >> omap2/devices.c
> >> > index 7d4513b..1fdfc7f 100644
> >> > --- a/arch/arm/mach-omap2/devices.c
> >> > +++ b/arch/arm/mach-omap2/devices.c
> >> > @@ -575,7 +575,7 @@ static inline void omap2_mmc_mux(struct
> >> > omap_mmc_platform_data *mmc_controller,
> >> >  		}
> >> >  	}
> >> >
> >> > -	if (cpu_is_omap3430()) {
> >> > +	if (cpu_is_omap3430() || cpu_is_omap3630()) {
> 
> Not needed.
> For 34xx:
> 	cpu_is_omap3430() returns True
> 	cpu_is_omap3630() returns False
> 
> For 3630:
> 	cpu_is_omap3430() returns True
> 	cpu_is_omap3630() returns True
> 
> So no need to add an orring for 3630, as 3630 is treated just like a 34xx.
> 
Hi Vikram,

I have already posted V2 of this patch which uses cpu_is_omap34xx() and that
should be right way.

Regards,
Madhu
> 
> 
> >> >  		if (controller_nr == 0) {
> >> >  			omap_cfg_reg(N28_3430_MMC1_CLK);
> >> >  			omap_cfg_reg(M27_3430_MMC1_CMD);
> >>
> >> How about using cpu_is_omap34xx() here instead? It's more future proof.
> >>
> >> Regards,
> >>
> >> Tony
> >>
> >Yes. That makes sense. I will submit V2.
> >
> >Regards,
> >Madhu
> >
> >> > @@ -642,7 +642,8 @@ void __init omap2_init_mmc(struct
> >> omap_mmc_platform_data
> >> > **mmc_data,
> >> >  			irq = INT_24XX_MMC2_IRQ;
> >> >  			break;
> >> >  		case 2:
> >> > -			if (!cpu_is_omap44xx() &&
!cpu_is_omap34xx())
> >> > +			if (!cpu_is_omap44xx() && !cpu_is_omap34xx()
> >> > +				&& !cpu_is_omap3630())
> >> >  				return;
> >> >  			base = OMAP3_MMC3_BASE;
> >> >  			irq = INT_34XX_MMC3_IRQ;
> >> > --
> >> > 1.6.0.4
> >> >
> >> >
> >> >
> >
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html


