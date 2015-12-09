From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH 004/182] gpio: generic: factor into gpio_chip struct
Date: Wed, 9 Dec 2015 17:08:52 -0600
Message-ID: <20151209230852.GB28304@deathstar>
References: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Markus Pargmann <mpa@pengutronix.de>, Anton Vorontsov <anton@enomsg.org>, arm@kernel.org, Lee Jones <lee.jones@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexandre Courbot <gnurou@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Olof Johansson <olof@lixom.net>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Rabin Vincent <rabin@>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 09, 2015 at 02:12:40PM +0100, Linus Walleij wrote:
...
> @@ -55,16 +54,16 @@ static int moxart_gpio_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	bgc->gc.label = "moxart-gpio";
> -	bgc->gc.request = gpiochip_generic_request;
> -	bgc->gc.free = gpiochip_generic_free;
> -	bgc->data = bgc->read_reg(bgc->reg_set);
> -	bgc->gc.base = 0;
> -	bgc->gc.ngpio = 32;
> -	bgc->gc.parent = dev;
> -	bgc->gc.owner = THIS_MODULE;
> +	gc->label = "moxart-gpio";
> +	gc->request = gpiochip_generic_request;
> +	gc->free = gpiochip_generic_free;
> +	gc->bgpio_data = bgc->read_reg(bgc->reg_set);
> +	gc->base = 0;
> +	gc->ngpio = 32;
> +	gc->parent = dev;
> +	gc->owner = THIS_MODULE;
>  
> -	ret = gpiochip_add(&bgc->gc);
> +	ret = gpiochip_add_data(gc, NULL);
>  	if (ret) {

gpiochip_add is still mentioned in the dev_err below.

>  		dev_err(dev, "%s: gpiochip_add failed\n",
>  			dev->of_node->full_name);
...

> @@ -226,14 +225,14 @@ static int sdv_gpio_probe(struct pci_dev *pdev,
>  		writel(mux_val, sd->gpio_pub_base + GPMUXCTL);
>  	}
>  
> -	ret = bgpio_init(&sd->bgpio, &pdev->dev, 4,
> +	ret = bgpio_init(&sd->chip, &pdev->dev, 4,
>  			sd->gpio_pub_base + GPINR, sd->gpio_pub_base + GPOUTR,
>  			NULL, sd->gpio_pub_base + GPOER, NULL, 0);
>  	if (ret)
>  		goto unmap;
> -	sd->bgpio.gc.ngpio = SDV_NUM_PUB_GPIOS;
> +	sd->chip.ngpio = SDV_NUM_PUB_GPIOS;
>  
> -	ret = gpiochip_add(&sd->bgpio.gc);
> +	ret = gpiochip_add_data(&sd->chip, sd);
>  	if (ret < 0) {

Also still mentioned here in the dev_err.

>  		dev_err(&pdev->dev, "gpiochip_add() failed.\n");
>  		goto unmap;
...
 
> @@ -201,8 +201,8 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	bgpio_init(mmc_gpio_chip, &pdev->dev, 0x4, base + SYS_MCI,
>  			NULL, NULL, NULL, NULL, 0);

Was going to complain about this one not switching to _data but it was
addressed in a follow up patch.

> -	mmc_gpio_chip->gc.ngpio = 2;
> -	gpiochip_add(&mmc_gpio_chip->gc);
> +	mmc_gpio_chip->ngpio = 2;
> +	gpiochip_add(mmc_gpio_chip);
