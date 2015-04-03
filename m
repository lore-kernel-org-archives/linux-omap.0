From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCHv5] media: i2c/adp1653: devicetree support for adp1653
Date: Fri, 3 Apr 2015 14:32:16 +0300
Message-ID: <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
References: <20150402143846.GA11687@amd>
 <20150402203417.GA6336@amd>
 <20150403083353.GA21070@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:46358 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752384AbbDCLcV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 07:32:21 -0400
Content-Disposition: inline
In-Reply-To: <20150403083353.GA21070@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, galak@codeaurora.org, bcousson@baylibre.com, m.chehab@samsung.com, devicetree@vger.kernel.org

Hi Pavel,

Thanks for the update.

On Fri, Apr 03, 2015 at 10:33:53AM +0200, Pavel Machek wrote:
> 
> We are moving to device tree support on OMAP3, but that currently
> breaks ADP1653 driver. This adds device tree support, plus required
> documentation.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>  
> ---
> 
> Switched to gpiod_, as requested by Javier.
> 
> Please apply,

Let's properly review this first.

>   							Pavel
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/adp1653.txt b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> new file mode 100644
> index 0000000..da9934a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/adp1653.txt

Please split this as Javier suggested. I'd think both could go through
the media-tree unless someone objects.

> @@ -0,0 +1,37 @@
> +* Analog Devices ADP1653 flash LED driver
> +
> +Required Properties:
> +
> +  - compatible: Must contain be "adi,adp1653"
> +
> +  - reg: I2C slave address
> +
> +  - power-gpios: Reference to the GPIO that controls the power for the chip.

You're using power-gpios in documentation only.

The spec refers to this by "EN". How about "en-gpios" instead? This
definitely isn't about power, but about resetting the chip. It gets the
power through another pin.

