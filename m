From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 27/33] OMAPDSS: n8x0 panel: handle gpio data in panel
 driver
Date: Wed, 13 Feb 2013 19:35:27 +0200
Message-ID: <20130213173527.GE21750@blackmetal.musicnaut.iki.fi>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
 <1360765345-19312-28-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:40384 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760123Ab3BMRfb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 12:35:31 -0500
Content-Disposition: inline
In-Reply-To: <1360765345-19312-28-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Wed, Feb 13, 2013 at 07:52:19PM +0530, Archit Taneja wrote:
> @@ -444,6 +445,20 @@ static int n8x0_panel_probe(struct omap_dss_device *dssdev)
>  	dssdev->ctrl.rfbi_timings = n8x0_panel_timings;
>  	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
>  
> +	if (gpio_is_valid(bdata->panel_reset)) {
> +		r = devm_gpio_request_one(&dssdev->dev, bdata->panel_reset,
> +				GPIOF_OUT_INIT_LOW, "PANEL RESET");
> +		if (r)
> +			return r;
> +	}
> +
> +	if (gpio_is_valid(bdata->ctrl_pwrdown)) {
> +		r = devm_gpio_request_one(&dssdev->dev, bdata->ctrl_pwrdown,
> +				GPIOF_OUT_INIT_LOW, "PANEL PWRDOWN");
> +		if (r)
> +			return r;
> +	}
> +

In the error case, the other GPIO is not freed. Also maybe you should
free them on module removal, because now the module owns the GPIOs.

A.
