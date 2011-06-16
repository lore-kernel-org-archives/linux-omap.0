From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 14/18] GPIO: OMAP: Fix use of readl/readw to access isr_reg
Date: Thu, 16 Jun 2011 10:53:44 -0700
Message-ID: <87aadhmzmf.fsf@ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
	<1308111806-29152-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:60353 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757205Ab1FPRxr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 13:53:47 -0400
Received: by mail-pw0-f50.google.com with SMTP id 3so1004146pwi.23
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 10:53:47 -0700 (PDT)
In-Reply-To: <1308111806-29152-5-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 15 Jun 2011 09:53:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> In gpio_irq_handler, isr register is always accessed as 32 bit register and only
> for OMAP15xx the first 16 MSBs are masked. Correct this by using the appropriate
> readl/readw registers as per the bank width.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index c6987f2..01b568f 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -590,10 +590,12 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  		u32 enabled;
>  
>  		enabled = _get_gpio_irqbank_mask(bank);
> -		isr_saved = isr = __raw_readl(isr_reg) & enabled;
>  
> -		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
> -			isr &= 0x0000ffff;
> +		if (bank->width == 32)
> +			isr = __raw_readl(isr_reg) & enabled;
> +		else if (bank->width == 16)
> +			isr = (__raw_readw(isr_reg) & enabled) & 0x0000ffff;

Minor nit: is the '& 0xffff' really needed.  The 'enabled' mask is
already masked using the bank width.

Kevin

> +		isr_saved = isr;
>  
>  		if (bank->regs->leveldetect0)
>  			level_mask = bank->level_mask & enabled;
