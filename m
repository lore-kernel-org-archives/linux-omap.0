From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Thu, 28 Feb 2013 00:41:06 +0100
Message-ID: <CACRpkdabXa8tXNeGRPntvY9cx4XWCa7XaEXHmVREeWN-x793ZA@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
	<1329321854-24490-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:57524 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab3B0XlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Feb 2013 18:41:07 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so1331001ieb.37
        for <linux-omap@vger.kernel.org>; Wed, 27 Feb 2013 15:41:06 -0800 (PST)
In-Reply-To: <1329321854-24490-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, Feb 15, 2012 at 5:04 PM, Benoit Cousson <b-cousson@ti.com> wrote:

> @@ -52,7 +55,8 @@ struct gpio_bank {
>         struct list_head node;
>         void __iomem *base;
>         u16 irq;
> -       u16 virtual_irq_start;
> +       int irq_base;
> +       struct irq_domain *domain;

This seems wrong. IRQ domains are used to avoid keeping track of
irq base offsets. I would even say it's the whole point of irq domains.

> @@ -669,7 +673,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>                 if (!isr)
>                         break;
>
> -               gpio_irq = bank->virtual_irq_start;
> +               gpio_irq = bank->irq_base;
>                 for (; isr != 0; isr >>= 1, gpio_irq++) {
>                         gpio_index = GPIO_INDEX(bank, irq_to_gpio(gpio_irq));
>

Use irq_find_mapping(irqdomain, hwirq) in this function.


> @@ -915,7 +919,7 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
>         struct gpio_bank *bank;
>
>         bank = container_of(chip, struct gpio_bank, chip);
> -       return bank->virtual_irq_start + offset;
> +       return bank->irq_base + offset;

Use irq_create_mapping() in this function.

> +       bank->irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
> +       if (bank->irq_base < 0) {
> +               dev_err(dev, "Couldn't allocate IRQ numbers\n");
> +               return -ENODEV;
> +       }
> +
> +       bank->domain = irq_domain_add_legacy(node, bank->width, bank->irq_base,
> +                                            0, &irq_domain_simple_ops, NULL);

Use irq_domain_add_simple() and the descs will be allocated for
you as part of the domain creation, when using a pre-fixed base.

If you fix this I suspect the device tree discussion also will fix
itself :-)

Documentation/IRQ-domain.txt

Yours,
Linus Walleij
