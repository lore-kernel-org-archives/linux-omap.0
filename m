From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v4 3/5] ARM: dts: omap3-sniper: TWL4030 keypad support
Date: Tue, 01 Mar 2016 20:19:16 +0100
Message-ID: <1456859956.1031.39.camel@paulk.fr>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
	 <1456663185-14170-4-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-QvR59q0AMK+2KlhqmL0/"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456663185-14170-4-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-QvR59q0AMK+2KlhqmL0/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le dimanche 28 f=C3=A9vrier 2016 =C3=A0 13:39 +0100, Paul Kocialkowski a =
=C3=A9crit=C2=A0:
> This adds support for the volume and gesture keys, using TWL4030 keypad.

I noticed this patch hadn't been picked up in:=C2=A0https://git.kernel.org/=
cgit/linux
/kernel/git/tmlind/linux-omap.git/log/?h=3Domap-for-v4.6/dt

Should I submit it somewhere else instead?

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
> =C2=A0arch/arm/boot/dts/omap3-sniper.dts | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3=
-
> sniper.dts
> index 6e31daf..78a1184 100644
> --- a/arch/arm/boot/dts/omap3-sniper.dts
> +++ b/arch/arm/boot/dts/omap3-sniper.dts
> @@ -8,6 +8,7 @@
> =C2=A0/dts-v1/;
> =C2=A0
> =C2=A0#include "omap36xx.dtsi"
> +#include <dt-bindings/input/input.h>
> =C2=A0
> =C2=A0/ {
> =C2=A0	model =3D "LG Optimus Black";
> @@ -226,6 +227,14 @@
> =C2=A0#include "twl4030.dtsi"
> =C2=A0#include "twl4030_omap3.dtsi"
> =C2=A0
> +&twl_keypad {
> +	linux,keymap =3D <
> +		MATRIX_KEY(0x00, 0x00, KEY_VOLUMEUP)
> +		MATRIX_KEY(0x01, 0x00, KEY_VOLUMEDOWN)
> +		MATRIX_KEY(0x02, 0x00, KEY_SELECT)
> +	>;
> +};
> +
> =C2=A0/*
> =C2=A0 * The TWL4030 VAUX2 and VDAC regulators power sensors that are sla=
ves on
> I2C3.
> =C2=A0 * When not powered, these sensors cause the I2C3 clock to stay low=
 at all
> times,
--=-QvR59q0AMK+2KlhqmL0/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW1es0AAoJEIT9weqP7pUM1y4P/3fXVuHw8IXrTHKcY8YvYM/e
V1GAmwM3hGSk/eOHUtWK2loATAwwduyz2ynOgQ7f0ejlD35SFbO+kOmLbddb+uGw
sn7/xO7O0B7Rll31HOA+B33B+9Um5eaLNuawSBV0G96T+qVfJbEHga7/2MxbBlBV
yDIxLIdvNk13Gr6596pfsUbJz99QNE+WFD7Fa+wNasMkKTSNgQr8R5ytRWCNOM8G
Krcn7AOrSbvsJxu21IrLDWxRTZ1YlGH5rtD//vElWPIaigGMbmPLJaBiyOCzYvqJ
kws+A2aZHLOWx8gCPwfwTXosnR0JVFCX64cPZgM8I6RIqnuW1X8PrmlMpiWhARAM
MDxyW9h0ftbu3w/z6dapMKvBRAPaX1tY8FUcdaEoojpheZEUlP64V5GBz47mXJ/I
T/kTHnb/68juMWCHx9H/ipsovL/FYl4hySc5m/IN0086ZmXcCEmBx/CnaiumiKJD
7PqvmHTfuXMe5uQQcTzErKZJewgB0dvVWQR+hK4hYBcUY4yze9JIC+7HFEm9rXl+
luWlu7apmbtoHdIU+QytOSTxO5wCjceu+S5itVyvxV5wRu4OrqivSmaGc0ByA0RC
FRHo+2KyI+32XGqAYxKZpl0M+7wp8fAnfTxl1ab4U9MuNBjPa/9cKaa67+qj2bva
TI95BRBA743222IcZsaK
=DlHN
-----END PGP SIGNATURE-----

--=-QvR59q0AMK+2KlhqmL0/--
