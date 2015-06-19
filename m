From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] gpio: omap: use raw locks for locking
Date: Fri, 19 Jun 2015 23:52:34 +0200
Message-ID: <CABxcv==rPLGKSSuXNFqh1gSgDH0DsD2qDYJdXhspwojzAFE1Pw@mail.gmail.com>
References: <1423757436-18986-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1423757436-18986-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Sebastian,

On Thu, Feb 12, 2015 at 5:10 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> This patch converts gpio_bank.lock from a spin_lock into a
> raw_spin_lock. The call path to access this lock is always under a
> raw_spin_lock, for instance
> - __setup_irq() holds &desc->lock with irq off
>   + __irq_set_trigger()
>    + omap_gpio_irq_type()
>
> - handle_level_irq() (runs with irqs off therefore raw locks)
>   + mask_ack_irq()
>    + omap_gpio_mask_irq()
>
> This fixes the obvious backtrace on -RT. However I noticed two cases
> where it looks wrong and this is not limited to -RT:
> - omap_gpio_irq_type() is called with IRQ off and has an conditional
>   call to pm_runtime_get_sync() which may sleep. Either it may happen or
>   it may not happen but pm_runtime_get_sync() should not be called in an
>   atomic section.
>
> - omap_gpio_debounce() is holding the lock with IRQs off.
>   + omap2_set_gpio_debounce()
>    + clk_prepare_enable()
>     + clk_prepare() this one might sleep.
>   The number of users of gpiod_set_debounce() / gpio_set_debounce()
>   looks low but still this is not good.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

I had already acked the first time you posted this [0] but you didn't
carry the tag so here goes again:

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier

[0]: https://patchwork.ozlabs.org/patch/439249/
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
