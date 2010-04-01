From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] OMAP3:GPIO:Add support for early platform gpio
 device
Date: Thu, 1 Apr 2010 02:13:57 -0700
Message-ID: <20100401091357.GE31200@atomide.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56686 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab0DAJMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:12:06 -0400
Content-Disposition: inline
In-Reply-To: <1270038239-1090-3-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com

* Charulatha V <charu@ti.com> [100331 05:15]:
> This patch adds support for implementing OMAP3 GPIO as an
> early platform device and adds gpio_init specific to OMAP3
> 
> This patch adds device structures for each GPIO device in
> OMAP3 architecture. These strutures are not created in a
> separate *_data.c file because these structures would be
> removed once the driver gets adapted to HWMOD way.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/mach-omap2/gpio3xxx.c          |  351 +++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/include/mach/gpio.h |   13 +-
>  2 files changed, 363 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/gpio3xxx.c
> 
> diff --git a/arch/arm/mach-omap2/gpio3xxx.c b/arch/arm/mach-omap2/gpio3xxx.c
> new file mode 100644
> index 0000000..8f404e7
> --- /dev/null
> +++ b/arch/arm/mach-omap2/gpio3xxx.c
> @@ -0,0 +1,351 @@
> +/*
> + * gpio3xxx.c - OMAP3-specific gpio code
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + *
> + * Author:
> + *	Charulatha V <charu@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <plat/gpio.h>
> +
> +/*
> + * OMAP3 GPIO reg offsets
> + */
> +static struct gpio_reg_offset omap3_gpio_reg = {
> +	.data_in	= OMAP24XX_GPIO_DATAIN,
> +	.data_out	= OMAP24XX_GPIO_DATAOUT,
> +	.data_out_set	= OMAP24XX_GPIO_SETDATAOUT,
> +	.data_out_clear	= OMAP24XX_GPIO_CLEARDATAOUT,
> +	.dir_ctrl	= OMAP24XX_GPIO_OE,
> +	.irq_status0	= OMAP24XX_GPIO_IRQSTATUS1,
> +	.irq_status1	= OMAP24XX_GPIO_IRQSTATUS2,
> +	.irq_mask	= OMAP24XX_GPIO_IRQENABLE1,
> +	.irq_set	= OMAP24XX_GPIO_SETIRQENABLE1,
> +	.irq_clear	= OMAP24XX_GPIO_CLEARIRQENABLE1,
> +	.irq_mask_bits	= 0xffffffff,
> +	.irq_inv	= 0,
> +	.wkup_enable	= OMAP24XX_GPIO_WAKE_EN,
> +	.wkup_clear	= OMAP24XX_GPIO_CLEARWKUENA,
> +	.wkup_set	= OMAP24XX_GPIO_SETWKUENA,
> +	.debounce_ena	= OMAP24XX_GPIO_DEBOUNCE_EN,
> +	.debounce_val	= OMAP24XX_GPIO_DEBOUNCE_VAL,
> +	.ctrl		= OMAP24XX_GPIO_CTRL,
> +	.syscfg		= OMAP24XX_GPIO_SYSCONFIG,
> +	.leveldetect0	= OMAP24XX_GPIO_LEVELDETECT0,
> +	.leveldetect1	= OMAP24XX_GPIO_LEVELDETECT1,
> +	.rise_detect	= OMAP24XX_GPIO_RISINGDETECT,
> +	.fall_detect	= OMAP24XX_GPIO_FALLINGDETECT,
> +	.rev_reg	= OMAP24XX_GPIO_REVISION,
> +};

Can we use just a omap specific shift here? Or is the register
ordering different too?

Tony
