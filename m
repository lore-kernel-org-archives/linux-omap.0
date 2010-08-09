From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/13 v5] OMAP: GPIO: Modify init() in preparation for platform device implementation
Date: Mon, 09 Aug 2010 15:20:44 -0700
Message-ID: <878w4fh1hf.fsf@deeprootsystems.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35293 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734Ab0HIWUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 18:20:49 -0400
Received: by iwn33 with SMTP id 33so3864683iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 09 Aug 2010 15:20:49 -0700 (PDT)
In-Reply-To: <1281098065-24177-2-git-send-email-charu@ti.com> (Charulatha V.'s
	message of "Fri, 6 Aug 2010 18:04:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, "Basak, Partha" <p-basak2@ti.com>

Charulatha V <charu@ti.com> writes:

> This is in prepartion for implementing GPIO as a platform device.
> gpio bank's base addresses are moved from gpio.c to plat/gpio.h.
>
> This patch also modifies omap_gpio_init() to make use of
> omap_gpio_chip_init() and omap_gpio_mod_init(). omap_gpio_mod_init() does
> the module init by clearing the status register and initializing the
> GPIO control register. omap_gpio_chip_init() initializes the chip request,
> free, get, set and other function pointers and sets the gpio irq handler.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Basak, Partha <p-basak2@ti.com>

[...]

> +static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
> +{
> +	if (cpu_class_is_omap2()) {
> +		if (cpu_is_omap44xx()) {
> +			__raw_writel(0xffffffff, bank->base +
> +					OMAP4_GPIO_IRQSTATUSCLR0);
> +			__raw_writel(0x00000000, bank->base +
> +					 OMAP4_GPIO_DEBOUNCENABLE);
> +			/* Initialize interface clk ungated, module enabled */
> +			__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
> +		} else if (cpu_is_omap34xx()) {
> +			__raw_writel(0x00000000, bank->base +
> +					OMAP24XX_GPIO_IRQENABLE1);
> +			__raw_writel(0xffffffff, bank->base +
> +					OMAP24XX_GPIO_IRQSTATUS1);
> +			__raw_writel(0x00000000, bank->base +
> +					OMAP24XX_GPIO_DEBOUNCE_EN);
> +
> +			/* Initialize interface clk ungated, module enabled */
> +			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
> +			/* Enable autoidle for the OCP interface */
> +			omap_writel(1 << 0, 0x48306814);

This autoidle stuff should be removed in this series as setting this is
handled by the hwmod layer.

> +		} else if (cpu_is_omap24xx()) {
> +			static const u32 non_wakeup_gpios[] = {
> +				0xe203ffc0, 0x08700040
> +			};
> +			if (id < ARRAY_SIZE(non_wakeup_gpios))
> +				bank->non_wakeup_gpios = non_wakeup_gpios[id];
> +
> +			/* Enable autoidle for the OCP interface */
> +			omap_writel(1 << 0, 0x48019010);

ditto

> +		}

Kevin
