From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 02/14] ARM: OMAP: counter-32k: Select the CR register offset using the IP scheme.
Date: Mon, 09 Jul 2012 09:47:47 -0700
Message-ID: <873950x4ng.fsf@ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
	<1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:55870 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752436Ab2GIQrv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 12:47:51 -0400
Received: by ghbz10 with SMTP id z10so10732818ghb.7
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 09:47:49 -0700 (PDT)
In-Reply-To: <1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 6 Jul 2012 14:51:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> From: R Sricharan <r.sricharan@ti.com>
>
> OMAP socs has a legacy and a highlander version of the
> 32k sync counter IP. The register offsets vary between the
> highlander and the legacy scheme. So use the 'SCHEME'
> bits(30-31) of the revision register to distinguish between
> the two versions and choose the CR register offset accordingly.

Do these scheme bits exist on *all* OMAPs?  including OMAP1?

This driver is used on OMAP1 as well as OMAP2+.  

The cover letter says this was only build tested on OMAP1 so I suggest
this actually be tested on OMAP1 before merging.

Kevin

> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/plat-omap/counter_32k.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> index 2132c4f..dbf1e03 100644
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> @@ -29,7 +29,10 @@
>  #include <plat/clock.h>
>  
>  /* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
> -#define OMAP2_32KSYNCNT_CR_OFF		0x10
> +#define OMAP2_32KSYNCNT_REV_OFF		0x0
> +#define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
> +#define OMAP2_32KSYNCNT_CR_OFF_LOW	0x10
> +#define OMAP2_32KSYNCNT_CR_OFF_HIGH	0x30
>  
>  /*
>   * 32KHz clocksource ... always available, on pretty most chips except
> @@ -84,9 +87,16 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
>  	int ret;
>  
>  	/*
> -	 * 32k sync Counter register offset is at 0x10
> +	 * 32k sync Counter IP register offsets vary between the
> +	 * highlander version and the legacy ones.
> +	 * The 'SCHEME' bits(30-31) of the revision register is used
> +	 * to identify the version.
>  	 */
> -	sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF;
> +	if (__raw_readl(vbase + OMAP2_32KSYNCNT_REV_OFF) &
> +						OMAP2_32KSYNCNT_REV_SCHEME)
> +		sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_HIGH;
> +	else
> +		sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_LOW;
>  
>  	/*
>  	 * 120000 rough estimate from the calculations in
