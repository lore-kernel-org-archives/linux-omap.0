From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCHv4] media: i2c/adp1653: devicetree support for adp1653
Date: Fri, 3 Apr 2015 00:18:54 +0200
Message-ID: <CABxcv=nfg_D9HvXUd4PBFJ5a1XST=PCDEZCjkTtbu_u7cc1+ug@mail.gmail.com>
References: <20150402143846.GA11687@amd>
	<20150402203417.GA6336@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150402203417.GA6336@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, pali.rohar@gmail.com, Sebastian Reichel <sre@debian.org>, Sebastian Reichel <sre@ring0.de>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, sakari.ailus@iki.fi, m.chehab@samsung.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Pavel,

I haven't reviewed the patch since I'm not familiar with the hardware
but just wanted to point out a couple of things that I spot:

On Thu, Apr 2, 2015 at 10:34 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
>
> We are moving to device tree support on OMAP3, but that currently
> breaks ADP1653 driver. This adds device tree support, plus required
> documentation.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
> ---
>
> Fixed feedback by Sakari.
>
> Please apply,

There is no need to ask for patches to be applied IMHO. It is expected
that people post patches wanting them to be applied unless there is an
RFC prefix in the subject or say explicitly that the patch is for
testing and should not be picked.

>                                                         Pavel
>
> diff --git a/Documentation/devicetree/bindings/media/i2c/adp1653.txt b/Documentation/devicetree/bindings/media/i2c/adp1653.txt

When adding DT bindings, the Documentation portion should be in a
separate patch and should come in the series before the patch
implementing the binding. That makes the change easier to review,
please take a look to points 1 and 3 in
Documentation/devicetree/bindings/submitting-patches.txt.

> new file mode 100644
> index 0000000..0fc28a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> @@ -0,0 +1,37 @@
> +* Analog Devices ADP1653 flash LED driver
> +
> +Required Properties:
> +
> +  - compatible: Must contain be "adi,adp1653"
> +
> +  - reg: I2C slave address
> +
> +  - gpios: References to the GPIO that controls the power for the chip.

The convention nowadays is to not use unnamed DT properties for GPIOs
but instead use a prefix that explains what those GPIOs are used for.
So something like "power-gpios" or "power-gpio" (if there is only one
GPIO) will be more suitable. Please take a look to
Documentation/gpio/board.txt for more details.

