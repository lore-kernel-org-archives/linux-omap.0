From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 01/13] OMAP: DSS2: enable VDDS_DSI when using DPI
Date: Mon, 15 Feb 2010 15:52:01 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A96DE7B@dbde02.ent.ti.com>
References: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50303 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371Ab0BOKWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 05:22:39 -0500
In-Reply-To: <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
> Sent: Monday, February 08, 2010 9:26 PM
> To: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org
> Cc: Tomi Valkeinen
> Subject: [PATCH 01/13] OMAP: DSS2: enable VDDS_DSI when using DPI
> 
> It looks like on OMAP3 some DSS pins need VDDS_DSI to function
> properly.
> 
> This has not been confirmed from TI, but looking at figure 15-1
> "Display
> subsystem highlight" from the TRM, some data pins come near the DSI
> and SDI
> blocks. This is not very hard evidence, but the fact remains that
> with the
> power on, pixels are ok, and with the power off, pixels are not ok.
> 
[Hiremath, Vaibhav] Tomi, sorry for delayed response. As usual stuck with some other issues. Below are some quick comments -

I am not regulator expert, but as per my finding I believe it is nothing to do with pins position closure to each other. The actual root cause is TWL4030 Ownership bit. Please refer to the below mail-chain - 

http://marc.info/?l=linux-omap&m=126045146600334&w=2


