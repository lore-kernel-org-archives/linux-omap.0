From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: Common clock and dvfs
Date: Fri, 6 May 2011 17:13:25 +0900
Message-ID: <BANLkTikSFpNm55F66_DkabNTX8Yfh37NxA@mail.gmail.com>
References: <4DC07F10.6010305@ti.com>
	<4DC230E0.7090909@ti.com>
	<BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
	<4DC311C6.7090707@ti.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36610 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab1EFIN1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 04:13:27 -0400
Received: by fxm17 with SMTP id 17so2049690fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 06 May 2011 01:13:25 -0700 (PDT)
In-Reply-To: <4DC311C6.7090707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Colin Cross <ccross@google.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Mark Brown <broonie@sirena.org.uk>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Turquette, Mike" <mturquette@ti.com>

On Fri, May 6, 2011 at 6:08 AM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
[]
>
> Devices will indeed never care about voltage directly, but that will =
happen
> indirectly because of:
> - voltage domains dependency: Changing the MPU or IVA voltage domain =
might
> force the CORE voltage to increase its voltage due to HW limitation. =
We
> cannot have the CPU at 1GHz while the interconnect is at the lowest O=
PP.
> - voltage domain increase due to one device frequency increase might =
force
> the other voltage domain devices to increase their frequency.
> - Thermal management might be a good example as well, but in general
> changing the main contributors frequency (MPU, GPU) should be enough.
>
> In both cases, the indirect voltage change will trigger potentially
> frequency change.
>
> vdd1 <--> vdd2
> =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
> =C2=A0+----+ =C2=A0 =C2=A0+----+
> =C2=A0| =C2=A0 =C2=A0| =C2=A0 =C2=A0| =C2=A0 =C2=A0|
> devA devB devC devD
>
> With such partitioning, an increase of devA OPP, will increase vdd1 t=
hat
> will trigger an increase of vdd2 that will then broadcast to devices =
that
> belong to it. devC and devD might or not increase their frequency to =
reduce
> the energy consumption.
> Any devices like processors that can run fast and idle must run at th=
e max
> frequency allowed by the current voltage.

As long as the voltage change in vdd1, which changes vdd2 (vdd1 and 2
are consumers of the same regulator, right?), can update OPP entries
related (enable/disable entries), devfreq can handle this.

If the clocks and devices (A~D) related are using devfreq, disabling,
enabling, and adding OPPs will instantly affect devfreq and adjust
clock frequency based on the enabled OPP entries only. Thus, if a
module is increasing the voltage, it just needs to disable some
low-voltage OPP entries although some set_min/max APIs mentioned by
Colin will be more useful.


--=20
MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
