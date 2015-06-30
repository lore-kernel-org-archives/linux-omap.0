From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH REPOST] gpio: omap: use raw locks for locking
Date: Tue, 30 Jun 2015 13:55:53 +0300
Message-ID: <559275B9.3040909@ti.com>
References: <20150619170654.GA4937@linutronix.de> <5584547B.9040203@oracle.com> <CABxcv==5Fo-x9CdSu6BYNfBpAS7rp63fHA319J_KvWZZG9q=ng@mail.gmail.com> <20150622070821.GB4156@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150622070821.GB4156@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian, All,

On 06/22/2015 10:08 AM, Tony Lindgren wrote:
> * Javier Martinez Canillas <javier@dowhile0.org> [150619 14:57]:
>> On Fri, Jun 19, 2015 at 7:42 PM, santosh shilimkar
>> <santosh.shilimkar@oracle.com> wrote:
>>> On 6/19/2015 10:06 AM, Sebastian Andrzej Siewior wrote:
>>>>
>>>> This patch converts gpio_bank.lock from a spin_lock into a
>>>> raw_spin_lock. The call path is to access this lock is always under a
>>>> raw_spin_lock, for instance
>>>> - __setup_irq() holds &desc->lock with irq off
>>>>     + __irq_set_trigger()
>>>>      + omap_gpio_irq_type()
>>>>
>>>> - handle_level_irq() (runs with irqs off therefore raw locks)
>>>>     + mask_ack_irq()
>>>>      + omap_gpio_mask_irq()
>>>>
>>>> This fixes the obvious backtrace on -RT. However the locking vs context
>>>> is not and this is not limited to -RT:
>>>> - omap_gpio_irq_type() is called with IRQ off and has an conditional
>>>>     call to pm_runtime_get_sync() which may sleep. Either it may happen or
>>>>     it may not happen but pm_runtime_get_sync() should not be called with
>>>>     irqs off.
>>>>
>>>> - omap_gpio_debounce() is holding the lock with IRQs off.
>>>>     + omap2_set_gpio_debounce()
>>>>      + clk_prepare_enable()
>>>>       + clk_prepare() this one might sleep.
>>>>     The number of users of gpiod_set_debounce() / gpio_set_debounce()
>>>>     looks low but still this is not good.
>>>>
>>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>>> ---
>>>
>>> Should be safe to do it.
>>> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
>>>
>>
>> Answered on the wrong thread, sorry for the noise.
>>
>> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> 
> Seems OK but looks like this needs updating against current Linux next
> to apply though.
> 

I've tested this patch on TI 3.14-rt kernel, but I still can see bunch
of "inconsistent lock state" warnings related to the PM runtime (as expected
and as you mentioned in commit log actually).

The problem here is that OMAPs code implemented using PM runtime based
approach and PM runtime is used everywhere. We don't see warnings form
other drivers just because their HW IRQ handlers forced to be threaded, but
that's not the case for OMAP GPIO :(

PM runtime for OMAP GPIO is implemented in irq_safe manner and it works for
non-RT case, but the main question here - How can we proceed for -RT case?

May be you have some thought?

>From my side what I've tried or thought about:
1) OMAP HW IRQ handler can be transformed to threaded IRQ on -RT.
   Can it be acceptable?

2) I've tried to use irq_chip->irq_bus_lock/irq_bus_sync_unlock() callbacks.
   It helps a bit, but there are two problems:
   - These callbacks are not expected to fail;
   - PM runtime calls are still present in omap_gpio_irq_handler().
   Hypothetically, they can be removed, but we'd need to ensure that OMAP GPIO HW
   is powered and ready to process IRQs all the time while GPIO bank IRQ is in use.
   Not trivial thing to do taking into account multi-SoC support, suspend, cpuidle :(

  [code provided just to illustrate idea]
  static void omap_gpio_irq_bus_lock(struct irq_data *data)
  {
       struct gpio_bank *bank = irq_data_get_irq_chip_data(data);

       if (!BANK_USED(bank))
               pm_runtime_get_sync(bank->dev);
  }

  static void gpio_irq_bus_sync_unlock(struct irq_data *data)
  {
       struct gpio_bank *bank = irq_data_get_irq_chip_data(data);
       if (!BANK_USED(bank))
               pm_runtime_put(bank->dev);
  }

I would be appreciated for any comments on this (1 or 2 or ..), thanks. 

-- 
regards,
-grygorii
