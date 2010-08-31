From: Silesh C V <silesh@ti.com>
Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Tue, 31 Aug 2010 12:27:24 +0530
Message-ID: <AANLkTinsOKQsd1ifwof-OQDmdRY+m8VtAnZ8YJbger6x@mail.gmail.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<87bp8nn9yx.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC3560870310FA8865@dbde02.ent.ti.com>
	<AANLkTi=uOyqbBxvhDHza8oV6TBDVPMFKqN_3Z+jqtJwR@mail.gmail.com>
	<FCCFB4CDC6E5564B9182F639FC3560870310FA8A80@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53688 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932210Ab0HaG5h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 02:57:37 -0400
Received: by gxk23 with SMTP id 23so2332574gxk.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Aug 2010 23:57:36 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870310FA8A80@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "vishwanath.sripathy@linaro.org" <vishwanath.sripathy@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On Tue, Aug 31, 2010 at 10:28 AM, Sripathy, Vishwanath
<vishwanath.bs@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: Silesh C V [mailto:saileshcv@gmail.com]
>> Sent: Tuesday, August 31, 2010 9:53 AM
>> To: Sripathy, Vishwanath
>> Cc: Kevin Hilman; vishwanath.sripathy@linaro.org; linux-omap@vger.ke=
rnel.org;
>> linaro-dev@lists.linaro.org
>> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
>>
>> Hi Vishwa,
>>
>> On Mon, Aug 30, 2010 at 6:29 PM, Sripathy, Vishwanath
>> <vishwanath.bs@ti.com> wrote:
>> > Kevin,
>> >
>> >> -----Original Message-----
>> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> >> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> >> Sent: Saturday, August 28, 2010 12:45 AM
>> >> To: vishwanath.sripathy@linaro.org
>> >> Cc: linux-omap@vger.kernel.org; linaro-dev@lists.linaro.org
>> >> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
>> >>
>> >> vishwanath.sripathy@linaro.org writes:
>> >>
>> >> > From: Vishwanath BS <vishwanath.sripathy@linaro.org>
>> >> >
>> >> > This patch has instrumentation code for measuring latencies for
>> >> > various CPUIdle C states for OMAP. Idea here is to capture the
>> >> > timestamp at various phases of CPU Idle and then compute the sw
>> >> > latency for various c states. =A0For OMAP, 32k clock is chosen =
as
>> >> > reference clock this as is an always on clock. =A0wkup domain m=
emory
>> >> > (scratchpad memory) is used for storing timestamps. =A0One can =
see the
>> >> > worstcase latencies in below sysfs entries (after enabling
>> >> > CONFIG_CPU_IDLE_PROF in .config). This information can be used =
to
>> >> > correctly configure cpu idle latencies for various C states aft=
er
>> >> > adding HW latencies for each of these sw latencies.
>> >> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
>> >> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
>> >> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
>> >> >
>> >> > THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
>> >> >
>> >> > Signed-off-by: Vishwanath BS <vishwanath.sripathy@linaro.org>
>> >> > Cc: linaro-dev@lists.linaro.org
>> >>
>> >> While I have many problems with the implementation details, I won=
't go
>> >> into them because in general this is the wrong direction for kern=
el
>> >> instrumentation.
>> >>
>> >> This approach adds quite a bit overhead to the idle path itself. =
=A0With
>> >> all the reads/writes from/to the scratchpad(?) and all the multip=
lications
>> >> and divides in every idle path, as well as the wait-for-idlest in=
 both
>> >> the sleep and resume paths. =A0The additional overhead added is n=
on trivial.
>> >>
>> >> Basically, I'd like get away from custom instrumentation and meas=
urement
>> >> coded inside the kernel itself. =A0This kind of code never stops =
growing
>> >> and morphing into ugliness, and rarely scales well when new SoCs =
are
>> >> added.
>> >>
>> >> With ftrace/perf, we can add tracepoints at specific points and u=
se
>> >> external tools to extract and analyze the delays, latencys etc.
>> >>
>> >> The point is to keep the minimum possible in the kernel: just the
>> >> tracepoints we're interested in. =A0 The rest (calculations, aver=
ages,
>> >> analysis, etc.) does not need to be in the kernel and can be done=
 easier
>> >> and with more powerful tools outside the kernel.
>> > The challenge here is that we need to take time stamp at the fag e=
nd of CPU Idle
>> which means we have no access to DDR, MMU/Caches are disabled etc (o=
n OMAP3).
>> So I am not sure if we will be able to use ftrace/perf kind of tools=
 here. If we choose
>> to exclude assembly code part for measurement, then we will be omitt=
ing major
>> contributor to CPU Idle latency namely ARM context save/restoration =
part.
>> >
>> > Also these calculations are done only when we enable CPUIDLE profi=
ling feature.
>> > In the normal production system, these will not come into picture =
at all. So I am
>> not sure latencies involved in these calculations are still an issue=
 >when we are just
>> doing profiling.
>>
>>
>> There are two other issues when we use 32k timer for latency measure=
ment.
>>
>> <snip>
>> +
>> + =A0 =A0 =A0 /* take care of overflow */
>> + =A0 =A0 =A0 if (postidle_time < preidle_time)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 postidle_time +=3D (u32) 0xffffffff;
>> + =A0 =A0 =A0 if (wkup_time < sleep_time)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wkup_time +=3D (u32) 0xffffffff;
>> +
>> <snip>
>>
>> 1.We are checking postidle_time < preidle_time to find out whether
>> there had been an
>> =A0 =A0over flow or not. There can be situations in which the timer
>> overflows and still we have
>> =A0 =A0a greater postidle_time.
>>
>> 2. We are doing the correction for one overflow. What happens if the
>> timer overflows for
>> =A0 =A0a second or third time. Can we keep track of the number of
>> overflows and then do the
>> =A0 =A0correction accordingly?
>
> Unfortunately, there is no way to check if overflow happens more than=
 once in 32k timer and as you said, theoretically it's possible >that i=
f timer overflows more than once, these calculation will wrong. Having =
said that, do you really see any usecase where system >will idle for mo=
re than 37 hours in single cpuidle execution to cause timer overflow?


I am not sure. But can we completely write off such a possibility ?


Regards,
Silesh

>
> Vishwa
>>
>> Regards,
>> Silesh
>>
>> >
>> > Regards
>> > Vishwa
>> >>
>> >> Kevin
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-o=
map" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
