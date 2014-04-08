From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
Date: Mon, 7 Apr 2014 17:13:39 -0700
Message-ID: <20140408001339.GA15842@atomide.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33876 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbaDHANt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2014 20:13:49 -0400
Content-Disposition: inline
In-Reply-To: <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>

Tomi,

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140121 03:01]:
> Add DT support for panel-dpi.

Looks like this patch did not get merged or am I missing
something?

As you probably are aware, we have at least these boards
needing it before we can remove the omap3 legacy support:

board-am3517evm.c
board-cm-t35.c
board-devkit8000.c
board-ldp.c
board-overo.c

We could probably set the display timings based on the
compatible flag in the driver if that's an issue?

And then board-omap3pandora.c also needs support for
panel_tpo_td043mtea1_platform_data.
 
Regards,

Tony

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/displays-new/panel-dpi.c | 64 +++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/omap2/displays-new/panel-dpi.c b/drivers/video/omap2/displays-new/panel-dpi.c
> index 5f8f7e7c81ef..b032daf0f407 100644
> --- a/drivers/video/omap2/displays-new/panel-dpi.c
> +++ b/drivers/video/omap2/displays-new/panel-dpi.c
> @@ -13,9 +13,12 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  
>  #include <video/omapdss.h>
>  #include <video/omap-panel-data.h>
> +#include <video/of_display_timing.h>
>  
>  struct panel_drv_data {
>  	struct omap_dss_device dssdev;
> @@ -70,7 +73,8 @@ static int panel_dpi_enable(struct omap_dss_device *dssdev)
>  	if (omapdss_device_is_enabled(dssdev))
>  		return 0;
>  
> -	in->ops.dpi->set_data_lines(in, ddata->data_lines);
> +	if (ddata->data_lines)
> +		in->ops.dpi->set_data_lines(in, ddata->data_lines);
>  	in->ops.dpi->set_timings(in, &ddata->videomode);
>  
>  	r = in->ops.dpi->enable(in);
> @@ -182,6 +186,52 @@ static int panel_dpi_probe_pdata(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int panel_dpi_probe_of(struct platform_device *pdev)
> +{
> +	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct device_node *node = pdev->dev.of_node;
> +	struct omap_dss_device *in;
> +	int r;
> +	struct display_timing timing;
> +	struct videomode vm;
> +	int gpio;
> +
> +	gpio = of_get_gpio(node, 0);
> +	if (gpio_is_valid(gpio) || gpio == -ENOENT) {
> +		ddata->enable_gpio = gpio;
> +	} else {
> +		dev_err(&pdev->dev, "failed to parse enable gpio\n");
> +		return gpio;
> +	}
> +
> +	gpio = of_get_gpio(node, 1);
> +	if (gpio_is_valid(gpio) || gpio == -ENOENT) {
> +		ddata->backlight_gpio = gpio;
> +	} else {
> +		dev_err(&pdev->dev, "failed to parse backlight gpio\n");
> +		return gpio;
> +	}
> +
> +	r = of_get_display_timing(node, "panel-timing", &timing);
> +	if (r) {
> +		dev_err(&pdev->dev, "failed to get video timing\n");
> +		return r;
> +	}
> +
> +	videomode_from_timing(&timing, &vm);
> +	videomode_to_omap_video_timings(&vm, &ddata->videomode);
> +
> +	in = omapdss_of_find_source_for_first_ep(node);
> +	if (IS_ERR(in)) {
> +		dev_err(&pdev->dev, "failed to find video source\n");
> +		return PTR_ERR(in);
> +	}
> +
> +	ddata->in = in;
> +
> +	return 0;
> +}
> +
>  static int panel_dpi_probe(struct platform_device *pdev)
>  {
>  	struct panel_drv_data *ddata;
> @@ -198,6 +248,10 @@ static int panel_dpi_probe(struct platform_device *pdev)
>  		r = panel_dpi_probe_pdata(pdev);
>  		if (r)
>  			return r;
> +	} else if (pdev->dev.of_node) {
> +		r = panel_dpi_probe_of(pdev);
> +		if (r)
> +			return r;
>  	} else {
>  		return -ENODEV;
>  	}
> @@ -254,12 +308,20 @@ static int __exit panel_dpi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id panel_dpi_of_match[] = {
> +	{ .compatible = "omapdss,panel-dpi", },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, panel_dpi_of_match);
> +
>  static struct platform_driver panel_dpi_driver = {
>  	.probe = panel_dpi_probe,
>  	.remove = __exit_p(panel_dpi_remove),
>  	.driver = {
>  		.name = "panel-dpi",
>  		.owner = THIS_MODULE,
> +		.of_match_table = panel_dpi_of_match,
>  	},
>  };
>  
> -- 
> 1.8.3.2
> 
