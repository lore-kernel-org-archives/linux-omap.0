From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] ARM: OMAP3: Fix warnings in clock34xx.h
Date: Thu, 3 Jul 2008 14:02:15 +0300
Message-ID: <20080703110212.GW14276@atomide.com>
References: <48651B85.9030904@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51181 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028AbYGCMM2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:12:28 -0400
Content-Disposition: inline
In-Reply-To: <48651B85.9030904@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Dirk Behme <dirk.behme@googlemail.com> [080627 19:56]:
>
> Fix warnings
>
> arch/arm/mach-omap2/clock34xx.h:178: warning: initialization makes  
> pointer from integer without a cast
> arch/arm/mach-omap2/clock34xx.h:204: warning: initialization makes  
> pointer from integer without a cast
> arch/arm/mach-omap2/clock34xx.h:229: warning: initialization makes  
> pointer from integer without a cast

Pushing today.

Tony

>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>

> 
> Subject: ARM: OMAP3: Fix warnings in clock34xx.h 
> 
> From: Dirk Behme <dirk.behme@gmail.com>
> 
> Fix warnings
> 
> arch/arm/mach-omap2/clock34xx.h:178: warning: initialization makes pointer from integer without a cast
> arch/arm/mach-omap2/clock34xx.h:204: warning: initialization makes pointer from integer without a cast
> arch/arm/mach-omap2/clock34xx.h:229: warning: initialization makes pointer from integer without a cast
> 
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> 
> ---
> 
> Changes in V3: Update to recent git.
> 
> Index: linux-beagle/arch/arm/mach-omap2/clock34xx.h
> ===================================================================
> --- linux-beagle.orig/arch/arm/mach-omap2/clock34xx.h
> +++ linux-beagle/arch/arm/mach-omap2/clock34xx.h
> @@ -53,14 +53,17 @@ static int omap3_noncore_dpll_set_rate(s
>  #define DPLL_LOW_POWER_BYPASS		0x5
>  #define DPLL_LOCKED			0x7
>  
> +#define _OMAP34XX_PRM_REGADDR(module, reg)				\
> +	((__force void __iomem *)(OMAP34XX_PRM_REGADDR((module), (reg))))
> +
>  #define OMAP3430_PRM_CLKSRC_CTRL					\
> -	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)
> +	_OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, OMAP3_PRM_CLKSRC_CTRL_OFFSET)
>  
>  #define OMAP3430_PRM_CLKSEL						\
> -	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, OMAP3_PRM_CLKSEL_OFFSET)
> +	_OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, OMAP3_PRM_CLKSEL_OFFSET)
>  
>  #define OMAP3430_PRM_CLKOUT_CTRL					\
> -	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, OMAP3_PRM_CLKOUT_CTRL_OFFSET)
> +	_OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, OMAP3_PRM_CLKOUT_CTRL_OFFSET)
>  
>  /* PRM CLOCKS */
>  

