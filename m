From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/5] gpiolib: introduce set_debounce method
Date: Fri, 21 May 2010 11:11:36 +0100
Message-ID: <20100521111136.53dba6c9@lxorguk.ukuu.org.uk>
References: <20100520194509.GB10739@sirena.org.uk>
	<598314.1671.qm@web180305.mail.gq1.yahoo.com>
	<20100521064925.GF925@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100521064925.GF925@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: David Brownell <david-b@pacbell.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org


> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index cd85fd1..ed1ed74 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1461,9 +1461,14 @@ int gpio_set_debounce(unsigned gpio, unsigned debounce)
>   
>          spin_lock_irqsave(&gpio_lock, flags);
>   
> +       chip = desc->chip;
> +       if (!(chip->flags & GPIO_FLAG_DEBOUNCE)) {
> +               spin_unlock_irqrestore(&gpio_lock, flags);
> +               return 0;
> +       }
> +

If you add the feature check then presumably someone trying to do
debounce on a port without the feature isn't paying attention so this
should WARN at the very least. Also it shouldn't be a return 0.

This however seems a bit excessive and inconsistent. Every other function
simply returns -EINVAL if the request is unsupported. So not only does it
complicate the code it makes the code inconsistent with its existing
regular behaviour. The initial patch is consistent, regular and follows
expected gpiolib behaviour in all respects.

> that could be used later for adding debounce emulation for chips that 
> doesn't support hw debouncing.

You don't need flags for this - the request will just start working if
someone adds the feature.

GPIO is almost always fairly tightly platform bound so features only
existing on certain ports is fine. The platform vendor will have made
sure they relevant ports have suitable debounce facilities.

Alan
