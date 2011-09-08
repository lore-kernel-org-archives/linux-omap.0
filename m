From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP2PLUS: DSS: Ensure DSS works correctly if display
 is enabled in bootloader
Date: Thu, 08 Sep 2011 14:28:54 +0300
Message-ID: <1315481334.2018.40.camel@deskari>
References: <1315475793-7737-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50422 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932403Ab1IHL27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 07:28:59 -0400
Received: by mail-bw0-f54.google.com with SMTP id t8so668736bka.41
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 04:28:57 -0700 (PDT)
In-Reply-To: <1315475793-7737-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: santosh.shilimkar@ti.com, r.sricharan@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

Hi,

I guess this should go through Paul. Paul, this is based on the DSS
HWMOD patches from me, and needed for cases where the bootloader has
enabled the DSS.

On Thu, 2011-09-08 at 15:26 +0530, Archit Taneja wrote:
> Resetting DISPC when a DISPC output is enabled causes the DSS to go into an
> inconsistent state. Thus if the bootloader has enabled a display, the hwmod code
> cannot reset the DISPC module just like that, but the outputs need to be
> disabled first.
> 
> Add function dispc_disable_outputs() which disables all active overlay manager
> and ensure all frame transfers are completed.
> 
> Modify omap_dss_reset() to call this function and clear DSS_CONTROL,
> DSS_SDI_CONTROL and DSS_PLL_CONTROL so that DSS is in a clean state when the
> DSS2 driver starts.
> 
> Tested-by: R, Sricharan <r.sricharan@ti.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
> Note:
> This resolves the hang issue(caused by a L3 errod during boot) seen on the
> beagle board C3, which has a factory bootloader that enables display. The issue
> is resovled with this patch.

This note would be useful to have in the actual commit desc also. (with
error and resolved typofixed =).

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

