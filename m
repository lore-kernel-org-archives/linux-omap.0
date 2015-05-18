From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Calling irq_set_irq_wake() from .set_irq_wake()? (was: Re:
 [PATCH] gpio: pcf875x: Revert "gpio: pcf857x: Propagate wake-up setting to
 parent irq controller")
Date: Mon, 18 May 2015 16:31:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505181626060.4225@nanos>
References: <CAMuHMdXYPcQNCHhGa5kC8omtBw_O=Ua+rRJ+gh3tc6dY0oC5JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXYPcQNCHhGa5kC8omtBw_O=Ua+rRJ+gh3tc6dY0oC5JA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Ingo Molnar <mingo@redhat.com>, Roger Quadros <rogerq@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 17 May 2015, Geert Uytterhoeven wrote:
> >>> At least the recursive locking message no longer appears after the revert.
> >>>
> >>> [   30.591905] PM: Syncing filesystems ... done.
> >>> [   30.623060] Freezing user space processes ... (elapsed 0.003 seconds) done.
> >>> [   30.634470] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> >>> [   30.658288] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >>> [   30.663678]
> >>> [   30.663681] =============================================
> >>> [   30.663683] [ INFO: possible recursive locking detected ]
> >>> [   30.663688] 4.1.0-rc3 #1115 Not tainted
> >>> [   30.663693] ---------------------------------------------
> >>> [   30.663697] suspend.sh/2319 is trying to acquire lock:
> >>> [   30.663719]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
> >>> [   30.663722]
> >>> [   30.663722] but task is already holding lock:
> >>> [   30.663734]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
> >>
> >> Does this mean .set_irq_wake() cannot call irq_set_irq_wake()?

It can call it, if it's guaranteed that this wont deadlock.

To tell lockdep that you sure about that, you need to set a different
lock class for the child interrupts. irq_set_lockdep_class() is what
you want to use here.

> >> Many GPIO drivers do that, as they need to propagate wake-up state to the
> >> parent interrupt controller?
> >
> > As I remember, there was similar problem, so I found corresponding patch (just FYI)
> >
> > ab2b926 mfd: Fix twl6030 lockdep recursion warning on setting wake IRQs
> >
> > Not sure such kind of solution is the best choice (
> 
> That looks like a convoluted solution...

Indeed. See above.
 
Thanks,

	tglx