> It may also be that VDDS_SDI is needed to power some pins, but as
> normally
> both VDDS_SDI and VDDS_DSI come from the same power source, this
> hasn't
> been shown.
> 
> It seems that a single driver can only get a regulator once. This
> patch
> solves it by getting all the required regulators in one place, and
> from
> which the submodules then get the regulators they need.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  drivers/video/omap2/dss/core.c |   66
> +++++++++++++++++++++++++++++++++++++++-
>  drivers/video/omap2/dss/dpi.c  |   55 ++++++++++++++++++++++++++++-
> ----
>  drivers/video/omap2/dss/dsi.c  |    4 +--
>  drivers/video/omap2/dss/dss.h  |    5 ++-
>  drivers/video/omap2/dss/venc.c |    4 +--
>  5 files changed, 117 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/core.c
> b/drivers/video/omap2/dss/core.c
> index 82918ee..791e1cb 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -31,6 +31,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/io.h>
>  #include <linux/device.h>
> +#include <linux/regulator/consumer.h>
> 
>  #include <plat/display.h>
>  #include <plat/clock.h>
> @@ -47,6 +48,10 @@ static struct {
>  	struct clk      *dss_54m_fck;
>  	struct clk	*dss_96m_fck;
>  	unsigned	num_clks_enabled;
> +
> +	struct regulator *vdds_dsi_reg;
> +	struct regulator *vdds_sdi_reg;
> +	struct regulator *vdda_dac_reg;
>  } core;
> 
>  static void dss_clk_enable_all_no_ctx(void);
> @@ -352,6 +357,50 @@ static void dss_clk_disable_all(void)
>  	dss_clk_disable(clks);
>  }
> 
> +/* REGULATORS */
> +
> +struct regulator *dss_get_vdds_dsi(void)
> +{
> +	struct regulator *reg;
> +
> +	if (core.vdds_dsi_reg != NULL)
> +		return core.vdds_dsi_reg;
> +
> +	reg = regulator_get(&core.pdev->dev, "vdds_dsi");
> +	if (!IS_ERR(reg))
> +		core.vdds_dsi_reg = reg;
> +
> +	return reg;
> +}
> +
> +struct regulator *dss_get_vdds_sdi(void)
> +{
> +	struct regulator *reg;
> +
> +	if (core.vdds_sdi_reg != NULL)
> +		return core.vdds_sdi_reg;
> +
> +	reg = regulator_get(&core.pdev->dev, "vdds_sdi");
> +	if (!IS_ERR(reg))
> +		core.vdds_sdi_reg = reg;
> +
> +	return reg;
> +}
> +
> +struct regulator *dss_get_vdda_dac(void)
> +{
> +	struct regulator *reg;
> +
> +	if (core.vdda_dac_reg != NULL)
> +		return core.vdda_dac_reg;
> +
> +	reg = regulator_get(&core.pdev->dev, "vdda_dac");
> +	if (!IS_ERR(reg))
> +		core.vdda_dac_reg = reg;
> +
> +	return reg;
> +}
> +
>  /* DEBUGFS */
>  #if defined(CONFIG_DEBUG_FS) &&
> defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
>  static void dss_debug_dump_clocks(struct seq_file *s)
> @@ -473,7 +522,7 @@ static int omap_dss_probe(struct platform_device
> *pdev)
>  	}
>  #endif
> 
> -	r = dpi_init();
> +	r = dpi_init(pdev);
>  	if (r) {
>  		DSSERR("Failed to initialize dpi\n");
>  		goto fail0;
> @@ -901,6 +950,21 @@ static int __init omap_dss_init(void)
> 
>  static void __exit omap_dss_exit(void)
>  {
> +	if (core.vdds_dsi_reg != NULL) {
> +		regulator_put(core.vdds_dsi_reg);
> +		core.vdds_dsi_reg = NULL;
> +	}
> +
> +	if (core.vdds_sdi_reg != NULL) {
> +		regulator_put(core.vdds_sdi_reg);
> +		core.vdds_sdi_reg = NULL;
> +	}
> +
> +	if (core.vdda_dac_reg != NULL) {
> +		regulator_put(core.vdda_dac_reg);
> +		core.vdda_dac_reg = NULL;
> +	}
> +
>  	platform_driver_unregister(&omap_dss_driver);
> 
>  	omap_dss_bus_unregister();
> diff --git a/drivers/video/omap2/dss/dpi.c
> b/drivers/video/omap2/dss/dpi.c
> index 2d71031..69ce31a 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -25,7 +25,10 @@
>  #include <linux/kernel.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/err.h>
>  #include <linux/errno.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> 
>  #include <plat/display.h>
>  #include <plat/cpu.h>
> @@ -34,6 +37,7 @@
> 
>  static struct {
>  	int update_enabled;
> +	struct regulator *vdds_dsi_reg;
>  } dpi;
> 
>  #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
> @@ -166,21 +170,27 @@ static int dpi_display_enable(struct
> omap_dss_device *dssdev)
>  		goto err1;
>  	}
> 
> +	if (cpu_is_omap34xx()) {
> +		r = regulator_enable(dpi.vdds_dsi_reg);
> +		if (r)
> +			goto err2;
> +	}
> +
>  	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
> 
>  	r = dpi_basic_init(dssdev);
>  	if (r)
> -		goto err2;
> +		goto err3;
> 
>  #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
>  	dss_clk_enable(DSS_CLK_FCK2);
>  	r = dsi_pll_init(dssdev, 0, 1);
>  	if (r)
> -		goto err3;
> +		goto err4;
>  #endif
>  	r = dpi_set_mode(dssdev);
>  	if (r)
> -		goto err4;
> +		goto err5;
> 
>  	mdelay(2);
> 
> @@ -188,22 +198,25 @@ static int dpi_display_enable(struct
> omap_dss_device *dssdev)
> 
>  	r = dssdev->driver->enable(dssdev);
>  	if (r)
> -		goto err5;
> +		goto err6;
> 
>  	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> 
>  	return 0;
> 
> -err5:
> +err6:
>  	dispc_enable_lcd_out(0);
> -err4:
> +err5:
>  #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
>  	dsi_pll_uninit();
> -err3:
> +err4:
>  	dss_clk_disable(DSS_CLK_FCK2);
>  #endif
> -err2:
> +err3:
>  	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
> +err2:
> +	if (cpu_is_omap34xx())
> +		regulator_disable(dpi.vdds_dsi_reg);
>  err1:
>  	omap_dss_stop_device(dssdev);
>  err0:
> @@ -232,6 +245,9 @@ static void dpi_display_disable(struct
> omap_dss_device *dssdev)
> 
>  	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
> 
> +	if (cpu_is_omap34xx())
> +		regulator_disable(dpi.vdds_dsi_reg);
> +
>  	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
> 
>  	omap_dss_stop_device(dssdev);
> @@ -251,6 +267,9 @@ static int dpi_display_suspend(struct
> omap_dss_device *dssdev)
> 
>  	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
> 
> +	if (cpu_is_omap34xx())
> +		regulator_disable(dpi.vdds_dsi_reg);
> +
>  	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
> 
>  	return 0;
> @@ -258,11 +277,19 @@ static int dpi_display_suspend(struct
> omap_dss_device *dssdev)
> 
>  static int dpi_display_resume(struct omap_dss_device *dssdev)
>  {
> +	int r;
> +
>  	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED)
>  		return -EINVAL;
> 
>  	DSSDBG("dpi_display_resume\n");
> 
> +	if (cpu_is_omap34xx()) {
> +		r = regulator_enable(dpi.vdds_dsi_reg);
> +		if (r)
> +			goto err0;
> +	}
> +
>  	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
> 
>  	dispc_enable_lcd_out(1);
> @@ -273,6 +300,8 @@ static int dpi_display_resume(struct
> omap_dss_device *dssdev)
>  	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> 
>  	return 0;
> +err0:
> +	return r;
[Hiremath, Vaibhav] if we initialize r = 0; and jump here in case of error, we can just use 

return r;

Or return from there itself 

if (cpu_is_omap34xx()) {
	r = regulator_enable(dpi.vdds_dsi_reg);
	if (r)
		return r;


Thanks,
Vaibhav

>  }
> 
>  static void dpi_set_timings(struct omap_dss_device *dssdev,
> @@ -388,8 +417,16 @@ int dpi_init_display(struct omap_dss_device
> *dssdev)
>  	return 0;
>  }
> 
> -int dpi_init(void)
> +int dpi_init(struct platform_device *pdev)
>  {
> +	if (cpu_is_omap34xx()) {
> +		dpi.vdds_dsi_reg = dss_get_vdds_dsi();
> +		if (IS_ERR(dpi.vdds_dsi_reg)) {
> +			DSSERR("can't get VDDS_DSI regulator\n");
> +			return PTR_ERR(dpi.vdds_dsi_reg);
> +		}
> +	}
> +
>  	return 0;
>  }
> 
> diff --git a/drivers/video/omap2/dss/dsi.c
> b/drivers/video/omap2/dss/dsi.c
> index 6122178..036f422 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -3799,7 +3799,7 @@ int dsi_init(struct platform_device *pdev)
>  		goto err1;
>  	}
> 
> -	dsi.vdds_dsi_reg = regulator_get(&pdev->dev, "vdds_dsi");
> +	dsi.vdds_dsi_reg = dss_get_vdds_dsi();
>  	if (IS_ERR(dsi.vdds_dsi_reg)) {
>  		iounmap(dsi.base);
>  		DSSERR("can't get VDDS_DSI regulator\n");
> @@ -3830,8 +3830,6 @@ void dsi_exit(void)
>  {
>  	kthread_stop(dsi.thread);
> 
> -	regulator_put(dsi.vdds_dsi_reg);
> -
>  	iounmap(dsi.base);
> 
>  	DSSDBG("omap_dsi_exit\n");
> diff --git a/drivers/video/omap2/dss/dss.h
> b/drivers/video/omap2/dss/dss.h
> index 2bcb124..41145af 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -169,6 +169,9 @@ unsigned long dss_clk_get_rate(enum dss_clock
> clk);
>  int dss_need_ctx_restore(void);
>  void dss_dump_clocks(struct seq_file *s);
>  struct bus_type *dss_get_bus(void);
> +struct regulator *dss_get_vdds_dsi(void);
> +struct regulator *dss_get_vdds_sdi(void);
> +struct regulator *dss_get_vdda_dac(void);
> 
>  /* display */
>  int dss_suspend_all_devices(void);
> @@ -261,7 +264,7 @@ void dsi_get_overlay_fifo_thresholds(enum
> omap_plane plane,
>  		u32 *fifo_low, u32 *fifo_high);
> 
>  /* DPI */
> -int dpi_init(void);
> +int dpi_init(struct platform_device *pdev);
>  void dpi_exit(void);
>  int dpi_init_display(struct omap_dss_device *dssdev);
> 
> diff --git a/drivers/video/omap2/dss/venc.c
> b/drivers/video/omap2/dss/venc.c
> index 749a5a0..44b4998 100644
> --- a/drivers/video/omap2/dss/venc.c
> +++ b/drivers/video/omap2/dss/venc.c
> @@ -482,7 +482,7 @@ int venc_init(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
> 
> -	venc.vdda_dac_reg = regulator_get(&pdev->dev, "vdda_dac");
> +	venc.vdda_dac_reg = dss_get_vdda_dac();
>  	if (IS_ERR(venc.vdda_dac_reg)) {
>  		iounmap(venc.base);
>  		DSSERR("can't get VDDA_DAC regulator\n");
> @@ -503,8 +503,6 @@ void venc_exit(void)
>  {
>  	omap_dss_unregister_driver(&venc_driver);
> 
> -	regulator_put(venc.vdda_dac_reg);
> -
>  	iounmap(venc.base);
>  }
> 
> --
> 1.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
