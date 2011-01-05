From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v3 09/17] OMAP2,3: DSS2: Move clocks from core driver
 to dss driver
Date: Wed, 05 Jan 2011 17:35:55 +0200
Message-ID: <1294241755.14254.142.camel@tubuntu>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
	 <1294059069-26737-10-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:27927 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641Ab1AEPgK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 10:36:10 -0500
In-Reply-To: <1294059069-26737-10-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>, "ext Semwal, Sumit" <sumit.semwal@ti.com>
Cc: paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org

On Mon, 2011-01-03 at 18:21 +0530, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> clks are moved to dss platform driver.  clk_get/put APIs use dss device instead
> of core platform device. So the device name is changed from omap_display to
> omap_dss in 2420, 2430, 3xxx clock database files. Now teh core driver
> "omap_display" only takes care of panel registration with the custom bus.
> dss driver would take care of the clocks needed by DISPC, RFBI, DSI, VENC.
> 
> TODO:  The clock content would be adapted to omap_hwmod in a seperate series.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>

<snip>

> @@ -508,14 +192,7 @@ static int omap_dss_probe(struct platform_device *pdev)
>  	dss_init_overlay_managers(pdev);
>  	dss_init_overlays(pdev);
>  
> -	r = dss_get_clocks();
> -	if (r)
> -		goto err_clocks;
> -
> -	dss_clk_enable_all_no_ctx();
> -
> -	core.ctx_id = dss_get_ctx_id();
> -	DSSDBG("initial ctx id %u\n", core.ctx_id);
> +	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
>  
>  #ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
>  	/* DISPC_CONTROL */
> @@ -589,7 +266,7 @@ static int omap_dss_probe(struct platform_device *pdev)
>  			pdata->default_device = dssdev;
>  	}
>  
> -	dss_clk_disable_all();
> +	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);

Why are the calls dss_clk_enable_all_no_ctx() and dss_clk_disable_all()
changed?

>  /* DSS HW IP initialisation */
>  static int omap_dsshw_probe(struct platform_device *pdev)
>  {
> -	return 0;
> +	int r;
> +
> +	dss.pdev = pdev;
> +
> +	r = dss_get_clocks();
> +	if (r)
> +		goto err_clocks;
> +
> +	dss_clk_enable_all_no_ctx();
> +
> +	dss.ctx_id = dss_get_ctx_id();
> +	DSSDBG("initial ctx id %u\n", dss.ctx_id);
> +
> +	dss_clk_disable_all_no_ctx();

I don't think clock enable/disable are needed here. dss_get_ctx_id()
should work fine without DSS's clocks.

 Tomi


