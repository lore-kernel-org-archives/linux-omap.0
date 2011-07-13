From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/4] dt: OMAP3: Beagle board: set clock freq for i2c devices
Date: Thu, 14 Jul 2011 08:04:29 +0900
Message-ID: <CACxGe6uaR41CLPRWURDiXxnphScHPikLU3AmwxNZsijt9GP4qg@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com> <1310592975-25773-3-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56261 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab1GMXEt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 19:04:49 -0400
Received: by gxk21 with SMTP id 21so2616012gxk.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Jul 2011 16:04:49 -0700 (PDT)
In-Reply-To: <1310592975-25773-3-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
>
> Update omap3 beagle dts file with required clock frequencies for the =
i2c
> client devices existing on beagle board.
>
> Beagle custom board dts file is cleaned up so that it can coexist wit=
h omap3
> soc dts file.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
> =A0arch/arm/boot/dts/omap3-beagle-nunchuck.dts | =A0 11 +---------
> =A0arch/arm/boot/dts/omap3-beagle.dts =A0 =A0 =A0 =A0 =A0| =A0 29 +++=
++++++++++++++++++++++-
> =A02 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts b/arch/arm/b=
oot/dts/omap3-beagle-nunchuck.dts
> index 2607be5..324ff86 100644
> --- a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> @@ -1,16 +1,7 @@
> =A0/include/ "omap3-beagle.dts"
>
> =A0/ {
> - =A0 =A0 =A0 i2c@48072000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap3-i2c";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x48072000 0x80>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeprom@50 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "at,at24=
c01";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x50 >;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 i2c@2 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0joystick@52 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "sparkf=
un,wiichuck";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D < 0x52 >;
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/o=
map3-beagle.dts
> index 4439466..b45fbc9 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -1,7 +1,32 @@
> -/dts-v1/;
> -/include/ "skeleton.dtsi"
> +/include/ "omap3-soc.dtsi"
>
> =A0/ {
> =A0 =A0 =A0 =A0model =3D "TI OMAP3 BeagleBoard";
> =A0 =A0 =A0 =A0compatible =3D "ti,omap3-beagle";

compatible =3D "ti,omap3-beagle", "ti,omap3";

> +
> + =A0 =A0 =A0 i2c@1 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <2600000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D "disabled";
> + =A0 =A0 =A0 };

Since this file include the omap3-soc dtsi, you don't need to
duplicate the #address-cells and #size-cells properties.  You only
need to specify the ones that have changed.  Also, since the include
file has the i2c nodes as children of the l4 bus, you should you need
to either duplicate the same bus hierarchy here, or use an independent
label reference by adding a label to the node in omap3-soc.dtsi, and
using the following syntax /outside/ of the /{ ... } root node:

&i2c-1 {
       clock-frequency =3D <2600000>;
};

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
