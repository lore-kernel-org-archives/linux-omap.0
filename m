From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH 1/4] dt: omap3: add SoC file for handling i2c controllers
Date: Thu, 14 Jul 2011 09:04:55 +0530
Message-ID: <20110714033455.GA26506@manju-desktop>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
 <1310592975-25773-2-git-send-email-manjugk@ti.com>
 <CACxGe6u3D=ZgK2TpLP7waCwH=MA_5UR+YBRSgVE9QBVyvkF32A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:37454 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524Ab1GNDfP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 23:35:15 -0400
Received: by iwi5 with SMTP id 5so9135920iwi.35
        for <linux-omap@vger.kernel.org>; Wed, 13 Jul 2011 20:35:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACxGe6u3D=ZgK2TpLP7waCwH=MA_5UR+YBRSgVE9QBVyvkF32A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jul 14, 2011 at 07:57:16AM +0900, Grant Likely wrote:
> On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.co=
m> wrote:
> >
> > Add omap3 SoC file for handling omap3 SoC i2c controllers existing
> > on l4-core bus.
> >
> > Out of three i2c controllers, first i2c controller is interfaced wi=
th
> > PMIC on all the boards of OMAP3. The clock for i2c controllers are
> > controlled through omap hwmod framework hence first i2c controller
> > device registration through dt is disabled till hwmod dependencies
> > are resolved.
> >
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > ---
> > =A0arch/arm/boot/dts/omap3-soc.dtsi | =A0 65 ++++++++++++++++++++++=
++++++++++++++++
> > =A01 files changed, 65 insertions(+), 0 deletions(-)
> > =A0create mode 100644 arch/arm/boot/dts/omap3-soc.dtsi
> >
> > diff --git a/arch/arm/boot/dts/omap3-soc.dtsi b/arch/arm/boot/dts/o=
map3-soc.dtsi
> > new file mode 100644
> > index 0000000..f186a32
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/omap3-soc.dtsi
> > @@ -0,0 +1,65 @@
> > +/*
> > + * Device Tree Source for OMAP3 SoC
> > + *
> > + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.=
ti.com/
> > + *
> > + * This file is licensed under the terms of the GNU General Public=
 License
> > + * version 2. =A0This program is licensed "as is" without any warr=
anty of any
> > + * kind, whether express or implied.
> > + */
> > +
> > +/dts-v1/;
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > + =A0 =A0 =A0 #address-cells =3D <1>;
> > + =A0 =A0 =A0 #size-cells =3D <1>;
> > + =A0 =A0 =A0 model =3D "ti,omap3";
>=20
> You can drop the model property here since this doesn't define a boar=
d.
ok
>=20
> > + =A0 =A0 =A0 compatible =3D "ti,omap3";
> > +
> > + =A0 =A0 =A0 intc: interrupt-controller@0x48200000 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap3-intc", "arm,=
intc";
>=20
> Which arm intc controller?  For any new 'compatible' value you define=
,
> the patch needs to include documentation for it in
> Documentation/devicetree/bindings.
for time being, I can drop this and introduce later with documentation.
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x48200000 0x1000>;
> > + =A0 =A0 =A0 };
> > +
> > + =A0 =A0 =A0 l4-core {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,l4-core";
>=20
> Probably should be "ti,omap3-l4-core"?
ok.
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0 0x48000000 0x1000000>;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c@1 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1=
>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,om=
ap3-i2c";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x70000 0x10=
0>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < 88 >=
;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D "disabled"=
;
>=20
> Drop the 'status' properties.  I know the current tegra code does
> this, but I'd prefer devices to be enabled by default and for boards
> to explicitly disable them instead of the other way around.
wanted to disable i2c1 by default. i will remove.

-Manjunath
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
