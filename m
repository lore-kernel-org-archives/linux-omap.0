From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] gpio: omap: use raw locks for locking
Date: Tue, 28 Jul 2015 14:22:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507281417140.3825@nanos>
References: <1437496011-11486-1-git-send-email-bigeasy@linutronix.de> <CACRpkdaHiJ5qYGu=t7hDTvvUuf4h-Q2_5Xv4GzvSPS1SZ6F_Gw@mail.gmail.com> <55B63167.9000107@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <55B63167.9000107@linutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 27 Jul 2015, Sebastian Andrzej Siewior wrote:
> On 07/27/2015 02:50 PM, Linus Walleij wrote:
> > Patch applied.
> thanks.
> 
> > 
> > Now this question appear in my head:
> > 
> > Is drivers/gpio full of stuff that will not work with the -RT kernel,
> > and is this a change that should be done mutatis mutandis on
> > all the GPIO drivers?
> 
> I described two call paths where you need a rawlock_t. If your gpio
> driver uses irq_chip_generic then you a rawlock here and things should
> be fine.
> 
> In general: If your gpio controller acts as an interrupts controller
> (that is via chained handler) then you need the raw-locks if you need
> any locking (if you have a write 1 to mask/unmask/enable/disable
> register then you probably don't need any locking here at all). If the
> gpio controller does not act as an interrupt controller than the
> spinlock_t type should be enough.
> If your gpio-interrupt controller requests its interrupt via
> requested_threaded_irq() then it should do handle_nested_irq() and a
> mutex is probably used for locking.
> 
> Using request_irq() with "0" flags is kind of broken. It works in
> IRQ-context and delivers the interrupts with generic_handle_irq() and
> this one passes it the handler (like handle_edge_irq() /
> handle_level_irq()) which takes a raw_lock. Now, if you boot the
> vanilla kernel with threadedirq then the irq-handler runs in threaded
> context and you can't take a spinlock here anymore. So I think you
> should use here IRQF_NO_THREAD here (and the raw lock type). I added
> tglx on Cc: to back up because it is Monday.

Indeed it was monday.

It's an RT only problem. On mainline spinlock resovles to raw_spinlock.

Now there is the story what breaks in RT:

1) irq controller specific locks which are taken in the irq chip
   callbacks need to be raw_spinlocks because these functions are
   called with irq_desc->lock helds and interrupts disabled.

   If that irq chip lock is not raw you rightfully get a backtrace.

   raw_spinlock_irq(&desc->lock);
   chip->callback()
     spin_lock(chip_private_lock);
       might_sleep() triggers

2) locks which are taken in chained interrupt handlers need to be raw
   on RT. These handlers run in hard interrupt context so again
   might_sleep() rightfully complains.

Thanks,

	tglx
