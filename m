From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 04/10] Input: ams_delta_serio: Replace power GPIO with
 regulator
Date: Thu, 21 Jun 2018 17:09:02 -0700
Message-ID: <20180622000902.GC79890@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-4-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621224128.17623-4-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, "David S . Miller " <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 22, 2018 at 12:41:22AM +0200, Janusz Krzysztofik wrote:
> Modify the driver so it no longer requests and manipulates the
> "keybrd_pwr" GPIO pin but a "vcc" regulator supply instead.
> 
> For this to work with Amstrad Delta, define a regulator over the
> "keybrd_pwr" GPIO pin with the "vcc" supply for ams-delta-serio device
> and register it from the board file.  Both assign an absulute GPIO
> number to the soon depreciated .gpio member of the regulator config
> structure, and also build and register a GPIO lookup table so it is
> ready for use by the regulator driver as soon as its upcoming update
> is applied.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Input bits look good.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Changelog:
> v2: - extended comment above error code conversion, thanks Dmitry for 
>       requesting that,
>     - rebased on v4.18-rc1, no conflicts.
> 
>  arch/arm/mach-omap1/board-ams-delta.c | 63 +++++++++++++++++++++++++++++++++--
>  drivers/input/serio/ams_delta_serio.c | 37 +++++++++++++++-----
>  2 files changed, 89 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 2119d2d3ba84..706eb2f9301d 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -509,6 +509,46 @@ static struct platform_device ams_delta_serio_device = {
>  	.id		= PLATFORM_DEVID_NONE,
>  };
>  
> +static struct regulator_consumer_supply keybrd_pwr_consumers[] = {
> +	/*
> +	 * Initialize supply .dev_name with NULL.  It will be replaced
> +	 * with serio dev_name() as soon as the serio device is registered.
> +	 */
> +	REGULATOR_SUPPLY("vcc", NULL),
> +};
> +
> +static struct regulator_init_data keybrd_pwr_initdata = {
> +	.constraints		= {
> +		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(keybrd_pwr_consumers),
> +	.consumer_supplies	= keybrd_pwr_consumers,
> +};
> +
> +static struct fixed_voltage_config keybrd_pwr_config = {
> +	.supply_name		= "keybrd_pwr",
> +	.microvolts		= 5000000,
> +	.gpio			= AMS_DELTA_GPIO_PIN_KEYBRD_PWR,
> +	.enable_high		= 1,
> +	.init_data		= &keybrd_pwr_initdata,
> +};
> +
> +static struct platform_device keybrd_pwr_device = {
> +	.name	= "reg-fixed-voltage",
> +	.id	= PLATFORM_DEVID_AUTO,
> +	.dev	= {
> +		.platform_data	= &keybrd_pwr_config,
> +	},
> +};
> +
> +static struct gpiod_lookup_table keybrd_pwr_gpio_table = {
> +	.table = {
> +		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_PWR, NULL,
> +			    GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +
>  static struct platform_device *ams_delta_devices[] __initdata = {
>  	&latch1_gpio_device,
>  	&latch2_gpio_device,
> @@ -526,6 +566,7 @@ static struct platform_device *late_devices[] __initdata = {
>  
>  static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
>  	&ams_delta_audio_gpio_table,
> +	&keybrd_pwr_gpio_table,
>  };
>  
>  static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
> @@ -566,12 +607,30 @@ static void __init ams_delta_init(void)
>  	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
>  
>  	/*
> -	 * As soon as devices have been registered, assign their dev_names
> -	 * to respective GPIO lookup tables before they are added.
> +	 * As soon as regulator consumers have been registered, assign their
> +	 * dev_names to consumer supply entries of respective regulators.
> +	 */
> +	keybrd_pwr_consumers[0].dev_name =
> +			dev_name(&ams_delta_serio_device.dev);
> +
> +	/*
> +	 * Once consumer supply entries are populated with dev_names,
> +	 * register regulator devices.  At this stage only the keyboard
> +	 * power regulator has its consumer supply table fully populated.
> +	 */
> +	platform_device_register(&keybrd_pwr_device);
> +
> +	/*
> +	 * As soon as GPIO consumers have been registered, assign
> +	 * their dev_names to respective GPIO lookup tables.
>  	 */
>  	ams_delta_audio_gpio_table.dev_id =
>  			dev_name(&ams_delta_audio_device.dev);
> +	keybrd_pwr_gpio_table.dev_id = dev_name(&keybrd_pwr_device.dev);
>  
> +	/*
> +	 * Once GPIO lookup tables are populated with dev_names, register them.
> +	 */
>  	gpiod_add_lookup_tables(ams_delta_gpio_tables,
>  				ARRAY_SIZE(ams_delta_gpio_tables));
>  
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index 551a4fa73fe4..854d0d3ada52 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -23,6 +23,7 @@
>  #include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/serio.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -39,6 +40,7 @@ MODULE_LICENSE("GPL");
>  
>  struct ams_delta_serio {
>  	struct serio *serio;
> +	struct regulator *vcc;
>  };
>  
>  static int check_data(struct serio *serio, int data)
> @@ -94,16 +96,18 @@ static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
>  
>  static int ams_delta_serio_open(struct serio *serio)
>  {
> -	/* enable keyboard */
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_KEYBRD_PWR, 1);
> +	struct ams_delta_serio *priv = serio->port_data;
>  
> -	return 0;
> +	/* enable keyboard */
> +	return regulator_enable(priv->vcc);
>  }
>  
>  static void ams_delta_serio_close(struct serio *serio)
>  {
> +	struct ams_delta_serio *priv = serio->port_data;
> +
>  	/* disable keyboard */
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_KEYBRD_PWR, 0);
> +	regulator_disable(priv->vcc);
>  }
>  
>  static const struct gpio ams_delta_gpios[] __initconst_or_module = {
> @@ -117,11 +121,6 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
>  		.flags	= GPIOF_DIR_IN,
>  		.label	= "serio-clock",
>  	},
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_PWR,
> -		.flags	= GPIOF_OUT_INIT_LOW,
> -		.label	= "serio-power",
> -	},
>  	{
>  		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATAOUT,
>  		.flags	= GPIOF_OUT_INIT_LOW,
> @@ -146,6 +145,26 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  		goto serio;
>  	}
>  
> +	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
> +	if (IS_ERR(priv->vcc)) {
> +		err = PTR_ERR(priv->vcc);
> +		dev_err(&pdev->dev, "regulator request failed (%d)\n", err);
> +		/*
> +		 * When running on a non-dt platform and requested regulator
> +		 * is not available, devm_regulator_get() never returns
> +		 * -EPROBE_DEFER as it is not able to justify if the regulator
> +		 * may still appear later.  On the other hand, the board can
> +		 * still set full constriants flag at late_initcall in order
> +		 * to instruct devm_regulator_get() to returnn a dummy one
> +		 * if sufficient.  Hence, if we get -ENODEV here, let's convert
> +		 * it to -EPROBE_DEFER and wait for the board to decide or
> +		 * let Deferred Probe infrastructure handle this error.
> +		 */
> +		if (err == -ENODEV)
> +			err = -EPROBE_DEFER;
> +		goto gpio;
> +	}
> +
>  	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
>  			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
>  			DRIVER_NAME, priv);
> -- 
> 2.16.4
> 

-- 
Dmitry
