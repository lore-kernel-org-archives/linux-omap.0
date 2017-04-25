From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] gpio: omap: return error if requested debounce time is
 not possible
Date: Tue, 25 Apr 2017 15:35:07 -0500
Message-ID: <1a4e724d-5519-1a74-d7b7-5f5756ec7196@ti.com>
References: <20170424225650.17566-1-drivshin@awxrd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170424225650.17566-1-drivshin@awxrd.com>
Sender: stable-owner@vger.kernel.org
To: David Rivshin <drivshin@awxrd.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-arm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 04/24/2017 05:56 PM, David Rivshin wrote:
> From: David Rivshin <DRivshin@allworx.com>
>
> omap_gpio_debounce() does not validate that the requested debounce
> is within a range it can handle. Instead it lets the register value
> wrap silently, and always returns success.
>
> This can lead to all sorts of unexpected behavior, such as gpio_keys
> asking for a too-long debounce, but getting a very short debounce in
> practice.
>
> Fix this by returning -EINVAL if the requested value does not fit into
> the register field. If there is no debounce clock available at all,
> return -ENOTSUPP.
>
> Fixes: e85ec6c3047b ("gpio: omap: fix omap2_set_gpio_debounce")
> Cc: <stable@vger.kernel.org> # 4.3+
> Signed-off-by: David Rivshin <drivshin@allworx.com>

Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>

> ---
> Changes since v1 (https://lkml.org/lkml/2017/3/16/1094):
> - Added dev_info() in omap_gpio_debounce() on error.
>
>  drivers/gpio/gpio-omap.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index efc85a2..fd9bce9 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -208,9 +208,11 @@ static inline void omap_gpio_dbck_disable(struct gpio_bank *bank)
>   * OMAP's debounce time is in 31us steps
>   *   <debounce time> = (GPIO_DEBOUNCINGTIME[7:0].DEBOUNCETIME + 1) x 31
>   * so we need to convert and round up to the closest unit.
> + *
> + * Return: 0 on success, negative error otherwise.
>   */
> -static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
> -				    unsigned debounce)
> +static int omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
> +				   unsigned debounce)
>  {
>  	void __iomem		*reg;
>  	u32			val;
> @@ -218,11 +220,12 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
>  	bool			enable = !!debounce;
>
>  	if (!bank->dbck_flag)
> -		return;
> +		return -ENOTSUPP;
>
>  	if (enable) {
>  		debounce = DIV_ROUND_UP(debounce, 31) - 1;
> -		debounce &= OMAP4_GPIO_DEBOUNCINGTIME_MASK;
> +		if ((debounce & OMAP4_GPIO_DEBOUNCINGTIME_MASK) != debounce)
> +			return -EINVAL;
>  	}
>
>  	l = BIT(offset);
> @@ -255,6 +258,8 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
>  		bank->context.debounce = debounce;
>  		bank->context.debounce_en = val;
>  	}
> +
> +	return 0;
>  }
>
>  /**
> @@ -964,14 +969,20 @@ static int omap_gpio_debounce(struct gpio_chip *chip, unsigned offset,
>  {
>  	struct gpio_bank *bank;
>  	unsigned long flags;
> +	int ret;
>
>  	bank = gpiochip_get_data(chip);
>
>  	raw_spin_lock_irqsave(&bank->lock, flags);
> -	omap2_set_gpio_debounce(bank, offset, debounce);
> +	ret = omap2_set_gpio_debounce(bank, offset, debounce);
>  	raw_spin_unlock_irqrestore(&bank->lock, flags);
>
> -	return 0;
> +	if (ret)
> +		dev_info(chip->parent,
> +			 "Could not set line %u debounce to %u microseconds (%d)",
> +			 offset, debounce, ret);
> +
> +	return ret;
>  }
>
>  static int omap_gpio_set_config(struct gpio_chip *chip, unsigned offset,
>

-- 
regards,
-grygorii
