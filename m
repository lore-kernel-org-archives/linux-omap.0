From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: Re: get_irq_regs() from soft IRQ
Date: Mon, 29 Jun 2009 21:38:59 +0300
Message-ID: <200906292139.00046.siarhei.siamashka@nokia.com>
References: <200906291631.19562.jpihet@mvista.com>
	<200906291936.57703.siarhei.siamashka@nokia.com>
	<20090629173757.GC9042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
In-Reply-To: <20090629173757.GC9042@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Monday 29 June 2009 20:37:57 ext Russell King - ARM Linux wrote:
> On Mon, Jun 29, 2009 at 07:36:57PM +0300, Siarhei Siamashka wrote:
> > On Monday 29 June 2009 17:31:18 ext Jean Pihet wrote:
> > > I am trying to get the latest IRQ registers from a timer or a work
> > > queue but I am running into problems:
> > > - get_irq_regs() returns NULL in some cases, so it is unsuable and even
> > > causes crash when trying to get the registers values from the returned
> > > ptr - I never get user space registers, only kernel
> > >
> > > The use case is that the performance unit (PMNC) of the Cortex A8 has
> > > some serious bug, in short the performance counters overflow IRQ is to
> > > be avoided. The solution I am implementing is to read and reset the
> > > counters from a work queue that is triggered by a timer.
> >
> > Regarding this oprofile related part. I wonder how you can get oprofile
> > working properly (providing non-bogus results) without performance
> > counters overflow IRQ generation?
>
> I don't think you can - triggering capture on overflow is precisely how
> oprofile works.
>
> The erratum talks about polling for overflow.  By doing this, you are in
> a well defined part of the kernel, which is obviously going to be shown
> as a hot path for every counter, thus making oprofile useless for kernel
> work.
>
> Deferring the interrupt to a workqueue doesn't resolve the problem either.
> The problem has nothing to do with what happens after the interrupt
> occurs - it's about interrupts themselves being lost.
>
> I think just accepting that this erratum breaks oprofile is the only
> realistic solution. ;(

I also thought about the same initially. But the problem still looks like it
can be workarounded, admittedly in quite a dirty way.

We just need to use not a periodic timer, but kind of a watchdog (this can be
implemented with OMAP GPTIMER).

As long as PMU interrupts are coming fast, watchdog is frequently reset and
never shows up anywhere. Everything is working nice.

Now if PMU gets broken, watchdog gets triggered eventually and recovers PMU
state. As PMU could get broken something like 10 times per second in the worst
case in my experiments, having ~10 ms for a watchdog trigger period seemed to
be a  reasonable empirical value.  So in this conditions, PMU will be in a
nonworking state approximately less than 10% of the time in the worst
practical case. Not very nice, but not completely ugly either.

Another problematic condition is when PMU is fine, but is not generating
events naturally (for example we have configured it for cache misses, but are
burning cpu in a loop which is not accessing memory at all). In this case a
watchdog will be triggered periodically for no reason, generating the "noise"
in profiling statistics. This noise needs to be filtered out, and seems like
it is possible to do it. The trick is to reset watchdog counter to a lower
value than it is typically reset in PMU IRQ handler. This way, whenever PMU
interrupt is generated, we check if watchdog counter is below the normal
threshold. If it is lower, then we know that watchdog interrupt was triggered
recently and this sample can be ignored. The difference between normal
watchdog counter reset value and the value which gets set on watchdog
interrupts should provide sufficient time to get out of the watchdog interrupt
handler and its related code, so that it does not show up in statistics that
much.

A working proof of concept patch was submitted there:
http://groups.google.com/group/beagleboard/msg/dd361f3b43fdeff0
Sorry for not posting it to one of the kernel mailing lists, but I thought
that beagleboard mailing list was a good place to find users who may
want to try it and evaluate if it has any practical value. Maybe it was not a
very wise decision.

Unfortunately I'm not a kernel hacker and cleaning up the patch may take
too much time and efforts, taking into account my current knowledge. I would
be happy if somebody else with more hands-on kernel experience could make a
clean and usable Cortex-A8 PMU workaround. I don't care about getting some
part of credit for it or not, the end result is more important :)

One of the obvious problems with the patch (other than race conditions) is
that it is using OMAP-specific GPTIMER. Is there something more portable in
the kernel to provide similar functionality? Or are there any Cortex-A8 r1
cores other than OMAP3 in the wild?

-- 
Best regards,
Siarhei Siamashka

------------------------------------------------------------------------------
