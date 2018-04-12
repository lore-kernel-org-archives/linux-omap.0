From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/14] gpio: omap: Drop the concept of gpio banks not
 being able to lose context.
Date: Thu, 12 Apr 2018 07:22:57 -0700
Message-ID: <20180412142257.GW5700@atomide.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-11-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523505239-16229-11-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180412 03:56]:
> From: Russ Dill <Russ.Dill@ti.com>
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -68,7 +68,7 @@ struct gpio_bank {
>  	bool dbck_enabled;
>  	bool is_mpuio;
>  	bool dbck_flag;
> -	bool loses_context;
> +
>  	bool context_valid;
>  	int stride;
>  	u32 width;

For some SoCs GPIO bank1 won't lose the context ever. So I'd like to
keep loses_context flag around to avoid pointless save and restore.
But maybe this still happens with get_context_loss_count and I'm
misreading this patch?

However..

> @@ -1198,15 +1198,9 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  #ifdef CONFIG_OF_GPIO
>  	bank->chip.of_node = of_node_get(node);
>  #endif
> -	if (node) {
> -		if (!of_property_read_bool(node, "ti,gpio-always-on"))
> -			bank->loses_context = true;
> -	} else {
> -		bank->loses_context = pdata->loses_context;
> -
> -		if (bank->loses_context)
> -			bank->get_context_loss_count =
> -				pdata->get_context_loss_count;
> +	if (!node) {
> +		bank->get_context_loss_count =
> +			pdata->get_context_loss_count;
>  	}
>  
>  	if (bank->regs->set_dataout && bank->regs->clr_dataout)

.. I do have a patch ready here that I'll post after -rc1 to remove
CONFIG_OMAP_PM_NOOP related stuff, turns out that's noop anyways :)

So yeah the pdata->get_context_loss_count parts are noop and can
be just removed.

Regards,

Tony
