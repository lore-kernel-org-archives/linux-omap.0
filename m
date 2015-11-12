From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: omap: fix debounce time calculation
Date: Thu, 12 Nov 2015 20:05:41 +0200
Message-ID: <5644D4F5.8070006@ti.com>
References: <1447350640-20347-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1447350640-20347-1-git-send-email-balbi@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/12/2015 07:50 PM, Felipe Balbi wrote:
> According to TRM, debounce is measured in periods of
> the functional clock of the GPIO IP. This means that


What TRM? link pls.

http://www.ti.com/lit/ug/spruhl7d/spruhl7d.pdf

28.4.1.24 GPIO_DEBOUNCINGTIME Register (offset = 154h) [reset = 0h]

The GPIO_DEBOUNCINGTIME register controls debouncing time (the value is
global for all ports). The debouncing cell is running with the
debouncing clock (32 kHz), this register represents the number of the
clock cycle(s) (31 s long) to be used.

Debouncing Value in 31 microsecond steps.
Debouncing Value = (DEBOUNCETIME + 1) * 31 microseconds.

> we should divide by the rate of functional clock.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>   drivers/gpio/gpio-omap.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 56d2d026e62e..2b29fd195521 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -217,15 +217,29 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
>   	u32			val;
>   	u32			l;
>   	bool			enable = !!debounce;
> +	unsigned long		flags;
>   
>   	if (!bank->dbck_flag)
>   		return;
>   
>   	if (enable) {
> -		debounce = DIV_ROUND_UP(debounce, 31) - 1;
> +		struct clk	*clk;
> +		unsigned long	rate;
> +
> +		clk = clk_get(bank->dev, "fck");
> +		if (IS_ERR(clk)) {
> +			dev_err(bank->dev, "can't get clock\n");
> +			return;
> +		}
> +
> +		rate = clk_get_rate(clk);
> +		clk_put(clk);
> +
> +		debounce = DIV_ROUND_UP(debounce, rate);
>   		debounce &= OMAP4_GPIO_DEBOUNCINGTIME_MASK;
>   	}
>   
> +	raw_spin_lock_irqsave(&bank->lock, flags);
>   	l = BIT(offset);
>   
>   	clk_enable(bank->dbck);
> @@ -256,6 +270,7 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
>   		bank->context.debounce = debounce;
>   		bank->context.debounce_en = val;
>   	}
> +	raw_spin_unlock_irqrestore(&bank->lock, flags);
>   }
>   
>   /**
> @@ -1002,14 +1017,9 @@ static int omap_gpio_output(struct gpio_chip *chip, unsigned offset, int value)
>   static int omap_gpio_debounce(struct gpio_chip *chip, unsigned offset,
>   			      unsigned debounce)
>   {
> -	struct gpio_bank *bank;
> -	unsigned long flags;
> -
> -	bank = container_of(chip, struct gpio_bank, chip);
> +	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
>   
> -	raw_spin_lock_irqsave(&bank->lock, flags);
>   	omap2_set_gpio_debounce(bank, offset, debounce);
> -	raw_spin_unlock_irqrestore(&bank->lock, flags);
>   
>   	return 0;
>   }
> 


-- 
regards,
-grygorii
