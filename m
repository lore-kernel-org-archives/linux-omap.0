From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5] gpio/omap: fix off-mode bug: clear debounce settings on free/reset
Date: Fri, 26 Oct 2012 14:19:26 -0700
Message-ID: <874nlhhqxt.fsf@deeprootsystems.com>
References: <1351279564-4591-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56097 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966492Ab2JZVSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 17:18:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3027362pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 26 Oct 2012 14:18:53 -0700 (PDT)
In-Reply-To: <1351279564-4591-1-git-send-email-jon-hunter@ti.com> (Jon
	Hunter's message of "Fri, 26 Oct 2012 14:26:04 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, Grazvydas Ignotas <notasas@gmail.com>

Jon Hunter <jon-hunter@ti.com> writes:

> This change was originally titled "gpio/omap: fix off-mode bug: clear debounce
> clock enable mask on free/reset". The title has been updated slightly to
> reflect (what should be) the final fix.

nit: this kind of thing should typically go after the '---' since it's
useful reviewers/maintainers but not necessarily in the permanant git
history.

Otherwise, thanks for taking this over, and hopefully this can still
get in for v3.7-rc.

Kevin

> When a GPIO is freed or shutdown, we need to ensure that any debounce settings
> are cleared and if the GPIO is the only GPIO in the bank that is currently
> using debounce, then disable the debounce clock as well to save power.
>
> Currently, the debounce settings are not cleared on a GPIO free or shutdown and
> so during a context restore on subsequent off-mode transition, the previous
> debounce values are restored from the shadow copies (bank->context.debounce*)
> leading to mismatch state between driver state and hardware state.
>
> This was discovered when board code was doing
>
>   gpio_request_one()
>   gpio_set_debounce()
>   gpio_free()
>
> which was leaving the GPIO debounce settings in a confused state.  If that GPIO
> bank is subsequently used with off-mode enabled, bogus state would be restored,
> leaving GPIO debounce enabled which then prevented the CORE powerdomain from
> transitioning.
>
> To fix this, introduce a new function called _clear_gpio_debounce() to clear
> any debounce settings when the GPIO is freed or shutdown. If this GPIO is the
> last debounce-enabled GPIO in the bank, the debounce will also be cut.
>
> Please note that we cannot use _gpio_dbck_disable() to disable the debounce
> clock because this has been specifically created for the gpio suspend path
> and is intended to shutdown the debounce clock while debounce is enabled.
>
> Special thanks to Kevin Hilman for root causing the bug. This fix is a
> collaborative effort with inputs from Kevin Hilman, Grazvydas Ignotas and
> Santosh Shilimkar.
>
> Testing:
> - This has been unit tested on an OMAP3430 Beagle board, by requesting a gpio,
>   enabling debounce and then freeing the gpio and checking the register
>   contents, the saved register context and the debounce clock state.
> - Kevin Hilman tested on 37xx/EVM board which configures GPIO debounce for the
>   ads7846 touchscreen in its board file using the above sequence, and so was
>   failing off-mode tests in dynamic idle. Verified that off-mode tests are
>   passing with this patch.
>
> V5 changes:
> - Corrected author
>
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Grazvydas Ignotas <notasas@gmail.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |   35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 94cbc84..d335af1 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -251,6 +251,40 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
>  	}
>  }
>  
> +/**
> + * _clear_gpio_debounce - clear debounce settings for a gpio
> + * @bank: the gpio bank we're acting upon
> + * @gpio: the gpio number on this @gpio
> + *
> + * If a gpio is using debounce, then clear the debounce enable bit and if
> + * this is the only gpio in this bank using debounce, then clear the debounce
> + * time too. The debounce clock will also be disabled when calling this function
> + * if this is the only gpio in the bank using debounce.
> + */
> +static void _clear_gpio_debounce(struct gpio_bank *bank, unsigned gpio)
> +{
> +	u32 gpio_bit = GPIO_BIT(bank, gpio);
> +
> +	if (!bank->dbck_flag)
> +		return;
> +
> +	if (!(bank->dbck_enable_mask & gpio_bit))
> +		return;
> +
> +	bank->dbck_enable_mask &= ~gpio_bit;
> +	bank->context.debounce_en &= ~gpio_bit;
> +	__raw_writel(bank->context.debounce_en,
> +		     bank->base + bank->regs->debounce_en);
> +
> +	if (!bank->dbck_enable_mask) {
> +		bank->context.debounce = 0;
> +		__raw_writel(bank->context.debounce, bank->base +
> +			     bank->regs->debounce);
> +		clk_disable(bank->dbck);
> +		bank->dbck_enabled = false;
> +	}
> +}
> +
>  static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
>  						unsigned trigger)
>  {
> @@ -539,6 +573,7 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
>  	_set_gpio_irqenable(bank, gpio, 0);
>  	_clear_gpio_irqstatus(bank, gpio);
>  	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
> +	_clear_gpio_debounce(bank, gpio);
>  }
>  
>  /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
