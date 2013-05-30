From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v3 1/3] gpio/omap: replace open coded read-modify-write with _gpio_rmw function.
Date: Thu, 30 May 2013 07:30:13 -0700
Message-ID: <874ndka6bu.fsf@linaro.org>
References: <1368564867-11142-1-git-send-email-andreas.fenkart@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:63659 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757037Ab3E3OaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 10:30:17 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so453094pbc.11
        for <linux-omap@vger.kernel.org>; Thu, 30 May 2013 07:30:16 -0700 (PDT)
In-Reply-To: <1368564867-11142-1-git-send-email-andreas.fenkart@streamunlimited.com>
	(Andreas Fenkart's message of "Tue, 14 May 2013 22:54:25 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: santosh.shilimkar@ti.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, daniel@zonque.org, jon-hunter@ti.com

Andreas Fenkart <andreas.fenkart@streamunlimited.com> writes:

> By also making it return the modified value, we save the readl
> needed to update the context.
>
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Great cleanups,   Thanks!

Some minor comments below...

Also, it would be nice to see a cover letter for this series describing
how it was tested, on what platforms, did it include PM testing
(off-mode, etc.).

[...]

> @@ -94,20 +107,10 @@ static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
>  
>  static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
>  {
> -	void __iomem *reg = bank->base;
> -	u32 l;
> -
> -	reg += bank->regs->direction;
> -	l = __raw_readl(reg);
> -	if (is_input)
> -		l |= 1 << gpio;
> -	else
> -		l &= ~(1 << gpio);
> -	__raw_writel(l, reg);
> -	bank->context.oe = l;
> +	bank->context.oe = _gpio_rmw(bank->base, bank->regs->direction, 1 <<
> +				     gpio, is_input);

wrapping is funny here, IMO the "1 <<" should be on the next line along
with "gpio".

[...]

> @@ -450,19 +428,16 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
>  
>  static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
>  {
> -	void __iomem *reg = bank->base;
> +	void __iomem *base = bank->base;
>  
> -	reg += bank->regs->irqstatus;
> -	__raw_writel(gpio_mask, reg);
> +	__raw_writel(gpio_mask, base + bank->regs->irqstatus);
>  
>  	/* Workaround for clearing DSP GPIO interrupts to allow retention */
> -	if (bank->regs->irqstatus2) {
> -		reg = bank->base + bank->regs->irqstatus2;
> -		__raw_writel(gpio_mask, reg);
> -	}
> +	if (bank->regs->irqstatus2)
> +		__raw_writel(gpio_mask, base + bank->regs->irqstatus2);
>  
>  	/* Flush posted write for the irq status to avoid spurious interrupts */
> -	__raw_readl(reg);
> +	__raw_readl(base + bank->regs->irqstatus);

All of the changes in this function are not related to the change
described in the changelog.  Either make a separate patch, or add a
description of this cleanup to the changelog too.

Thanks,

Kevin

