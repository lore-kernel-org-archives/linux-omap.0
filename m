From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 03/22] gpio/omap: make gpio_context part of gpio_bank
 structure
Date: Tue, 23 Aug 2011 18:15:34 +0530
Message-ID: <4E53A0EE.5000703@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-4-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:45657 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752656Ab1HWMpm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:45:42 -0400
Received: by mail-gw0-f48.google.com with SMTP id 22so57570gwj.35
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:45:41 -0700 (PDT)
In-Reply-To: <1312455893-14922-4-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> Currently gpio_context array used to save gpio bank's context, is used only for
> OMAP3 architecture. Move gpio_context as part of gpio_bank structure so that it
> can be specific to each gpio bank and can be used for any OMAP architecture
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
Few comments.

>   drivers/gpio/gpio-omap.c |   76 ++++++++++++++++++++-------------------------
>   1 files changed, 34 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index aaf07b8..2fa8b13 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -30,6 +30,19 @@
>
>   static LIST_HEAD(omap_gpio_list);
>
> +struct gpio_regs {
> +	u32 irqenable1;
> +	u32 irqenable2;
> +	u32 wake_en;
> +	u32 ctrl;
> +	u32 oe;
> +	u32 leveldetect0;
> +	u32 leveldetect1;
> +	u32 risingdetect;
> +	u32 fallingdetect;
> +	u32 dataout;
debounce and debounce_en registers are missing.
Add them please.

> +};
> +
>   struct gpio_bank {
>   	struct list_head node;
>   	unsigned long pbase;
> @@ -43,7 +56,7 @@ struct gpio_bank {
>   #endif
>   	u32 non_wakeup_gpios;
>   	u32 enabled_non_wakeup_gpios;
> -
> +	struct gpio_regs context;
>   	u32 saved_datain;
>   	u32 saved_fallingdetect;
>   	u32 saved_risingdetect;
> @@ -66,23 +79,6 @@ struct gpio_bank {
>   	struct omap_gpio_reg_offs *regs;
>   };
>
> -#ifdef CONFIG_ARCH_OMAP3
> -struct omap3_gpio_regs {
> -	u32 irqenable1;
> -	u32 irqenable2;
> -	u32 wake_en;
> -	u32 ctrl;
> -	u32 oe;
> -	u32 leveldetect0;
> -	u32 leveldetect1;
> -	u32 risingdetect;
> -	u32 fallingdetect;
> -	u32 dataout;
> -};
> -
> -static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
> -#endif
> -
>   #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
>   #define GPIO_BIT(bank, gpio) (1<<  GPIO_INDEX(bank, gpio))
>
> @@ -1494,33 +1490,31 @@ void omap2_gpio_resume_after_idle(void)
>   void omap_gpio_save_context(void)
>   {
>   	struct gpio_bank *bank;
> -	int i = 0;
>
>   	list_for_each_entry(bank,&omap_gpio_list, node) {
> -		i++;
>
>   		if (!bank->loses_context)
>   			continue;
>
> -		gpio_context[i].irqenable1 =
> +		bank->context.irqenable1 =
>   			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
> -		gpio_context[i].irqenable2 =
> +		bank->context.irqenable2 =
>   			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);

The context restore procedure should be done carefully. For instance
IRQ enabled register should be restored last to avoid any spurious 
interrupts.

> -		gpio_context[i].wake_en =
> +		bank->context.wake_en =
>   			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
> -		gpio_context[i].ctrl =
> +		bank->context.ctrl =
>   			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> -		gpio_context[i].oe =
> +		bank->context.oe =
>   			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
Restore dataout register before OE restore.

> -		gpio_context[i].leveldetect0 =
> +		bank->context.leveldetect0 =
>   			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
> -		gpio_context[i].leveldetect1 =
> +		bank->context.leveldetect1 =
>   			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
> -		gpio_context[i].risingdetect =
> +		bank->context.risingdetect =
>   			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
> -		gpio_context[i].fallingdetect =
> +		bank->context.fallingdetect =
>   			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
> -		gpio_context[i].dataout =
> +		bank->context.dataout =
>   			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
>   	}
>   }

Regards
Santosh
