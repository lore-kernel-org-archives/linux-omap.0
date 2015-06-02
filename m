From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH 2/7] gpio: omap: fix error handling in omap_gpio_irq_type
Date: Tue, 02 Jun 2015 17:27:57 +0300
Message-ID: <556DBD6D.8090306@linaro.org>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>	<1432305354-5968-3-git-send-email-grygorii.strashko@linaro.org> <CABxcv=m7htmrUStVJXdUmPvn+hOkA6+vZJi4qvcYZ46qXiJ6Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:34003 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759122AbbFBO2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 10:28:01 -0400
Received: by laew7 with SMTP id w7so34804535lae.1
        for <linux-omap@vger.kernel.org>; Tue, 02 Jun 2015 07:27:59 -0700 (PDT)
In-Reply-To: <CABxcv=m7htmrUStVJXdUmPvn+hOkA6+vZJi4qvcYZ46qXiJ6Jw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Grygorii Strashko <grygorii.strashko@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>

On 06/02/2015 12:40 PM, Javier Martinez Canillas wrote:
> Hello Grygorii,
>
> On Fri, May 22, 2015 at 4:35 PM, Grygorii Strashko
> <grygorii.strashko@linaro.org> wrote:
>> The GPIO bank will be kept powered in case if input parameters
>> are invalid or error occurred in omap_gpio_irq_type.
>>
>> Hence, fix it by ensuring that GPIO bank will be unpowered
>> in case of errors and add additional check of value returned
>> from omap_set_gpio_triggering().
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>> ---
>>   drivers/gpio/gpio-omap.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index bb60cbc..f6cc638 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -488,9 +488,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>>          unsigned long flags;
>>          unsigned offset = d->hwirq;
>>
>> -       if (!BANK_USED(bank))
>> -               pm_runtime_get_sync(bank->dev);
>> -
>>          if (type & ~IRQ_TYPE_SENSE_MASK)
>>                  return -EINVAL;
>>
>> @@ -498,12 +495,18 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>>                  (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
>>                  return -EINVAL;
>>
>> +       if (!BANK_USED(bank))
>> +               pm_runtime_get_sync(bank->dev);
>> +
>>          spin_lock_irqsave(&bank->lock, flags);
>>          retval = omap_set_gpio_triggering(bank, offset, type);
>> +       if (retval)
>
> At this point the bank->lock spinlock is held so you need to add a
> spin_unlock_irqrestore() in the error path.

Ops. Thanks for catching it.
>
>> +               goto error;
>>          omap_gpio_init_irq(bank, offset);
>>          if (!omap_gpio_is_input(bank, offset)) {
>>                  spin_unlock_irqrestore(&bank->lock, flags);
>> -               return -EINVAL;
>> +               retval = -EINVAL;
>> +               goto error;
>>          }
>>          spin_unlock_irqrestore(&bank->lock, flags);
>>
>> @@ -512,6 +515,11 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>>          else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
>>                  __irq_set_handler_locked(d->irq, handle_edge_irq);
>>
>> +       return 0;
>> +
>> +error:
>> +       if (!BANK_USED(bank))
>> +               pm_runtime_put(bank->dev);
>>          return retval;
>>   }
>>
>> --
>
> But you are correct about the runtime PM bug so after addressing the
> above comment, feel free to add:
>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
>

Linus, How do prefer me to fix it?
Resend whole patch or send additional fix on top of patch 5.


-- 
regards,
-grygorii
