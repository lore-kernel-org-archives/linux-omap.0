From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/16] ARM: OMAP: Fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code
Date: Tue, 19 Aug 2008 18:21:38 +0100
Message-ID: <20080819172138.GC17034@flint.arm.linux.org.uk>
References: <1212804762-18413-1-git-send-email-tony@atomide.com> <1212804762-18413-2-git-send-email-tony@atomide.com> <1212804762-18413-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37635 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbYHSRVt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 13:21:49 -0400
Content-Disposition: inline
In-Reply-To: <1212804762-18413-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jun 06, 2008 at 07:12:30PM -0700, Tony Lindgren wrote:
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
> +	u32 bit, reg, other_reg, st_reg;
> +
> +	reg = (__force u32)clk->enable_reg;
> +	if (((reg & 0xff) >= CM_FCLKEN1) &&
> +	    ((reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
> +		other_reg = ((reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
> +	else if (((reg & 0xff) >= CM_ICLKEN1) &&
> +		 ((reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
> +		other_reg = ((reg & ~0xf0) | 0x00); /* CM_FCLKEN* */

	unsigned long reg = (unsigned long)clk->enable_reg;

IIRC is a permitted cast, doesn't require __force.  And you can convert
back to void __iomem * without using __force either.

> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index aad781d..598f2d2 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -24,9 +24,9 @@
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
>  
> -#include <asm/io.h>
> -#include <asm/irq.h>

As I keep saying to people, not every warning that checkpatch spits
out is valid.  asm/irq.h -> linux/irq.h is not a valid warning.
