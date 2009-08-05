From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/15] OMAP: OMAPFB: add omapdss device
Date: Wed, 5 Aug 2009 17:32:35 +0300
Message-ID: <20090805143234.GK7374@atomide.com>
References: <1249481741-14008-1-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-2-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-3-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60802 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934442AbZHEOcj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:32:39 -0400
Content-Disposition: inline
In-Reply-To: <1249481741-14008-3-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [090805 17:19]:
> The upcoming new display subsystem driver is divided to two devices,
> omapdss and omapfb, of which omapdss handles the actual hardware.
> 
> This patch adds a dummy omapdss platform device for the current omapfb
> driver, which is then used to get the clocks. This will make it possible
> for the current and the new display drivers to co-exist.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Acked-by: Tony Lindgren <tony@atomide.com>


> ---
>  arch/arm/mach-omap2/clock24xx.c |    8 ++++----
>  arch/arm/mach-omap2/clock34xx.c |   10 +++++-----
>  drivers/video/omap/dispc.c      |   19 ++++++++++++++++---
>  3 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
> index 44de027..402a3d4 100644
> --- a/arch/arm/mach-omap2/clock24xx.c
> +++ b/arch/arm/mach-omap2/clock24xx.c
> @@ -103,10 +103,10 @@ static struct omap_clk omap24xx_clks[] = {
>  	CLK(NULL,	"mdm_ick",	&mdm_ick,	CK_243X),
>  	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
>  	/* DSS domain clocks */
> -	CLK("omapfb",	"ick",		&dss_ick,	CK_243X | CK_242X),
> -	CLK("omapfb",	"dss1_fck",	&dss1_fck,	CK_243X | CK_242X),
> -	CLK("omapfb",	"dss2_fck",	&dss2_fck,	CK_243X | CK_242X),
> -	CLK("omapfb",	"tv_fck",	&dss_54m_fck,	CK_243X | CK_242X),
> +	CLK("omapdss",	"ick",		&dss_ick,	CK_243X | CK_242X),
> +	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_243X | CK_242X),
> +	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_243X | CK_242X),
> +	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_243X | CK_242X),
>  	/* L3 domain clocks */
>  	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X | CK_242X),
>  	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X | CK_242X),
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 045da92..dd7bba2 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -200,11 +200,11 @@ static struct omap_clk omap34xx_clks[] = {
>  	CLK("omap_rng",	"ick",		&rng_ick,	CK_343X),
>  	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
>  	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
> -	CLK("omapfb",	"dss1_fck",	&dss1_alwon_fck, CK_343X),
> -	CLK("omapfb",	"tv_fck",	&dss_tv_fck,	CK_343X),
> -	CLK("omapfb",	"video_fck",	&dss_96m_fck,	CK_343X),
> -	CLK("omapfb",	"dss2_fck",	&dss2_alwon_fck, CK_343X),
> -	CLK("omapfb",	"ick",		&dss_ick,	CK_343X),
> +	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck, CK_343X),
> +	CLK("omapdss",	"tv_fck",	&dss_tv_fck,	CK_343X),
> +	CLK("omapdss",	"video_fck",	&dss_96m_fck,	CK_343X),
> +	CLK("omapdss",	"dss2_fck",	&dss2_alwon_fck, CK_343X),
> +	CLK("omapdss",	"ick",		&dss_ick,	CK_343X),
>  	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
>  	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
>  	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_343X),
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index 06438d0..cde3d18 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -24,6 +24,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/platform_device.h>
>  
>  #include <mach/sram.h>
>  #include <mach/board.h>
> @@ -188,6 +189,11 @@ static struct {
>  	struct omapfb_color_key	color_key;
>  } dispc;
>  
> +static struct platform_device omapdss_device = {
> +	.name		= "omapdss",
> +	.id		= -1,
> +};
> +
>  static void enable_lcd_clocks(int enable);
>  
>  static void inline dispc_write_reg(int idx, u32 val)
> @@ -907,20 +913,20 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
>  
>  static int get_dss_clocks(void)
>  {
> -	dispc.dss_ick = clk_get(dispc.fbdev->dev, "ick");
> +	dispc.dss_ick = clk_get(&omapdss_device.dev, "ick");
>  	if (IS_ERR(dispc.dss_ick)) {
>  		dev_err(dispc.fbdev->dev, "can't get ick\n");
>  		return PTR_ERR(dispc.dss_ick);
>  	}
>  
> -	dispc.dss1_fck = clk_get(dispc.fbdev->dev, "dss1_fck");
> +	dispc.dss1_fck = clk_get(&omapdss_device.dev, "dss1_fck");
>  	if (IS_ERR(dispc.dss1_fck)) {
>  		dev_err(dispc.fbdev->dev, "can't get dss1_fck\n");
>  		clk_put(dispc.dss_ick);
>  		return PTR_ERR(dispc.dss1_fck);
>  	}
>  
> -	dispc.dss_54m_fck = clk_get(dispc.fbdev->dev, "tv_fck");
> +	dispc.dss_54m_fck = clk_get(&omapdss_device.dev, "tv_fck");
>  	if (IS_ERR(dispc.dss_54m_fck)) {
>  		dev_err(dispc.fbdev->dev, "can't get tv_fck\n");
>  		clk_put(dispc.dss_ick);
> @@ -1371,6 +1377,12 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
>  	int skip_init = 0;
>  	int i;
>  
> +	r = platform_device_register(&omapdss_device);
> +	if (r) {
> +		dev_err(fbdev->dev, "can't register omapdss device\n");
> +		return r;
> +	}
> +
>  	memset(&dispc, 0, sizeof(dispc));
>  
>  	dispc.base = ioremap(DISPC_BASE, SZ_1K);
> @@ -1508,6 +1520,7 @@ static void omap_dispc_cleanup(void)
>  	free_irq(INT_24XX_DSS_IRQ, dispc.fbdev);
>  	put_dss_clocks();
>  	iounmap(dispc.base);
> +	platform_device_unregister(&omapdss_device);
>  }
>  
>  const struct lcd_ctrl omap2_int_ctrl = {
> -- 
> 1.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
