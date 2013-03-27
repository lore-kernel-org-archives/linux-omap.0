From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 16/26] OMAPDSS: TFP410: convert to platform device
Date: Wed, 27 Mar 2013 16:41:36 +0530
Message-ID: <5152D3E8.9040603@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com> <1364304836-18134-17-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34701 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307Ab3C0LMX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 07:12:23 -0400
In-Reply-To: <1364304836-18134-17-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday 26 March 2013 07:03 PM, Tomi Valkeinen wrote:
> Convert TFP410 driver from omap_dss_driver to a platform driver. The
> driver uses the new panel support from omapdss.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/displays/panel-tfp410.c |  205 +++++++++++++++++----------
>   1 file changed, 128 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
> index 8281baa..a225ea1 100644
> --- a/drivers/video/omap2/displays/panel-tfp410.c
> +++ b/drivers/video/omap2/displays/panel-tfp410.c
> @@ -22,10 +22,13 @@
>   #include <video/omapdss.h>
>   #include <linux/i2c.h>
>   #include <linux/gpio.h>
> +#include <linux/platform_device.h>
>   #include <drm/drm_edid.h>
>
>   #include <video/omap-panel-tfp410.h>
>
> +static struct omap_dss_driver tfp410_driver;
> +
>   static const struct omap_video_timings tfp410_default_timings = {
>   	.x_res		= 640,
>   	.y_res		= 480,
> @@ -48,121 +51,152 @@ static const struct omap_video_timings tfp410_default_timings = {
>   };
>
>   struct panel_drv_data {
> -	struct omap_dss_device *dssdev;
> +	struct omap_dss_device dssdev;
>
>   	struct mutex lock;
>
> +	const char *name;
> +
>   	int pd_gpio;
> +	int data_lines;
> +
> +	struct omap_video_timings timings;
>
>   	struct i2c_adapter *i2c_adapter;
>   };
>
> -static int tfp410_power_on(struct omap_dss_device *dssdev)
> +#define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
> +
> +static int tfp410_probe_pdata(struct platform_device *pdev)
>   {
> -	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
> -	int r;
> +	struct tfp410_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(&pdev->dev);
> +	int r, gpio, i2c_bus_num;
>
> -	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
> -		return 0;
> +	ddata->name = pdata->name;
>
> -	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
> -	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
> +	gpio = pdata->power_down_gpio;
>
> -	r = omapdss_dpi_display_enable(dssdev);
> -	if (r)
> -		goto err0;
> +	if (gpio_is_valid(gpio)) {
> +		r = devm_gpio_request_one(&pdev->dev, gpio,
> +				GPIOF_OUT_INIT_LOW, "tfp410 pd");
> +		if (r) {
> +			dev_err(&pdev->dev, "Failed to request PD GPIO %d\n",
> +					gpio);
> +			return r;
> +		}
>
> -	if (gpio_is_valid(ddata->pd_gpio))
> -		gpio_set_value_cansleep(ddata->pd_gpio, 1);
> +		ddata->pd_gpio = gpio;
> +	} else {
> +		ddata->pd_gpio = -1;
> +	}
>
> -	return 0;
> -err0:
> -	return r;
> -}
> +	ddata->data_lines = pdata->data_lines;
>
> -static void tfp410_power_off(struct omap_dss_device *dssdev)
> -{
> -	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
> +	i2c_bus_num = pdata->i2c_bus_num;
>
> -	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
> -		return;
> +	if (i2c_bus_num != -1) {
> +		struct i2c_adapter *adapter;
>
> -	if (gpio_is_valid(ddata->pd_gpio))
> -		gpio_set_value_cansleep(ddata->pd_gpio, 0);
> +		adapter = i2c_get_adapter(i2c_bus_num);
> +		if (!adapter) {
> +			dev_err(&pdev->dev,
> +					"Failed to get I2C adapter, bus %d\n",
> +					i2c_bus_num);
> +			return -EINVAL;
> +		}
>
> -	omapdss_dpi_display_disable(dssdev);
> +		ddata->i2c_adapter = adapter;
> +	}
> +
> +	return 0;
>   }
>
> -static int tfp410_probe(struct omap_dss_device *dssdev)
> +static int tfp410_probe(struct platform_device *pdev)
>   {
> +	struct tfp410_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct omap_dss_device *dssdev;
>   	struct panel_drv_data *ddata;
>   	int r;
> -	int i2c_bus_num;
>
> -	ddata = devm_kzalloc(&dssdev->dev, sizeof(*ddata), GFP_KERNEL);
> +	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
>   	if (!ddata)
>   		return -ENOMEM;
>
> -	dssdev->panel.timings = tfp410_default_timings;
> +	dev_set_drvdata(&pdev->dev, ddata);
>
> -	ddata->dssdev = dssdev;
>   	mutex_init(&ddata->lock);
>
> -	if (dssdev->data) {
> -		struct tfp410_platform_data *pdata = dssdev->data;
> -
> -		ddata->pd_gpio = pdata->power_down_gpio;
> -		i2c_bus_num = pdata->i2c_bus_num;
> -	} else {
> -		ddata->pd_gpio = -1;
> -		i2c_bus_num = -1;
> -	}
> -
> -	if (gpio_is_valid(ddata->pd_gpio)) {
> -		r = devm_gpio_request_one(&dssdev->dev, ddata->pd_gpio,
> -				GPIOF_OUT_INIT_LOW, "tfp410 pd");
> -		if (r) {
> -			dev_err(&dssdev->dev, "Failed to request PD GPIO %d\n",
> -					ddata->pd_gpio);
> +	if (pdata) {
> +		r = tfp410_probe_pdata(pdev);
> +		if (r)
>   			return r;
> -		}
> +	} else {
> +		return -ENODEV;
>   	}
>
> -	if (i2c_bus_num != -1) {
> -		struct i2c_adapter *adapter;
> +	ddata->timings = tfp410_default_timings;
>
> -		adapter = i2c_get_adapter(i2c_bus_num);
> -		if (!adapter) {
> -			dev_err(&dssdev->dev, "Failed to get I2C adapter, bus %d\n",
> -					i2c_bus_num);
> -			return -EINVAL;
> -		}
> -
> -		ddata->i2c_adapter = adapter;
> +	dssdev = &ddata->dssdev;
> +	dssdev->driver = &tfp410_driver;
> +	dssdev->panel.timings = tfp410_default_timings;
> +	dssdev->name = ddata->name;
> +	dssdev->phy.dpi.data_lines = ddata->data_lines;
> +	dssdev->panel_dev = &pdev->dev;

Some of the omap_dss_device fields populated here(like data_lines) are 
not going to be used anywhere. Are you populating all of them just for 
the sake of clarity, so that they can be removed in another series later 
on? Or is there some other reason?

Archit

> +
> +	r = omap_dpi_register_panel(dssdev);
> +	if (r) {
> +		dev_err(&pdev->dev, "Failed to register panel\n");
> +		return r;
>   	}
>
> -	dev_set_drvdata(&dssdev->dev, ddata);
> -
>   	return 0;
>   }
>
> -static void __exit tfp410_remove(struct omap_dss_device *dssdev)
> +static int __exit tfp410_remove(struct platform_device *pdev)
>   {
> -	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(&pdev->dev);
>
>   	mutex_lock(&ddata->lock);
>
> +	omap_dpi_free_panel(&ddata->dssdev);
> +
>   	if (ddata->i2c_adapter)
>   		i2c_put_adapter(ddata->i2c_adapter);
>
> -	dev_set_drvdata(&dssdev->dev, NULL);
> +	dev_set_drvdata(&pdev->dev, NULL);
>
>   	mutex_unlock(&ddata->lock);
> +
> +	return 0;
> +}
> +
> +static int tfp410_power_on(struct omap_dss_device *dssdev)
> +{
> +	struct panel_drv_data *ddata = to_panel_data(dssdev);
> +	int r;
> +
> +	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
> +		return 0;
> +
> +	omapdss_dpi_set_timings(dssdev, &ddata->timings);
> +	omapdss_dpi_set_data_lines(dssdev, ddata->data_lines);
> +
> +	r = omapdss_dpi_display_enable(dssdev);
> +	if (r)
> +		goto err0;
> +
> +	if (gpio_is_valid(ddata->pd_gpio))
> +		gpio_set_value_cansleep(ddata->pd_gpio, 1);
> +
> +	return 0;
> +err0:
> +	return r;
>   }
>
>   static int tfp410_enable(struct omap_dss_device *dssdev)
>   {
> -	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
> +	struct panel_drv_data *ddata = to_panel_data(dssdev);
>   	int r;
>
>   	mutex_lock(&ddata->lock);
> @@ -176,9 +210,22 @@ static int tfp410_enable(struct omap_dss_device *dssdev)
>   	return r;
>   }
>
> +static void tfp410_power_off(struct omap_dss_device *dssdev)
> +{
> +	struct panel_drv_data *ddata = to_panel_data(dssdev);
> +
> +	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
> +		return;
> +
> +	if (gpio_is_valid(ddata->pd_gpio))
> +		gpio_set_value_cansleep(ddata->pd_gpio, 0);
> +
> +	omapdss_dpi_display_disable(dssdev);
> +}
> +
>   static void tfp410_disable(struct omap_dss_device *dssdev)
>   {
> -	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
> +	struct panel_drv_data *ddata = to_panel_data(dssdev);
>
>   	mutex_lock(&ddata->lock);
>
> @@ -192,18 +239,19 @@ static void tfp410_disable(struct omap_dss_device *dssdev)
>   static void tfp410_set_timings(struct omap_dss_device *dssdev,
>   		struct omap_video_timings *timings)
>   {
> -	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
> +	struct panel_drv_data *ddata = to_panel_data(dssdev);
>
>   	mutex_lock(&ddata->lock);
>   	omapdss_dpi_set_timings(dssdev, timings);
>   	dssdev->panel.timings = *timings;
> +	ddata->timings = *timings;
>   	mutex_unlock(&ddata->lock);
>   }
>
>   static void tfp410_get_timings(struct omap_dss_device *dssdev,
>   		struct omap_video_timings *timings)
>   {
> -	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
> +	struct panel_drv_data *ddata = to_panel_data(dssdev);
>
>   	mutex_lock(&ddata->lock);
>   	*timings = dssdev->panel.timings;
> @@ -213,7 +261,7 @@ static void tfp410_get_timings(struct omap_dss_device *dssdev,
>   static int tfp410_check_timings(struct omap_dss_device *dssdev,
>   		struct omap_video_timings *timings)
>   {
> -	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
> +	struct panel_drv_data *ddata = to_panel_data(dssdev);
>   	int r;
>
>   	mutex_lock(&ddata->lock);
> @@ -258,7 +306,7 @@ static int tfp410_ddc_read(struct i2c_adapter *adapter,
>   static int tfp410_read_edid(struct omap_dss_device *dssdev,
>   		u8 *edid, int len)
>   {
> -	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
> +	struct panel_drv_data *ddata = to_panel_data(dssdev);
>   	int r, l, bytes_read;
>
>   	mutex_lock(&ddata->lock);
> @@ -298,7 +346,7 @@ err:
>
>   static bool tfp410_detect(struct omap_dss_device *dssdev)
>   {
> -	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
> +	struct panel_drv_data *ddata = to_panel_data(dssdev);
>   	unsigned char out;
>   	int r;
>
> @@ -319,9 +367,6 @@ out:
>   }
>
>   static struct omap_dss_driver tfp410_driver = {
> -	.probe		= tfp410_probe,
> -	.remove		= __exit_p(tfp410_remove),
> -
>   	.enable		= tfp410_enable,
>   	.disable	= tfp410_disable,
>
> @@ -329,23 +374,29 @@ static struct omap_dss_driver tfp410_driver = {
>   	.get_timings	= tfp410_get_timings,
>   	.check_timings	= tfp410_check_timings,
>
> +	.get_resolution	= omapdss_default_get_resolution,
> +
>   	.read_edid	= tfp410_read_edid,
>   	.detect		= tfp410_detect,
> +};
>
> -	.driver         = {
> -		.name   = "tfp410",
> -		.owner  = THIS_MODULE,
> +static struct platform_driver tfp410_platform_driver = {
> +	.probe	= tfp410_probe,
> +	.remove	= __exit_p(tfp410_remove),
> +	.driver	= {
> +		.name	= "tfp410",
> +		.owner	= THIS_MODULE,
>   	},
>   };
>
>   static int __init tfp410_init(void)
>   {
> -	return omap_dss_register_driver(&tfp410_driver);
> +	return platform_driver_register(&tfp410_platform_driver);
>   }
>
>   static void __exit tfp410_exit(void)
>   {
> -	omap_dss_unregister_driver(&tfp410_driver);
> +	platform_driver_unregister(&tfp410_platform_driver);
>   }
>
>   module_init(tfp410_init);
>

