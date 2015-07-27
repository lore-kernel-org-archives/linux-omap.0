From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: use raw locks for locking
Date: Mon, 27 Jul 2015 14:50:53 +0200
Message-ID: <CACRpkdaHiJ5qYGu=t7hDTvvUuf4h-Q2_5Xv4GzvSPS1SZ6F_Gw@mail.gmail.com>
References: <1437496011-11486-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1437496011-11486-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 21, 2015 at 6:26 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> This patch converts gpio_bank.lock from a spin_lock into a
> raw_spin_lock. The call path is to access this lock is always under a
> raw_spin_lock, for instance
> - __setup_irq() holds &desc->lock with irq off
>   + __irq_set_trigger()
>    + omap_gpio_irq_type()
>
> - handle_level_irq() (runs with irqs off therefore raw locks)
>   + mask_ack_irq()
>    + omap_gpio_mask_irq()
>
> This fixes the obvious backtrace on -RT. However the locking vs context
> is not and this is not limited to -RT:
> - omap_gpio_irq_type() is called with IRQ off and has an conditional
>   call to pm_runtime_get_sync() which may sleep. Either it may happen or
>   it may not happen but pm_runtime_get_sync() should not be called with
>   irqs off.
>
> - omap_gpio_debounce() is holding the lock with IRQs off.
>   + omap2_set_gpio_debounce()
>    + clk_prepare_enable()
>     + clk_prepare() this one might sleep.
>   The number of users of gpiod_set_debounce() / gpio_set_debounce()
>   looks low but still this is not good.
>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Patch applied.

Now this question appear in my head:

Is drivers/gpio full of stuff that will not work with the -RT kernel,
and is this a change that should be done mutatis mutandis on
all the GPIO drivers?

Yours,
Linus Walleij
