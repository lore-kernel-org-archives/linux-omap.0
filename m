From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [GIT PULL] OMAP DSS for v3.4
Date: Wed, 21 Mar 2012 18:48:54 +0000
Message-ID: <4F6A2296.10400@gmx.de>
References: <1332154865.2144.57.camel@deskari> <1332333553.2236.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:39373 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751849Ab2CUStU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 14:49:20 -0400
In-Reply-To: <1332333553.2236.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>

On 03/21/2012 12:39 PM, Tomi Valkeinen wrote:
> From 849c07b1fd3d9f23e8ed94436b6221f8652462c0 Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Mon, 19 Mar 2012 15:05:02 +0200
> Subject: [PATCH] OMAPDSS: register dss drivers in module init
> 
> We do the dss driver registration in a rather strange way: we have the
> higher level omapdss driver, and we use that driver's probe function to
> register the drivers for the rest of the dss devices.
> 
> There doesn't seem to be any reason for that, and additionally the
> soon-to-be-merged patch "ARM: OMAP: omap_device: remove
> omap_device_parent" will break omapdss initialization with the current
> registration model.
> 
> This patch changes the registration for all drivers to happen at the
> same place, in the init of the module.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/omap2/dss/core.c |  135 +++++++++++++++++++++++-----------------
>  1 files changed, 77 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index 8613f86..e8a1207 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -183,42 +183,6 @@ static int omap_dss_probe(struct platform_device *pdev)
>  	dss_init_overlay_managers(pdev);
>  	dss_init_overlays(pdev);
>  
> -	r = dss_init_platform_driver();
> -	if (r) {
> -		DSSERR("Failed to initialize DSS platform driver\n");
> -		goto err_dss;
> -	}
> -
> -	r = dispc_init_platform_driver();
> -	if (r) {
> -		DSSERR("Failed to initialize dispc platform driver\n");
> -		goto err_dispc;
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
> -	}
> -
>  	r = dss_initialize_debugfs();
>  	if (r)
>  		goto err_debugfs;
> @@ -246,18 +210,6 @@ static int omap_dss_probe(struct platform_device *pdev)
>  err_register:
>  	dss_uninitialize_debugfs();
>  err_debugfs:
> -	hdmi_uninit_platform_driver();
> -err_hdmi:
> -	dsi_uninit_platform_driver();
> -err_dsi:
> -	venc_uninit_platform_driver();
> -err_venc:
> -	dispc_uninit_platform_driver();
> -err_dispc:
> -	rfbi_uninit_platform_driver();
> -err_rfbi:
> -	dss_uninit_platform_driver();
> -err_dss:
>  
>  	return r;
>  }
> @@ -269,13 +221,6 @@ static int omap_dss_remove(struct platform_device *pdev)
>  
>  	dss_uninitialize_debugfs();
>  
> -	hdmi_uninit_platform_driver();
> -	dsi_uninit_platform_driver();
> -	venc_uninit_platform_driver();
> -	rfbi_uninit_platform_driver();
> -	dispc_uninit_platform_driver();
> -	dss_uninit_platform_driver();
> -
>  	dss_uninit_overlays(pdev);
>  	dss_uninit_overlay_managers(pdev);
>  
> @@ -525,6 +470,80 @@ static int omap_dss_bus_register(void)
>  
>  /* INIT */
>  
> +static int __init omap_dss_register_drivers(void)
> +{
> +	int r;
> +
> +	r = platform_driver_register(&omap_dss_driver);
> +	if (r)
> +		return r;
> +
> +	r = dss_init_platform_driver();
> +	if (r) {
> +		DSSERR("Failed to initialize DSS platform driver\n");
> +		goto err_dss;
> +	}
> +
> +	r = dispc_init_platform_driver();
> +	if (r) {
> +		DSSERR("Failed to initialize dispc platform driver\n");
> +		goto err_dispc;
> +	}
> +
> +	r = rfbi_init_platform_driver();
> +	if (r) {
> +		DSSERR("Failed to initialize rfbi platform driver\n");
> +		goto err_rfbi;
> +	}
> +
> +	r = venc_init_platform_driver();
> +	if (r) {
> +		DSSERR("Failed to initialize venc platform driver\n");
> +		goto err_venc;
> +	}
> +
> +	r = dsi_init_platform_driver();
> +	if (r) {
> +		DSSERR("Failed to initialize DSI platform driver\n");
> +		goto err_dsi;
> +	}
> +
> +	r = hdmi_init_platform_driver();
> +	if (r) {
> +		DSSERR("Failed to initialize hdmi\n");
> +		goto err_hdmi;
> +	}
> +
> +	return 0;
> +
> +err_hdmi:
> +	dsi_uninit_platform_driver();
> +err_dsi:
> +	venc_uninit_platform_driver();
> +err_venc:
> +	rfbi_uninit_platform_driver();
> +err_rfbi:
> +	dispc_uninit_platform_driver();
> +err_dispc:
> +	dss_uninit_platform_driver();
> +err_dss:
> +	platform_driver_unregister(&omap_dss_driver);
> +
> +	return r;
> +}
> +
> +static void __exit omap_dss_unregister_drivers(void)
> +{
> +	hdmi_uninit_platform_driver();
> +	dsi_uninit_platform_driver();
> +	venc_uninit_platform_driver();
> +	rfbi_uninit_platform_driver();
> +	dispc_uninit_platform_driver();
> +	dss_uninit_platform_driver();
> +
> +	platform_driver_unregister(&omap_dss_driver);
> +}
> +
>  #ifdef CONFIG_OMAP2_DSS_MODULE
>  static void omap_dss_bus_unregister(void)
>  {
> @@ -541,7 +560,7 @@ static int __init omap_dss_init(void)
>  	if (r)
>  		return r;
>  
> -	r = platform_driver_register(&omap_dss_driver);
> +	r = omap_dss_register_drivers();
>  	if (r) {
>  		omap_dss_bus_unregister();
>  		return r;
> @@ -562,7 +581,7 @@ static void __exit omap_dss_exit(void)
>  		core.vdds_sdi_reg = NULL;
>  	}
>  
> -	platform_driver_unregister(&omap_dss_driver);
> +	omap_dss_unregister_drivers();
>  
>  	omap_dss_bus_unregister();
>  }
> @@ -577,7 +596,7 @@ static int __init omap_dss_init(void)
>  
>  static int __init omap_dss_init2(void)
>  {
> -	return platform_driver_register(&omap_dss_driver);
> +	return omap_dss_register_drivers();
>  }
>  
>  core_initcall(omap_dss_init);

