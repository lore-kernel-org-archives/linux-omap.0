From: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: [PATCH 1/4] ARM: dts: am335x-bone-common: use phandles for USB
 and DMA refs
Date: Mon, 28 Apr 2014 13:10:41 -0300
Message-ID: <20140428161041.GA6140@solid>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
 <535E689D.7010204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <535E689D.7010204-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 28, 2014 at 08:11:33PM +0530, George Cherian wrote:
> On 4/28/2014 7:28 PM, Guido Mart=EDnez wrote:
> >Use phandles instead of unit adresses to reference usb and dma nodes=
=2E
> >This makes the DT more robust and readable.
> The series will give dtb build errors
> Error: arch/arm/boot/dts/am335x-bone-common.dtsi:186.2-15 syntax erro=
r
> FATAL ERROR: Unable to parse input tree
> Error: arch/arm/boot/dts/am335x-evmsk.dts:367.2-15 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [arch/arm/boot/dts/am335x-bone.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Error: arch/arm/boot/dts/am335x-evm.dts:334.2-15 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [arch/arm/boot/dts/am335x-evmsk.dtb] Error 1
> make[1]: *** [arch/arm/boot/dts/am335x-evm.dtb] Error 1
> Error: arch/arm/boot/dts/am335x-igep0033.dtsi:204.2-15 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [arch/arm/boot/dts/am335x-base0033.dtb] Error 1
> Error: arch/arm/boot/dts/am335x-bone-common.dtsi:186.2-15 syntax erro=
r
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [arch/arm/boot/dts/am335x-boneblack.dtb] Error 1
> make: *** [dtbs] Error 2
>=20
Terribly sorry about this. I'll send a v2.

> >
> >Signed-off-by: Guido Mart=EDnez <guido-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
> >---
> >  arch/arm/boot/dts/am335x-bone-common.dtsi | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/bo=
ot/dts/am335x-bone-common.dtsi
> >index 2e7d932..b95bc9a 100644
> >--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> >+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> >@@ -183,28 +183,28 @@
> >  &usb {
> >  	status =3D "okay";
> >-	control@44e10620 {
> >+	&usb_ctrl_mod {
> >  		status =3D "okay";
> >  	};
> >-	usb-phy@47401300 {
> >+	&usb0_phy {
> >  		status =3D "okay";
> >  	};
> >-	usb-phy@47401b00 {
> >+	&usb1_phy {
> >  		status =3D "okay";
> >  	};
> >-	usb@47401000 {
> >+	&usb0 {
> >  		status =3D "okay";
> >  	};
> >-	usb@47401800 {
> >+	&usb1 {
> >  		status =3D "okay";
> >  		dr_mode =3D "host";
> >  	};
> >-	dma-controller@47402000  {
> >+	&cppi41dma  {
> >  		status =3D "okay";
> >  	};
> >  };
> Instead the patch should be
>=20
>      diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi
> b/arch/arm/boot/dts/am335x-bone-common.dtsi
>      index 2e7d932..06be20a 100644
>      --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
>      +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
>      @@ -182,31 +182,30 @@
>=20
>       &usb {
>              status =3D "okay";
>      +};
>      +&usb_ctrl_mod {
>      +       status =3D "okay";
>      +};
>=20
>      -       control@44e10620 {
>      -               status =3D "okay";
>      -       };
>      -
>      -       usb-phy@47401300 {
>      -               status =3D "okay";
>      -       };
>      +&usb0_phy {
>      +       status =3D "okay";
>      +};
>=20
>      -       usb-phy@47401b00 {
>      -               status =3D "okay";
>      -       };
>      +&usb1_phy {
>      +       status =3D "okay";
>      +};
>=20
>      -       usb@47401000 {
>      -               status =3D "okay";
>      -       };
>      +&usb {
>      +       status =3D "okay";
>      +};
>=20
>      -       usb@47401800 {
>      -               status =3D "okay";
>      -               dr_mode =3D "host";
>      -       };
>      +&usb1 {
>      +       status =3D "okay";
>      +       dr_mode =3D "host";
>      +};
>=20
>      -       dma-controller@47402000  {
>      -               status =3D "okay";
>      -       };
>      +&cppi41dma  {
>      +       status =3D "okay";
>       };
>=20
>=20
>=20
> --=20
> -George
>=20

--=20
Guido Mart=EDnez, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
