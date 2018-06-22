From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 09/10] Input: ams_delta_serio: use IRQ resource
Date: Thu, 21 Jun 2018 17:11:24 -0700
Message-ID: <20180622001124.GF79890@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-9-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621224128.17623-9-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, "David S . Miller " <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 22, 2018 at 12:41:27AM +0200, Janusz Krzysztofik wrote:
> The driver still obtains IRQ number from a hardcoded GPIO.  Use IRQ
> resource instead.
> 
> For this to work on Amstrad Delta, add the IRQ resource to
> ams-delta-serio platform device structure.  Obtain the IRQ number
> assigned to "keybrd_clk" GPIO pin from FIQ initialization routine.
> 
> As a benefit, the driver no longer needs to include
> <mach/board-ams-delta.h>.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Input bits look good.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Changelog:
> v2: - obsolete assignment of handle_simple_irq() removed from the driver
>       and replaced with a comment in the FIQ init file,
>     - rebased on v4.18-rc1, no conflicts.
> 
>  arch/arm/mach-omap1/ams-delta-fiq.c   | 20 +++++++++++++++++++-
>  arch/arm/mach-omap1/ams-delta-fiq.h   |  3 ++-
>  arch/arm/mach-omap1/board-ams-delta.c | 17 ++++++++++++++++-
>  drivers/input/serio/ams_delta_serio.c | 32 +++++++++-----------------------
>  4 files changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
> index e72935034d42..82ca4246a5e4 100644
> --- a/arch/arm/mach-omap1/ams-delta-fiq.c
> +++ b/arch/arm/mach-omap1/ams-delta-fiq.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/platform_data/ams-delta-fiq.h>
> +#include <linux/platform_device.h>
>  
>  #include <mach/board-ams-delta.h>
>  
> @@ -84,7 +85,8 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -void __init ams_delta_init_fiq(struct gpio_chip *chip)
> +void __init ams_delta_init_fiq(struct gpio_chip *chip,
> +			       struct platform_device *serio)
>  {
>  	struct gpio_desc *gpiod, *data = NULL, *clk = NULL;
>  	void *fiqhandler_start;
> @@ -201,6 +203,22 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
>  	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
>  	omap_writel(val, OMAP_IH1_BASE + offset);
>  
> +	/* Initialize serio device IRQ resource */
> +	serio->resource[0].start = gpiod_to_irq(clk);
> +	serio->resource[0].end = serio->resource[0].start;
> +
> +	/*
> +	 * Since FIQ handler performs handling of GPIO registers for
> +	 * "keybrd_clk" IRQ pin, ams_delta_serio driver used to set
> +	 * handle_simple_irq() as active IRQ handler for that pin to avoid
> +	 * bad interaction with gpio-omap driver.  This is no longer needed
> +	 * as handle_simple_irq() is now the default handler for OMAP GPIO
> +	 * edge interrupts.
> +	 * This comment replaces the obsolete code which has been removed
> +	 * from the ams_delta_serio driver and stands here only as a reminder
> +	 * of that dependency on gpio-omap driver behavior.
> +	 */
> +
>  	return;
>  
>  out_gpio:
> diff --git a/arch/arm/mach-omap1/ams-delta-fiq.h b/arch/arm/mach-omap1/ams-delta-fiq.h
> index 3f691d68aa62..fd76df3cce37 100644
> --- a/arch/arm/mach-omap1/ams-delta-fiq.h
> +++ b/arch/arm/mach-omap1/ams-delta-fiq.h
> @@ -35,7 +35,8 @@
>  #ifndef __ASSEMBLER__
>  extern unsigned char qwerty_fiqin_start, qwerty_fiqin_end;
>  
> -extern void __init ams_delta_init_fiq(struct gpio_chip *chip);
> +extern void __init ams_delta_init_fiq(struct gpio_chip *chip,
> +				      struct platform_device *pdev);
>  #endif
>  
>  #endif
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index fe9a3e7cbfeb..84177ba3e39a 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -504,9 +504,24 @@ static struct platform_device cx20442_codec_device = {
>  	.id     = -1,
>  };
>  
> +static struct resource ams_delta_serio_resources[] = {
> +	{
> +		.flags	= IORESOURCE_IRQ,
> +		/*
> +		 * Initialize IRQ resource with invalid IRQ number.
> +		 * It will be replaced with dynamically allocated GPIO IRQ
> +		 * obtained from GPIO chip as soon as the chip is available.
> +		 */
> +		.start	= -EINVAL,
> +		.end	= -EINVAL,
> +	},
> +};
> +
>  static struct platform_device ams_delta_serio_device = {
>  	.name		= "ams-delta-serio",
>  	.id		= PLATFORM_DEVID_NONE,
> +	.num_resources	= ARRAY_SIZE(ams_delta_serio_resources),
> +	.resource	= ams_delta_serio_resources,
>  };
>  
>  static struct regulator_consumer_supply keybrd_pwr_consumers[] = {
> @@ -615,7 +630,7 @@ static void __init omap_gpio_deps_init(void)
>  		return;
>  	}
>  
> -	ams_delta_init_fiq(chip);
> +	ams_delta_init_fiq(chip, &ams_delta_serio_device);
>  }
>  
>  static void __init ams_delta_init(void)
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index 2602f7cff5ae..c1f8226f172e 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -20,7 +20,6 @@
>   * However, when used with the E3 mailboard that producecs non-standard
>   * scancodes, a custom key table must be prepared and loaded from userspace.
>   */
> -#include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/platform_data/ams-delta-fiq.h>
>  #include <linux/platform_device.h>
> @@ -29,8 +28,6 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  
> -#include <mach/board-ams-delta.h>
> -
>  #define DRIVER_NAME	"ams-delta-serio"
>  
>  MODULE_AUTHOR("Matt Callow");
> @@ -113,7 +110,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  {
>  	struct ams_delta_serio *priv;
>  	struct serio *serio;
> -	int err;
> +	int irq, err;
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -139,26 +136,20 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
> -			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
> -			DRIVER_NAME, priv);
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -ENXIO;
> +
> +	err = devm_request_irq(&pdev->dev, irq, ams_delta_serio_interrupt,
> +			       IRQ_TYPE_EDGE_RISING, DRIVER_NAME, priv);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
>  		return err;
>  	}
> -	/*
> -	 * Since GPIO register handling for keyboard clock pin is performed
> -	 * at FIQ level, switch back from edge to simple interrupt handler
> -	 * to avoid bad interaction.
> -	 */
> -	irq_set_handler(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
> -			handle_simple_irq);
>  
>  	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
> -	if (!serio) {
> -		err = -ENOMEM;
> -		goto irq;
> -	}
> +	if (!serio)
> +		return -ENOMEM;
>  
>  	priv->serio = serio;
>  
> @@ -177,10 +168,6 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  	dev_info(&serio->dev, "%s\n", serio->name);
>  
>  	return 0;
> -
> -irq:
> -	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), priv);
> -	return err;
>  }
>  
>  static int ams_delta_serio_exit(struct platform_device *pdev)
> @@ -188,7 +175,6 @@ static int ams_delta_serio_exit(struct platform_device *pdev)
>  	struct ams_delta_serio *priv = platform_get_drvdata(pdev);
>  
>  	serio_unregister_port(priv->serio);
> -	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
>  
>  	return 0;
>  }
> -- 
> 2.16.4
> 

-- 
Dmitry
