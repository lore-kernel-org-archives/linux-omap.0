From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Tue, 24 Apr 2012 14:50:43 +0200
Message-ID: <CAORVsuU2aBMOk5-Vbi17zpM82U7q+kX5NE0eV0Y-9S82=-uWAA@mail.gmail.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	<87ehrtn6na.fsf@ti.com>
	<CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
	<87y5puwhus.fsf@ti.com>
	<CAORVsuWP72dHFSBhX=Kux7GEk33qQgR74a74FFwzA8uniSabAQ@mail.gmail.com>
	<4F96828B.1090902@ti.com>
	<1335270113.2149.87.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47350 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab2DXMun convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 08:50:43 -0400
Received: by vcqp1 with SMTP id p1so452285vcq.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 05:50:43 -0700 (PDT)
In-Reply-To: <1335270113.2149.87.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Hi Tero,

On Tue, Apr 24, 2012 at 2:21 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Tue, 2012-04-24 at 16:08 +0530, Santosh Shilimkar wrote:
>> + Tero
>>
>> On Tuesday 24 April 2012 03:20 PM, Jean Pihet wrote:
>> > Hi Grazvydas, Kevin,
>> >
>> > I did some gather some performance measurements and statistics usi=
ng
>> > custom tracepoints in __omap3_enter_idle.
>> > All the details are at
>> > http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Me=
asurement#C1_performance_problem:_analysis
>> > .
>> >
>> Nice data.
>>
>> > The setup is:
>> > - Beagleboard (OMAP3530) at 500MHz,
>> > - l-o master kernel + functional power states + per-device PM QoS.=
 It
>> > has been checked that the changes from l-o master do not have an
>> > impact on the performance.
>> > - The data transfer is performed using dd from a file in JFFS2 to
>> > /dev/null: 'dd if=3D/tmp/mnt/a of=3D/dev/null bs=3D1M count=3D32'.
>
> Question: what is used for gathering the latency values?
I used ftrace tracepoints which are supposed to be low overhead. I
checked that the overhead cannot be measured on the measurement
interval (>400us), given the fact that the time base is 31us (32 KHz
clock).

>> >
>> > On Tue, Apr 17, 2012 at 4:30 PM, Kevin Hilman <khilman@ti.com> wro=
te:
>> >> Grazvydas Ignotas <notasas@gmail.com> writes:
>> >>
>> >>> On Thu, Apr 12, 2012 at 3:19 AM, Kevin Hilman <khilman@ti.com> w=
rote:
>> >>>> It would be helpful now to narrow down what are the big contrib=
utors to
>> >>>> the overhead in omap_sram_idle(). =A0Most of the code there is =
skipped for
>> >>>> C1 because the next states for MPU and CORE are both ON.
>> >>>
>> >>> Ok I did some tests, all in mostly idle system with just init, b=
usybox
>> >>> shell and dd doing a NAND read to /dev/null .
>> >>
>> > ...
>> >>
>> >>> MB/s is throughput that
>> >>> dd reports, mA and approx. current draw during the transfer, rea=
d from
>> >>> fuel gauge that's onboard.
>> >>>
>> >>> MB/s| mA|comment
>> >>> =A03.7|218|mainline f549e088b80
>> >>> =A03.8|224|nand qos PM_QOS_CPU_DMA_LATENCY 0 [1]
>> >>> =A04.4|220|[1] + pwrdm_p*_transition commented [2]
>> >>> =A03.8|225|[1] + omap34xx_do_sram_idle->cpu_do_idle [3]
>> >>> =A04.2|210|[1] + pwrdm_set_next_pwrst(per_pd, PWRDM_POWER_ON) [4=
]
>> >>> =A04.0|224|[1] + 'Deny idle' [5]
>> >>> =A05.1|210|[2] + [4] + [5]
>> >>> =A05.2|202|[5] + omap_sram_idle->cpu_do_idle [6]
>> >>> =A05.5|243|!CONFIG_PM
>> >>> =A06.1|282|busywait DMA end (for reference)
>> >
>> > Here are the results (BW in MB/s) on Beagleboard:
>> > - 4.7: without using DMA,
>> >
>> > - Using DMA
>> > =A0 2.1: [0]
>> > =A0 2.1: [1] only C1
>> > =A0 2.6: [1]+[2] no pre_ post_
>> > =A0 2.3: [1]+[5] no pwrdm_for_each_clkdm
>> > =A0 2.8: [1]+[5]+[2]
>> > =A0 3.1: [1]+[5]+[6] no omap_sram_idle
>> > =A0 3.1: No IDLE, no omap_sram_idle, all pwrdms to ON
>> >
>> > So indeed this shows there is some serious performance issue with =
the
>> > C1 C-state.
>> >
>> Looks like other clock-domain (notably l4, per, AON) should be denie=
d
>> idle in C1 to avoid the huge penalties. It might just do the trick.
>>
>>
>> >> Thanks for the detailed experiments. =A0This definitely confirms =
we have
>> >> some serious unwanted overhead for C1, and our C-state latency va=
lues
>> >> are clearly way off base, since they only account HW latency and =
not any
>> >> of the SW latency introduced in omap_sram_idle().
>> >>
>> >>>> There are 2 primary differences that I see as possible causes. =
=A0I list
>> >>>> them here with a couple more experiments for you to try to help=
 us
