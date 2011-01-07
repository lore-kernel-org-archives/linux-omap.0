From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 09/17] OMAP2,3: DSS2: DSS: create platform_driver, move init,exit to driver
Date: Fri, 07 Jan 2011 15:43:30 -0800
Message-ID: <87fwt4i8kd.fsf@ti.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
	<1294399551-10457-10-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54242 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751711Ab1AGXne (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 18:43:34 -0500
Received: by pzk37 with SMTP id 37so4307965pzk.12
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 15:43:34 -0800 (PST)
In-Reply-To: <1294399551-10457-10-git-send-email-sumit.semwal@ti.com> (Sumit
	Semwal's message of "Fri, 7 Jan 2011 16:55:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Sumit Semwal <sumit.semwal@ti.com> writes:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>
> Hwmod adaptation design requires each of the DSS HW IP to be a platform driver.
> So a platform_driver of DSS is created and init exit methods are moved from core.c
> to its driver probe,remove. pdev member has to be maintained by its own drivers.
>
> DSS platform driver is registered from inside omap_dss_probe, in the order desired.
>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> ---
>  drivers/video/omap2/dss/core.c |   21 +++++++--------
>  drivers/video/omap2/dss/dss.c  |   55 ++++++++++++++++++++++++++++++++++++++-
>  drivers/video/omap2/dss/dss.h  |    4 +-
>  3 files changed, 65 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index 48d20d8..faca859 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -497,9 +497,9 @@ static inline void dss_uninitialize_debugfs(void)
>  static int omap_dss_probe(struct platform_device *pdev)
>  {
>  	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
> -	int skip_init = 0;
>  	int r;
>  	int i;
> +	int skip_init = 0;

looks like unnessary move.

maybe you meant to remove this var since its usage was removed from this
function?

>  	core.pdev = pdev;
>  
> @@ -517,15 +517,9 @@ static int omap_dss_probe(struct platform_device *pdev)
>  	core.ctx_id = dss_get_ctx_id();
>  	DSSDBG("initial ctx id %u\n", core.ctx_id);
>  
> -#ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
> -	/* DISPC_CONTROL */
> -	if (omap_readl(0x48050440) & 1)	/* LCD enabled? */
> -		skip_init = 1;
> -#endif
> -
> -	r = dss_init(skip_init);
> +	r = dss_init_platform_driver();
>  	if (r) {
> -		DSSERR("Failed to initialize DSS\n");
> +		DSSERR("Failed to initialize DSS platform driver\n");
>  		goto err_dss;
>  	}
>  
> @@ -553,6 +547,11 @@ static int omap_dss_probe(struct platform_device *pdev)
>  		goto err_venc;
>  	}
>  
> +#ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
> +	/* DISPC_CONTROL */
> +	if (omap_readl(0x48050440) & 1)	/* LCD enabled? */
> +		skip_init = 1;
> +#endif

nope, you just moved it here.  

But it's also duplicated in dsshw_probe below.  Is that needed?

>  	if (cpu_is_omap34xx()) {
>  		r = sdi_init(skip_init);
>  		if (r) {
> @@ -610,7 +609,7 @@ err_dispc:
>  err_dpi:
>  	rfbi_exit();
>  err_rfbi:
> -	dss_exit();
> +	dss_deinit_platform_driver();

s/deinit/uninit/ or uninitial
>  err_dss:
>  	dss_clk_disable_all_no_ctx();
>  	dss_put_clocks();
> @@ -636,7 +635,7 @@ static int omap_dss_remove(struct platform_device *pdev)
>  		sdi_exit();
>  	}
>  
> -	dss_exit();
> +	dss_deinit_platform_driver();
>  
>  	/* these should be removed at some point */
>  	c = core.dss_ick->usecount;
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 77c3621..ebb294a 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -59,6 +59,7 @@ struct dss_reg {
>  	dss_write_reg(idx, FLD_MOD(dss_read_reg(idx), val, start, end))
>  
>  static struct {
> +	struct platform_device *pdev;
>  	void __iomem    *base;
>  
>  	struct clk	*dpll4_m4_ck;
> @@ -549,7 +550,7 @@ void dss_set_dac_pwrdn_bgz(bool enable)
>  	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
>  }
>  
> -int dss_init(bool skip_init)
> +static int dss_init(bool skip_init)
>  {
>  	int r;
>  	u32 rev;
> @@ -629,7 +630,7 @@ fail0:
>  	return r;
>  }
>  
> -void dss_exit(void)
> +static void dss_exit(void)
>  {
>  	if (cpu_is_omap34xx())
>  		clk_put(dss.dpll4_m4_ck);
> @@ -639,3 +640,53 @@ void dss_exit(void)
>  	iounmap(dss.base);
>  }
>  
> +/* DSS HW IP initialisation */
> +static int omap_dsshw_probe(struct platform_device *pdev)
> +{
> +	int r;
> +	int skip_init = 0;
> +
> +	dss.pdev = pdev;
> +
> +#ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
> +	/* DISPC_CONTROL */
> +	if (omap_readl(0x48050440) & 1)	/* LCD enabled? */
> +		skip_init = 1;
> +#endif
> +
> +	r = dss_init(skip_init);
> +	if (r) {
> +		DSSERR("Failed to initialize DSS\n");
> +		goto err_dss;
> +	}
> +
> +err_dss:
> +
> +	return r;
> +}
> +
> +static int omap_dsshw_remove(struct platform_device *pdev)
> +{
> +	dss_exit();
> +
> +	return 0;
> +}
> +
> +static struct platform_driver omap_dsshw_driver = {
> +	.probe          = omap_dsshw_probe,
> +	.remove         = omap_dsshw_remove,
> +	.driver         = {
> +		.name   = "omap_dss",
> +		.owner  = THIS_MODULE,
> +	},
> +};
> +
> +int dss_init_platform_driver(void)
> +{
> +	return platform_driver_register(&omap_dsshw_driver);
> +}
> +
> +void dss_deinit_platform_driver(void)
> +{
> +	return platform_driver_unregister(&omap_dsshw_driver);
> +}

Is there a reason for these extra functions?

Why can't the platform_driver APIs be called directly?

> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 5c7940d..50b4223 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -214,8 +214,8 @@ void dss_overlay_setup_l4_manager(struct omap_overlay_manager *mgr);
>  void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
>  
>  /* DSS */
> -int dss_init(bool skip_init);
> -void dss_exit(void);
> +int dss_init_platform_driver(void);
> +void dss_deinit_platform_driver(void);
>  
>  void dss_save_context(void);
>  void dss_restore_context(void);
