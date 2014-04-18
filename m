From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
Date: Fri, 18 Apr 2014 08:51:08 -0700
Message-ID: <20140418155107.GB5354@atomide.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37305 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbaDRPvQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 11:51:16 -0400
Content-Disposition: inline
In-Reply-To: <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Joachim Eastwood <manabian@gmail.com>

Hi,

Just trying to summarize what has been discussed so far in
various threads regarding changes needed to this patch.

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140121 03:01]:
> --- a/drivers/video/omap2/displays-new/panel-dpi.c
> +++ b/drivers/video/omap2/displays-new/panel-dpi.c
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

We should set the GPIO polarity based on the OF_GPIO_ACTIVE_LOW like
gpio_backlight_probe_dt is doing. 

Then do we really want to do the dev_err for each -EPROBE_DEFER here?

> +	gpio = of_get_gpio(node, 1);
> +	if (gpio_is_valid(gpio) || gpio == -ENOENT) {
> +		ddata->backlight_gpio = gpio;
> +	} else {
> +		dev_err(&pdev->dev, "failed to parse backlight gpio\n");
> +		return gpio;
> +	}

How about let's drop the backlight_gpio as discussed since it
can be handled with gpio-backlight?

Instead, let's add the panel specific reset_gpio as suggested by
Joachim. That seems common to some dpi using panels.

Then support for the other panel specific GPIOs can then be added
as a follow-up patch when we know how we want to handle them.

Oh, and this patch needs the related binding documentation too in
Documentation/devicetree/bindings.

Regards,

Tony
