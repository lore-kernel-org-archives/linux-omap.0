From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Tue, 1 May 2012 16:10:44 +0200
Message-ID: <CAORVsuXX9c+8-uJ1e1U920_jy0MK53jmCu+hXhHaXapHArMeLg@mail.gmail.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	<87ehrtn6na.fsf@ti.com>
	<CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
	<87y5puwhus.fsf@ti.com>
	<CAORVsuWP72dHFSBhX=Kux7GEk33qQgR74a74FFwzA8uniSabAQ@mail.gmail.com>
	<877gx5dwz2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49023 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637Ab2EAOKp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 10:10:45 -0400
Received: by vbbff1 with SMTP id ff1so2768524vbb.19
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 07:10:44 -0700 (PDT)
In-Reply-To: <877gx5dwz2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

HI Kevin, Grazvydas,

On Tue, Apr 24, 2012 at 4:29 PM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Hi Grazvydas, Kevin,
>>
>> I did some gather some performance measurements and statistics using
>> custom tracepoints in __omap3_enter_idle.
I posted the patches for the power domains registers cache, cf.
http://marc.info/?l=3Dlinux-omap&m=3D133587781712039&w=3D2.

>> All the details are at
>> http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Meas=
urement#C1_performance_problem:_analysis
I updated the page with the measurements results with Kevin's patches
and the registers cache patches.

The results are showing that:
- the registers cache optimizes the low power mode transitions, but is
not sufficient to obtain a big gain. A few unused domains are
transitioning, which causes a big penalty in the idle path.
- khilman's optimizations are really helpful. Furthermore it optimizes
farther the registers cache statistics accesses.
- the average time in idle now drops to 246us, which is still very
large for a cpu intensive C-state. For information with PM disabled
the average time in idle is 113us.

Regards,
Jean

>> .
>
> This is great, thanks.
>
> [...]
>
>> Here are the results (BW in MB/s) on Beagleboard:
>> - 4.7: without using DMA,
>>
>> - Using DMA
>> =A0 2.1: [0]
>> =A0 2.1: [1] only C1
>> =A0 2.6: [1]+[2] no pre_ post_
>> =A0 2.3: [1]+[5] no pwrdm_for_each_clkdm
>> =A0 2.8: [1]+[5]+[2]
>> =A0 3.1: [1]+[5]+[6] no omap_sram_idle
>> =A0 3.1: No IDLE, no omap_sram_idle, all pwrdms to ON
>>
>> So indeed this shows there is some serious performance issue with th=
e
>> C1 C-state.
>
> Yes, this confirms what both Grazvytas and I are seeing as well.
>
> [...]
>
>> From the list of contributors, the main ones are:
>> =A0 =A0 (140us) pwrdm_pre_transition and pwrdm_post_transition,
>
> See the series I just posted to address this one:
> [PATCH/RFT 0/3] ARM: OMAP: PM: reduce overhead of pwrdm pre/post tran=
sitions
>
>> =A0 =A0 (105us) omap2_gpio_prepare_for_idle and
>> omap2_gpio_resume_after_idle. This could be avoided if PER stays ON =
in
>> the latency-critical C-states,
>> =A0 =A0 (78us) pwrdm_for_each_clkdm(mpu, core, deny_idle/allow_idle)=
,
>> =A0 =A0 (33us estimated) omap_set_pwrdm_state(mpu, core, neon),
>> =A0 =A0 (11 us) clkdm_allow_idle(mpu). Is this needed?
>
> In that same series, I removed this as it appears to be a remnant of =
a
> code move (c.f. patch 3 in above series.)
>
>> Here are a few questions and suggestions:
>> - In case of latency critical C-states could the high-latency code b=
e
>> bypassed in favor of a much simpler version? Pushing the concept a b=
it
>> farther one could have a C1 state that just relaxes the cpu (no WFI)=
,
>> a C2 state which bypasses a lot of code in __omap3_enter_idle, and t=
he
>> rest of the C-states as we have today,
>
> I was thinking a "WFI only" state, with *all* powerdomains staying on=
 is
> probably sufficient for C1. =A0Do you see the enter/exit latency from=
 that
> as even being too hight?
>
>> - Is it needed to iterate through all the power and clock domains in
>> order to keep them active?
>
> No. =A0My series above starts to addresses this, but I think Tero's
> use-counting series is the final solution since this should really be
> done when we know the powerdomains are transitioning.
>
> Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
