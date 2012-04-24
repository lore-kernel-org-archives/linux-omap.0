From: Tero Kristo <t-kristo@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Tue, 24 Apr 2012 15:21:53 +0300
Message-ID: <1335270113.2149.87.camel@sokoban>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	 <877gxobudk.fsf@ti.com>
	 <CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	 <87ehrtn6na.fsf@ti.com>
	 <CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
	 <87y5puwhus.fsf@ti.com>
	 <CAORVsuWP72dHFSBhX=Kux7GEk33qQgR74a74FFwzA8uniSabAQ@mail.gmail.com>
	 <4F96828B.1090902@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33416 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab2DXMV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 08:21:59 -0400
In-Reply-To: <4F96828B.1090902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Tue, 2012-04-24 at 16:08 +0530, Santosh Shilimkar wrote:
> + Tero
> 
> On Tuesday 24 April 2012 03:20 PM, Jean Pihet wrote:
> > Hi Grazvydas, Kevin,
> > 
> > I did some gather some performance measurements and statistics using
> > custom tracepoints in __omap3_enter_idle.
> > All the details are at
> > http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement#C1_performance_problem:_analysis
> > .
> > 
> Nice data.
> 
> > The setup is:
> > - Beagleboard (OMAP3530) at 500MHz,
> > - l-o master kernel + functional power states + per-device PM QoS. It
> > has been checked that the changes from l-o master do not have an
> > impact on the performance.
> > - The data transfer is performed using dd from a file in JFFS2 to
> > /dev/null: 'dd if=/tmp/mnt/a of=/dev/null bs=1M count=32'.

Question: what is used for gathering the latency values?

> > 
> > On Tue, Apr 17, 2012 at 4:30 PM, Kevin Hilman <khilman@ti.com> wrote:
> >> Grazvydas Ignotas <notasas@gmail.com> writes:
> >>
> >>> On Thu, Apr 12, 2012 at 3:19 AM, Kevin Hilman <khilman@ti.com> wrote:
> >>>> It would be helpful now to narrow down what are the big contributors to
> >>>> the overhead in omap_sram_idle().  Most of the code there is skipped for
> >>>> C1 because the next states for MPU and CORE are both ON.
> >>>
> >>> Ok I did some tests, all in mostly idle system with just init, busybox
> >>> shell and dd doing a NAND read to /dev/null .
> >>
> > ...
> >>
> >>> MB/s is throughput that
> >>> dd reports, mA and approx. current draw during the transfer, read from
> >>> fuel gauge that's onboard.
> >>>
> >>> MB/s| mA|comment
> >>>  3.7|218|mainline f549e088b80
> >>>  3.8|224|nand qos PM_QOS_CPU_DMA_LATENCY 0 [1]
> >>>  4.4|220|[1] + pwrdm_p*_transition commented [2]
> >>>  3.8|225|[1] + omap34xx_do_sram_idle->cpu_do_idle [3]
> >>>  4.2|210|[1] + pwrdm_set_next_pwrst(per_pd, PWRDM_POWER_ON) [4]
> >>>  4.0|224|[1] + 'Deny idle' [5]
> >>>  5.1|210|[2] + [4] + [5]
> >>>  5.2|202|[5] + omap_sram_idle->cpu_do_idle [6]
> >>>  5.5|243|!CONFIG_PM
> >>>  6.1|282|busywait DMA end (for reference)
> > 
> > Here are the results (BW in MB/s) on Beagleboard:
> > - 4.7: without using DMA,
> > 
> > - Using DMA
> >   2.1: [0]
> >   2.1: [1] only C1
> >   2.6: [1]+[2] no pre_ post_
> >   2.3: [1]+[5] no pwrdm_for_each_clkdm
> >   2.8: [1]+[5]+[2]
> >   3.1: [1]+[5]+[6] no omap_sram_idle
> >   3.1: No IDLE, no omap_sram_idle, all pwrdms to ON
> > 
> > So indeed this shows there is some serious performance issue with the
> > C1 C-state.
> >
> Looks like other clock-domain (notably l4, per, AON) should be denied
> idle in C1 to avoid the huge penalties. It might just do the trick.
> 
> 
> >> Thanks for the detailed experiments.  This definitely confirms we have
> >> some serious unwanted overhead for C1, and our C-state latency values
> >> are clearly way off base, since they only account HW latency and not any
> >> of the SW latency introduced in omap_sram_idle().
> >>
> >>>> There are 2 primary differences that I see as possible causes.  I list
> >>>> them here with a couple more experiments for you to try to help us
> >>>> narrow this down.
> >>>>
> >>>> 1) powerdomain accounting: pwrdm_pre_transition(), pwrdm_post_transition()
> >>>>
> >>>> Could you try using omap_sram_idle() and just commenting out those
> >>>> calls?  Does that help performance?  Those iterate over all the
> >>>> powerdomains, so defintely add some overhead, but I don't think it
> >>>> would be as significant as what you're seeing.
> >>>
> >>> Seems to be taking good part of it.
> >>>
> >>>>    Much more likely is...
> >>>>
> >>>> 2) jump to SRAM, SDRC self-refresh, SDRC errata workarounds
> >>>
> >>> Could not notice any difference.
> >>>
> >>> To me it looks like this results from many small things adding up..
> >>> Idle is called so often that pwrdm_p*_transition() and those
> >>> pwrdm_for_each_clkdm() walks start slowing everything down, perhaps
> >>> because they access lots of registers on slow buses?
> > 
> > From the list of contributors, the main ones are:
> >     (140us) pwrdm_pre_transition and pwrdm_post_transition,
> 
> I have observed this one on OMAP4 too. There was a plan to remove
> this as part of Tero's PD/CD use-counting series.

