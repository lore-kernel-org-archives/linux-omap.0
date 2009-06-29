From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: Re: get_irq_regs() from soft IRQ
Date: Mon, 29 Jun 2009 22:45:11 +0300
Message-ID: <200906292245.11840.siarhei.siamashka@nokia.com>
References: <200906291631.19562.jpihet@mvista.com>
	<200906292139.00046.siarhei.siamashka@nokia.com>
	<200906292049.59789.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
In-Reply-To: <200906292049.59789.jpihet@mvista.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: ext Jean Pihet <jpihet@mvista.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

On Monday 29 June 2009 21:49:59 ext Jean Pihet wrote:
[...]
> > We just need to use not a periodic timer, but kind of a watchdog (this
> > can be implemented with OMAP GPTIMER).
> >
> > As long as PMU interrupts are coming fast, watchdog is frequently reset
> > and never shows up anywhere. Everything is working nice.
> >
> > Now if PMU gets broken, watchdog gets triggered eventually and recovers
> > PMU state. As PMU could get broken something like 10 times per second in
> > the worst case in my experiments, having ~10 ms for a watchdog trigger
> > period seemed to be a  reasonable empirical value.  So in this
> > conditions, PMU will be in a nonworking state approximately less than 10%
> > of the time in the worst practical case. Not very nice, but not
> > completely ugly either.
>
> The accuracy is not very good.

Yes, but it is the worst case. In "normal" case when PMU not broken or very
rarely broken, the statistics would be quite good. One of the reasons of
dropping working on this patch was also the fact that in some cases Cortex-A8
PMU even works reliable enough :) Adding some suspicious weird extra logic may
be not very desired by the people, who are quite satisfied even with the
current oprofile state on Cortex-A8 chips (numbercrunching applications with
relatively low number of syscalls and hence rarely touching any coprocessor
registers, are mostly unaffected).

Some adaptive watchdog trigger period may be better (try to predict when the
next PMU interrupt is going to normally happen and tune watchdog timeout at
runtime), but also may be more complex and may theoretically still misbehave
in some cases.

> > Another problematic condition is when PMU is fine, but is not generating
> > events naturally (for example we have configured it for cache misses, but
> > are burning cpu in a loop which is not accessing memory at all). In this
> > case a watchdog will be triggered periodically for no reason, generating
> > the "noise" in profiling statistics. This noise needs to be filtered out,
> > and seems like it is possible to do it. The trick is to reset watchdog
> > counter to a lower value than it is typically reset in PMU IRQ handler.
> > This way, whenever PMU interrupt is generated, we check if watchdog
> > counter is below the normal threshold. If it is lower, then we know that
> > watchdog interrupt was triggered recently and this sample can be ignored.
> > The difference between normal watchdog counter reset value and the value
> > which gets set on watchdog interrupts should provide sufficient time to
> > get out of the watchdog interrupt handler and its related code, so that
> > it does not show up in statistics that much.

And forgot to mention here, very low frequency events (with frequency lower
than the frequency of watchdog) may be quite problematic and still distort the
statistics because they will be filtered out. Tuning all the magic values may
turn out to be a hell.

But at the very least, all the watchdog interrupts (both false alarms and real
cases of PMU breakage) can be counted and taken into account. This statistics
could be somehow reported to the user, so that (s)he would make a decision
if the final profiling statistics can be trusted and for how much time the PMU
was actually broken.

> > A working proof of concept patch was submitted there:
> > http://groups.google.com/group/beagleboard/msg/dd361f3b43fdeff0
> > Sorry for not posting it to one of the kernel mailing lists, but I
> > thought that beagleboard mailing list was a good place to find users who
> > may want to try it and evaluate if it has any practical value. Maybe it
> > was not a very wise decision.
> >
> > Unfortunately I'm not a kernel hacker and cleaning up the patch may take
> > too much time and efforts, taking into account my current knowledge. I
> > would be happy if somebody else with more hands-on kernel experience
> > could make a clean and usable Cortex-A8 PMU workaround. I don't care
> > about getting some part of credit for it or not, the end result is more
> > important
> >
> > :)
>
> I am ok to help
>
> > One of the obvious problems with the patch (other than race conditions)
> > is that it is using OMAP-specific GPTIMER. Is there something more
> > portable in the kernel to provide similar functionality? Or are there any
> > Cortex-A8 r1 cores other than OMAP3 in the wild?
>
> You can use a 'struct timer_list' and the setup_timer, mod_timer,
> del_timer_sync. Another API is the hight resolution timers (HRT) but I do
> not think we need such a high precision timer here.

Thanks

-- 
Best regards,
Siarhei Siamashka

------------------------------------------------------------------------------
