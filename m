From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 2/7] gpio: omap: fix error handling in omap_gpio_irq_type
Date: Tue, 2 Jun 2015 11:40:35 +0200
Message-ID: <CABxcv=m7htmrUStVJXdUmPvn+hOkA6+vZJi4qvcYZ46qXiJ6Jw@mail.gmail.com>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
	<1432305354-5968-3-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33742 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbbFBJkg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 05:40:36 -0400
Received: by ykfr66 with SMTP id r66so52051354ykf.0
        for <linux-omap@vger.kernel.org>; Tue, 02 Jun 2015 02:40:35 -0700 (PDT)
In-Reply-To: <1432305354-5968-3-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>

Hello Grygorii,

On Fri, May 22, 2015 at 4:35 PM, Grygorii Strashko
<grygorii.strashko@linaro.org> wrote:
> The GPIO bank will be kept powered in case if input parameters
> are invalid or error occurred in omap_gpio_irq_type.
>
> Hence, fix it by ensuring that GPIO bank will be unpowered
> in case of errors and add additional check of value returned
> from omap_set_gpio_triggering().
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
> ---
>  drivers/gpio/gpio-omap.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index bb60cbc..f6cc638 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -488,9 +488,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>         unsigned long flags;
>         unsigned offset = d->hwirq;
>
> -       if (!BANK_USED(bank))
> -               pm_runtime_get_sync(bank->dev);
> -
>         if (type & ~IRQ_TYPE_SENSE_MASK)
>                 return -EINVAL;
>
> @@ -498,12 +495,18 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>                 (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
>                 return -EINVAL;
>
> +       if (!BANK_USED(bank))
> +               pm_runtime_get_sync(bank->dev);
> +
>         spin_lock_irqsave(&bank->lock, flags);
>         retval = omap_set_gpio_triggering(bank, offset, type);
> +       if (retval)

At this point the bank->lock spinlock is held so you need to add a
spin_unlock_irqrestore() in the error path.

> +               goto error;
>         omap_gpio_init_irq(bank, offset);
>         if (!omap_gpio_is_input(bank, offset)) {
>                 spin_unlock_irqrestore(&bank->lock, flags);
> -               return -EINVAL;
> +               retval = -EINVAL;
> +               goto error;
>         }
>         spin_unlock_irqrestore(&bank->lock, flags);
>
> @@ -512,6 +515,11 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>         else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
>                 __irq_set_handler_locked(d->irq, handle_edge_irq);
>
> +       return 0;
> +
> +error:
> +       if (!BANK_USED(bank))
> +               pm_runtime_put(bank->dev);
>         return retval;
>  }
>
> --

But you are correct about the runtime PM bug so after addressing the
above comment, feel free to add:

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
