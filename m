From: "Kumar, Purushotam" <purushotam@ti.com>
Subject: RE: [PATCH] OMAP3:devices.c: Enabling 4-bit for SD card
Date: Wed, 25 Jun 2008 15:34:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301118F2774@dbde02.ent.ti.com>
References: <200806161302.m5GD2Xg4007641@india.ti.com>
 <20080623124703.GW7741@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35091 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbYFYKES convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 06:04:18 -0400
In-Reply-To: <20080623124703.GW7741@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Purushotam Kumar <a0876542@india.ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Monday, June 23, 2008 6:17 PM
> To: Purushotam Kumar
> Cc: linux-omap@vger.kernel.org; Gole, Anant
> Subject: Re: [PATCH] OMAP3:devices.c: Enabling 4-bit for SD card
>
> * Purushotam Kumar <a0876542@india.ti.com> [080616 16:03]:
> > OMAP3:devices.c:Enabling 4-bit for SD card
> >
> > SD card was working in 1-bit mode.This patch will configure SD card in
> > 4-bit mode and hence performance  will increase.
> >
> > Signed-off-by: Purushotam Kumar <purushotam@ti.com>
> > Acked-by: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> > ---
> >  arch/arm/plat-omap/devices.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > Index: linux-omap-2.6/arch/arm/plat-omap/devices.c
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/plat-omap/devices.c
> > +++ linux-omap-2.6/arch/arm/plat-omap/devices.c
> > @@ -292,8 +292,10 @@ static void __init omap_init_mmc(void)
> >       mmc = &mmc_conf->mmc[0];
> >
> >       if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> > -             if (mmc->enabled)
> > +             if (mmc->enabled) {
> > +                     mmc1_data.conf = *mmc;
> >                       (void) platform_device_register(&mmc_omap_device1);
> > +             }
> >
> >  #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
> >               mmc = &mmc_conf->mmc[1];
>
> I guess this should be also done for mmc2_data.conf?
>
> Tony

I agree with you that it is required to be done for MMC2 as well.
Please push this patch for MMC1 and I will submit other patch latter for MMC2.

Regards,
Purushotam
