From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/10] ARM: OMAP: Fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code
Date: Sat, 4 Oct 2008 14:19:11 +0100
Message-ID: <20081004131911.GA5674@flint.arm.linux.org.uk>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002163749.15385.75147.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56477 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYJDNT0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Oct 2008 09:19:26 -0400
Content-Disposition: inline
In-Reply-To: <20081002163749.15385.75147.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thu, Oct 02, 2008 at 10:37:50AM -0600, Paul Walmsley wrote:
>  static void omap2_clk_wait_ready(struct clk *clk)
>  {
> -	void __iomem *reg, *other_reg, *st_reg;
> -	u32 bit;
> -
> -	/*
> -	 * REVISIT: This code is pretty ugly.  It would be nice to generalize
> -	 * it and pull it into struct clk itself somehow.
> -	 */
> -	reg = clk->enable_reg;
> -	if ((((u32)reg & 0xff) >= CM_FCLKEN1) &&
> -	    (((u32)reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
> -		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
> -	else if ((((u32)reg & 0xff) >= CM_ICLKEN1) &&
> -		 (((u32)reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
> -		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
> +	u32 bit, other_reg, st_reg;
> +	unsigned long reg;
> +
> +	reg = (unsigned long)clk->enable_reg;
> +	if (((reg & 0xff) >= CM_FCLKEN1) &&
> +	    ((reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
> +		other_reg = ((reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
> +	else if (((reg & 0xff) >= CM_ICLKEN1) &&
> +		 ((reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
> +		other_reg = ((reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
>  	else
>  		return;
>  
>  	/* REVISIT: What are the appropriate exclusions for 34XX? */
>  	/* No check for DSS or cam clocks */
> -	if (cpu_is_omap24xx() && ((u32)reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
> +	if (cpu_is_omap24xx() && (reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
>  		if (clk->enable_bit == OMAP24XX_EN_DSS2_SHIFT ||
>  		    clk->enable_bit == OMAP24XX_EN_DSS1_SHIFT ||
>  		    clk->enable_bit == OMAP24XX_EN_CAM_SHIFT)
> @@ -249,25 +245,25 @@ static void omap2_clk_wait_ready(struct clk *clk)
>  	/* REVISIT: What are the appropriate exclusions for 34XX? */
>  	/* OMAP3: ignore DSS-mod clocks */
>  	if (cpu_is_omap34xx() &&
> -	    (((u32)reg & ~0xff) == (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
> -	     ((((u32)reg & ~0xff) == (u32)OMAP_CM_REGADDR(CORE_MOD, 0)) &&
> -	     clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
> +	    ((reg & ~0xff) == (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
> +	     (((reg & ~0xff) == (u32)OMAP_CM_REGADDR(CORE_MOD, 0)) &&
> +	      clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
>  		return;
>  
>  	/* Check if both functional and interface clocks
>  	 * are running. */
>  	bit = 1 << clk->enable_bit;
> -	if (!(__raw_readl(other_reg) & bit))
> +	if (!(__raw_readl((void __iomem *)other_reg) & bit))

This isn't an improvement.  Moving casts to the readl/writel macros is
a definite no no.

The rest of the patch is fine.
