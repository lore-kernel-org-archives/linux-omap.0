From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] gpio: omap: use raw locks for locking
Date: Mon, 16 Feb 2015 09:54:24 +0100
Message-ID: <CABxcv=mikHw7Tp+9e+=4xbjNqKKAoN=CkszPEzKo0jBWz+wenQ@mail.gmail.com>
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

Thanks a lot for your patch.

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

Agreed that raw_spin_lock should be used instead of spin_lock since
afaiu those are converted to a rt-mutex in PREEMPT_RT and so they
might sleep.

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

Right, those are bugs regardless of PREEMPT_RT or not as you said.
I'll add it to my TODO list, thanks for finding those.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/gpio/gpio-omap.c | 78 ++++++++++++++++++++++++------------------------
>  1 file changed, 39 insertions(+), 39 deletions(-)
>

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
