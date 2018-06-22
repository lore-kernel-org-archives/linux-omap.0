From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 02/10] Input: ams_delta_serio: convert to platform
 driver
Date: Thu, 21 Jun 2018 17:05:02 -0700
Message-ID: <20180622000502.GA79890@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621224128.17623-2-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, "David S . Miller " <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 22, 2018 at 12:41:20AM +0200, Janusz Krzysztofik wrote:
> Convert the driver to an "ams-delta-serio" platform driver.  For it to
> be used with Amstrad Delta, register an "ams-delta-serio" platform
> device from the board init file.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
> Changelog:
> v2: rebased on v4.18-rc1, no conflicts

Input bits look good to me.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
>  arch/arm/mach-omap1/board-ams-delta.c |  6 ++++++
>  drivers/input/serio/ams_delta_serio.c | 34 +++++++++++++++++++++-------------
>  2 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 18e0ff437b27..2119d2d3ba84 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -504,12 +504,18 @@ static struct platform_device cx20442_codec_device = {
>  	.id     = -1,
>  };
>  
> +static struct platform_device ams_delta_serio_device = {
> +	.name		= "ams-delta-serio",
> +	.id		= PLATFORM_DEVID_NONE,
> +};
> +
>  static struct platform_device *ams_delta_devices[] __initdata = {
>  	&latch1_gpio_device,
>  	&latch2_gpio_device,
>  	&ams_delta_kp_device,
>  	&ams_delta_camera_device,
>  	&ams_delta_audio_device,
> +	&ams_delta_serio_device,
>  };
>  
>  static struct platform_device *late_devices[] __initdata = {
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index 3df501c3421b..a2a7fa19bf49 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -22,15 +22,17 @@
>   */
>  #include <linux/gpio.h>
>  #include <linux/irq.h>
> +#include <linux/platform_device.h>
>  #include <linux/serio.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  
> -#include <asm/mach-types.h>
>  #include <mach/board-ams-delta.h>
>  
>  #include <mach/ams-delta-fiq.h>
>  
> +#define DRIVER_NAME	"ams-delta-serio"
> +
>  MODULE_AUTHOR("Matt Callow");
>  MODULE_DESCRIPTION("AMS Delta (E3) keyboard port driver");
>  MODULE_LICENSE("GPL");
> @@ -126,13 +128,10 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
>  	},
>  };
>  
> -static int __init ams_delta_serio_init(void)
> +static int ams_delta_serio_init(struct platform_device *pdev)
>  {
>  	int err;
>  
> -	if (!machine_is_ams_delta())
> -		return -ENODEV;
> -
>  	ams_delta_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
>  	if (!ams_delta_serio)
>  		return -ENOMEM;
> @@ -142,22 +141,22 @@ static int __init ams_delta_serio_init(void)
>  	ams_delta_serio->close = ams_delta_serio_close;
>  	strlcpy(ams_delta_serio->name, "AMS DELTA keyboard adapter",
>  			sizeof(ams_delta_serio->name));
> -	strlcpy(ams_delta_serio->phys, "GPIO/serio0",
> +	strlcpy(ams_delta_serio->phys, dev_name(&pdev->dev),
>  			sizeof(ams_delta_serio->phys));
> +	ams_delta_serio->dev.parent = &pdev->dev;
>  
>  	err = gpio_request_array(ams_delta_gpios,
>  				ARRAY_SIZE(ams_delta_gpios));
>  	if (err) {
> -		pr_err("ams_delta_serio: Couldn't request gpio pins\n");
> +		dev_err(&pdev->dev, "Couldn't request gpio pins\n");
>  		goto serio;
>  	}
>  
>  	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
>  			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
> -			"ams-delta-serio", 0);
> +			DRIVER_NAME, 0);
>  	if (err < 0) {
> -		pr_err("ams_delta_serio: couldn't request gpio interrupt %d\n",
> -				gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));
> +		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
>  		goto gpio;
>  	}
>  	/*
> @@ -179,13 +178,22 @@ static int __init ams_delta_serio_init(void)
>  	kfree(ams_delta_serio);
>  	return err;
>  }
> -module_init(ams_delta_serio_init);
>  
> -static void __exit ams_delta_serio_exit(void)
> +static int ams_delta_serio_exit(struct platform_device *pdev)
>  {
>  	serio_unregister_port(ams_delta_serio);
>  	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
>  	gpio_free_array(ams_delta_gpios,
>  			ARRAY_SIZE(ams_delta_gpios));
> +
> +	return 0;
>  }
> -module_exit(ams_delta_serio_exit);
> +
> +static struct platform_driver ams_delta_serio_driver = {
> +	.probe	= ams_delta_serio_init,
> +	.remove	= ams_delta_serio_exit,
> +	.driver	= {
> +		.name	= DRIVER_NAME
> +	},
> +};
> +module_platform_driver(ams_delta_serio_driver);
> -- 
> 2.16.4
> 

-- 
Dmitry
