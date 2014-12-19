From: Paul Walmsley <paul@pwsan.com>
Subject: Re: regression: Clock changes in next-20141205 break at least
 omap4
Date: Fri, 19 Dec 2014 02:15:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1412190034040.3102@utopia.booyaka.com>
References: <20141212194238.20398.33333@quantum> <548F8B70.2060803@nvidia.com> <5490816E.7060706@codeaurora.org> <54908F8D.2020202@nvidia.com> <20141216202301.GF11502@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1412162034420.3102@utopia.booyaka.com>
 <20141216205754.GG11502@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1412162159270.3102@utopia.booyaka.com> <1418809957.3347.1.camel@pengutronix.de> <alpine.DEB.2.02.1412181717450.3102@utopia.booyaka.com> <20141218233739.29014.73421@quantum>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1648712108-1418955359=:3102"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57992 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbaLSCQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2014 21:16:04 -0500
In-Reply-To: <20141218233739.29014.73421@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Paul Walmsley <pwalmsley@nvidia.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, khilman@linaro.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1648712108-1418955359=:3102
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 18 Dec 2014, Mike Turquette wrote:

> Quoting Paul Walmsley (2014-12-18 11:23:07)
>
> > Flipping over from hardware to software, in the Linux clock tree, there=
's=20
> > usually not much point to modeling the VCO/DCO directly because it tend=
s=20
> > not to be under the direct control of the OS, and it is usually tightly=
=20
> > integrated into the PLLs from a hardware point of view.  But unlike mos=
t=20
> > of the Linux clock tree nodes that are downstream from clock sources,=
=20
> > which use clocks that are electrically driven by the clock source, the=
=20
> > clock signal that PLLs and PLL-like clocks generate is not directly dri=
ven=20
> > by the reference clock.
>=20
> Hi Paul,

Hi Mike,

> This is debatable given that the formula to determine the OMAP DPLL=20
> output rate directly depends upon the rate of the input clock (osc,=20
> 32Khz, hsd, bypass, etc). I'm not speaking for all PLLs, just for the=20
> OMAP ones that I am familiar with.

The frequency and phase noise characteristics of the PLL's output signal=20
are partially a function of the reference clock.  But that's only because=
=20
the reference clock is used to steer the VCO.  It's not because the=20
reference clock itself appears on the PLL output.  Even if the reference=20
clock dividers and VCO loop dividers were both set to divide-by-one, the=20
reference clock still would not appear on the PLL output - merely a=20
simulacrum of it, originating by the VCO.  The PLL's output clock is,=20
electrically, directly driven by the VCO.

Page 5 of this PDF has a nice frequency synthesis PLL block diagram with=20
integer dividers:

    http://www.ti.com/lit/an/swra029/swra029.pdf

To rephrase, if, in the block diagram above, one were to remove everything=
=20
from the TCXO reference clock on the left to the triangle to the left of=20
the VCO, and to replace all that with a constant voltage input to the VCO,=
=20
you'd still get a clock signal out of the IP block, even though the=20
reference clock would no longer exist.

> > So why is a reference clock listed as a Linux parent clock of an OMAP P=
LL? =20
> > At least for OMAP, it was sort of shoehorned in to represent a gating=
=20
> > dependency.  It was a way of stating that the reference clock had to be=
=20
> > enabled for the PLL to generate an output clock.  (The off-chip crystal=
=20
> > oscillator that drives most of the PLL reference clocks could be disabl=
ed=20
> > when all of its users were idle, to save energy.)  But this type of gat=
ing=20
> > dependency is equally true for, say, a separate functional clock that t=
he=20
> > clock source requires in order to operate.  (OMAP PLLs didn't have a=20
> > separate functional clock, at least not that I was aware of; but that's=
=20
> > not true for some similar clock sources used in other SoCs.)
>=20
> Using your terminology above, it is possible to do what you want to do
> today without any change to the clock framework. Simply make each DPLL a
> device. That device calls clk_get, clk_prepare_enable on the input
> reference clock.=20

I think I did something like that with the Tegra DFLL driver last year. =20
Except the clock provider device was the DFLL IP block itself, with its=20
own registers, etc., and not an additional abstraction, if I recall=20
correctly.

