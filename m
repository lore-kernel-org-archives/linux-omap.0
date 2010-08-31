From: Silesh C V <saileshcv@gmail.com>
Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Tue, 31 Aug 2010 09:52:48 +0530
Message-ID: <AANLkTi=uOyqbBxvhDHza8oV6TBDVPMFKqN_3Z+jqtJwR@mail.gmail.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<87bp8nn9yx.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC3560870310FA8865@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52521 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab0HaEWt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 00:22:49 -0400
Received: by iwn5 with SMTP id 5so5506973iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Aug 2010 21:22:49 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870310FA8865@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "vishwanath.sripathy@linaro.org" <vishwanath.sripathy@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

Hi Vishwa,

On Mon, Aug 30, 2010 at 6:29 PM, Sripathy, Vishwanath
<vishwanath.bs@ti.com> wrote:
> Kevin,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Saturday, August 28, 2010 12:45 AM
>> To: vishwanath.sripathy@linaro.org
>> Cc: linux-omap@vger.kernel.org; linaro-dev@lists.linaro.org
>> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
>>
>> vishwanath.sripathy@linaro.org writes:
>>
>> > From: Vishwanath BS <vishwanath.sripathy@linaro.org>
>> >
>> > This patch has instrumentation code for measuring latencies for
>> > various CPUIdle C states for OMAP. Idea here is to capture the
>> > timestamp at various phases of CPU Idle and then compute the sw
>> > latency for various c states. =A0For OMAP, 32k clock is chosen as
>> > reference clock this as is an always on clock. =A0wkup domain memo=
ry
>> > (scratchpad memory) is used for storing timestamps. =A0One can see=
 the
>> > worstcase latencies in below sysfs entries (after enabling
>> > CONFIG_CPU_IDLE_PROF in .config). This information can be used to
>> > correctly configure cpu idle latencies for various C states after
>> > adding HW latencies for each of these sw latencies.
>> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
>> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
>> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
>> >
>> > THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
>> >
>> > Signed-off-by: Vishwanath BS <vishwanath.sripathy@linaro.org>
>> > Cc: linaro-dev@lists.linaro.org
>>
>> While I have many problems with the implementation details, I won't =
go
>> into them because in general this is the wrong direction for kernel
>> instrumentation.
>>
>> This approach adds quite a bit overhead to the idle path itself. =A0=
With
>> all the reads/writes from/to the scratchpad(?) and all the multiplic=
ations
>> and divides in every idle path, as well as the wait-for-idlest in bo=
th
>> the sleep and resume paths. =A0The additional overhead added is non =
trivial.
>>
>> Basically, I'd like get away from custom instrumentation and measure=
ment
>> coded inside the kernel itself. =A0This kind of code never stops gro=
wing
>> and morphing into ugliness, and rarely scales well when new SoCs are
>> added.
>>
>> With ftrace/perf, we can add tracepoints at specific points and use
>> external tools to extract and analyze the delays, latencys etc.
>>
>> The point is to keep the minimum possible in the kernel: just the
>> tracepoints we're interested in. =A0 The rest (calculations, average=
s,
>> analysis, etc.) does not need to be in the kernel and can be done ea=
sier
>> and with more powerful tools outside the kernel.
> The challenge here is that we need to take time stamp at the fag end =
of CPU Idle which means we have no access to DDR, MMU/Caches are disabl=
ed etc (on OMAP3). So I am not sure if we will be able to use ftrace/pe=
rf kind of tools here. If we choose to exclude assembly code part for m=
easurement, then we will be omitting major contributor to CPU Idle late=
ncy namely ARM context save/restoration part.
>
> Also these calculations are done only when we enable CPUIDLE profilin=
g feature.
> In the normal production system, these will not come into picture at =
all. So I am not sure latencies involved in these calculations are stil=
l an issue >when we are just doing profiling.


There are two other issues when we use 32k timer for latency measuremen=
t.

<snip>
+
+       /* take care of overflow */
+       if (postidle_time < preidle_time)
+               postidle_time +=3D (u32) 0xffffffff;
+       if (wkup_time < sleep_time)
+               wkup_time +=3D (u32) 0xffffffff;
+
<snip>

1.We are checking postidle_time < preidle_time to find out whether
there had been an
   over flow or not. There can be situations in which the timer
overflows and still we have
   a greater postidle_time.

2. We are doing the correction for one overflow. What happens if the
timer overflows for
   a second or third time. Can we keep track of the number of
overflows and then do the
   correction accordingly?

Regards,
Silesh

>
> Regards
> Vishwa
>>
>> Kevin
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
