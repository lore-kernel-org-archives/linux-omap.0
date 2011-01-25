From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Tue, 25 Jan 2011 14:23:10 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1101251418260.31804@localhost6.localdomain6>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com> <20110124110609.GJ16202@n2100.arm.linux.org.uk> <20110124111114.GA19409@n2100.arm.linux.org.uk>
 <AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com> <20110125103231.GD11507@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463795968-1978765975-1295961792=:31804"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:39710 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab1AYNXk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 08:23:40 -0500
In-Reply-To: <20110125103231.GD11507@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795968-1978765975-1295961792=:31804
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 25 Jan 2011, Russell King - ARM Linux wrote:
> On Mon, Jan 24, 2011 at 11:39:13PM -0800, Colin Cross wrote:
> > On Mon, Jan 24, 2011 at 3:11 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Mon, Jan 24, 2011 at 11:06:09AM +0000, Russell King - ARM Linux wrote:
> > >> On Mon, Jan 24, 2011 at 02:21:17PM +0530, Santosh Shilimkar wrote:
> > >> > In CPU low power state, local timer looses its register context. This
> > >> > patch adds context save restore hooks which can be used by platforms
> > >> > appropriately.
> > >>
> > >> I thought the whole point of CLOCK_EVT_FEAT_C3STOP was that the generic
> > >> timer stuff wouldn't rely on it being kept alive?
> > >>
> > >> Hmm, it looks like we bypass the clockevents code by only setting the
> > >> TWD load value at initialization time, not when we switch to periodic
> > >> mode.  We really ought to rewrite it whenever we switch back to periodic
> > >> mode.
> > >>
> > >> I suspect fixing that means you won't need this save/restore support.
> > >
> > > Untested, but should do what's required.
> > >
> > > diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> > > index fd91566..60636f4 100644
> > > --- a/arch/arm/kernel/smp_twd.c
> > > +++ b/arch/arm/kernel/smp_twd.c
> > > @@ -36,6 +36,7 @@ static void twd_set_mode(enum clock_event_mode mode,
> > >                /* timer load already set up */
> > >                ctrl = TWD_TIMER_CONTROL_ENABLE | TWD_TIMER_CONTROL_IT_ENABLE
> > >                        | TWD_TIMER_CONTROL_PERIODIC;
> > > +               __raw_writel(twd_timer_rate / HZ, twd_base + TWD_TIMER_LOAD);
> > >                break;
> > >        case CLOCK_EVT_MODE_ONESHOT:
> > >                /* period set, and timer enabled in 'next_event' hook */
> > > @@ -81,7 +82,7 @@ int twd_timer_ack(void)
> > >
> > >  static void __cpuinit twd_calibrate_rate(void)
> > >  {
> > > -       unsigned long load, count;
> > > +       unsigned long count;
> > >        u64 waitjiffies;
> > >
> > >        /*
> > > @@ -116,10 +117,6 @@ static void __cpuinit twd_calibrate_rate(void)
> > >                printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
> > >                        (twd_timer_rate / 1000000) % 100);
> > >        }
> > > -
> > > -       load = twd_timer_rate / HZ;
> > > -
> > > -       __raw_writel(load, twd_base + TWD_TIMER_LOAD);
> > >  }
> > >
> > >  /*
> > 
> > This doesn't work for oneshot timers if the TWD_TIMER_CONTROL register
> > gets reset by cpu idle between twd_set_mode and twd_set_next_event.
> > Shadowing ctrl in a percpu variable and rewriting it during every call
> > to twd_set_next_event does work, but that's not much different, and a
> > little less efficient, than just saving and restoring the control and
> > load registers in idle.  It does have the advantage that platforms
> > don't need any extra calls.
> 
> The next question is can we teach the generic time infrastructure about
> this so we don't have to modify every clock event driver for it?  We
> really need to get away from having this kind of knowledge buried down
> in the lowest levels of every driver.

In which way? I mean the generic code issues a call to the set_mode
function when we leave the broadcast mode. So what should the generic
code do more ?

Thanks,

	tglx

---1463795968-1978765975-1295961792=:31804--