pwrdm_pre / post transitions could be optimized a bit already now. They
only should need to be called for mpu / core and per domains, but
currently they scan through everything.

> 
> >     (105us) omap2_gpio_prepare_for_idle and
> > omap2_gpio_resume_after_idle. This could be avoided if PER stays ON in
> > the latency-critical C-states,
> Yes. In C1 when you deny idle for per, there should be no need to
> call this. But even in the case when it is called, why is it taking
> 105 uS. Needs to dig further.
> 
> >     (78us) pwrdm_for_each_clkdm(mpu, core, deny_idle/allow_idle),
> Depending on OPP, a PRCM read can take upto ~12-14 uS, so above
> shouldn't be surprising.
> 
> >     (33us estimated) omap_set_pwrdm_state(mpu, core, neon),
> This is again dominated by PRCM read
> 
> >     (11 us) clkdm_allow_idle(mpu). Is this needed?
> > 
> I guess yes other wise when C2+ is attempted MPU CD can't idle.
> 
> > Here are a few questions and suggestions:
> > - In case of latency critical C-states could the high-latency code be
> > bypassed in favor of a much simpler version? Pushing the concept a bit
> > farther one could have a C1 state that just relaxes the cpu (no WFI),
> > a C2 state which bypasses a lot of code in __omap3_enter_idle, and the
> > rest of the C-states as we have today,
> We should do that. Infact C1 state should be as lite as possible like
> WFI or so.
> 
> > - Is it needed to iterate through all the power and clock domains in
> > order to keep them active?
> That iteration should be removed.
> 
> > - Trying to idle some non related power domains (e.g. PER) causes a
> > performance hit. How to link all the power domains states to the
> > cpuidle C-state? The per-device PM QoS framework could be used to
> > constraint some power domains, but this is highly dependent on the use
> > case.
> >
> Note that just limiting PER PD state to ON is not going to
> solve the penalty. You need to avoid per CD transition and
> hence deny idle. I remember Nokia team did this on some
> products.

n9 kernel (which is available here
http://harmattan-dev.nokia.com/pool/harmattan/free/k/kernel/) contained
a lot of optimizations in the idle path. Maybe someone should take a
look at this at some point.

> 
> 
> >> Yes PRCM register accesses are unfortunately rather slow, and we've
> >> known that for some time, but haven't done any detailed analysis of the
> >> overhead.
> > That would be worth doing the analysis. A lot of read accesses to the
> > current, next and previous power states are performed in the idle
> > code.
> > 
> >> Using the function_graph tracer, I was able to see that the pre/post
> >> transition are taking an enormous amount of time:
> >>
> >>  - pwrdm pre-transition: 1400+ us at 600MHz (4000+ us at 125MHz)
> >>  - pwrdm post-transtion: 1600+ us at 600MHz (6000+ us at 125MHz)
> >>
> >> Notice the big difference between 600MHz OPP and 125MHz OPP.  Are you
> >> using CPUfreq at all in your tests?  If using cpufreq + ondemand
> >> governor, you're probably running at low OPP due to lack of CPU activity
> >> which will also affect the latencies in the idle path.
> >>
> >>> Maybe some register cache would help us there, or are those registers
> >>> expected to be changed by hardware often?
> >>
> >> Yes, we've known that some sort of register cache here would be useful
> >> for some time, but haven't got to implementing it.
> > I can try some proof of concept code, just to prove its usefulness.
> > 
> Please do so. We were hoping that after Tero's series, we don't need
> this pre/post stuff but am not sure if Tero is addressing that.
> 
> Register cache initiative is most welcome.
> 
> Regards
> Santosh


