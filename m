From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Thu, 28 Apr 2011 14:59:42 +0900
Message-ID: <BANLkTin-OMyrz=McN6X4TAZrvv3ehVBGew@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
	<BANLkTinP0_qpF3sp8CzDy42i24wqqo7ohw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56341 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab1D1F7p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 01:59:45 -0400
Received: by bwz15 with SMTP id 15so2012510bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 22:59:44 -0700 (PDT)
In-Reply-To: <BANLkTinP0_qpF3sp8CzDy42i24wqqo7ohw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Apr 28, 2011 at 3:37 AM, Colin Cross <ccross@google.com> wrote:
> (sorry, missent the earlier one)
>
> On Wed, Apr 27, 2011 at 11:07 AM, Menon, Nishanth <nm@ti.com> wrote:
>> On Wed, Apr 27, 2011 at 12:49, Colin Cross <ccross@google.com> wrote=
:
>> +l-o
>>
>>> I'm a little confused about the design for this, and OPP as well. =C2=
=A0OPP
>>> matches a struct device * and a frequency to a voltage, which is no=
t a
>>> generically useful pairing, as far as I can tell. =C2=A0On Tegra, i=
t is
>>> quite possible for a single device to have multiple clocks that eac=
h
>>> have different voltage requirements, for example the display block =
can
>>> have an interface clock as well as a pixel clock. =C2=A0Simplifying=
 this to
>>> dev + freq =3D voltage seems very OMAP specific, and will be diffic=
ult
>>> or impossible to adapt to Tegra.
>> We have the same requirements as well(iclk,fclk,pixclk etc..)! We
>> group them under voltage domains in OMAP ;). if your issue was a
>> ability to have a single freq to a OPP, it is upto SoC to do the
>> proper mapping. Concept of an OPP still remains consistent - which i=
s
>> for a voltage, there is only so much freq you can drive that specifi=
c
>> module to.
> No, that is still wrong. =C2=A0You don't drive a module at a frequenc=
y, you
> drive a clock. =C2=A0You can't map struct device * 1-1 to a clock. =C2=
=A0Look at
> omap2_set_init_voltage:
> static int __init omap2_set_init_voltage(char *vdd_name, char *clk_na=
me,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0clk =3D =C2=A0clk_get(NULL, clk_name=
);
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0freq =3D clk->rate;
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0opp =3D opp_find_freq_ceil(dev, &fre=
q);
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0...
> }
>
> What happens if I have a dev with two frequencies? =C2=A0I can only p=
ass a
> dev into opp. =C2=A0It makes infinitely more sense to pass in a clock=
:
> opp_find_freq_ceil(clk, &freq).

What one instance of DVFS (devfreq) controls are clocks and
regulators. (a device may have multiple regulators as well as multiple
clocks)
What one instance of DVFS (devfreq) monitors (device load and/or
temperature) is a device that uses the clocks and regulators.

If we focus on the things that are controlled by DVFS, connecting DVFS
with clock seems fine; however, DVFS's decision is based on the status
of the device and the decision (monitoring result) configures a set of
clocks and regulators. The clocks are not configured independently
from others if the clocks are used by a DVFS-capable device. The
frequency/voltage pair (OPP in this patch) associated with a device
becomes a representative value of a specific configuration that
configures the set of clocks and regulators.

This is quite similar with CPUFREQ. CPUFREQ provides a single
frequency value as a result of monitoring; however the machine's
cpufreq driver may set multiple clocks and multiple voltage regulators
based on the representative value (which is usually the core clock)
although the cpufreq driver may need to control many more clocks with
different frequencies.

With multiple clocks of a device, if there is a clock that is required
to be set independently from the "representative" clock with DVFS, it
means that the DVFS monitoring result (load/temperature) is not a
scalar value but a vector (multi-dimensional value). That implies that
we need to monitor different and independent values, which in turn,
implies that we need separated devices. Note that the DVFS monitor
result from load and temperature combined is not a multi-dimensional
value because the temperature limits "maximum possible frequency or
voltage" and the load gives "preferred lower bound of frequency" that
can be overridden by the limit set by temperature.

Therefore, having one DVFS per clock where multiple clocks are
attached to a device will create multiple monitors that monitor the
same object(device behavior) with same metrics (load and temperature).

Besides, the reason I've started with "target" callback, not clk and
regulator names or pointers is that a device may have multiple clks
and regulators and the OPP may only show the representative
clock/regulators as CPUFREQ does. Especially when the order of
transitions of those multiple clocks and regulators matter (if they
are in a single device, it sometimes does), running a DVFS per clock,
not per device, will be bothersome if not disasterous.

>
>> It is upto SoC frameworks to implement the transitions. E.g. lets lo=
ok
>> at scalability: How'd the mechanism proposed work with temperature
>> variances: Example: I dont want to hit 1.5GHz if temp >70C - wont it
>> be an SoC specific hack I'd need to introduce?
> No, because you're putting it in the wrong place, that is a policy
> decision. =C2=A0Handle it in the clock framework, or handle it in the
> device driver. =C2=A0That's a bad example either way - what happens i=
f you
> are already at 1.5GHz when the temperature crosses 70C? =C2=A0You nee=
d an
> interrupt that tells you the temperature is too high, and than needs
> to affect a policy decision at a much higher level than dvfs.
>
>>
>> All OPP framework does is store that maps, and leaves it to users to
>> choose regulators, clock framework variances, SoC temperature sensor=
s
>> or what ever mechanisms they choose to allow through a transition.
> I understand its just a map, but its a map between two things that
> don't have a direct mapping in many SoCs. =C2=A0I think if you change=
d
> every usage of struct dev * in opp to struct clk *, it would make muc=
h
> more sense. =C2=A0There is already a mapping from struct dev * to str=
uct
> clk *, its called clk_get, and it takes a second parameter to allow
> devices to have multiple clocks.

Anyway, I agree that we need either one of the followings (at least in
the future)
1) OPP mapped with clock
or
2) multiple OPPs mapped with a dev, each OPP with a clock of the dev.

Still, DVFS(devfreq) would be better linked directly with a device
although we will need to tell which OPP of the device or which clock's
OPP should be linked as representative clock OPP.

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>

Cheers!
- MyungJoo
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
