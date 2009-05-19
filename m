From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESUBMIT][PATCH 3/7 v2] OMAP4: Update common omap platform
	headers.
Date: Tue, 19 May 2009 14:18:18 -0700
Message-ID: <20090519211818.GI19742@atomide.com>
References: <1242739907-12487-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55014 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbZESVS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 17:18:26 -0400
Content-Disposition: inline
In-Reply-To: <1242739907-12487-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [090519 06:32]:
> (patch is rebased on 2.6.30-rc6. The older version was based on 2.6.30-rc2)
> 
> This patch updates the common platform headers files for OMAP4430.
> On OMAP4, GIC is used instead of INTC, hence all the private peripheral
> interrupts are shifted by an offset of 32. So if the hardcoding is not
> done for IRQ lines in drivers, then this change won't impact any driver.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/plat-omap/include/mach/clock.h       |    8 ++-
>  arch/arm/plat-omap/include/mach/common.h      |    1 +
>  arch/arm/plat-omap/include/mach/control.h     |    7 +-
>  arch/arm/plat-omap/include/mach/debug-macro.S |    2 +-
>  arch/arm/plat-omap/include/mach/dma.h         |    1 +
>  arch/arm/plat-omap/include/mach/entry-macro.S |   46 ++++++++++++-
>  arch/arm/plat-omap/include/mach/io.h          |   37 ++++++++++
>  arch/arm/plat-omap/include/mach/irqs.h        |   89 +++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/memory.h      |    3 +-
>  arch/arm/plat-omap/include/mach/serial.h      |   16 ++++-
>  10 files changed, 198 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
> index 073a2c5..058a808 100644
> --- a/arch/arm/plat-omap/include/mach/clock.h
> +++ b/arch/arm/plat-omap/include/mach/clock.h
> @@ -22,7 +22,8 @@ struct clkops {
>  	void			(*disable)(struct clk *);
>  };
>  
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +		defined(CONFIG_ARCH_OMAP4)
>  
>  struct clksel_rate {
>  	u32			val;
> @@ -51,7 +52,7 @@ struct dpll_data {
>  	u8			max_divider;
>  	u32			max_tolerance;
>  	u16			max_multiplier;
> -#  if defined(CONFIG_ARCH_OMAP3)
> +#  if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  	u8			modes;
>  	void __iomem		*autoidle_reg;
>  	void __iomem		*idlest_reg;

Please get rid of the extra spaces in the #if defined above while at it.

Regards,

Tony
