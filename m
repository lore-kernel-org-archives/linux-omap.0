From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 004/182] gpio: generic: factor into gpio_chip struct
Date: Wed, 9 Dec 2015 11:49:50 -0800
Message-ID: <20151209194950.GA23396@atomide.com>
References: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Anton Vorontsov <anton@enomsg.org>, arm@kernel.org, Lee Jones <lee.jones@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexandre Courbot <gnurou@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Olof Johansson <olof@lixom.net>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Rabin Vincent <rab>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [151209 05:14]:
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
...

> ---
> ARM SoC folks and Lee: it would be great if you could
> ACK the few lines hitting arch/arm/* and drivers/mfd/* in this
> so I can take it through the GPIO tree.

For omap:

Acked-by: Tony Lindgren <tony@atomide.com>
