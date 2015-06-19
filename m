From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH REPOST] gpio: omap: use raw locks for locking
Date: Fri, 19 Jun 2015 23:54:59 +0200
Message-ID: <CABxcv==5Fo-x9CdSu6BYNfBpAS7rp63fHA319J_KvWZZG9q=ng@mail.gmail.com>
References: <20150619170654.GA4937@linutronix.de>
	<5584547B.9040203@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5584547B.9040203@oracle.com>
Sender: linux-gpio-owner@vger.kernel.org
To: santosh shilimkar <santosh.shilimkar@oracle.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 19, 2015 at 7:42 PM, santosh shilimkar
<santosh.shilimkar@oracle.com> wrote:
> On 6/19/2015 10:06 AM, Sebastian Andrzej Siewior wrote:
>>
>> This patch converts gpio_bank.lock from a spin_lock into a
>> raw_spin_lock. The call path is to access this lock is always under a
>> raw_spin_lock, for instance
>> - __setup_irq() holds &desc->lock with irq off
>>    + __irq_set_trigger()
>>     + omap_gpio_irq_type()
>>
>> - handle_level_irq() (runs with irqs off therefore raw locks)
>>    + mask_ack_irq()
>>     + omap_gpio_mask_irq()
>>
>> This fixes the obvious backtrace on -RT. However the locking vs context
>> is not and this is not limited to -RT:
>> - omap_gpio_irq_type() is called with IRQ off and has an conditional
>>    call to pm_runtime_get_sync() which may sleep. Either it may happen or
>>    it may not happen but pm_runtime_get_sync() should not be called with
>>    irqs off.
>>
>> - omap_gpio_debounce() is holding the lock with IRQs off.
>>    + omap2_set_gpio_debounce()
>>     + clk_prepare_enable()
>>      + clk_prepare() this one might sleep.
>>    The number of users of gpiod_set_debounce() / gpio_set_debounce()
>>    looks low but still this is not good.
>>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>
> Should be safe to do it.
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
>

Answered on the wrong thread, sorry for the noise.

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
