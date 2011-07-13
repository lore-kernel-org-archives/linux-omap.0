From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] dt: omap3: add SoC file for handling i2c controllers
Date: Thu, 14 Jul 2011 07:57:16 +0900
Message-ID: <CACxGe6u3D=ZgK2TpLP7waCwH=MA_5UR+YBRSgVE9QBVyvkF32A@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com> <1310592975-25773-2-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44884 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab1GMW5h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 18:57:37 -0400
Received: by gxk21 with SMTP id 21so2614017gxk.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Jul 2011 15:57:36 -0700 (PDT)
In-Reply-To: <1310592975-25773-2-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
>
> Add omap3 SoC file for handling omap3 SoC i2c controllers existing
> on l4-core bus.
>
> Out of three i2c controllers, first i2c controller is interfaced with
> PMIC on all the boards of OMAP3. The clock for i2c controllers are
> controlled through omap hwmod framework hence first i2c controller
> device registration through dt is disabled till hwmod dependencies
> are resolved.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
> =A0arch/arm/boot/dts/omap3-soc.dtsi | =A0 65 ++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 65 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/boot/dts/omap3-soc.dtsi
>
> diff --git a/arch/arm/boot/dts/omap3-soc.dtsi b/arch/arm/boot/dts/oma=
p3-soc.dtsi
> new file mode 100644
> index 0000000..f186a32
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-soc.dtsi
> @@ -0,0 +1,65 @@
> +/*
> + * Device Tree Source for OMAP3 SoC
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + *
> + * This file is licensed under the terms of the GNU General Public L=
icense
> + * version 2. =A0This program is licensed "as is" without any warran=
ty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "skeleton.dtsi"
> +
> +/ {
> + =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 model =3D "ti,omap3";

You can drop the model property here since this doesn't define a board.

> + =A0 =A0 =A0 compatible =3D "ti,omap3";
> +
> + =A0 =A0 =A0 intc: interrupt-controller@0x48200000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap3-intc", "arm,in=
tc";

Which arm intc controller?  For any new 'compatible' value you define,
the patch needs to include documentation for it in
Documentation/devicetree/bindings.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x48200000 0x1000>;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 l4-core {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,l4-core";

Probably should be "ti,omap3-l4-core"?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0 0x48000000 0x1000000>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c@1 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap=
3-i2c";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x70000 0x100>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < 88 >;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D "disabled";

Drop the 'status' properties.  I know the current tegra code does
this, but I'd prefer devices to be enabled by default and for boards
to explicitly disable them instead of the other way around.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c@2 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap=
3-i2c";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x72000 0x100>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < 89 >;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c@3 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap=
3-i2c";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x60000 0x100>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < 93 >;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 l4-per {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,l4-per";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0 0x49000000 0x100000>;
> + =A0 =A0 =A0 };
> +};
> --
> 1.7.4.1
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
