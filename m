From: Tony Lindgren <tony@atomide.com>
Subject: Re: Overo broken with current top of tree
Date: Thu, 30 Apr 2009 08:24:57 -0700
Message-ID: <20090430152457.GE12986@atomide.com>
References: <5e088bd90904290903q1e13afb6g2df13364a7ec0ddf@mail.gmail.com> <6ed0b2680904300231y2afa25a7ge192eb3333d7353b@mail.gmail.com> <20090430101619.GE10190@sirena.org.uk> <5e088bd90904300807r2ddecfb3vd3f16ae8d2bfb4ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54631 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758357AbZD3PZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 11:25:04 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90904300807r2ddecfb3vd3f16ae8d2bfb4ce@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Mark Brown <broonie@sirena.org.uk>, Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

* Steve Sakoman <sakoman@gmail.com> [090430 08:10]:
> On Thu, Apr 30, 2009 at 3:16 AM, Mark Brown <broonie@sirena.org.uk> w=
rote:
> > On Thu, Apr 30, 2009 at 12:31:47PM +0300, Grazvydas Ignotas wrote:
> >> On Wed, Apr 29, 2009 at 7:03 PM, Steve Sakoman <sakoman@gmail.com>=
 wrote:
> >
> >> > set_machine_constraints: invalid 'VUSB1V5' voltage constraints
> >
> >> I get the same on pandora, although it continues booting fine afte=
r
> >> that. Maybe regulator folks will comment about regulator errors.
> >
> > I suspect this may be due to the buggy defaults that are provided w=
hen
> > no voltage constraints are given for a fixed voltage regulator. =A0=
There's
> > a patch on its way to mainline fixing this:
>=20
> Thanks Mark!  This patch does indeed fix the regulator issues, and th=
e
> system seems to operate normally once again.

Great. Looks like -rc4 is out, so I'll update our omap tree to that tod=
ay,
and we'll get this patch in.

Tony

=20
> The platform data messages still appear, but a quick look at the code
> that generates them shows that we are at the start of a transition in
> how platform data is handled (both old and new style are handled at
> the moment).  Seems we will have a bit of work to do to adapt.
>=20
> i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
> twl4030: PIH (irq 7) chaining IRQs 368..375
> twl4030: power (irq 373) chaining IRQs 376..383
> twl4030_gpio: use which platform_data?
> twl4030: gpio (irq 368) chaining IRQs 384..401
> mmci-omap-hs.0: use which platform_data?
> mmci-omap-hs.1: use which platform_data?
> twl4030_usb: use which platform_data?
> twl4030_reg.6: use which platform_data?
> regulator: VMMC1: 1850 <--> 3150 mV normal standby
> twl4030_reg.17: use which platform_data?
> regulator: VUSB1V5: 1500 mV normal standby
> twl4030_reg.18: use which platform_data?
> regulator: VUSB1V8: 1800 mV normal standby
> twl4030_reg.19: use which platform_data?
> regulator: VUSB3V1: 3100 mV normal standby
>=20
>=20
> Steve
>=20
>=20
> >
> > commit 14d32bb077f7cc6f78bd012e5b1489899dddf749
> > Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Date: =A0 Tue Apr 28 11:09:38 2009 +0100
> >
> > =A0 =A0regulator: Fix default constraints for fixed voltage regulat=
ors
> >
> > =A0 =A0Default voltage constraints were being provided for fixed vo=
ltage
> > =A0 =A0regulator where board constraints were not provided but thes=
e constraints
> > =A0 =A0used INT_MIN as the default minimum voltage which is not a v=
alid value
> > =A0 =A0since it is less than zero. Use 1uV instead.
> >
> > =A0 =A0Also set the default values we set in the constraints themse=
lves since
> > =A0 =A0otherwise the max_uV constraint we determine will not be sto=
red in the
> > =A0 =A0actual constraint strucutre and will therefore not be used.
> >
> > =A0 =A0Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.c=
om>
> > =A0 =A0Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> >
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index 2f14c16..98c3a74 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -703,10 +703,13 @@ static int set_machine_constraints(struct reg=
ulator_dev *rdev,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =A0 =A0 cmin =3D constraints->mi=
n_uV;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =A0 =A0 cmax =3D constraints->ma=
x_uV;
> >
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* it's safe to autoconfigure fixed-v=
oltage supplies */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* it's safe to autoconfigure fixed-v=
oltage supplies
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0and the constraints are used b=
y list_voltage. */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (count =3D=3D 1 && !cmin) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmin =3D INT_MIN;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmin =3D 1;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmax =3D INT_MAX;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 constraints->min_uV =3D=
 cmin;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 constraints->max_uV =3D=
 cmax;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* voltage constraints are optional =
*/
> >
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
