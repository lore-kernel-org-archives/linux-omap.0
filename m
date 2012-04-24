From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Tue, 24 Apr 2012 11:50:06 +0200
Message-ID: <CAORVsuWP72dHFSBhX=Kux7GEk33qQgR74a74FFwzA8uniSabAQ@mail.gmail.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	<87ehrtn6na.fsf@ti.com>
	<CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
	<87y5puwhus.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52296 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756600Ab2DXJuH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 05:50:07 -0400
Received: by vcqp1 with SMTP id p1so340912vcq.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 02:50:06 -0700 (PDT)
In-Reply-To: <87y5puwhus.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Hi Grazvydas, Kevin,

I did some gather some performance measurements and statistics using
custom tracepoints in __omap3_enter_idle.
All the details are at
http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measure=
ment#C1_performance_problem:_analysis
=2E

The setup is:
- Beagleboard (OMAP3530) at 500MHz,
- l-o master kernel + functional power states + per-device PM QoS. It
has been checked that the changes from l-o master do not have an
impact on the performance.
- The data transfer is performed using dd from a file in JFFS2 to
/dev/null: 'dd if=3D/tmp/mnt/a of=3D/dev/null bs=3D1M count=3D32'.

On Tue, Apr 17, 2012 at 4:30 PM, Kevin Hilman <khilman@ti.com> wrote:
> Grazvydas Ignotas <notasas@gmail.com> writes:
>
>> On Thu, Apr 12, 2012 at 3:19 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> It would be helpful now to narrow down what are the big contributor=
s to
>>> the overhead in omap_sram_idle(). =A0Most of the code there is skip=
ped for
>>> C1 because the next states for MPU and CORE are both ON.
>>
>> Ok I did some tests, all in mostly idle system with just init, busyb=
ox
>> shell and dd doing a NAND read to /dev/null .
>
=2E..
>
>> MB/s is throughput that
>> dd reports, mA and approx. current draw during the transfer, read fr=
om
>> fuel gauge that's onboard.
>>
>> MB/s| mA|comment
>> =A03.7|218|mainline f549e088b80
>> =A03.8|224|nand qos PM_QOS_CPU_DMA_LATENCY 0 [1]
>> =A04.4|220|[1] + pwrdm_p*_transition commented [2]
>> =A03.8|225|[1] + omap34xx_do_sram_idle->cpu_do_idle [3]
>> =A04.2|210|[1] + pwrdm_set_next_pwrst(per_pd, PWRDM_POWER_ON) [4]
>> =A04.0|224|[1] + 'Deny idle' [5]
>> =A05.1|210|[2] + [4] + [5]
>> =A05.2|202|[5] + omap_sram_idle->cpu_do_idle [6]
>> =A05.5|243|!CONFIG_PM
>> =A06.1|282|busywait DMA end (for reference)

Here are the results (BW in MB/s) on Beagleboard:
- 4.7: without using DMA,

- Using DMA
  2.1: [0]
  2.1: [1] only C1
  2.6: [1]+[2] no pre_ post_
  2.3: [1]+[5] no pwrdm_for_each_clkdm
  2.8: [1]+[5]+[2]
  3.1: [1]+[5]+[6] no omap_sram_idle
  3.1: No IDLE, no omap_sram_idle, all pwrdms to ON

So indeed this shows there is some serious performance issue with the
C1 C-state.

> Thanks for the detailed experiments. =A0This definitely confirms we h=
ave
> some serious unwanted overhead for C1, and our C-state latency values
> are clearly way off base, since they only account HW latency and not =
any
> of the SW latency introduced in omap_sram_idle().
>
>>> There are 2 primary differences that I see as possible causes. =A0I=
 list
>>> them here with a couple more experiments for you to try to help us
>>> narrow this down.
>>>
>>> 1) powerdomain accounting: pwrdm_pre_transition(), pwrdm_post_trans=
ition()
>>>
>>> Could you try using omap_sram_idle() and just commenting out those
>>> calls? =A0Does that help performance? =A0Those iterate over all the
>>> powerdomains, so defintely add some overhead, but I don't think it
>>> would be as significant as what you're seeing.
>>
>> Seems to be taking good part of it.
>>
>>> =A0 =A0Much more likely is...
>>>
>>> 2) jump to SRAM, SDRC self-refresh, SDRC errata workarounds
>>
>> Could not notice any difference.
>>
>> To me it looks like this results from many small things adding up..
>> Idle is called so often that pwrdm_p*_transition() and those
>> pwrdm_for_each_clkdm() walks start slowing everything down, perhaps
>> because they access lots of registers on slow buses?

=46rom the list of contributors, the main ones are:
    (140us) pwrdm_pre_transition and pwrdm_post_transition,
    (105us) omap2_gpio_prepare_for_idle and
omap2_gpio_resume_after_idle. This could be avoided if PER stays ON in
the latency-critical C-states,
    (78us) pwrdm_for_each_clkdm(mpu, core, deny_idle/allow_idle),
    (33us estimated) omap_set_pwrdm_state(mpu, core, neon),
    (11 us) clkdm_allow_idle(mpu). Is this needed?

Here are a few questions and suggestions:
- In case of latency critical C-states could the high-latency code be
bypassed in favor of a much simpler version? Pushing the concept a bit
farther one could have a C1 state that just relaxes the cpu (no WFI),
a C2 state which bypasses a lot of code in __omap3_enter_idle, and the
rest of the C-states as we have today,
- Is it needed to iterate through all the power and clock domains in
order to keep them active?
- Trying to idle some non related power domains (e.g. PER) causes a
performance hit. How to link all the power domains states to the
cpuidle C-state? The per-device PM QoS framework could be used to
constraint some power domains, but this is highly dependent on the use
case.

