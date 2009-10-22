From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH]Omap3630: Add hsmmc related checks
Date: Thu, 22 Oct 2009 14:36:38 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AB9224C@dlee02.ent.ti.com>
References: <62121.192.168.10.89.1256233132.squirrel@dbdmail.itg.ti.com>
 <20091022174408.GO16230@atomide.com>
 <001001ca534b$a55bcd30$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50970 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756627AbZJVTgm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 15:36:42 -0400
In-Reply-To: <001001ca534b$a55bcd30$544ff780@am.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, 'Tony Lindgren' <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Chikkature Rajashekar, Madhusudhan
> Sent: Thursday, October 22, 2009 2:13 PM
> 
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Thursday, October 22, 2009 12:44 PM
> >
> > * Madhusudhan Chikkature <madhu.cr@ti.com> [091022 10:38]:
> > > From 661b13474a7af62c54f7df7a33a818c5e782cc59 Mon Sep 17 00:00:00 2001
> > > From: Madhu <madhu.cr@ti.com>
> > > Date: Wed, 21 Oct 2009 16:16:31 -0400
> > > Subject: [PATCH] Omap3630: Add HSMMC related checks.
> > >
> > > Add omap3630 conditional checks to devices.c to allow HSMMC3 addition
> > and
> > > mux configuration for HSMMC1/2.
> > >
> > > Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/devices.c |    5 +++--
> > >  1 files changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
> > omap2/devices.c
> > > index 7d4513b..1fdfc7f 100644
> > > --- a/arch/arm/mach-omap2/devices.c
> > > +++ b/arch/arm/mach-omap2/devices.c
> > > @@ -575,7 +575,7 @@ static inline void omap2_mmc_mux(struct
> > > omap_mmc_platform_data *mmc_controller,
> > >  		}
> > >  	}
> > >
> > > -	if (cpu_is_omap3430()) {
> > > +	if (cpu_is_omap3430() || cpu_is_omap3630()) {
> > >  		if (controller_nr == 0) {
> > >  			omap_cfg_reg(N28_3430_MMC1_CLK);
> > >  			omap_cfg_reg(M27_3430_MMC1_CMD);
> >
> > How about using cpu_is_omap34xx() here instead? It's more future proof.
> >
> > Regards,
> >
> > Tony
> >
> Yes. That makes sense. I will submit V2.
> 
> Regards,
> Madhu
> 
> > > @@ -642,7 +642,8 @@ void __init omap2_init_mmc(struct
> > omap_mmc_platform_data
> > > **mmc_data,
> > >  			irq = INT_24XX_MMC2_IRQ;
> > >  			break;
> > >  		case 2:
> > > -			if (!cpu_is_omap44xx() && !cpu_is_omap34xx())
> > > +			if (!cpu_is_omap44xx() && !cpu_is_omap34xx()
> > > +				&& !cpu_is_omap3630())
!cpu_is_omap3630() is redundant here.. please consider for your v2.

> > >  				return;
> > >  			base = OMAP3_MMC3_BASE;
> > >  			irq = INT_34XX_MMC3_IRQ;
> > > --

Regards,
Nishanth Menon