>> >>>> narrow this down.
>> >>>>
>> >>>> 1) powerdomain accounting: pwrdm_pre_transition(), pwrdm_post_t=
ransition()
>> >>>>
>> >>>> Could you try using omap_sram_idle() and just commenting out th=
ose
>> >>>> calls? =A0Does that help performance? =A0Those iterate over all=
 the
>> >>>> powerdomains, so defintely add some overhead, but I don't think=
 it
>> >>>> would be as significant as what you're seeing.
>> >>>
>> >>> Seems to be taking good part of it.
>> >>>
>> >>>> =A0 =A0Much more likely is...
>> >>>>
>> >>>> 2) jump to SRAM, SDRC self-refresh, SDRC errata workarounds
>> >>>
>> >>> Could not notice any difference.
>> >>>
>> >>> To me it looks like this results from many small things adding u=
p..
>> >>> Idle is called so often that pwrdm_p*_transition() and those
>> >>> pwrdm_for_each_clkdm() walks start slowing everything down, perh=
aps
>> >>> because they access lots of registers on slow buses?
>> >
>> > From the list of contributors, the main ones are:
>> > =A0 =A0 (140us) pwrdm_pre_transition and pwrdm_post_transition,
>>
>> I have observed this one on OMAP4 too. There was a plan to remove
>> this as part of Tero's PD/CD use-counting series.
>
> pwrdm_pre / post transitions could be optimized a bit already now. Th=
ey
> only should need to be called for mpu / core and per domains, but
> currently they scan through everything.
>
>>
>> > =A0 =A0 (105us) omap2_gpio_prepare_for_idle and
>> > omap2_gpio_resume_after_idle. This could be avoided if PER stays O=
N in
>> > the latency-critical C-states,
>> Yes. In C1 when you deny idle for per, there should be no need to
>> call this. But even in the case when it is called, why is it taking
>> 105 uS. Needs to dig further.
>>
>> > =A0 =A0 (78us) pwrdm_for_each_clkdm(mpu, core, deny_idle/allow_idl=
e),
>> Depending on OPP, a PRCM read can take upto ~12-14 uS, so above
>> shouldn't be surprising.
>>
>> > =A0 =A0 (33us estimated) omap_set_pwrdm_state(mpu, core, neon),
>> This is again dominated by PRCM read
>>
>> > =A0 =A0 (11 us) clkdm_allow_idle(mpu). Is this needed?
>> >
>> I guess yes other wise when C2+ is attempted MPU CD can't idle.
>>
>> > Here are a few questions and suggestions:
>> > - In case of latency critical C-states could the high-latency code=
 be
>> > bypassed in favor of a much simpler version? Pushing the concept a=
 bit
>> > farther one could have a C1 state that just relaxes the cpu (no WF=
I),
>> > a C2 state which bypasses a lot of code in __omap3_enter_idle, and=
 the
>> > rest of the C-states as we have today,
>> We should do that. Infact C1 state should be as lite as possible lik=
e
>> WFI or so.
>>
>> > - Is it needed to iterate through all the power and clock domains =
in
>> > order to keep them active?
>> That iteration should be removed.
>>
>> > - Trying to idle some non related power domains (e.g. PER) causes =
a
>> > performance hit. How to link all the power domains states to the
>> > cpuidle C-state? The per-device PM QoS framework could be used to
>> > constraint some power domains, but this is highly dependent on the=
 use
>> > case.
>> >
>> Note that just limiting PER PD state to ON is not going to
>> solve the penalty. You need to avoid per CD transition and
>> hence deny idle. I remember Nokia team did this on some
>> products.
>
> n9 kernel (which is available here
> http://harmattan-dev.nokia.com/pool/harmattan/free/k/kernel/) contain=
ed
> a lot of optimizations in the idle path. Maybe someone should take a
> look at this at some point.
Ok, thanks for the link.

>
>>
>>
>> >> Yes PRCM register accesses are unfortunately rather slow, and we'=
ve
>> >> known that for some time, but haven't done any detailed analysis =
of the
>> >> overhead.
>> > That would be worth doing the analysis. A lot of read accesses to =
the
>> > current, next and previous power states are performed in the idle
>> > code.
>> >
>> >> Using the function_graph tracer, I was able to see that the pre/p=
ost
>> >> transition are taking an enormous amount of time:
>> >>
>> >> =A0- pwrdm pre-transition: 1400+ us at 600MHz (4000+ us at 125MHz=
)
>> >> =A0- pwrdm post-transtion: 1600+ us at 600MHz (6000+ us at 125MHz=
)
>> >>
>> >> Notice the big difference between 600MHz OPP and 125MHz OPP. =A0A=
re you
>> >> using CPUfreq at all in your tests? =A0If using cpufreq + ondeman=
d
>> >> governor, you're probably running at low OPP due to lack of CPU a=
ctivity
>> >> which will also affect the latencies in the idle path.
>> >>
>> >>> Maybe some register cache would help us there, or are those regi=
sters
>> >>> expected to be changed by hardware often?
>> >>
>> >> Yes, we've known that some sort of register cache here would be u=
seful
>> >> for some time, but haven't got to implementing it.
>> > I can try some proof of concept code, just to prove its usefulness=
=2E
>> >
>> Please do so. We were hoping that after Tero's series, we don't need
>> this pre/post stuff but am not sure if Tero is addressing that.
>>
>> Register cache initiative is most welcome.
>>
>> Regards
>> Santosh
>
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
