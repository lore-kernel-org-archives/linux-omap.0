From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 02/10] ARM: OMAP: Fix sparse, checkpatch warnings in
 OMAP2/3 PRCM/PM code
Date: Mon, 6 Oct 2008 08:52:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810060848470.354@utopia.booyaka.com>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002163749.15385.75147.stgit@localhost.localdomain> <20081004131911.GA5674@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36706 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbYJFOwl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 10:52:41 -0400
In-Reply-To: <20081004131911.GA5674@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hello Russell,

On Sat, 4 Oct 2008, Russell King - ARM Linux wrote:

> On Thu, Oct 02, 2008 at 10:37:50AM -0600, Paul Walmsley wrote:
> >  static void omap2_clk_wait_ready(struct clk *clk)
> >  {
> > -	void __iomem *reg, *other_reg, *st_reg;
> > -	u32 bit;
> > -
> > -	/*
> > -	 * REVISIT: This code is pretty ugly.  It would be nice to generalize
> > -	 * it and pull it into struct clk itself somehow.
> > -	 */
> > -	reg = clk->enable_reg;
> > -	if ((((u32)reg & 0xff) >= CM_FCLKEN1) &&
> > -	    (((u32)reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
> > -		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
> > -	else if ((((u32)reg & 0xff) >= CM_ICLKEN1) &&
> > -		 (((u32)reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
> > -		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
> > +	u32 bit, other_reg, st_reg;
> > +	unsigned long reg;
> > +
> > +	reg = (unsigned long)clk->enable_reg;
> > +	if (((reg & 0xff) >= CM_FCLKEN1) &&
> > +	    ((reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
> > +		other_reg = ((reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
> > +	else if (((reg & 0xff) >= CM_ICLKEN1) &&
> > +		 ((reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
> > +		other_reg = ((reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
> >  	else
> >  		return;
> >  
> >  	/* REVISIT: What are the appropriate exclusions for 34XX? */
> >  	/* No check for DSS or cam clocks */
> > -	if (cpu_is_omap24xx() && ((u32)reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
> > +	if (cpu_is_omap24xx() && (reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
> >  		if (clk->enable_bit == OMAP24XX_EN_DSS2_SHIFT ||
> >  		    clk->enable_bit == OMAP24XX_EN_DSS1_SHIFT ||
> >  		    clk->enable_bit == OMAP24XX_EN_CAM_SHIFT)
> > @@ -249,25 +245,25 @@ static void omap2_clk_wait_ready(struct clk *clk)
> >  	/* REVISIT: What are the appropriate exclusions for 34XX? */
> >  	/* OMAP3: ignore DSS-mod clocks */
> >  	if (cpu_is_omap34xx() &&
> > -	    (((u32)reg & ~0xff) == (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
> > -	     ((((u32)reg & ~0xff) == (u32)OMAP_CM_REGADDR(CORE_MOD, 0)) &&
> > -	     clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
> > +	    ((reg & ~0xff) == (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
> > +	     (((reg & ~0xff) == (u32)OMAP_CM_REGADDR(CORE_MOD, 0)) &&
> > +	      clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
> >  		return;
> >  
> >  	/* Check if both functional and interface clocks
> >  	 * are running. */
> >  	bit = 1 << clk->enable_bit;
> > -	if (!(__raw_readl(other_reg) & bit))
> > +	if (!(__raw_readl((void __iomem *)other_reg) & bit))
> 
> This isn't an improvement.  Moving casts to the readl/writel macros is
> a definite no no.

OK.  Tony's tree contains some patches which thoroughly clean this 
function up, but they are large.  Would you like me to send those along 
with this patch set, or would you prefer that I just drop this part of the 
patch and repost?


- Paul