> 
> The patch depends on a HWMOD patch series which has been posted by Tomi, it can
> be tested by applying over the following branch:
> 
> https://gitorious.org/linux-omap-dss2/linux/commits/master
> 
>  arch/arm/mach-omap2/display.c |  110 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 110 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 93db7c1..eab81f4 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -30,6 +30,30 @@
>  
>  #include "control.h"
>  
> +#define DISPC_BASE_OMAP2	0x48050400
> +#define DISPC_BASE_OMAP4	0x48041000
> +
> +#define DISPC_REG(base, offset)	(base + offset)
> +
> +#define DISPC_CONTROL		0x0040
> +#define DISPC_CONTROL2		0x0238
> +#define DISPC_IRQSTATUS		0x0018
> +
> +#define DSS_SYSCONFIG		0x10
> +#define DSS_SYSSTATUS		0x14
> +#define DSS_CONTROL		0x40
> +#define DSS_SDI_CONTROL		0x44
> +#define DSS_PLL_CONTROL		0x48
> +
> +#define LCD_EN_MASK		(0x1 << 0)
> +#define DIGIT_EN_MASK		(0x1 << 1)
> +
> +#define FRAMEDONE_IRQ_SHIFT	0
> +#define EVSYNC_EVEN_IRQ_SHIFT	2
> +#define EVSYNC_ODD_IRQ_SHIFT	3
> +#define FRAMEDONE2_IRQ_SHIFT	22
> +#define FRAMEDONETV_IRQ_SHIFT	24
> +
>  static struct platform_device omap_display_device = {
>  	.name          = "omapdss",
>  	.id            = -1,
> @@ -182,6 +206,78 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
>  	return r;
>  }
>  
> +static void dispc_disable_outputs(void)
> +{
> +	u32 val, irq_mask, base;
> +	bool lcd_en, digit_en, lcd2_en = false;
> +	int i, num_mgrs;
> +
> +	if (cpu_is_omap44xx()) {
> +		base = DISPC_BASE_OMAP4;
> +		num_mgrs = 3;
> +	} else {
> +		base = DISPC_BASE_OMAP2;
> +		num_mgrs = 2;
> +	}
> +
> +	/* store value of LCDENABLE and DIGITENABLE bits */
> +	val = omap_readl(DISPC_REG(base, DISPC_CONTROL));
> +	lcd_en = val & LCD_EN_MASK;
> +	digit_en = val & DIGIT_EN_MASK;
> +
> +	/* store value of LCDENABLE for LCD2 */
> +	if (num_mgrs > 2) {
> +		val = omap_readl(DISPC_REG(base, DISPC_CONTROL2));
> +		lcd2_en = val & LCD_EN_MASK;
> +	}
> +
> +	/*
> +	 * If any manager was enabled, we need to disable it before DSS clocks
> +	 * are disabled or DISPC module is reset
> +	 */
> +	if (lcd_en || digit_en || lcd2_en) {
> +		irq_mask = (lcd_en ? 1 : 0) << FRAMEDONE_IRQ_SHIFT;
> +
> +		if (cpu_is_omap44xx())
> +			irq_mask |= (digit_en ? 1 : 0) << FRAMEDONETV_IRQ_SHIFT;
> +		else
> +			irq_mask |= (digit_en ? 1 : 0) << EVSYNC_EVEN_IRQ_SHIFT |
> +				(digit_en ? 1 : 0) << EVSYNC_ODD_IRQ_SHIFT;
> +
> +		irq_mask |= (lcd2_en ? 1 : 0) << FRAMEDONE2_IRQ_SHIFT;
> +
> +		/*
> +		 * clear any previous FRAMEDONE, FRAMEDONETV, EVSYNC_EVEN/ODD
> +		 * or FRAMEDONE2 interrupts
> +		 */
> +		omap_writel(irq_mask, DISPC_REG(base, DISPC_IRQSTATUS));
> +
> +		/* disable LCD and TV managers */
> +		val = omap_readl(DISPC_REG(base, DISPC_CONTROL));
> +		val &= ~(LCD_EN_MASK | DIGIT_EN_MASK);
> +		omap_writel(val, DISPC_REG(base, DISPC_CONTROL));
> +
> +		/* disable LCD2 manager */
> +		if (num_mgrs > 2) {
> +			val = omap_readl(DISPC_REG(base, DISPC_CONTROL2));
> +			val &= ~LCD_EN_MASK;
> +			omap_writel(val, DISPC_REG(base, DISPC_CONTROL2));
> +		}
> +
> +		i = 0;
> +		while ((omap_readl(DISPC_REG(base, DISPC_IRQSTATUS)) & irq_mask) !=
> +				irq_mask) {
> +			i++;
> +			if (i > 100) {
> +				printk(KERN_ERR "didn't get FRAMEDONE1/2 or TV"
> +					" interrupt\n");
> +				break;
> +			}
> +			mdelay(1);
> +		}
> +	}
> +}
> +
>  #define MAX_MODULE_SOFTRESET_WAIT	10000
>  int omap_dss_reset(struct omap_hwmod *oh)
>  {
> @@ -198,6 +294,20 @@ int omap_dss_reset(struct omap_hwmod *oh)
>  		if (oc->_clk)
>  			clk_enable(oc->_clk);
>  
> +	dispc_disable_outputs();
> +
> +	/* clear SDI registers */
> +	if (cpu_is_omap3430()) {
> +		omap_hwmod_write(0x0, oh, DSS_SDI_CONTROL);
> +		omap_hwmod_write(0x0, oh, DSS_PLL_CONTROL);
> +	}
> +
> +	/*
> +	 * clear DSS_CONTROL register to switch DSS clock sources to
> +	 * PRCM clock, if any
> +	 */
> +	omap_hwmod_write(0x0, oh, DSS_CONTROL);
> +
>  	omap_test_timeout((omap_hwmod_read(oh, oh->class->sysc->syss_offs)
>  				& SYSS_RESETDONE_MASK),
>  			MAX_MODULE_SOFTRESET_WAIT, c);


