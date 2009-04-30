From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Overo broken with current top of tree
Date: Thu, 30 Apr 2009 21:23:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D75FBA69@dbde02.ent.ti.com>
References: <5e088bd90904290903q1e13afb6g2df13364a7ec0ddf@mail.gmail.com>
 <6ed0b2680904300231y2afa25a7ge192eb3333d7353b@mail.gmail.com>
 <20090430101619.GE10190@sirena.org.uk>
 <5e088bd90904300807r2ddecfb3vd3f16ae8d2bfb4ce@mail.gmail.com>
 <20090430152457.GE12986@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55613 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933346AbZD3Pxg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 11:53:36 -0400
In-Reply-To: <20090430152457.GE12986@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Steve Sakoman <sakoman@gmail.com>
Cc: Mark Brown <broonie@sirena.org.uk>, Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Thursday, April 30, 2009 8:55 PM
> To: Steve Sakoman
> Cc: Mark Brown; Grazvydas Ignotas;=20
> linux-omap@vger.kernel.org; David Brownell
> Subject: Re: Overo broken with current top of tree
>=20
> * Steve Sakoman <sakoman@gmail.com> [090430 08:10]:
> > On Thu, Apr 30, 2009 at 3:16 AM, Mark Brown=20
> <broonie@sirena.org.uk> wrote:
> > > On Thu, Apr 30, 2009 at 12:31:47PM +0300, Grazvydas Ignotas wrote=
:
> > >> On Wed, Apr 29, 2009 at 7:03 PM, Steve Sakoman=20
> <sakoman@gmail.com> wrote:
> > >
> > >> > set_machine_constraints: invalid 'VUSB1V5' voltage constraints
> > >
> > >> I get the same on pandora, although it continues booting=20
> fine after
> > >> that. Maybe regulator folks will comment about regulator errors.
> > >
> > > I suspect this may be due to the buggy defaults that are=20
> provided when
> > > no voltage constraints are given for a fixed voltage=20
> regulator. =A0There's
> > > a patch on its way to mainline fixing this:
> >=20
> > Thanks Mark!  This patch does indeed fix the regulator=20
> issues, and the
> > system seems to operate normally once again.
>=20
> Great. Looks like -rc4 is out, so I'll update our omap tree=20
> to that today,
> and we'll get this patch in.
>=20

Still observing the problems on OMAP3EVM. My code is at
415f2c76e247f2e6a325621e54f0b1b5dc3669cd + the patch below.

bootlog:

[snip]--[snip]

<6>i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
<6>twl4030: PIH (irq 7) chaining IRQs 368..375
<6>twl4030: power (irq 373) chaining IRQs 376..383
<3>twl4030_gpio: use which platform_data?
<6>twl4030: gpio (irq 368) chaining IRQs 384..401
<4>MUX: setup L8_34XX_GPIO63 (0xd80020ce): 0x0118 -> 0x0104
<3>mmci-omap-hs.0: use which platform_data?
<3>twl4030_keypad: use which platform_data?
<3>twl4030_usb: use which platform_data?
<3>twl4030_reg.17: use which platform_data?
<6>regulator: VUSB1V5: 1500 mV normal standby
<3>twl4030_reg.18: use which platform_data?
<6>regulator: VUSB1V8: 1800 mV normal standby
<3>twl4030_reg.19: use which platform_data?
<6>regulator: VUSB3V1: 3100 mV normal standby
<6>i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
<6>i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
<5>SCSI subsystem initialized
<6>twl4030_usb twl4030_usb: Initialized TWL4030 USB module
<6>usbcore: registered new interface driver usbfs
<6>usbcore: registered new interface driver hub
<6>usbcore: registered new device driver usb
<6>musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
<7>Switched to high resolution mode on CPU 0
<7>musb_hdrc: ConfigData=3D0x55 (UTMI-16, dyn FIFOs, bulk split (X), HB=
-ISO Rx (X))

[snip]--[/snip]

<6>omapfb: configured for panel omap3evm
<6>omapfb: DISPC version 3.0 initialized
<6>omapfb: Framebuffer initialized. Total vram 614400 planes 1
<6>omapfb: Pixclock 25411 kHz hfreq 48.9 kHz vfreq 74.4 Hz
<6>Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
<6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654

Get too many 'funny' chars beyond this point:

> Tony
>=20
> =20
> > The platform data messages still appear, but a quick look=20
> at the code
> > that generates them shows that we are at the start of a=20
> transition in
> > how platform data is handled (both old and new style are handled at
> > the moment).  Seems we will have a bit of work to do to adapt.
> >=20
> > i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
> > twl4030: PIH (irq 7) chaining IRQs 368..375
> > twl4030: power (irq 373) chaining IRQs 376..383
> > twl4030_gpio: use which platform_data?
> > twl4030: gpio (irq 368) chaining IRQs 384..401
> > mmci-omap-hs.0: use which platform_data?
> > mmci-omap-hs.1: use which platform_data?
> > twl4030_usb: use which platform_data?
> > twl4030_reg.6: use which platform_data?
> > regulator: VMMC1: 1850 <--> 3150 mV normal standby
> > twl4030_reg.17: use which platform_data?
> > regulator: VUSB1V5: 1500 mV normal standby
> > twl4030_reg.18: use which platform_data?
> > regulator: VUSB1V8: 1800 mV normal standby
> > twl4030_reg.19: use which platform_data?
> > regulator: VUSB3V1: 3100 mV normal standby
> >=20
> >=20
> > Steve
> >=20
> >=20
> > >
> > > commit 14d32bb077f7cc6f78bd012e5b1489899dddf749
> > > Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > > Date: =A0 Tue Apr 28 11:09:38 2009 +0100
> > >
> > > =A0 =A0regulator: Fix default constraints for fixed voltage regul=
ators
> > >
> > > =A0 =A0Default voltage constraints were being provided for=20
> fixed voltage
> > > =A0 =A0regulator where board constraints were not provided=20
> but these constraints
> > > =A0 =A0used INT_MIN as the default minimum voltage which is=20
> not a valid value
> > > =A0 =A0since it is less than zero. Use 1uV instead.
> > >
> > > =A0 =A0Also set the default values we set in the constraints=20
> themselves since
> > > =A0 =A0otherwise the max_uV constraint we determine will not=20
> be stored in the
> > > =A0 =A0actual constraint strucutre and will therefore not be used=
=2E
> > >
> > > =A0 =A0Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro=
=2Ecom>
> > > =A0 =A0Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> > >
> > > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > > index 2f14c16..98c3a74 100644
> > > --- a/drivers/regulator/core.c
> > > +++ b/drivers/regulator/core.c
> > > @@ -703,10 +703,13 @@ static int=20
> set_machine_constraints(struct regulator_dev *rdev,
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =A0 =A0 cmin =3D constraints->=
min_uV;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =A0 =A0 cmax =3D constraints->=
max_uV;
> > >
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* it's safe to autoconfigure=20
> fixed-voltage supplies */
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* it's safe to autoconfigure=20
> fixed-voltage supplies
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0and the constraints are used=
 by=20
> list_voltage. */
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (count =3D=3D 1 && !cmin) {
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmin =3D INT_MIN;
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmin =3D 1;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmax =3D INT_MAX;
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 constraints->min_uV=
 =3D cmin;
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 constraints->max_uV=
 =3D cmax;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > >
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* voltage constraints are optiona=
l */
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
