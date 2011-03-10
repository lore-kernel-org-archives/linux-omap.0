From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 0/2] OMAP3: wdtimer: fix wdtimer blocking CORE idle
Date: Thu, 10 Mar 2011 10:28:47 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B065E79@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1299749569-22673-1-git-send-email-kalle.jokiniemi@nokia.com>
 <alpine.DEB.2.00.1103100247190.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:17624 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab1CJKaZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 05:30:25 -0500
In-Reply-To: <alpine.DEB.2.00.1103100247190.15132@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: khilman@ti.com, linux-omap@vger.kernel.org, ilkka.koskinen@nokia.com, jhnikula@gmail.com, b-cousson@ti.com



> -----Original Message-----
> From: ext Paul Walmsley [mailto:paul@pwsan.com]
> Sent: 10. maaliskuuta 2011 11:50
> To: Jokiniemi Kalle (Nokia-MS/Tampere)
> Cc: khilman@ti.com; linux-omap@vger.kernel.org; Koskinen Ilkka (Nokia-
> MS/Tampere); jhnikula@gmail.com; b-cousson@ti.com
> Subject: Re: [PATCH 0/2] OMAP3: wdtimer: fix wdtimer blocking CORE idle
> 
> 
> Thanks Kalle for tracking this down,
> 
> could you try this patch along with the patch from this message:
> 
>   http://www.spinics.net/lists/linux-omap/msg48115.html
> 
> and see if it also fixes the problem?

It works as well it seems :)

I assume you prefer this fix to be applied, so I'll send patches on this.

- Kalle


> 
> This patch should also prevent the hwmod code from putting the WDT2 into
> smart-idle mode.
> 
> 
> - Paul
> 
> 
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 457df3e..4366b85 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1294,6 +1294,7 @@ static struct omap_hwmod
> omap3xxx_wd_timer2_hwmod = {
>  	.slaves		= omap3xxx_wd_timer2_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.flags		= HWMOD_SWSUP_SIDLE,
>  };
> 
>  /* UART common */
> --
> 1.7.2.3

