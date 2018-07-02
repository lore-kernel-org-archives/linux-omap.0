From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 06/10] ARM: OMAP1: ams-delta FIQ: don't use static
 GPIO numbers
Date: Mon, 2 Jul 2018 05:56:23 -0700
Message-ID: <20180702125623.GX112168@atomide.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-6-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621224128.17623-6-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, "David S . Miller " <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180621 22:45]:
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -580,6 +580,44 @@ static struct gpiod_hog ams_delta_gpio_hogs[] = {
>  	{},
>  };
>  
> +/*
> + * Some drivers may not use GPIO lookup tables but need to be provided
> + * with GPIO numbers.  The same applies to GPIO based IRQ lines - some
> + * drivers may even not use GPIO layer but expect just IRQ numbers.
> + * We could either define GPIO lookup tables then use them on behalf
> + * of those devices, or we can use GPIO driver level methods for
> + * identification of GPIO and IRQ numbers. For the purpose of the latter,
> + * defina a helper function which identifies GPIO chips by their labels.
> + */
> +static int gpiochip_match_by_label(struct gpio_chip *chip, void *data)
> +{
> +	char *label = data;
> +
> +	return !strcmp(label, chip->label);
> +}

I left out the duplicate gpiochip_match_by_label() above as it's already
there from an earlier "ARM: OMAP1: ams-delta: assign LED GPIO numbers
from descriptors". The whole series is now pushed out to
omap-for-v4.19/omap1 and I'll merge it into my for-next soon.

Thanks,

Tony
