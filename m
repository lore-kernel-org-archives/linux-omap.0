From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] gpio: omap: implement get_direction
Date: Thu, 24 Apr 2014 15:13:04 +0200
Message-ID: <CACRpkdZPNGHNQhqovDoaKTXZT3mJfN4pjKSBxW7m6wT5u-XEYQ@mail.gmail.com>
References: <1398322659-20008-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:41446 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051AbaDXNNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 09:13:05 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so2573166oag.22
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2014 06:13:05 -0700 (PDT)
In-Reply-To: <1398322659-20008-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegorslists@googlemail.com, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>

On Thu, Apr 24, 2014 at 8:57 AM,  <yegorslists@googlemail.com> wrote:

> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> This patch implements gpio_chip's get_direction() routine, that
> lets other drivers get particular GPIOs direction using
> struct gpio_desc.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
> Changes:
>         v3: get rid of _get_gpio_direction() (Linus Walleij)
>         v2: rework return value calculation

Looks good to me, Kevin, Santosh?

Part of me wants to list Javier as maintainer for this driver.

> +static int gpio_get_direction(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct gpio_bank *bank;
> +       unsigned long flags;
> +       void __iomem *reg;
> +       int dir;

That is a bool, actually. But no big deal.

> +
> +       bank = container_of(chip, struct gpio_bank, chip);
> +       reg = bank->base + bank->regs->direction;
> +       spin_lock_irqsave(&bank->lock, flags);
> +       dir = !!(readl_relaxed(reg) & BIT(offset));
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +       return dir;
> +}

Yours,
Linus Walleij
