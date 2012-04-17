From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Tue, 17 Apr 2012 07:30:51 -0700
Message-ID: <87y5puwhus.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	<87ehrtn6na.fsf@ti.com>
	<CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48328 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752970Ab2DQOa4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Apr 2012 10:30:56 -0400
Received: by dang27 with SMTP id g27so7808448dan.1
        for <linux-omap@vger.kernel.org>; Tue, 17 Apr 2012 07:30:55 -0700 (PDT)
In-Reply-To: <CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
	(Grazvydas Ignotas's message of "Fri, 13 Apr 2012 22:32:57 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Thu, Apr 12, 2012 at 3:19 AM, Kevin Hilman <khilman@ti.com> wrote:
>> It would be helpful now to narrow down what are the big contributors=
 to
>> the overhead in omap_sram_idle(). =C2=A0Most of the code there is sk=
ipped for
>> C1 because the next states for MPU and CORE are both ON.
>
> Ok I did some tests, all in mostly idle system with just init, busybo=
x
> shell and dd doing a NAND read to /dev/null .=20

Hmm, I seem to get a hang using dd to read from NAND /dev/mtdX on my
Overo.  I saw your patch 'mtd: omap2: fix resource leak in prefetch-bus=
y
path' but that didn't seem to help my crash.

> MB/s is throughput that
> dd reports, mA and approx. current draw during the transfer, read fro=
m
> fuel gauge that's onboard.
>
> MB/s| mA|comment
>  3.7|218|mainline f549e088b80
>  3.8|224|nand qos PM_QOS_CPU_DMA_LATENCY 0 [1]
>  4.4|220|[1] + pwrdm_p*_transition commented [2]
>  3.8|225|[1] + omap34xx_do_sram_idle->cpu_do_idle [3]
>  4.2|210|[1] + pwrdm_set_next_pwrst(per_pd, PWRDM_POWER_ON) [4]
>  4.0|224|[1] + 'Deny idle' [5]
>  5.1|210|[2] + [4] + [5]
>  5.2|202|[5] + omap_sram_idle->cpu_do_idle [6]
>  5.5|243|!CONFIG_PM
>  6.1|282|busywait DMA end (for reference)

Thanks for the detailed experiments.  This definitely confirms we have
some serious unwanted overhead for C1, and our C-state latency values
are clearly way off base, since they only account HW latency and not an=
y
of the SW latency introduced in omap_sram_idle().

>> There are 2 primary differences that I see as possible causes. =C2=A0=
I list
>> them here with a couple more experiments for you to try to help us
>> narrow this down.
>>
>> 1) powerdomain accounting: pwrdm_pre_transition(), pwrdm_post_transi=
tion()
>>
>> Could you try using omap_sram_idle() and just commenting out those
>> calls? =C2=A0Does that help performance? =C2=A0Those iterate over al=
l the
>> powerdomains, so defintely add some overhead, but I don't think it
>> would be as significant as what you're seeing.
>
> Seems to be taking good part of it.
>
>> =C2=A0 =C2=A0Much more likely is...
>>
>> 2) jump to SRAM, SDRC self-refresh, SDRC errata workarounds
>
> Could not notice any difference.
>
> To me it looks like this results from many small things adding up..
> Idle is called so often that pwrdm_p*_transition() and those
> pwrdm_for_each_clkdm() walks start slowing everything down, perhaps
> because they access lots of registers on slow buses?=20

Yes PRCM register accesses are unfortunately rather slow, and we've
known that for some time, but haven't done any detailed analysis of the
overhead.

Using the function_graph tracer, I was able to see that the pre/post
transition are taking an enormous amount of time:

  - pwrdm pre-transition: 1400+ us at 600MHz (4000+ us at 125MHz)
  - pwrdm post-transtion: 1600+ us at 600MHz (6000+ us at 125MHz)

Notice the big difference between 600MHz OPP and 125MHz OPP.  Are you
using CPUfreq at all in your tests?  If using cpufreq + ondemand
governor, you're probably running at low OPP due to lack of CPU activit=
y
which will also affect the latencies in the idle path.

> Maybe some register cache would help us there, or are those registers
> expected to be changed by hardware often?

Yes, we've known that some sort of register cache here would be useful
for some time, but haven't got to implementing it.

> Also trying to idle PER while transfer is ongoing (as reported in
> previous mail) doesn't sound like a good idea and is one of the
> reasons for slowdown. Seems to also causing more current drain,
> ironically.

Agreed.  Again, using the function_graph tracer, I get some pretty big
latencies from the GPIO pre/post idling process:

  - gpio_prepare_for_idle(): 2400+ us at 600MHz (8200+ us at 125MHz)
  - gpio_resume_from_idle(): 2200+ us at 600MHz (7600+ us at 125MHz)

Removing PER transtions as you did will get rid of those.

I'm looking into this in more detail know, and will likely have a few
patches for you to experiment with.

Thanks again for digging into this with us,

Kevin

>
>
> changes (again, sorry for corrupted diffs, but they should be easy to
> reproduce):
> [2]:
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -307,7 +307,7 @@ void omap_sram_idle(void)
>                         omap3_enable_io_chain();
>         }
>
> -       pwrdm_pre_transition();
> +//     pwrdm_pre_transition();
>
>         /* PER */
>         if (per_next_state < PWRDM_POWER_ON) {
> @@ -372,7 +373,7 @@ void omap_sram_idle(void)
>         }
>         omap3_intc_resume_idle();
>
> -       pwrdm_post_transition();
> +//     pwrdm_post_transition();
>
>         /* PER */
>         if (per_next_state < PWRDM_POWER_ON) {
> [3]:
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -347,7 +347,7 @@ void omap_sram_idle(void)
>         if (save_state =3D=3D 1 || save_state =3D=3D 3)
>                 cpu_suspend(save_state, omap34xx_do_sram_idle);
>         else
> -               omap34xx_do_sram_idle(save_state);
> +               cpu_do_idle();
>
>         /* Restore normal SDRC POWER settings */
>         if (cpu_is_omap3430() && omap_rev() >=3D OMAP3430_REV_ES3_0 &=
&
> [4]:
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -107,6 +107,7 @@ static int __omap3_enter_idle(struct cpuidle_devi=
ce *dev,
>         if (index =3D=3D 0) {
>                 pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
>                 pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> +               pwrdm_set_next_pwrst(per_pd, PWRDM_POWER_ON);
>         }
>
>         /*
> [5]:
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -105,8 +105,7 @@ static int __omap3_enter_idle(struct cpuidle_devi=
ce *dev,
>
>         /* Deny idle for C1 */
>         if (index =3D=3D 0) {
> -               pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
> -               pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> +               clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
>         }
>
>         /*
> @@ -128,8 +128,7 @@ static int __omap3_enter_idle(struct cpuidle_devi=
ce *dev,
>
>         /* Re-allow idle for C1 */
>         if (index =3D=3D 0) {
> -               pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
> -               pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> +               clkdm_allow_idle(mpu_pd->pwrdm_clkdms[0]);
>         }
>
>  return_sleep_time:
> [6]:
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -117,7 +116,8 @@ static int __omap3_enter_idle(struct cpuidle_devi=
ce *dev,
>                 cpu_pm_enter();
>
>         /* Execute ARM wfi */
> -       omap_sram_idle();
> +       //omap_sram_idle();
> +       cpu_do_idle();
>
>         /*
>          * Call idle CPU PM enter notifier chain to restore
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
