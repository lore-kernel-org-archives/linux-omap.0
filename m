From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Patches to bind the SGTL5000 chip to AM33XX McASP
Date: Thu, 19 Mar 2015 18:07:30 +0200
Message-ID: <550AF442.5040203@ti.com>
References: <1426741659.10003.9.camel@midgaarde>	<550AC783.8040304@ti.com> <CAAQQ3u=opRm3UzD+bG6aJvhQU2CFmzH4sXzuA=GxDp2d+MMiNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56936 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbbCSQHm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 12:07:42 -0400
In-Reply-To: <CAAQQ3u=opRm3UzD+bG6aJvhQU2CFmzH4sXzuA=GxDp2d+MMiNg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Knight <g.knight@symetrica.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 03/19/2015 04:34 PM, Greg Knight wrote:
>> SO is it so that the codec's MCLK is coming from McASP AHCLKX (or R)=
 and this
>> clock need to be present all the time? W/o the MCLK the registers ar=
e not
>> accessible?
>=20
> Correct, the SGTL5000's I2C registers are not accessible without MCLK=
=2E

Yeah, according to the datasheet, it needs MCLK in order to communicate=
 with it.

> From my testing, the clock need only be present when the audio chip i=
s
> in use. When not in use, the chip appears perfectly happy to not be
> clocked.

If you change audio controls while you don't have audio activity, you w=
ill
still need to have the MCLK running.

> Is there a better place to pull a ~12MHz clock signal for use as a
> master clock from an AM335X?

=46or a codec such as the SGTL5000 I would connect a clock, which is ru=
nning all
the time. If you take a look at the driver, it enables the clock at pro=
be and
leaves it running as long as the driver is loaded.

But AM335x has CLKOUT1,2 outputs as well. They are not high quality clo=
cks,
but can be enabled/disabled.

>> This will not work in mainline kernel. The McASP is turned off when =
it is not
>> in use (no audio activity) so the AHCLKX/R is not going to be there =
on the
>> ball output.
>=20
> The clock-to-talk hack in the patch enables the AHCLKX line during
> codec initialization. From my testing, we don't seem to spend much
> time communicating with the device when we're not using it. Disabling
> the clock when it's not used should not be a problem.

As I said, this is not going to work in upstream kernel. The McASP is n=
ot even
powered up during probe time anymore. It is only powered up when it is =
needed,
this means that you will not have clocks for the codec coming from McAS=
P pin.
The driver is not designed to support such a use case, when you use one=
 of
it's clock as a master clock for external chip. In other words the McAS=
P
driver is not a clock driver.
It might be possible to create a clock driver on top of the McASP drive=
r as
child, but it is really something which should not be supported.

>=20
>> How do you configure the frequency of the AHCLKX/R, this hack only e=
nables it,
>> so you are going to have _some_ clock going out.
>=20
> The frequency is the 12 MHz (I think) I get out from AHCLKX without
> any further configuration; I have not investigated changing that
> frequency as it suited my needs. But I can look into doing
> set_clkdiv/set_sysclk during the clock-to-talk enable if that's more
> appropriate?
>
>> You should be using set_clkdiv and set_sysclk calls from the machine=
 driver to
>> configure the AHCLKX (we do not have AHCLKR supported in the driver =
ATM).
>=20
> So, ehm, the SGTL5000 component logic (is this the machine driver?)
> should adjust the McASP's clocks? Am I misunderstanding? Would this
> not impact binding the SGTL5000 to devices that are *not* McASPs/brea=
k
> abstraction?
>=20
> TBH I'm not clear on how the SGTL5000 bindings to other hardware work=
=2E

It works in other HW because the designers connected the SGTL5000's MCL=
K to a
clock source which can be controlled or it is running all the time. In =
your
case the designers chosen a clock line, which is not working as 'normal=
' clock.

> Is it safe to assume set_sysclk is always going to adjust the I2S MCL=
K
> speed? Please pardon my crude questions, I'm not deeply familiar with
> the structure of ALSA.

With the setclkdiv/sysclk you can configure the AHCLKX direction and co=
nfigure
the divider to be used to generate the clock which goes out, or to divi=
de down
the clock which is coming in.

Another issue this hack has is: what happens if for some reason the SGT=
L5000
driver loads first? McASP will not enable the AHCLKX so the codec drive=
r will
fail reading the CHIP_ID and fails to load. You need to provide a dummy=
 clock
node to the codec, so that will not fail, but you will not have the MCL=
K.

> I'll reformat the patches and try from a mainline kernel when I get
> some spare time.

I'm not sure if this can be accepted, sorry. It is really a hack and th=
ere are
too many corner cases where the system can fail.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