My interest is mostly to determine whether some of that special-case code=
=20
can be converted into data that the CCF core can operate on, in a=20
consistent manner that would be useful across platforms, and in a way that=
=20
several people could potentially agree on.

> Coincidentally these new DPLL device are clock providers themselves and=
=20
> they provide root clocks of their own which are the DPLLs and=20
> corresponding Mx outputs. This model would treat the reference clock as=
=20
> something that drives the DPLL device's logic, but not as a part of the=
=20
> clock signal chain.
>=20
> I don't personally agree with the idea that the reference clock is not a
> parent of the DPLL,

I'd be interested to know how you would define a parent clock, if it=20
differs from the electrical "source clock" definition that I mentioned.

The Linux clock tree is a software abstraction.  So one could define=20
"parent clock" however one wishes.  (That's not to say that all=20
definitions are equally useful...)=20

One could state, for example, that a parent clock is any clock that has=20
some effect on the output of the child clock.  That would be one=20
definition which might be consistent with your comments.  The problem with=
=20
that is that it means that a clock can have multiple simultaneously-active=
=20
parents, which I'd na=C3=AFvely think we'd want to avoid, if we could.

I also have to admit that my bias is towards definitions with some kind of=
=20
relationship to the hardware, which helps avoid the "utter relativism"=20
problem that you mention below.

> but I don't oppose any change to the OMAP clock driver along those lines=
=20
> so long as it is done in a sane way. It seems there is never just one=20
> correct way to look at these things.

I'd say that to the extent that one could come up with concrete=20
definitions for terms like "parent clocks," it allows others to reason=20
about how the CCF should work, helps distinguish between data and code=20
changes that do and don't make sense, and helps others understand which=20
changes might be acceptable to maintainers.

> > The clock framework wasn't re-entrant back then, and we wanted to avoid=
=20
> > implementing re-entrancy because we were worried that it could turn int=
o a=20
> > mess.  So we just wound up listing the reference clock as the PLL's Lin=
ux=20
> > parent clock.
> >=20
> > My original comment was just intended to be a reflection on what it mea=
ns=20
> > to be a "parent clock" in the Linux clock tree sense.  If it's intended=
 to=20
> > represent "source clocks" as they are defined above, then PLLs and=20
> > PLL-like clocks should be root nodes, except for the few cases where it=
's=20
> > useful to add a node for the underlying source oscillator directly (for=
=20
> > example, if open-loop mode is supported).
> >=20
> > This might be the right way forward for the time being, and I like the=
=20
> > idea of stating that Linux parent clocks should represent electrical=20
> > "source clock" relationships. =20
> >=20
> > That raises the question of what to do about the additional gating=20
> > relationships.  At the moment, the clock type code needs to be responsi=
ble=20
> > for calling clk_enable() etc. on all of the reference and functional=20
> > clocks that need to be ungated for the clock source to work.  But it ha=
s=20
> > always seemed preferable to me to represent fundamental hardware=20
> > structural constraints in data.  If the data structures are well-define=
d,=20
> > then the data should be relatively easy to analyze, reason about,=20
> > generate, validate, share across platforms, and operate upon iterativel=
y;=20
> > unlike custom per-clocktype code, which often isn't.
>=20
> I completely agree that the interfaces and abstractions in the clock
> framework do not scale well. As an example, there could be much more
> reuse if callbacks such as .get_best_div() existed and the large variety
> of .round_rate() implementations could be replaced by a single generic
> one.
>=20
> Easier mixing and matching of callbacks would be great as well. We don't
> quite have polymorphism but something better could be achieved than the
> complex clock type. Namely the ability to combine various clock hardware
> ops at run-time without having to always generate unique struct clk_ops
> per platform.
>=20
> I think there are lots of ideas out there on how to improve this stuff.

Oh, just in case it isn't clear, my objective wasn't to criticize the=20
existing CCF.  Just thinking that if it was possible to come to an=20
agreement on how to define some of these entities, it might make it easier=
=20
to reason together about ways to work on the core code and data=20
structures.  I'd hate to spend a bunch of time working on changes that you=
=20
would eventually nack because we might not agree on what a parent clock is=
=20
:-)


- Paul
--843723315-1648712108-1418955359=:3102--