> +
> +There are two LED outputs available - flash and indicator. One LED is
> +represented by one child node, nodes need to be named "flash" and "indicator".
> +
> +Required properties of the LED child node:
> +- max-microamp : see Documentation/devicetree/bindings/leds/common.txt
> +
> +Required properties of the flash LED child node:
> +
> +- flash-max-microamp : see Documentation/devicetree/bindings/leds/common.txt
> +- flash-timeout-us : see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example:
> +
> +	adp1653: led-controller@30 {
> +		compatible = "adi,adp1653";
> +		reg = <0x30>;
> +		power-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> +
> +		flash {
> +			flash-timeout-us = <500000>;
> +			flash-max-microamp = <320000>;
> +			max-microamp = <50000>;
> +		};
> +		indicator {
> +			max-microamp = <17500>;
> +		};
> +	};
> diff --git a/drivers/media/i2c/adp1653.c b/drivers/media/i2c/adp1653.c
> index 873fe19..ba7f43d 100644
> --- a/drivers/media/i2c/adp1653.c
> +++ b/drivers/media/i2c/adp1653.c
> @@ -8,6 +8,7 @@
>   * Contributors:
>   *	Sakari Ailus <sakari.ailus@iki.fi>
>   *	Tuukka Toivonen <tuukkat76@gmail.com>
> + *	Pavel Machek <pavel@ucw.cz>
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
> @@ -34,6 +35,8 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
>  #include <media/adp1653.h>
>  #include <media/v4l2-device.h>
>  
> @@ -306,9 +309,17 @@ adp1653_init_device(struct adp1653_flash *flash)
>  static int
>  __adp1653_set_power(struct adp1653_flash *flash, int on)
>  {
> -	int ret;
> +	int ret = 0;
> +
> +	if (flash->platform_data->power) {
> +		ret = flash->platform_data->power(&flash->subdev, on);
> +	} else {
> +		gpiod_set_value(flash->platform_data->power_gpio, on);
> +		if (on)
> +			/* Some delay is apparently required. */
> +			udelay(20);
> +	}
>  
> -	ret = flash->platform_data->power(&flash->subdev, on);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -316,8 +327,13 @@ __adp1653_set_power(struct adp1653_flash *flash, int on)
>  		return 0;
>  
>  	ret = adp1653_init_device(flash);
> -	if (ret < 0)
> +	if (ret >= 0)
> +		return ret;
> +
> +	if (flash->platform_data->power)
>  		flash->platform_data->power(&flash->subdev, 0);
> +	else
> +		gpiod_set_value(flash->platform_data->power_gpio, 0);
>  
>  	return ret;
>  }
> @@ -407,21 +423,75 @@ static int adp1653_resume(struct device *dev)
>  
>  #endif /* CONFIG_PM */
>  
> +static int adp1653_of_init(struct i2c_client *client,
> +			   struct adp1653_flash *flash,
> +			   struct device_node *node)
> +{
> +	u32 val;
> +	struct adp1653_platform_data *pd;
> +	struct device_node *child;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	pd = devm_kzalloc(&client->dev, sizeof(*pd), GFP_KERNEL);
> +	if (!pd)
> +		return -ENOMEM;
> +	flash->platform_data = pd;
> +
> +	child = of_get_child_by_name(node, "flash");
> +	if (!child)
> +		return -EINVAL;
> +	if (of_property_read_u32(child, "flash-timeout-microsec", &val))
> +		return -EINVAL;
> +
> +	pd->max_flash_timeout = val;
> +	if (of_property_read_u32(child, "flash-max-microamp", &val))
> +		return -EINVAL;
> +	pd->max_flash_intensity = val/1000;
> +
> +	if (of_property_read_u32(child, "max-microamp", &val))
> +		return -EINVAL;
> +	pd->max_torch_intensity = val/1000;

I think you need to do of_node_put(child) here and after you're done with
indicator below.

> +
> +	child = of_get_child_by_name(node, "indicator");
> +	if (!child)
> +		return -EINVAL;
> +	if (of_property_read_u32(child, "max-microamp", &val))
> +		return -EINVAL;
> +	pd->max_indicator_intensity = val;
> +
> +	if (!of_find_property(node, "gpios", NULL)) {
> +		dev_err(&client->dev, "No gpio node\n");
> +		return -EINVAL;
> +	}
> +
> +	pd->power_gpio = devm_gpiod_get(&client->dev, "power");
> +	if (!pd->power_gpio) {
> +		dev_err(&client->dev, "Error getting GPIO\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +
>  static int adp1653_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *devid)
>  {
>  	struct adp1653_flash *flash;
>  	int ret;
>  
> -	/* we couldn't work without platform data */
> -	if (client->dev.platform_data == NULL)
> -		return -ENODEV;
> -
>  	flash = devm_kzalloc(&client->dev, sizeof(*flash), GFP_KERNEL);
>  	if (flash == NULL)
>  		return -ENOMEM;
>  
>  	flash->platform_data = client->dev.platform_data;
> +	if (client->dev.of_node) {
> +		ret = adp1653_of_init(client, flash, client->dev.of_node);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	mutex_init(&flash->power_lock);
>  
> @@ -442,6 +512,7 @@ static int adp1653_probe(struct i2c_client *client,
>  	return 0;
>  
>  free_and_quit:
> +	dev_err(&client->dev, "adp1653: failed to register device\n");
>  	v4l2_ctrl_handler_free(&flash->ctrls);
>  	return ret;
>  }
> @@ -464,7 +535,7 @@ static const struct i2c_device_id adp1653_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, adp1653_id_table);
>  
> -static struct dev_pm_ops adp1653_pm_ops = {
> +static const struct dev_pm_ops adp1653_pm_ops = {
>  	.suspend	= adp1653_suspend,
>  	.resume		= adp1653_resume,
>  };
> diff --git a/include/media/adp1653.h b/include/media/adp1653.h
> index 1d9b48a..34b505e 100644
> --- a/include/media/adp1653.h
> +++ b/include/media/adp1653.h
> @@ -100,9 +100,11 @@ struct adp1653_platform_data {
>  	int (*power)(struct v4l2_subdev *sd, int on);
>  
>  	u32 max_flash_timeout;		/* flash light timeout in us */
> -	u32 max_flash_intensity;	/* led intensity, flash mode */
> -	u32 max_torch_intensity;	/* led intensity, torch mode */
> -	u32 max_indicator_intensity;	/* indicator led intensity */
> +	u32 max_flash_intensity;	/* led intensity, flash mode, mA */
> +	u32 max_torch_intensity;	/* led intensity, torch mode, mA */
> +	u32 max_indicator_intensity;	/* indicator led intensity, uA */
> +
> +	struct gpio_desc *power_gpio;	/* for device-tree based boot */
>  };
>  
>  #define to_adp1653_flash(sd)	container_of(sd, struct adp1653_flash, subdev)
> 

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
