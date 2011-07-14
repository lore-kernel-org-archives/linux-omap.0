From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH 1/4] dt: omap3: add SoC file for handling i2c controllers
Date: Thu, 14 Jul 2011 09:21:15 +0530
Message-ID: <20110714035115.GB26506@manju-desktop>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
 <1310592975-25773-2-git-send-email-manjugk@ti.com>
 <CACxGe6u3D=ZgK2TpLP7waCwH=MA_5UR+YBRSgVE9QBVyvkF32A@mail.gmail.com>
 <CACxGe6vuX4286cN7sNa=3RsWeGzNmNBGVqeqKvcoyiLU9Z9A9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:49215 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753574Ab1GNDvY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 23:51:24 -0400
Received: by mail-iw0-f172.google.com with SMTP id 39so10274243iwn.17
        for <linux-omap@vger.kernel.org>; Wed, 13 Jul 2011 20:51:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACxGe6vuX4286cN7sNa=3RsWeGzNmNBGVqeqKvcoyiLU9Z9A9A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jul 14, 2011 at 07:58:35AM +0900, Grant Likely wrote:
> On Thu, Jul 14, 2011 at 7:57 AM, Grant Likely <grant.likely@secretlab=
=2Eca> wrote:
> > On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.=
com> wrote:
> >>
> >> Add omap3 SoC file for handling omap3 SoC i2c controllers existing
> >> on l4-core bus.
> >>
> >> Out of three i2c controllers, first i2c controller is interfaced w=
ith
> >> PMIC on all the boards of OMAP3. The clock for i2c controllers are
> >> controlled through omap hwmod framework hence first i2c controller
> >> device registration through dt is disabled till hwmod dependencies
> >> are resolved.
> >>
> >> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> >> ---
> >> =A0arch/arm/boot/dts/omap3-soc.dtsi | =A0 65 +++++++++++++++++++++=
+++++++++++++++++
> >> =A01 files changed, 65 insertions(+), 0 deletions(-)
> >> =A0create mode 100644 arch/arm/boot/dts/omap3-soc.dtsi
> >>
> >> diff --git a/arch/arm/boot/dts/omap3-soc.dtsi b/arch/arm/boot/dts/=
omap3-soc.dtsi
> >> new file mode 100644
> >> index 0000000..f186a32
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/omap3-soc.dtsi
> >> @@ -0,0 +1,65 @@
> >> +/*
> >> + * Device Tree Source for OMAP3 SoC
> >> + *
> >> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www=
=2Eti.com/
> >> + *
> >> + * This file is licensed under the terms of the GNU General Publi=
c License
> >> + * version 2. =A0This program is licensed "as is" without any war=
ranty of any
> >> + * kind, whether express or implied.
> >> + */
> >> +
> >> +/dts-v1/;
> >> +/include/ "skeleton.dtsi"
> >> +
> >> +/ {
> >> + =A0 =A0 =A0 #address-cells =3D <1>;
> >> + =A0 =A0 =A0 #size-cells =3D <1>;
> >> + =A0 =A0 =A0 model =3D "ti,omap3";
> >
> > You can drop the model property here since this doesn't define a bo=
ard.
> >
> >> + =A0 =A0 =A0 compatible =3D "ti,omap3";
> >> +
> >> + =A0 =A0 =A0 intc: interrupt-controller@0x48200000 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap3-intc", "arm=
,intc";
> >
> > Which arm intc controller? =A0For any new 'compatible' value you de=
fine,
> > the patch needs to include documentation for it in
> > Documentation/devicetree/bindings.
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <1>;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x48200000 0x1000>;
> >> + =A0 =A0 =A0 };
> >> +
> >> + =A0 =A0 =A0 l4-core {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,l4-core";
> >
> > Probably should be "ti,omap3-l4-core"?
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0 0x48000000 0x1000000>;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c@1 {
>=20
> This name is wrong.  The address portion of the name must match the
> address in the first entry of the 'reg' property.  So, that would be:
> "i2c@70000".
>=20
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <=
1>;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,o=
map3-i2c";
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x70000 0x1=
00>;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < 88 =
>;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D "disabled=
";
> >
> > Drop the 'status' properties. =A0I know the current tegra code does
> > this, but I'd prefer devices to be enabled by default and for board=
s
> > to explicitly disable them instead of the other way around.
ok. I will use the convention.

-Manjunath
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
