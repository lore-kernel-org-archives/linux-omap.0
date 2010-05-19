From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap4: Fix multi-omap boot with reset un-used clocks
Date: Wed, 19 May 2010 08:50:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005190848360.27473@utopia.booyaka.com>
References: <1274270345-28769-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34427 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab0ESOul (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 10:50:41 -0400
In-Reply-To: <1274270345-28769-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

Santosh,

a comment.

On Wed, 19 May 2010, Santosh Shilimkar wrote:

> As part of the "CONFIG_OMAP_RESET_CLOCKS" routine, all the clock
> are cut which are not acquired/enabled during the boot.
> 
> Because of this on OMAP4, memory controller clocks (emif) getting
> disabled which prevents further boot
> 
> This patch uses "ENABLE_ON_INIT" flag on the emif clock nodes
> and adds a check in the reset un-used clock routine to skip
> such clock nodes. Will updated the auto-gen script for 44xx
> accordingly
> 
> The real fix is to have driver for EMIF and do clock get/enable
> part of it. The EMIF driver is planned to be done HWMOD way so
> till that point to keep omap3_defconfig booting on OMAP4430,
> this patch is necessary. Also the cpu_is_44xx() check is added 
> to avoid any impact on the other OMAPs using "ENABLE_ON_INIT" flag
> 
> The flag usage was suggested by Paul Walmsley
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> With this patch and Tony's below sram fix, omap3_defconfig
> boots on OMAP4430 as it is. Tested with 2.6.34 maniline kernel
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27363.html
> 
>  arch/arm/mach-omap2/clock.c          |    4 ++++
>  arch/arm/mach-omap2/clock44xx_data.c |    2 ++
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index a6d0b34..67b531b 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -380,6 +380,10 @@ void omap2_clk_disable_unused(struct clk *clk)
>  {
>  	u32 regval32, v;
>  
> +	/* FIXME: Remove this when EMIF driver is ready */
> +	if (cpu_is_omap44xx() && (clk->flags & ENABLE_ON_INIT))
> +		return;
> +

Why is this needed?  omap4xxx_clk_init() should call 	
clk_enable_init_clocks() which should increase the usecount on all 
ENABLE_ON_INIT clocks.  That should prevent omap2_clk_disable_unused() 
from disabling the clock.


>  	v = (clk->flags & INVERT_ENABLE) ? (1 << clk->enable_bit) : 0;
>  
>  	regval32 = __raw_readl(clk->enable_reg);
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index a5c0c9c..a1b4cae 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -1369,6 +1369,7 @@ static struct clk emif1_ick = {
>  	.ops		= &clkops_omap2_dflt,
>  	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_1_CLKCTRL,
>  	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
> +	.flags		= ENABLE_ON_INIT,
>  	.clkdm_name	= "l3_emif_clkdm",
>  	.parent		= &ddrphy_ck,
>  	.recalc		= &followparent_recalc,
> @@ -1379,6 +1380,7 @@ static struct clk emif2_ick = {
>  	.ops		= &clkops_omap2_dflt,
>  	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_2_CLKCTRL,
>  	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
> +	.flags		= ENABLE_ON_INIT,
>  	.clkdm_name	= "l3_emif_clkdm",
>  	.parent		= &ddrphy_ck,
>  	.recalc		= &followparent_recalc,
> -- 
> 1.6.0.4
> 


- Paul
