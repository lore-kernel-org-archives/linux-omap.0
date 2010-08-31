From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Tue, 31 Aug 2010 10:28:41 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870310FA8A80@dbde02.ent.ti.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<87bp8nn9yx.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC3560870310FA8865@dbde02.ent.ti.com>
 <AANLkTi=uOyqbBxvhDHza8oV6TBDVPMFKqN_3Z+jqtJwR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54356 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595Ab0HaE6v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 00:58:51 -0400
In-Reply-To: <AANLkTi=uOyqbBxvhDHza8oV6TBDVPMFKqN_3Z+jqtJwR@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Silesh C V <saileshcv@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "vishwanath.sripathy@linaro.org" <vishwanath.sripathy@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>



> -----Original Message-----
> From: Silesh C V [mailto:saileshcv@gmail.com]
> Sent: Tuesday, August 31, 2010 9:53 AM
> To: Sripathy, Vishwanath
> Cc: Kevin Hilman; vishwanath.sripathy@linaro.org; linux-omap@vger.ker=
nel.org;
> linaro-dev@lists.linaro.org
> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
>=20
> Hi Vishwa,
>=20
> On Mon, Aug 30, 2010 at 6:29 PM, Sripathy, Vishwanath
> <vishwanath.bs@ti.com> wrote:
> > Kevin,
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> >> Sent: Saturday, August 28, 2010 12:45 AM
> >> To: vishwanath.sripathy@linaro.org
> >> Cc: linux-omap@vger.kernel.org; linaro-dev@lists.linaro.org
> >> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
> >>
> >> vishwanath.sripathy@linaro.org writes:
> >>
> >> > From: Vishwanath BS <vishwanath.sripathy@linaro.org>
> >> >
> >> > This patch has instrumentation code for measuring latencies for
> >> > various CPUIdle C states for OMAP. Idea here is to capture the
> >> > timestamp at various phases of CPU Idle and then compute the sw
> >> > latency for various c states. =A0For OMAP, 32k clock is chosen a=
s
> >> > reference clock this as is an always on clock. =A0wkup domain me=
mory
> >> > (scratchpad memory) is used for storing timestamps. =A0One can s=
ee the
> >> > worstcase latencies in below sysfs entries (after enabling
> >> > CONFIG_CPU_IDLE_PROF in .config). This information can be used t=
o
> >> > correctly configure cpu idle latencies for various C states afte=
r
> >> > adding HW latencies for each of these sw latencies.
> >> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
> >> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
> >> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
> >> >
> >> > THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
> >> >
> >> > Signed-off-by: Vishwanath BS <vishwanath.sripathy@linaro.org>
> >> > Cc: linaro-dev@lists.linaro.org
> >>
> >> While I have many problems with the implementation details, I won'=
t go
> >> into them because in general this is the wrong direction for kerne=
l
> >> instrumentation.
> >>
> >> This approach adds quite a bit overhead to the idle path itself. =A0=
With
> >> all the reads/writes from/to the scratchpad(?) and all the multipl=
ications
> >> and divides in every idle path, as well as the wait-for-idlest in =
both
> >> the sleep and resume paths. =A0The additional overhead added is no=
n trivial.
> >>
> >> Basically, I'd like get away from custom instrumentation and measu=
rement
> >> coded inside the kernel itself. =A0This kind of code never stops g=
rowing
> >> and morphing into ugliness, and rarely scales well when new SoCs a=
re
> >> added.
> >>
> >> With ftrace/perf, we can add tracepoints at specific points and us=
e
> >> external tools to extract and analyze the delays, latencys etc.
> >>
> >> The point is to keep the minimum possible in the kernel: just the
> >> tracepoints we're interested in. =A0 The rest (calculations, avera=
ges,
> >> analysis, etc.) does not need to be in the kernel and can be done =
easier
> >> and with more powerful tools outside the kernel.
> > The challenge here is that we need to take time stamp at the fag en=
d of CPU Idle
> which means we have no access to DDR, MMU/Caches are disabled etc (on=
 OMAP3).
> So I am not sure if we will be able to use ftrace/perf kind of tools =
here. If we choose
> to exclude assembly code part for measurement, then we will be omitti=
ng major
> contributor to CPU Idle latency namely ARM context save/restoration p=
art.
> >
> > Also these calculations are done only when we enable CPUIDLE profil=
ing feature.
> > In the normal production system, these will not come into picture a=
t all. So I am
> not sure latencies involved in these calculations are still an issue =
>when we are just
> doing profiling.
>=20
>=20
> There are two other issues when we use 32k timer for latency measurem=
ent.
>=20
> <snip>
> +
> +       /* take care of overflow */
> +       if (postidle_time < preidle_time)
> +               postidle_time +=3D (u32) 0xffffffff;
> +       if (wkup_time < sleep_time)
> +               wkup_time +=3D (u32) 0xffffffff;
> +
> <snip>
>=20
> 1.We are checking postidle_time < preidle_time to find out whether
> there had been an
>    over flow or not. There can be situations in which the timer
> overflows and still we have
>    a greater postidle_time.
>=20
> 2. We are doing the correction for one overflow. What happens if the
> timer overflows for
>    a second or third time. Can we keep track of the number of
> overflows and then do the
>    correction accordingly?

Unfortunately, there is no way to check if overflow happens more than o=
nce in 32k timer and as you said, theoretically it's possible that if t=
imer overflows more than once, these calculation will wrong. Having sai=
d that, do you really see any usecase where system will idle for more t=
han 37 hours in single cpuidle execution to cause timer overflow?

Vishwa
>=20
> Regards,
> Silesh
>=20
> >
> > Regards
> > Vishwa
> >>
> >> Kevin
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
