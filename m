From: Hartley Sweeten <HartleyS@visionengravers.com>
Subject: RE: [PATCH 004/182] gpio: generic: factor into gpio_chip struct
Date: Wed, 9 Dec 2015 18:10:41 +0000
Message-ID: <BN3PR0101MB1057B8DA60A1761DA432030AD0E80@BN3PR0101MB1057.prod.exchangelabs.com>
References: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Anton Vorontsov <anton@enomsg.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, Liviu Dudau <liviu.dudau@arm.com>, Lee Jones <lee.jones@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Alexander Shiyan <shc_work@mail.ru>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Gregory Fong <gregory.0xf0@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rabin Vincent <rabin@rab.in>, Kukjin Kim <kgene@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Olof
List-Id: linux-omap@vger.kernel.org

On Wednesday, December 09, 2015 6:13 AM, Linus Walleij wrote:
> The separate struct bgpio_chip has been a pain to handle, both
> by being confusingly similar in name to struct gpio_chip and
> for being contained inside a struct so that struct gpio_chip
> is contained in a struct contained in a struct, making several
> steps of dereferencing necessary.
>
> Make things simpler: include the fields directly into
> <linux/gpio/driver.h>, #ifdef:ed for CONFIG_GENERIC_GPIO, and
> get rid of the <linux/basic_mmio_gpio.h> altogether. Prefix
> some of the member variables with bgpio_* and add proper
> kerneldoc while we're at it.
>
> Modify all users to handle the change and use a struct
> gpio_chip directly. And while we're at it: replace all
> container_of() dereferencing by gpiochip_get_data() and
> registering the gpio_chip with gpiochip_add_data().
>
> Cc: arm@kernel.org
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Gregory Fong <gregory.0xf0@gmail.com>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks and Lee: it would be great if you could
> ACK the few lines hitting arch/arm/* and drivers/mfd/* in this
> so I can take it through the GPIO tree.
> ---

<snip>

> drivers/gpio/gpio-ep93xx.c              |  25 +--

<snip>

> diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
> index 3e3947b35c83..ad279078fed7 100644
> --- a/drivers/gpio/gpio-ep93xx.c
> +++ b/drivers/gpio/gpio-ep93xx.c
> @@ -16,10 +16,11 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> -#include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/slab.h>
> -#include <linux/basic_mmio_gpio.h>
> +#include <linux/gpio/driver.h>
> +/* FIXME: this is here for gpio_to_irq() - get rid of this! */
> +#include <linux/gpio.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/gpio-ep93xx.h>
> @@ -28,7 +29,7 @@
>  
>  struct ep93xx_gpio {
>  	void __iomem		*mmio_base;
> -	struct bgpio_chip	bgc[8];
> +	struct gpio_chip	gc[8];
>  };
>  
>  /*************************************************************************
> @@ -319,26 +320,26 @@ static int ep93xx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
>  	return 64 + gpio;
>  }
>  
> -static int ep93xx_gpio_add_bank(struct bgpio_chip *bgc, struct device *dev,
> +static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
>  	void __iomem *mmio_base, struct ep93xx_gpio_bank *bank)
>  {
>  	void __iomem *data = mmio_base + bank->data;
>  	void __iomem *dir =  mmio_base + bank->dir;
>  	int err;
>  
> -	err = bgpio_init(bgc, dev, 1, data, NULL, NULL, dir, NULL, 0);
> +	err = bgpio_init(gc, dev, 1, data, NULL, NULL, dir, NULL, 0);
>  	if (err)
>  		return err;
>  
> -	bgc->gc.label = bank->label;
> -	bgc->gc.base = bank->base;
> +	gc->label = bank->label;
> +	gc->base = bank->base;
>  
>  	if (bank->has_debounce) {
> -		bgc->gc.set_debounce = ep93xx_gpio_set_debounce;
> -		bgc->gc.to_irq = ep93xx_gpio_to_irq;
> +		gc->set_debounce = ep93xx_gpio_set_debounce;
> +		gc->to_irq = ep93xx_gpio_to_irq;
>  	}
>  
> -	return gpiochip_add(&bgc->gc);
> +	return gpiochip_add_data(gc, NULL);
>  }
>  
>  static int ep93xx_gpio_probe(struct platform_device *pdev)
> @@ -358,10 +359,10 @@ static int ep93xx_gpio_probe(struct platform_device *pdev)
>  		return PTR_ERR(ep93xx_gpio->mmio_base);
>  
>  	for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_banks); i++) {
> -		struct bgpio_chip *bgc = &ep93xx_gpio->bgc[i];
> +		struct gpio_chip *gc = &ep93xx_gpio->gc[i];
>  		struct ep93xx_gpio_bank *bank = &ep93xx_gpio_banks[i];
>  
> -		if (ep93xx_gpio_add_bank(bgc, &pdev->dev,
> +		if (ep93xx_gpio_add_bank(gc, &pdev->dev,
>  					 ep93xx_gpio->mmio_base, bank))
>  			dev_warn(&pdev->dev, "Unable to add gpio bank %s\n",
>  				bank->label);

For the drivers/gpio/gpio-ep93xx.c part:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

