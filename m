From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH 2/7] gpio: omap: fix error handling in omap_gpio_irq_type
Date: Wed, 03 Jun 2015 22:34:23 +0300
Message-ID: <556F56BF.8090803@linaro.org>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>	<1432305354-5968-3-git-send-email-grygorii.strashko@linaro.org> <CABxcv=m7htmrUStVJXdUmPvn+hOkA6+vZJi4qvcYZ46qXiJ6Jw@mail.gmail.com> <556DBD6D.8090306@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <556DBD6D.8090306@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

On 06/02/2015 05:27 PM, Grygorii.Strashko@linaro.org wrote:
> On 06/02/2015 12:40 PM, Javier Martinez Canillas wrote:
>> Hello Grygorii,
>>
>> On Fri, May 22, 2015 at 4:35 PM, Grygorii Strashko
>> <grygorii.strashko@linaro.org> wrote:
>>> The GPIO bank will be kept powered in case if input parameters
>>> are invalid or error occurred in omap_gpio_irq_type.
>>>
>>> Hence, fix it by ensuring that GPIO bank will be unpowered
>>> in case of errors and add additional check of value returned
>>> from omap_set_gpio_triggering().
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>>> ---
>>>   drivers/gpio/gpio-omap.c | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index bb60cbc..f6cc638 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -488,9 +488,6 @@ static int omap_gpio_irq_type(struct irq_data *d, 
>>> unsigned type)
>>>          unsigned long flags;
>>>          unsigned offset = d->hwirq;
>>>
>>> -       if (!BANK_USED(bank))
>>> -               pm_runtime_get_sync(bank->dev);
>>> -
>>>          if (type & ~IRQ_TYPE_SENSE_MASK)
>>>                  return -EINVAL;
>>>
>>> @@ -498,12 +495,18 @@ static int omap_gpio_irq_type(struct irq_data 
>>> *d, unsigned type)
>>>                  (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
>>>                  return -EINVAL;
>>>
>>> +       if (!BANK_USED(bank))
>>> +               pm_runtime_get_sync(bank->dev);
>>> +
>>>          spin_lock_irqsave(&bank->lock, flags);
>>>          retval = omap_set_gpio_triggering(bank, offset, type);
>>> +       if (retval)
>>
>> At this point the bank->lock spinlock is held so you need to add a
>> spin_unlock_irqrestore() in the error path.
> 
> Ops. Thanks for catching it.
>>
>>> +               goto error;
>>>          omap_gpio_init_irq(bank, offset);
>>>          if (!omap_gpio_is_input(bank, offset)) {
>>>                  spin_unlock_irqrestore(&bank->lock, flags);
>>> -               return -EINVAL;
>>> +               retval = -EINVAL;
>>> +               goto error;
>>>          }
>>>          spin_unlock_irqrestore(&bank->lock, flags);
>>>
>>> @@ -512,6 +515,11 @@ static int omap_gpio_irq_type(struct irq_data 
>>> *d, unsigned type)
>>>          else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
>>>                  __irq_set_handler_locked(d->irq, handle_edge_irq);
>>>
>>> +       return 0;
>>> +
>>> +error:
>>> +       if (!BANK_USED(bank))
>>> +               pm_runtime_put(bank->dev);
>>>          return retval;
>>>   }
>>>
>>> -- 
>>
>> But you are correct about the runtime PM bug so after addressing the
>> above comment, feel free to add:
>>
>> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
>>
> 
> Linus, How do prefer me to fix it?
> Resend whole patch or send additional fix on top of patch 5.
> 

Below is the additional patch to fix issue reported by Javier.
Pls. inform me if you would like me to send v2 of this patch instead.

-- 
regards,
-grygorii

------ <
>From 611cdfe480f095136e55f155bb71aeb09ea994b0 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@linaro.org>
Date: Wed, 3 Jun 2015 19:15:19 +0300
Subject: [PATCH] gpio: omap: add missed spin_unlock_irqrestore in omap_gpio_irq_type

Add missed spin_unlock_irqrestore in omap_gpio_irq_type when
omap_set_gpio_triggering() is failed.

This fixes patch 'gpio: omap: fix error handling in omap_gpio_irq_type'

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e26dc40..e3f8205 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -490,8 +490,10 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = omap_set_gpio_triggering(bank, offset, type);
-	if (retval)
+	if (retval) {
+		spin_unlock_irqrestore(&bank->lock, flags);
 		goto error;
+	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
-- 
1.9.1

