From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 16/21] OMAPDSS: handle output-driver reg/unreg more dynamically
Date: Thu, 8 Mar 2012 14:04:05 +0530
Message-ID: <4F586EFD.1020208@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com> <1331124290-6285-17-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47319 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab2CHIeW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 03:34:22 -0500
In-Reply-To: <1331124290-6285-17-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 07 March 2012 06:14 PM, Tomi Valkeinen wrote:
> Initialize and uninitialize the output drivers by using arrays of
> pointers to the init/uninit functions. This simplifies the code
> slightly.
>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/core.c |  111 +++++++++++++++++++++-------------------
>   drivers/video/omap2/dss/dss.h  |   41 ---------------
>   2 files changed, 59 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index 654962a..ac4f2cb 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -503,10 +503,54 @@ static int omap_dss_bus_register(void)
>   }
>
>   /* INIT */
> +static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
> +#ifdef CONFIG_OMAP2_DSS_DPI
> +	dpi_init_platform_driver,
> +#endif
> +#ifdef CONFIG_OMAP2_DSS_SDI
> +	sdi_init_platform_driver,
> +#endif
> +#ifdef CONFIG_OMAP2_DSS_RFBI
> +	rfbi_init_platform_driver,
> +#endif
> +#ifdef CONFIG_OMAP2_DSS_VENC
> +	venc_init_platform_driver,
> +#endif
> +#ifdef CONFIG_OMAP2_DSS_DSI
> +	dsi_init_platform_driver,
> +#endif
> +#ifdef CONFIG_OMAP4_DSS_HDMI
> +	hdmi_init_platform_driver,
> +#endif
> +};
> +
> +static void (*dss_output_drv_unreg_funcs[])(void) __exitdata = {
> +#ifdef CONFIG_OMAP2_DSS_DPI
> +	dpi_uninit_platform_driver,
> +#endif
> +#ifdef CONFIG_OMAP2_DSS_SDI
> +	sdi_uninit_platform_driver,
> +#endif
> +#ifdef CONFIG_OMAP2_DSS_RFBI
> +	rfbi_uninit_platform_driver,
> +#endif
> +#ifdef CONFIG_OMAP2_DSS_VENC
> +	venc_uninit_platform_driver,
> +#endif
> +#ifdef CONFIG_OMAP2_DSS_DSI
> +	dsi_uninit_platform_driver,
> +#endif
> +#ifdef CONFIG_OMAP4_DSS_HDMI
> +	hdmi_uninit_platform_driver,
> +#endif
> +};
> +
> +static bool dss_output_drv_loaded[ARRAY_SIZE(dss_output_drv_reg_funcs)];
>
>   static int __init omap_dss_register_drivers(void)
>   {
>   	int r;
> +	int i;
>
>   	r = platform_driver_probe(&omap_dss_driver, omap_dss_probe);
>   	if (r)
> @@ -524,56 +568,18 @@ static int __init omap_dss_register_drivers(void)
>   		goto err_dispc;
>   	}
>
> -	r = dpi_init_platform_driver();
> -	if (r) {
> -		DSSERR("Failed to initialize dpi platform driver\n");
> -		goto err_dpi;
> -	}
> -
> -	r = sdi_init_platform_driver();
> -	if (r) {
> -		DSSERR("Failed to initialize sdi platform driver\n");
> -		goto err_sdi;
> -	}
> -
> -	r = rfbi_init_platform_driver();
> -	if (r) {
> -		DSSERR("Failed to initialize rfbi platform driver\n");
> -		goto err_rfbi;
> -	}
> -
> -	r = venc_init_platform_driver();
> -	if (r) {
> -		DSSERR("Failed to initialize venc platform driver\n");
> -		goto err_venc;
> -	}
> -
> -	r = dsi_init_platform_driver();
> -	if (r) {
> -		DSSERR("Failed to initialize DSI platform driver\n");
> -		goto err_dsi;
> -	}
> -
> -	r = hdmi_init_platform_driver();
> -	if (r) {
> -		DSSERR("Failed to initialize hdmi\n");
> -		goto err_hdmi;
> +	/*
> +	 * It's ok if the output-driver register fails. It happens, for example,
> +	 * when there is no output-device (e.g. SDI for OMAP4).
> +	 */

Suppose we do a omap2plus_defconfig, CONFIG_OMAP2_DSS_SDI would be 
selected, and sdi.c would be built, if we boot on OMAP4, why would a sdi 
driver register cause a failure? Wouldn't the sdi driver just get 
registered, and wait till eternity for the corresponding sdi platform 
device to get registered?

Archit

> +	for (i = 0; i<  ARRAY_SIZE(dss_output_drv_reg_funcs); ++i) {
> +		r = dss_output_drv_reg_funcs[i]();
> +		if (r == 0)
> +			dss_output_drv_loaded[i] = true;
>   	}
>
>   	return 0;
>
> -err_hdmi:
> -	dsi_uninit_platform_driver();
> -err_dsi:
> -	venc_uninit_platform_driver();
> -err_venc:
> -	rfbi_uninit_platform_driver();
> -err_rfbi:
> -	sdi_uninit_platform_driver();
> -err_sdi:
> -	dpi_uninit_platform_driver();
> -err_dpi:
> -	dispc_uninit_platform_driver();
>   err_dispc:
>   	dss_uninit_platform_driver();
>   err_dss:
> @@ -584,12 +590,13 @@ err_dss:
>
>   static void __exit omap_dss_unregister_drivers(void)
>   {
> -	hdmi_uninit_platform_driver();
> -	dsi_uninit_platform_driver();
> -	venc_uninit_platform_driver();
> -	rfbi_uninit_platform_driver();
> -	sdi_uninit_platform_driver();
> -	dpi_uninit_platform_driver();
> +	int i;
> +
> +	for (i = 0; i<  ARRAY_SIZE(dss_output_drv_unreg_funcs); ++i) {
> +		if (dss_output_drv_loaded[i])
> +			dss_output_drv_unreg_funcs[i]();
> +	}
> +
>   	dispc_uninit_platform_driver();
>   	dss_uninit_platform_driver();
>
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 24aadde..af7bed1 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -265,14 +265,9 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
>   		struct dispc_clock_info *dispc_cinfo);
>
>   /* SDI */
> -#ifdef CONFIG_OMAP2_DSS_SDI
>   int sdi_init_platform_driver(void);
>   void sdi_uninit_platform_driver(void);
>   int sdi_init_display(struct omap_dss_device *display);
> -#else
> -static inline int sdi_init_platform_driver(void) { return 0; }
> -static inline void sdi_uninit_platform_driver(void) { }
> -#endif
>
>   /* DSI */
>   #ifdef CONFIG_OMAP2_DSS_DSI
> @@ -309,13 +304,6 @@ void dsi_wait_pll_hsdiv_dispc_active(struct platform_device *dsidev);
>   void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev);
>   struct platform_device *dsi_get_dsidev_from_id(int module);
>   #else
> -static inline int dsi_init_platform_driver(void)
> -{
> -	return 0;
> -}
> -static inline void dsi_uninit_platform_driver(void)
> -{
> -}
>   static inline int dsi_runtime_get(struct platform_device *dsidev)
>   {
>   	return 0;
> @@ -372,14 +360,9 @@ static inline struct platform_device *dsi_get_dsidev_from_id(int module)
>   #endif
>
>   /* DPI */
> -#ifdef CONFIG_OMAP2_DSS_DPI
>   int dpi_init_platform_driver(void);
>   void dpi_uninit_platform_driver(void);
>   int dpi_init_display(struct omap_dss_device *dssdev);
> -#else
> -static inline int dpi_init_platform_driver(void) { return 0; }
> -static inline void dpi_uninit_platform_driver(void) { }
> -#endif
>
>   /* DISPC */
>   int dispc_init_platform_driver(void);
> @@ -456,13 +439,6 @@ void venc_dump_regs(struct seq_file *s);
>   int venc_init_display(struct omap_dss_device *display);
>   unsigned long venc_get_pixel_clock(void);
>   #else
> -static inline int venc_init_platform_driver(void)
> -{
> -	return 0;
> -}
> -static inline void venc_uninit_platform_driver(void)
> -{
> -}
>   static inline unsigned long venc_get_pixel_clock(void)
>   {
>   	WARN("%s: VENC not compiled in, returning pclk as 0\n", __func__);
> @@ -482,13 +458,6 @@ static inline int hdmi_init_display(struct omap_dss_device *dssdev)
>   {
>   	return 0;
>   }
> -static inline int hdmi_init_platform_driver(void)
> -{
> -	return 0;
> -}
> -static inline void hdmi_uninit_platform_driver(void)
> -{
> -}
>   static inline unsigned long hdmi_get_pixel_clock(void)
>   {
>   	WARN("%s: HDMI not compiled in, returning pclk as 0\n", __func__);
> @@ -506,20 +475,10 @@ int hdmi_panel_init(void);
>   void hdmi_panel_exit(void);
>
>   /* RFBI */
> -#ifdef CONFIG_OMAP2_DSS_RFBI
>   int rfbi_init_platform_driver(void);
>   void rfbi_uninit_platform_driver(void);
>   void rfbi_dump_regs(struct seq_file *s);
>   int rfbi_init_display(struct omap_dss_device *display);
> -#else
> -static inline int rfbi_init_platform_driver(void)
> -{
> -	return 0;
> -}
> -static inline void rfbi_uninit_platform_driver(void)
> -{
> -}
> -#endif
>
>
>   #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS

