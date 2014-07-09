From: Tony Lindgren <tony@atomide.com>
Subject: Re: gpio-omap: wakeup mask
Date: Wed, 9 Jul 2014 08:24:42 -0700
Message-ID: <20140709152441.GZ28884@atomide.com>
References: <53B3F687.5050502@gmail.com>
 <20140704072752.GC28884@atomide.com>
 <53BD1683.9030505@gmail.com>
 <20140709104142.GO28884@atomide.com>
 <53BD3950.60000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53BD3950.60000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal Huerst <pascal.huerst@gmail.com>
Cc: santosh.shilimkar@ti.com, khilman@deeprootsystems.com, linus.walleij@linaro.org, gnurou@gmail.com, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: linux-omap@vger.kernel.org

* Pascal Huerst <pascal.huerst@gmail.com> [140709 05:47]:
> On 09.07.2014 12:41, Tony Lindgren wrote:
> 
> > If you just comment out the _gpio_rmw part above do
> > things work as expected?
> 
> Yes. It only wakes up on gpio 6 not on gpio 11 anymore.
> 
> > Then if that works as expected, maybe write only some unused bits
> > into wkup_en register and see if it still wakes to all events while
> > it should not?
> 
> If I use the following testcode, everything works as expected:
> 
> //WARN(true, "WARN: bank->base = %08X\n", bank->base);
> 
> if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
>   //_gpio_rmw(base, bank->regs->wkup_en, gpio_bit, trigger != 0);
>   writel(0xABC00000, base + bank->regs->wkup_en);
> 
>   bank->context.wake_en = readl_relaxed(bank->base +
>     bank->regs->wkup_en);
>   printk("bank->base = %08X gpio = %i bank->context->wake_en = %08X\n",
>     bank->base, gpio, bank->context.wake_en);
> }

Hmm weird. It sounds like something like the following is happening:

1. The first GPIO bank is always powered, and does not need to set
   wake-up events

2. When setting the GPIO wake-up events it seems that enabling any
   wake-up event for the first (16?) bits wakes up the system

You might want to check this with some spare GPIOs not in the
first bank and see if you need the wake-up events and if enabling
some bits enables more than one GPIO for wake-up events.

Regards,

Tony
