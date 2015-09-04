From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: omap: Fix GPIO numbering for deferred probe
Date: Fri, 4 Sep 2015 13:00:38 +0300
Message-ID: <55E96BC6.1040003@ti.com>
References: <1441301487-6238-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1441301487-6238-1-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 09/03/2015 08:31 PM, Tony Lindgren wrote:
> If gpio-omap probe fails with -EPROBE_DEFER, the GPIO numbering
> keeps increasing. Only increase the gpio count if gpiochip_add()
> was successful as otherwise the numbers will increase for each
> probe attempt.
>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/gpio/gpio-omap.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1095,7 +1095,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
>   	} else {
>   		bank->chip.label = "gpio";
>   		bank->chip.base = gpio;
> -		gpio += bank->width;
>   	}
>   	bank->chip.ngpio = bank->width;
>
> @@ -1105,6 +1104,9 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
>   		return ret;
>   	}
>
> +	if (!bank->is_mpuio)
> +		gpio += bank->width;
> +
>   #ifdef CONFIG_ARCH_OMAP1
>   	/*
>   	 * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
>

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

With hope that only GPIO0 will be deferred, otherwise
there will be total mess in gpios enumeration ;)

-- 
regards,
-grygorii
