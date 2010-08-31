From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Tue, 31 Aug 2010 14:39:16 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870310FA8C69@dbde02.ent.ti.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<87bp8nn9yx.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC3560870310FA8865@dbde02.ent.ti.com>
	<AANLkTi=uOyqbBxvhDHza8oV6TBDVPMFKqN_3Z+jqtJwR@mail.gmail.com>
	<FCCFB4CDC6E5564B9182F639FC3560870310FA8A80@dbde02.ent.ti.com>
 <AANLkTinsOKQsd1ifwof-OQDmdRY+m8VtAnZ8YJbger6x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58414 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395Ab0HaJJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 05:09:26 -0400
In-Reply-To: <AANLkTinsOKQsd1ifwof-OQDmdRY+m8VtAnZ8YJbger6x@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "C V, Silesh" <silesh@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "vishwanath.sripathy@linaro.org" <vishwanath.sripathy@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>



> -----Original Message-----
> From: saileshcv@gmail.com [mailto:saileshcv@gmail.com] On Behalf Of C=
 V, Silesh
> Sent: Tuesday, August 31, 2010 12:27 PM
> To: Sripathy, Vishwanath
> Cc: Kevin Hilman; vishwanath.sripathy@linaro.org; linux-omap@vger.ker=
nel.org;
> linaro-dev@lists.linaro.org
> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
>=20
> On Tue, Aug 31, 2010 at 10:28 AM, Sripathy, Vishwanath
> <vishwanath.bs@ti.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Silesh C V [mailto:saileshcv@gmail.com]
> >> Sent: Tuesday, August 31, 2010 9:53 AM
> >> To: Sripathy, Vishwanath
> >> Cc: Kevin Hilman; vishwanath.sripathy@linaro.org; linux-omap@vger.=
kernel.org;
> >> linaro-dev@lists.linaro.org
> >> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
> >>
> >> Hi Vishwa,
> >>
> >> On Mon, Aug 30, 2010 at 6:29 PM, Sripathy, Vishwanath
> >> <vishwanath.bs@ti.com> wrote:
> >> > Kevin,
> >> >
> >> >> -----Original Message-----
> >> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> >> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> >> >> Sent: Saturday, August 28, 2010 12:45 AM
> >> >> To: vishwanath.sripathy@linaro.org
> >> >> Cc: linux-omap@vger.kernel.org; linaro-dev@lists.linaro.org
> >> >> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
> >> >>
> >> >> vishwanath.sripathy@linaro.org writes:
> >> >>
> >> >> > From: Vishwanath BS <vishwanath.sripathy@linaro.org>
> >> >> >
> >> >> > This patch has instrumentation code for measuring latencies f=
or
> >> >> > various CPUIdle C states for OMAP. Idea here is to capture th=
e
> >> >> > timestamp at various phases of CPU Idle and then compute the =
sw
> >> >> > latency for various c states. =A0For OMAP, 32k clock is chose=
n as
> >> >> > reference clock this as is an always on clock. =A0wkup domain=
 memory
> >> >> > (scratchpad memory) is used for storing timestamps. =A0One ca=
n see the
> >> >> > worstcase latencies in below sysfs entries (after enabling
> >> >> > CONFIG_CPU_IDLE_PROF in .config). This information can be use=
d to
> >> >> > correctly configure cpu idle latencies for various C states a=
fter
> >> >> > adding HW latencies for each of these sw latencies.
> >> >> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
> >> >> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
> >> >> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
> >> >> >
> >> >> > THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
> >> >> >
> >> >> > Signed-off-by: Vishwanath BS <vishwanath.sripathy@linaro.org>
> >> >> > Cc: linaro-dev@lists.linaro.org
> >> >>
> >> >> While I have many problems with the implementation details, I w=
on't go
> >> >> into them because in general this is the wrong direction for ke=
rnel
> >> >> instrumentation.
> >> >>
> >> >> This approach adds quite a bit overhead to the idle path itself=
=2E =A0With
> >> >> all the reads/writes from/to the scratchpad(?) and all the mult=
iplications
> >> >> and divides in every idle path, as well as the wait-for-idlest =
in both
> >> >> the sleep and resume paths. =A0The additional overhead added is=
 non trivial.
> >> >>
> >> >> Basically, I'd like get away from custom instrumentation and me=
asurement
> >> >> coded inside the kernel itself. =A0This kind of code never stop=
s growing
> >> >> and morphing into ugliness, and rarely scales well when new SoC=
s are
> >> >> added.
> >> >>
> >> >> With ftrace/perf, we can add tracepoints at specific points and=
 use
> >> >> external tools to extract and analyze the delays, latencys etc.
> >> >>
> >> >> The point is to keep the minimum possible in the kernel: just t=
he
> >> >> tracepoints we're interested in. =A0 The rest (calculations, av=
erages,
> >> >> analysis, etc.) does not need to be in the kernel and can be do=
ne easier
> >> >> and with more powerful tools outside the kernel.
> >> > The challenge here is that we need to take time stamp at the fag=
 end of CPU
> Idle
> >> which means we have no access to DDR, MMU/Caches are disabled etc =
(on
> OMAP3).
> >> So I am not sure if we will be able to use ftrace/perf kind of too=
ls here. If we
> choose
> >> to exclude assembly code part for measurement, then we will be omi=
tting major
> >> contributor to CPU Idle latency namely ARM context save/restoratio=
n part.
> >> >
> >> > Also these calculations are done only when we enable CPUIDLE pro=
filing feature.
> >> > In the normal production system, these will not come into pictur=
e at all. So I
> am
> >> not sure latencies involved in these calculations are still an iss=
ue >when we are
> just
> >> doing profiling.
> >>
> >>
> >> There are two other issues when we use 32k timer for latency measu=
rement.
> >>
> >> <snip>
> >> +
> >> + =A0 =A0 =A0 /* take care of overflow */
> >> + =A0 =A0 =A0 if (postidle_time < preidle_time)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 postidle_time +=3D (u32) 0xffffffff;
> >> + =A0 =A0 =A0 if (wkup_time < sleep_time)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wkup_time +=3D (u32) 0xffffffff;
> >> +
> >> <snip>
> >>
> >> 1.We are checking postidle_time < preidle_time to find out whether
> >> there had been an
> >> =A0 =A0over flow or not. There can be situations in which the time=
r
> >> overflows and still we have
> >> =A0 =A0a greater postidle_time.
> >>
> >> 2. We are doing the correction for one overflow. What happens if t=
he
> >> timer overflows for
> >> =A0 =A0a second or third time. Can we keep track of the number of
> >> overflows and then do the
> >> =A0 =A0correction accordingly?
> >
> > Unfortunately, there is no way to check if overflow happens more th=
an once in 32k
> timer and as you said, theoretically it's possible >that if timer ove=
rflows more than
> once, these calculation will wrong. Having said that, do you really s=
ee any usecase
> where system >will idle for more than 37 hours in single cpuidle exec=
ution to cause
> timer overflow?
>=20
>=20
> I am not sure. But can we completely write off such a possibility ?
I do not think it's a possibility. Also I believe that this problem is =
applicable even for system time as it uses 32k clock for maintaining sy=
stem time.=20

Vishwa
>=20
>=20
> Regards,
> Silesh
>=20
> >
> > Vishwa
> >>
> >> Regards,
> >> Silesh
> >>
> >> >
> >> > Regards
> >> > Vishwa
> >> >>
> >> >> Kevin
> >> >>
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe linux=
-omap" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-=
omap" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
> >> >
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
