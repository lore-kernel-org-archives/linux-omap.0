From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: OMAP: sporadic hard lock-up when GPIO interrupts occur too fast (with
	preempt-RT and PREEMPT_HARDIRQ)
Date: Thu, 4 Jun 2009 11:51:57 +1200
Message-ID: <5a7b8b7b0906031651l709eb6b7qd6691bf543ccca33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, rt-users <linux-rt-users@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi everyone,

I'm trying to debug a problem with GPIO interrupts on my OMAP3503
(Gumstix Overo) platform with kernel 2.6.29.4-rt16-omap1.

While this is a sporadic lock-up, I haven't been able to reproduce it
when PREEMPT_HARDIRQ is disabled.

I think it might have something to do with this patch (which is applied BTW):
   http://patchwork.kernel.org/patch/16046/
And see this thread:
   http://markmail.org/message/aaqpk5jztrrypsxz

Sometimes, I see a spurious IRQ message like this:
   Spurious irq 95: 0xffffffdf, please flush posted write for irq 31
that the above patch is supposed to fix, just before the system locks
up. Is it possible that the interrupt handler is getting preempted
between acknowledging the interrupt and the 'flush posted write', and
meanwhile another interrupt from the same bank occurs?

To check this hypothesis, I built the kernel with
   CONFIG_PREEMPT_DESKTOP=y
   # CONFIG_PREEMPT_RT is not set
   CONFIG_PREEMPT=y
   CONFIG_PREEMPT_SOFTIRQS=y
   CONFIG_PREEMPT_HARDIRQS=y

which gives a /proc/irq/<irq>/<handler>/threaded flag. When I tried
disabling threading on irqs 246-249 (which are the virtual irqs for
the problematic GPIO interrupts), the problem still occured. I'm not
sure how to disable threading or preemption on the intermediate ISR
(gpio_irq_handler() at arch/arm/plat-omap/gpio.c:959) which determines
which GPIO in the bank caused the interrupt and spawns the virtual
interrupts.

Any ideas for debugging or narrowing down on the cause?

Many thanks,
Hugo
