From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC][PATCH 4/9] OMAP4: clocks: distinguish 4430 and 4460
Date: Thu, 26 May 2011 14:11:23 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D177F79@dbde02.ent.ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
 <1306375016-707-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51205 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752Ab1EZIlb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 May 2011 04:41:31 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4Q8fStR017394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 03:41:30 -0500
In-Reply-To: <1306375016-707-5-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, May 26, 2011 7:27 AM
> To: linux-omap
> Cc: Nayak, Rajendra
> Subject: [RFC][PATCH 4/9] OMAP4: clocks: distinguish 4430 and 4460
> 
> From: Rajendra Nayak <rnayak@ti.com>
> 
> omap4460 platform has a few clock nodes which are added
> and a few which are missing (compared to the 4430 platform)
> rename current 4430 definitions to 44XX and followon patches
> will introduce the 4460 changes
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c          |  659 
> +++++++++++++------------
>  arch/arm/plat-omap/include/plat/clkdev_omap.h |    2 +
>  arch/arm/plat-omap/include/plat/clock.h       |    2 +
>  3 files changed, 335 insertions(+), 328 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c 
> b/arch/arm/mach-omap2/clock44xx_data.c
> index 8c96567..96c0e3e 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -1,7 +1,7 @@
>  /*
> - * OMAP4 Clock data
> + * OMAP44xx Clock data
>   *
> - * Copyright (C) 2009-2010 Texas Instruments, Inc.
> + * Copyright (C) 2009-2011 Texas Instruments, Inc.

[sp] Since you are changing it, it should read:
     Copyright (C) 2009-2011 Texas Instruments Incorporated

>   * Copyright (C) 2009-2010 Nokia Corporation
>   *
>   * Paul Walmsley (paul@pwsan.com)
> @@ -127,42 +127,42 @@ static struct clk virt_38400000_ck = {
>  };
>  

[snip]...[snip]

>  
>  int __init omap4xxx_clk_init(void)
>  {
>  	struct omap_clk *c;
> -	u32 cpu_clkflg;
> +	u32 cpu_clkflg = 0;
>  
> -	if (cpu_is_omap44xx()) {
> +	if (cpu_is_omap443x()) {
>  		cpu_mask = RATE_IN_4430;
>  		cpu_clkflg = CK_443X;
> +	} else if (cpu_is_omap446x()) {
> +		cpu_mask = RATE_IN_4460;
> +		cpu_clkflg = CK_446X;
>  	}
>  
>  	clk_init(&omap2_clk_functions);
> diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h 
> b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> index f1899a3..324446b 100644
> --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
> +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> @@ -39,11 +39,13 @@ struct omap_clk {
>  #define CK_36XX		(1 << 10)	/* 
> 36xx/37xx-specific clocks */
>  #define CK_443X		(1 << 11)
>  #define CK_TI816X	(1 << 12)
> +#define CK_446X		(1 << 13)
>  
>  
>  #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
>  #define CK_AM35XX	(CK_3505 | CK_3517)	/* all Sitara AM35xx */
>  #define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
> +#define CK_44XX		(CK_443X | CK_446X)
>  


[sp] Unrelated to this change, but extra whitespacing can be corrected.

>  
>  #endif
> diff --git a/arch/arm/plat-omap/include/plat/clock.h 
> b/arch/arm/plat-omap/include/plat/clock.h
> index 006e599..21b1beb 100644
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -58,10 +58,12 @@ struct clkops {
>  #define RATE_IN_36XX		(1 << 4)
>  #define RATE_IN_4430		(1 << 5)
>  #define RATE_IN_TI816X		(1 << 6)
> +#define RATE_IN_4460		(1 << 7)
>  
>  #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
>  #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
>  #define RATE_IN_3XXX		(RATE_IN_34XX | RATE_IN_36XX)
> +#define RATE_IN_44XX		(RATE_IN_4430 | RATE_IN_4460)
>  
>  /* RATE_IN_3430ES2PLUS_36XX includes 34xx/35xx with ES >=2, 
> and all 36xx/37xx */
>  #define RATE_IN_3430ES2PLUS_36XX	(RATE_IN_3430ES2PLUS | 
> RATE_IN_36XX)
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 