From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] gpio: omap: cleanup: get rid of system GPIO <-> GPIO
 offset converseations
Date: Thu, 19 Mar 2015 16:00:25 -0700
Message-ID: <20150319230025.GO31346@atomide.com>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: grygorii.strashko@linaro.org
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

* grygorii.strashko@linaro.org <grygorii.strashko@linaro.org> [150319 10:26]:
> From: Grygorii Strashko <grygorii.strashko@linaro.org>
> 
> Now in TI OMAP GPIO driver there are a lot of places where
> System GPIO number calculated and then converted to GPIO offset.
> What is worse is that in many place such conversation performed twice
> or even three times. But actually, we don't need to do that at all, because
> - gpiolib always passes GPIO offset to GPIO controller
> - OMAP GPIO driver converted to use IRQ domain, so
>   struct irq_data->hwirq contains GPIO offset
> 
> Hence, it is safe to convert all GPIO OMAP functions to use GPIO
> offset instead of system GPIO numbers. Also, this allows to remove
> unneeded conversations routines
>  #define GPIO_INDEX(bank, gpio)
>  #define GPIO_BIT(bank, gpio)
>  int omap_irq_to_gpio()

Right on! This is excellent news. I've tested this set on top of -rc4
plus the patch mentioned below, and I'm not seeing regressions on
the platforms I tested with. Wake up to smsc911x ping with off-idle
still works on omap3.

I only briefly tested on omap1 (osk5912), so I'like to wait for
Aaro's ack before this gets merged.

I found one build error, other than that, for the whole series
please feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
 
> Tested on dra7-evm.
> 
> Last two patches have to be tested on OMAP1:
> -  gpio: omap: get rid of omap_irq_to_gpio()
> -  gpio: omap: get rid of GPIO_INDEX() macro
> 
> Based on top of Linux 4.0-rc4 plus patch
> '[PATCH 1/2] gpio: omap: irq_shutdown: remove unnecessary call of gpiochip_unlock_as_irq'
> http://www.spinics.net/lists/linux-omap/msg116482.html
> 
> Grygorii Strashko (8):
>   gpio: omap: convert omap_gpio_is_input() to use gpio offset
>   gpio: omap: simplify omap_set_gpio_dataout_x()
>   gpio: omap: convert debounce functions switch to use gpio offset
>   gpio: omap: drop 'gpio' param from omap_gpio_init_irq()
>   gpio: omap: convert gpio irq functions to use GPIO offset
>   gpio: omap: get rid of GPIO_BIT() macro
>   gpio: omap: get rid of omap_irq_to_gpio()
>   gpio: omap: get rid of GPIO_INDEX() macro
> 
>  drivers/gpio/gpio-omap.c | 130 ++++++++++++++++++++---------------------------
>  1 file changed, 55 insertions(+), 75 deletions(-)
> 
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
