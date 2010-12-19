From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Date: Sun, 19 Dec 2010 15:05:56 +0100
Message-ID: <19726.4420.289089.490319@pilspetsen.it.uu.se>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<19725.57447.256528.883703@pilspetsen.it.uu.se>
	<20101219105209.GN9937@n2100.arm.linux.org.uk>
	<19725.64412.395353.947407@pilspetsen.it.uu.se>
	<20101219125508.GG3047@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101219125508.GG3047@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@st.com>, Mikael Pettersson <mikpe@it.uu.se>, Kevin Hilman <khilman@deeprootsystems.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kukjin Kim <kgene.kim@samsung.com>, "Hans J. Koch" <hjk@linutronix.de>, Scott Branden <sbranden@broadcom.com>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Alessandro Rubini <rubini@unipv.it>, Sascha Hauer <kernel@pengutronix.de>, Wan ZongShun <mcuos.com@gmail.com>, linux-arm-msm@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Walker <dwalker@codeaurora.org>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Bryan Huntsman <bryanh@code>
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux writes:
 > > We take an early timer interrupt and call NULL in the
 > > 
 > > 	evt->event_handler(evt);
 > > 
 > > statement in iop_timer_interrupt(). Apparently the evt (dev_id) passed
 > > to the interrupt handler isn't initialized at this point.
 > 
 > evt is initialized, it's done statically:
 > 
 > static struct irqaction iop_timer_irq = {
 >         .dev_id         = &iop_clockevent,
 > };
 > 
 > What isn't initialized at this early point is evt->event_handler.
 > 
 > > The most visible change the sched_clock patches did in plat-iop was to add
 > > a call to init_sched_clock() at the very start of iop_init_time(), before
 > > the timer IRQ, clockevent, and clocksource have been set up. Moving that call
 > > to the very end of iop_init_time() [see below] made the kernel boot again,
 > > and the interactivity problems were also solved.
 > 
 > I think this is a bug just waiting to happen, and the sched_clock patch
 > just gives it a helping hand (by accidentally enabling interrupts early
 > - and that's something which also needs fixing.)
 > 
 > Here's the event device setup code:
 > 
 >         write_tmr0(timer_ctl & ~IOP_TMR_EN);
 >         setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
 >         clockevents_calc_mult_shift(&iop_clockevent,
 >                                     tick_rate, IOP_MIN_RANGE);
 >         iop_clockevent.max_delta_ns =
 >                 clockevent_delta2ns(0xfffffffe, &iop_clockevent);
 >         iop_clockevent.min_delta_ns =
 >                 clockevent_delta2ns(0xf, &iop_clockevent);
 >         iop_clockevent.cpumask = cpumask_of(0);
 >         clockevents_register_device(&iop_clockevent);
 >         write_trr0(ticks_per_jiffy - 1);
 >         write_tcr0(ticks_per_jiffy - 1);
 >         write_tmr0(timer_ctl);
 > 
 > First thing is that although the timer is stopped before the IRQ is
 > registered, there is no clearing of any pending timer interrupt at that
 > time.  As we don't know what state the timer was in, we can't be sure
 > that the interrupt isn't already pending.
 > 
 > Second thing is why is the timer being enabled by this code after it's
 > been registered.  This is something which should be done by the
 > clockevents code when it's ready via the ->set_mode callback, not when
 > the platform decides to do so - otherwise you can call the interrupt
 > handler when evt->event_handler has not been setup.

When I did the IOP clockevents conversion I didn't know that the
timer should be disabled, so I probably just kept the previous code
to enable it.

 > So, I think this will solve the IOP misbehaviour.  What I don't know
 > is what the cryptic txx0() suffixes on these write statements are
 > (what's the difference between trr and tcr?  tcr = timer counter
 > register, trr = timer ? register?

tmr = timer mode register
tcr = timer counter register
trr = timer reload register

When a timer is in periodic mode it reloads itself from its reload
register when the counter register decrements to zero.

 >  Does trr need to be written in
 > ->set_mode (if so that's another bug in this code)?

trr{0,1} need not and should not be changed after iop_time_init().

 > diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
 > index 0ca000d..e937e5d 100644
 > --- a/arch/arm/plat-iop/time.c
 > +++ b/arch/arm/plat-iop/time.c
 > @@ -162,6 +162,7 @@ void __init iop_init_time(unsigned long tick_rate)
 >  	 * Set up interrupting clockevent timer 0.
 >  	 */
 >  	write_tmr0(timer_ctl & ~IOP_TMR_EN);
 > +	write_tisr(1);
 >  	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
 >  	clockevents_calc_mult_shift(&iop_clockevent,
 >  				    tick_rate, IOP_MIN_RANGE);
 > @@ -171,9 +172,6 @@ void __init iop_init_time(unsigned long tick_rate)
 >  		clockevent_delta2ns(0xf, &iop_clockevent);
 >  	iop_clockevent.cpumask = cpumask_of(0);
 >  	clockevents_register_device(&iop_clockevent);
 > -	write_trr0(ticks_per_jiffy - 1);
 > -	write_tcr0(ticks_per_jiffy - 1);
 > -	write_tmr0(timer_ctl);
 >  
 >  	/*
 >  	 * Set up free-running clocksource timer 1.

Yes, this seems correct. Tested in a vanilla kernel w/o sched_clock patches,
and in a kernel with the sched_clock patches it eliminated the boot hang.