> Yes PRCM register accesses are unfortunately rather slow, and we've
> known that for some time, but haven't done any detailed analysis of t=
he
> overhead.
That would be worth doing the analysis. A lot of read accesses to the
current, next and previous power states are performed in the idle
code.

> Using the function_graph tracer, I was able to see that the pre/post
> transition are taking an enormous amount of time:
>
> =A0- pwrdm pre-transition: 1400+ us at 600MHz (4000+ us at 125MHz)
> =A0- pwrdm post-transtion: 1600+ us at 600MHz (6000+ us at 125MHz)
>
> Notice the big difference between 600MHz OPP and 125MHz OPP. =A0Are y=
ou
> using CPUfreq at all in your tests? =A0If using cpufreq + ondemand
> governor, you're probably running at low OPP due to lack of CPU activ=
ity
> which will also affect the latencies in the idle path.
>
>> Maybe some register cache would help us there, or are those register=
s
>> expected to be changed by hardware often?
>
> Yes, we've known that some sort of register cache here would be usefu=
l
> for some time, but haven't got to implementing it.
I can try some proof of concept code, just to prove its usefulness.

>> Also trying to idle PER while transfer is ongoing (as reported in
>> previous mail) doesn't sound like a good idea and is one of the
>> reasons for slowdown. Seems to also causing more current drain,
>> ironically.
>
> Agreed. =A0Again, using the function_graph tracer, I get some pretty =
big
> latencies from the GPIO pre/post idling process:
>
> =A0- gpio_prepare_for_idle(): 2400+ us at 600MHz (8200+ us at 125MHz)
> =A0- gpio_resume_from_idle(): 2200+ us at 600MHz (7600+ us at 125MHz)
>
> Removing PER transtions as you did will get rid of those.
>
> I'm looking into this in more detail know, and will likely have a few
> patches for you to experiment with.
>
> Thanks again for digging into this with us,
>
> Kevin
>

Any thoughts?

Regards,
Jean

>>
>>
>> changes (again, sorry for corrupted diffs, but they should be easy t=
o
>> reproduce):
>> [2]:
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -307,7 +307,7 @@ void omap_sram_idle(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_enable_io_chai=
n();
>> =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 pwrdm_pre_transition();
>> +// =A0 =A0 pwrdm_pre_transition();
>>
>> =A0 =A0 =A0 =A0 /* PER */
>> =A0 =A0 =A0 =A0 if (per_next_state < PWRDM_POWER_ON) {
>> @@ -372,7 +373,7 @@ void omap_sram_idle(void)
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 omap3_intc_resume_idle();
>>
>> - =A0 =A0 =A0 pwrdm_post_transition();
>> +// =A0 =A0 pwrdm_post_transition();
>>
>> =A0 =A0 =A0 =A0 /* PER */
>> =A0 =A0 =A0 =A0 if (per_next_state < PWRDM_POWER_ON) {
>> [3]:
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -347,7 +347,7 @@ void omap_sram_idle(void)
>> =A0 =A0 =A0 =A0 if (save_state =3D=3D 1 || save_state =3D=3D 3)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_suspend(save_state, omap34xx_do_=
sram_idle);
>> =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap34xx_do_sram_idle(save_state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_do_idle();
>>
>> =A0 =A0 =A0 =A0 /* Restore normal SDRC POWER settings */
>> =A0 =A0 =A0 =A0 if (cpu_is_omap3430() && omap_rev() >=3D OMAP3430_RE=
V_ES3_0 &&
>> [4]:
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -107,6 +107,7 @@ static int __omap3_enter_idle(struct cpuidle_dev=
ice *dev,
>> =A0 =A0 =A0 =A0 if (index =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(mpu_pd, _cpuidl=
e_deny_idle);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(core_pd, _cpuid=
le_deny_idle);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_next_pwrst(per_pd, PWRDM_POW=
ER_ON);
>> =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 /*
>> [5]:
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -105,8 +105,7 @@ static int __omap3_enter_idle(struct cpuidle_dev=
ice *dev,
>>
>> =A0 =A0 =A0 =A0 /* Deny idle for C1 */
>> =A0 =A0 =A0 =A0 if (index =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(mpu_pd, _cpuidle_=
deny_idle);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(core_pd, _cpuidle=
_deny_idle);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0=
]);
>> =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 /*
>> @@ -128,8 +128,7 @@ static int __omap3_enter_idle(struct cpuidle_dev=
ice *dev,
>>
>> =A0 =A0 =A0 =A0 /* Re-allow idle for C1 */
>> =A0 =A0 =A0 =A0 if (index =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(mpu_pd, _cpuidle_=
allow_idle);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(core_pd, _cpuidle=
_allow_idle);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle(mpu_pd->pwrdm_clkdms[=
0]);
>> =A0 =A0 =A0 =A0 }
>>
>> =A0return_sleep_time:
>> [6]:
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -117,7 +116,8 @@ static int __omap3_enter_idle(struct cpuidle_dev=
ice *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_pm_enter();
>>
>> =A0 =A0 =A0 =A0 /* Execute ARM wfi */
>> - =A0 =A0 =A0 omap_sram_idle();
>> + =A0 =A0 =A0 //omap_sram_idle();
>> + =A0 =A0 =A0 cpu_do_idle();
>>
>> =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0* Call idle CPU PM enter notifier chain to restor=
e
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
