From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Fri, 27 Aug 2010 15:30:00 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870310FA8172@dbde02.ent.ti.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
 <AANLkTin9sPHQD8v11_5iUDetJ0MsjfQ+NtENA3y92emN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36571 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab0H0KAI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 06:00:08 -0400
In-Reply-To: <AANLkTin9sPHQD8v11_5iUDetJ0MsjfQ+NtENA3y92emN@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, "vishwanath.sripathy@linaro.org" <vishwanath.sripathy@linaro.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Jean Pihet
> Sent: Friday, August 27, 2010 3:17 PM
> To: vishwanath.sripathy@linaro.org
> Cc: linux-omap@vger.kernel.org; linaro-dev@lists.linaro.org
> Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
>=20
> Hi,
>=20
> On Sat, Aug 28, 2010 at 12:08 AM,  <vishwanath.sripathy@linaro.org> w=
rote:
> > From: Vishwanath BS <vishwanath.sripathy@linaro.org>
> >
> > This patch has instrumentation code for measuring latencies for
> > various CPUIdle C states for OMAP. Idea here is to capture the
> > timestamp at various phases of CPU Idle and then compute the sw
> > latency for various c states. For OMAP, 32k clock is chosen as
> > reference clock this as is an always on clock. wkup domain memory
> > (scratchpad memory) is used for storing timestamps. One can see the
> > worstcase latencies in below sysfs entries (after enabling CONFIG_C=
PU_IDLE_PROF
> > in .config). This information can be used to correctly configure cp=
u idle
> > latencies for various C states after adding HW latencies for each o=
f
> > these sw latencies.
> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
> > /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
> >
> > THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.sripathy@linaro.org>
> > Cc: linaro-dev@lists.linaro.org
> > ---
> ...
>=20
> >
> > +#ifdef CONFIG_CPU_IDLE_PROF
> > + =A0 =A0 =A0 sleep_time =3D omap3_sram_get_sleep_time();
> > + =A0 =A0 =A0 wkup_time =3D omap3_sram_get_wkup_time();
> > +
> > + =A0 =A0 =A0 /* take care of overflow */
> > + =A0 =A0 =A0 if (postidle_time < preidle_time)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 postidle_time +=3D (u32) 0xffffffff;
> > + =A0 =A0 =A0 if (wkup_time < sleep_time)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wkup_time +=3D (u32) 0xffffffff;
> > +
> > + =A0 =A0 =A0 idle_time =3D postidle_time - preidle_time;
> > + =A0 =A0 =A0 total_sleep_time =3D wkup_time - =A0sleep_time;
> > + =A0 =A0 =A0 latency =3D idle_time - total_sleep_time;
> > + =A0 =A0 =A0 sleep_time =3D omap3_sram_get_sleep_time();
> > + =A0 =A0 =A0 wkup_time =3D omap3_sram_get_wkup_time();
> Is it needed to re-read the sleep_time and wkup_time values from the =
scratchpad?

Sleep and wake up time stamps were taken just before and after executin=
g wfi and stored in scratchpad wkup memory. These values are used while=
 computing actual latency.

> What about the 32k timer overflow? Could that cause the sleep_latency
> and/or wkup_latency to be <0?
Overflow issues are taken care while computing idle_time and total_slee=
p_time in code below.
+       if (postidle_time < preidle_time)
 +               postidle_time +=3D (u32) 0xffffffff;
 +       if (wkup_time < sleep_time)
 +               wkup_time +=3D (u32) 0xffffffff;
>=20
> > +
> > + =A0 =A0 =A0 /* calculate average latency after ignoring sprious o=
nes */
> > + =A0 =A0 =A0 if ((total_sleep_time > 0) && (latency > state->actua=
l_latency)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (latency >=3D 0)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state->actual_latency =3D CONVERT_32K=
_USEC(latency);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 latency =3D (sleep_time - preidle_tim=
e);
> Risk of overflow?
Yes I just realized that overflow can cause sleep_latency and wkup_late=
ncy to turn negative. Thanks for pointing it. Will fix it in next versi=
on.=20
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state->sleep_latency =3D CONVERT_32K_=
USEC(latency);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 latency =3D postidle_time - wkup_time=
;
> Risk of overflow?
Agreed. Will fix it.=20

Vishwa
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state->wkup_latency =3D CONVERT_32K_U=
SEC(latency);
> > + =A0 =A0 =A0 }
> > +#endif
> > +
> > =A0 =A0 =A0 =A0return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_=
sec * USEC_PER_SEC;
> > =A0}
> >
>=20
> Jean
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
