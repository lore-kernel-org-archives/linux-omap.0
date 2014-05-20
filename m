From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 2/3] OMAPDSS: panel-lgphilips-lb035q02: Add DT support
Date: Tue, 20 May 2014 12:58:11 +0200
Message-ID: <537B3543.2040906@epfl.ch>
References: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com> <1400148637-17726-3-git-send-email-tomi.valkeinen@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:46180 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbaETLEz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 07:04:55 -0400
In-Reply-To: <1400148637-17726-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>

Hi Tomi,

On 05/15/2014 12:10 PM, Tomi Valkeinen wrote:
> Add DT support for panel-lgphilips-lb035q02.
> 
> We disable the use of the backlight_gpio as it should be handled via
> backlight framework with DT boots.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  .../omap2/displays-new/panel-lgphilips-lb035q02.c  | 44 +++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
> index 6e6acd696a70..76c4fdc51c31 100644
> --- a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
> +++ b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
> @@ -159,7 +159,8 @@ static int lb035q02_enable(struct omap_dss_device *dssdev)
>  	if (omapdss_device_is_enabled(dssdev))
>  		return 0;
>  
> -	in->ops.dpi->set_data_lines(in, ddata->data_lines);
> +	if (ddata->data_lines)
> +		in->ops.dpi->set_data_lines(in, ddata->data_lines);
>  	in->ops.dpi->set_timings(in, &ddata->videomode);
>  
>  	r = in->ops.dpi->enable(in);
> @@ -277,6 +278,35 @@ err_gpio:
>  	return r;
>  }
>  
> +static int lb035q02_probe_of(struct spi_device *spi)
> +{
> +	struct device_node *node = spi->dev.of_node;
> +	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
> +	struct omap_dss_device *in;
> +	struct gpio_desc *gpio;
> +
> +	gpio = devm_gpiod_get(&spi->dev, "enable");
> +	if (IS_ERR(gpio)) {
> +		dev_err(&spi->dev, "failed to parse enable gpio\n");
> +		return PTR_ERR(gpio);
> +	} else {
> +		gpiod_direction_output(gpio, 0);
> +		ddata->enable_gpio = gpio;
> +	}
> +
> +	ddata->backlight_gpio = -ENOENT;
> +
> +	in = omapdss_of_find_source_for_first_ep(node);
> +	if (IS_ERR(in)) {
> +		dev_err(&spi->dev, "failed to find video source\n");
> +		return PTR_ERR(in);
> +	}
> +
> +	ddata->in = in;
> +
> +	return 0;
> +}
> +
>  static int lb035q02_panel_spi_probe(struct spi_device *spi)
>  {
>  	struct panel_drv_data *ddata;
> @@ -295,6 +325,10 @@ static int lb035q02_panel_spi_probe(struct spi_device *spi)
>  		r = lb035q02_probe_pdata(spi);
>  		if (r)
>  			return r;
> +	} else if (spi->dev.of_node) {
> +		r = lb035q02_probe_of(spi);
> +		if (r)
> +			return r;
>  	} else {
>  		return -ENODEV;
>  	}
> @@ -346,6 +380,13 @@ static int lb035q02_panel_spi_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id lb035q02_of_match[] = {
> +	{ .compatible = "omapdss,lgphilips,lb035q02", },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, lb035q02_of_match);
> +
>  static struct spi_driver lb035q02_spi_driver = {
>  	.probe		= lb035q02_panel_spi_probe,
>  	.remove		= lb035q02_panel_spi_remove,
> @@ -357,6 +398,7 @@ static struct spi_driver lb035q02_spi_driver = {
>  

		.of_match_table = lb035q02_of_match,

is missing.

>  module_spi_driver(lb035q02_spi_driver);
>  
> +MODULE_ALIAS("spi:lgphilips,lb035q02");
>  MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@ti.com>");
>  MODULE_DESCRIPTION("LG.Philips LB035Q02 LCD Panel driver");
>  MODULE_LICENSE("GPL");
> 

Regards,

Florian