> +
> +There are two led outputs available - flash and indicator. One led is
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
> +       adp1653: led-controller@30 {
> +               compatible = "adi,adp1653";
> +               reg = <0x30>;
> +               gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> +
> +               flash {
> +                       flash-timeout-us = <500000>;
> +                       flash-max-microamp = <320000>;
> +                       max-microamp = <50000>;
> +               };
> +               indicator {
> +                       max-microamp = <17500>;
> +               };
> +       };
> diff --git a/drivers/media/i2c/adp1653.c b/drivers/media/i2c/adp1653.c
> index 873fe19..6d57b16 100644
> --- a/drivers/media/i2c/adp1653.c
> +++ b/drivers/media/i2c/adp1653.c
> @@ -8,6 +8,7 @@
>   * Contributors:
>   *     Sakari Ailus <sakari.ailus@iki.fi>
>   *     Tuukka Toivonen <tuukkat76@gmail.com>
> + *     Pavel Machek <pavel@ucw.cz>
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
> -       int ret;
> +       int ret = 0;
> +
> +       if (flash->platform_data->power) {
> +               ret = flash->platform_data->power(&flash->subdev, on);
> +       } else {
> +               gpio_set_value(flash->platform_data->power_gpio, on);
> +               if (on)
> +                       /* Some delay is apparently required. */
> +                       udelay(20);
> +       }
>
> -       ret = flash->platform_data->power(&flash->subdev, on);
>         if (ret < 0)
>                 return ret;
>
> @@ -316,8 +327,13 @@ __adp1653_set_power(struct adp1653_flash *flash, int on)
>                 return 0;
>
>         ret = adp1653_init_device(flash);
> -       if (ret < 0)
> +       if (ret >= 0)
> +               return ret;
> +
> +       if (flash->platform_data->power)
>                 flash->platform_data->power(&flash->subdev, 0);
> +       else
> +               gpio_set_value(flash->platform_data->power_gpio, 0);
>
>         return ret;
>  }
> @@ -407,21 +423,76 @@ static int adp1653_resume(struct device *dev)
>
>  #endif /* CONFIG_PM */
>
> +static int adp1653_of_init(struct i2c_client *client,
> +                          struct adp1653_flash *flash,
> +                          struct device_node *node)
> +{
> +       u32 val;
> +       struct adp1653_platform_data *pd;
> +       enum of_gpio_flags flags;
> +       struct device_node *child;
> +
> +       if (!node)
> +               return -EINVAL;
> +
> +       pd = devm_kzalloc(&client->dev, sizeof(*pd), GFP_KERNEL);
> +       if (!pd)
> +               return -ENOMEM;
> +       flash->platform_data = pd;
> +
> +       child = of_get_child_by_name(node, "flash");
> +       if (!child)
> +               return -EINVAL;
> +       if (of_property_read_u32(child, "flash-timeout-microsec", &val))
> +               return -EINVAL;
> +
> +       pd->max_flash_timeout = val;
> +       if (of_property_read_u32(child, "flash-max-microamp", &val))
> +               return -EINVAL;
> +       pd->max_flash_intensity = val/1000;
> +
> +       if (of_property_read_u32(child, "max-microamp", &val))
> +               return -EINVAL;
> +       pd->max_torch_intensity = val/1000;
> +
> +       child = of_get_child_by_name(node, "indicator");
> +       if (!child)
> +               return -EINVAL;
> +       if (of_property_read_u32(child, "max-microamp", &val))
> +               return -EINVAL;
> +       pd->max_indicator_intensity = val;
> +
> +       if (!of_find_property(node, "gpios", NULL)) {
> +               dev_err(&client->dev, "No gpio node\n");
> +               return -EINVAL;
> +       }
> +
> +       pd->power_gpio = of_get_gpio_flags(node, 0, &flags);

The old integer-based GPIO interface is deprecated and we want to get
rid of it so please use the descriptor-based for new code. For example
you want to use gpiod_get() instead of of_get_gpio_flags().
Documentation/gpio/gpio.txt describes the new interface.

> +       if (pd->power_gpio < 0) {
> +               dev_err(&client->dev, "Error getting GPIO\n");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +
>  static int adp1653_probe(struct i2c_client *client,
>                          const struct i2c_device_id *devid)
>  {
>         struct adp1653_flash *flash;
>         int ret;
>
> -       /* we couldn't work without platform data */
> -       if (client->dev.platform_data == NULL)
> -               return -ENODEV;
> -
>         flash = devm_kzalloc(&client->dev, sizeof(*flash), GFP_KERNEL);
>         if (flash == NULL)
>                 return -ENOMEM;
>
>         flash->platform_data = client->dev.platform_data;
> +       if (client->dev.of_node) {
> +               ret = adp1653_of_init(client, flash, client->dev.of_node);
> +               if (ret)
> +                       return ret;
> +       }
>
>         mutex_init(&flash->power_lock);
>
> @@ -442,6 +513,7 @@ static int adp1653_probe(struct i2c_client *client,
>         return 0;
>
>  free_and_quit:
> +       dev_err(&client->dev, "adp1653: failed to register device\n");
>         v4l2_ctrl_handler_free(&flash->ctrls);
>         return ret;
>  }
> @@ -464,7 +536,7 @@ static const struct i2c_device_id adp1653_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, adp1653_id_table);
>
> -static struct dev_pm_ops adp1653_pm_ops = {
> +static const struct dev_pm_ops adp1653_pm_ops = {
>         .suspend        = adp1653_suspend,
>         .resume         = adp1653_resume,
>  };
>

Best regards,
Javier
