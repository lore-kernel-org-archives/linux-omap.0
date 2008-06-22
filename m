From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] OMAP3 clock: fix omap2_clk_wait_ready for OMAP3430ES2
 DSS
Date: Sun, 22 Jun 2008 14:01:23 +0200
Message-ID: <485E3F13.9040801@googlemail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB022BE46296@dbde02.ent.ti.com>,<485CA347.909@googlemail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BB66209@dbde02.ent.ti.com> <alpine.DEB.1.00.0806211054100.19765@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:11010 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYFVMBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jun 2008 08:01:30 -0400
Received: by an-out-0708.google.com with SMTP id d40so483039and.103
        for <linux-omap@vger.kernel.org>; Sun, 22 Jun 2008 05:01:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806211054100.19765@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "jouni.hogander@nokia.com" <jouni.hogander@nokia.com>

Paul Walmsley wrote:
> On OMAP3430ES2, DSS has both an initiator standby CM_IDLEST bit, and a
> target idle CM_IDLEST bit.  This is a departure from previous silicon,
> which only had an initiator standby bit.
> 
> This means we need to test the target idle bit after enabling
> dss1_alwon_fclk.  Previous clock code has done the wrong thing since ES2
> came out: it's either tested the wrong bit, causing intermittent
> 
>     Clock dss1_alwon_fck didn't enable in 100000 tries
> 
> messages; or not tested anything at all, causing intermittent crashes 
> during DISPC initialization with:
> 
>     Unhandled fault: external abort on non-linefetch (0x1028)
> 
> This patch modifies omap2_clk_wait_ready() to wait for the DSS to become
> accessible after dss1_alwon_fclk is enabled.
> 
> Thanks to Anand Gadiyar <gadiyar@ti.com> for identifying one of the
> problem patches.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Acked-by: Dirk Behme <dirk.behme@gmail.com>

>  arch/arm/mach-omap2/clock.c           |   30 ++++++++++++++++++++++++------
>  arch/arm/mach-omap2/cm-regbits-34xx.h |    4 +++-
>  2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index ed15868..1820f75 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -244,18 +244,36 @@ static void omap2_clk_wait_ready(struct clk *clk)
>  	}
>  
>  	/* REVISIT: What are the appropriate exclusions for 34XX? */
> -	/* OMAP3: ignore DSS-mod clocks */
> -	if (cpu_is_omap34xx() &&
> -	    ((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
> -	     (((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(CORE_MOD, 0)) &&
> -	      clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
> -		return;
> +	if (cpu_is_omap34xx()) {
> +
> +		/* 3430ES1 DSS and SSI have no target idlest bits */
> +		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0) &&
> +		    ((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
> +		     ((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
> +		      clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
> +			return;
> +
> +		/* Even for 3430ES2 DSS, only wait for dss1_alwon_fclk */
> +		if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0) &&
> +		    (reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) &&
> +		    clk->enable_bit != OMAP3430_EN_DSS1_SHIFT)
> +			return;
> +
> +	}
>  
>  	/* Check if both functional and interface clocks
>  	 * are running. */
>  	bit = 1 << clk->enable_bit;
>  	if (!(__raw_readl((__force void __iomem *)other_reg) & bit))
>  		return;
> +
> +	/* OMAP3430ES2 DSS is an unusual case */
> +	if (cpu_is_omap34xx() &&
> +	    (reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) &&
> +	    clk->enable_bit == OMAP3430_EN_DSS1_SHIFT) {
> +		bit = OMAP3430ES2_ST_DSS_IDLE;
> +	}
> +
>  	st_reg = ((other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
>  
>  	omap2_wait_clock_ready((__force void __iomem *)st_reg, bit, clk->name);
> diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
> index 6ec66f4..946c552 100644
> --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> @@ -500,7 +500,9 @@
>  #define OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT		0
>  
>  /* CM_IDLEST_DSS */
> -#define OMAP3430_ST_DSS					(1 << 0)
> +#define OMAP3430ES2_ST_DSS_IDLE				(1 << 1)
> +#define OMAP3430ES2_ST_DSS_STDBY			(1 << 0)
> +#define OMAP3430ES1_ST_DSS				(1 << 0)
>  
>  /* CM_AUTOIDLE_DSS */
>  #define OMAP3430_AUTO_DSS				(1 << 0)
> 

