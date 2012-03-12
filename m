From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 11/13] gpio/omap: fix dataout register overwrite in _set_gpio_dataout_*
Date: Mon, 12 Mar 2012 14:54:17 -0700
Message-ID: <87y5r5wkmu.fsf@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<1331118963-26364-12-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:36651 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753784Ab2CLVyZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 17:54:25 -0400
Received: by iahk25 with SMTP id k25so11662217iah.27
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 14:54:24 -0700 (PDT)
In-Reply-To: <1331118963-26364-12-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 7 Mar 2012 16:46:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> In the existing _set_gpio_dataout_*() implementation, the dataout
> register is overwritten every time the function is called. This is
> not intended behavior because that would end up one user of a GPIO
> line overwriting what is written by another. Fix this so that previous
> value is always preserved until explicitly changed by respective
> user/driver of the GPIO line.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 04c2677..2e8e476 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -114,6 +114,7 @@ static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
>  	else
>  		reg += bank->regs->clr_dataout;
>  
> +	l |= __raw_readl(bank->base + bank->regs->set_dataout);

minor: IMO, it's more reader-friendly if this looks like

       l = __raw_read(...)
       l |= GPIO_BIT(...)
       __raw_write(...)

>  	__raw_writel(l, reg);
>  	bank->context.dataout = l;
>  }
> @@ -130,6 +131,8 @@ static void _set_gpio_dataout_mask(struct gpio_bank *bank, int gpio, int enable)
>  		l |= gpio_bit;
>  	else
>  		l &= ~gpio_bit;
> +
> +	l |= __raw_readl(bank->base + bank->regs->set_dataout);

There's already a __raw_read() in this function just above.

>  	__raw_writel(l, reg);
>  	bank->context.dataout = l;
>  }
