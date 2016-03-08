From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/3] pinctrl: single: Use a separate lockdep class
Date: Tue, 8 Mar 2016 18:32:10 +0700
Message-ID: <56DEB83A.9070901@ti.com>
References: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
 <1454351299-27440-2-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1454351299-27440-2-git-send-email-sudeep.holla@arm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 02/02/2016 01:28 AM, Sudeep Holla wrote:
> The single pinmux controller can be cascaded to the other interrupt
> controllers. Hence when propagating wake-up settings to its parent
> interrupt controller, there's possiblity of detecting possible recursive
> locking and getting lockdep warning.
> 
> This patch avoids this false positive by using a separate lockdep class
> for this single pinctrl interrupts.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/pinctrl/pinctrl-single.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index d24e5f1d1525..fb126d56ad40 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -255,6 +255,13 @@ static enum pin_config_param pcs_bias[] = {
>   };
>   
>   /*
> + * This lock class tells lockdep that irqchip core that this single
> + * pinctrl can be in a different category than its parents, so it won't
> + * report false recursion.
> + */
> +static struct lock_class_key pcs_lock_class;
> +
> +/*
>    * REVISIT: Reads and writes could eventually use regmap or something
>    * generic. But at least on omaps, some mux registers are performance
>    * critical as they may need to be remuxed every time before and after
> @@ -1713,6 +1720,7 @@ static int pcs_irqdomain_map(struct irq_domain *d, unsigned int irq,
>   	irq_set_chip_data(irq, pcs_soc);
>   	irq_set_chip_and_handler(irq, &pcs->chip,
>   				 handle_level_irq);
> +	irq_set_lockdep_class(irq, &pcs_lock_class);
>   	irq_set_noprobe(irq);
>   
>   	return 0;
> 

I have no objection to this patch and it's independent from other patches in
this series.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>  

-- 
regards,
-grygorii
