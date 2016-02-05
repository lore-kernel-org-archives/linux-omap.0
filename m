From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ARM: LG Optimus Black (P970) codename sniper
 support, with basic features
Date: Fri, 05 Feb 2016 20:39:00 +0100
Message-ID: <1454701140.2623.12.camel@collins>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
	 <1454697741-8687-4-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-uKMkmFyrqv4pzcvoyayI"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454697741-8687-4-git-send-email-contact-W9ppeneeCTY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--=-uKMkmFyrqv4pzcvoyayI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 05 f=C3=A9vrier 2016 =C3=A0 19:42 +0100, Paul Kocialkowski a =
=C3=A9crit :
> The LG Optimus Black (P970) codename sniper is a smartphone that was desi=
gned
> and manufactured by LG Electronics (LGE) and released back in 2011.
> It is using an OMAP3630 SoC, GP version.
>=20
> This adds devicetree support for the device, with only a few basic featur=
es
> supported, such as debug uart, i2c, internal emmc and external mmc.
>=20
> Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> ---
>  arch/arm/boot/dts/Makefile         |   1 +
>  arch/arm/boot/dts/omap3-sniper.dts | 215 +++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 216 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3-sniper.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a4a6d70..7314cf8 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -460,6 +460,7 @@ dtb-$(CONFIG_ARCH_OMAP3) +=3D \
>  	omap3-sbc-t3517.dtb \
>  	omap3-sbc-t3530.dtb \
>  	omap3-sbc-t3730.dtb \
> +	omap3-sniper.dtb \
>  	omap3-thunder.dtb \
>  	omap3-zoom3.dtb
>  dtb-$(CONFIG_SOC_TI81XX) +=3D \
> diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3=
-sniper.dts
> new file mode 100644
> index 0000000..24bcd82
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-sniper.dts
> @@ -0,0 +1,215 @@
> +/*
> + * Copyright (C) 2015-2016 Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +#include "omap36xx.dtsi"
> +
> +/ {
> +	model =3D "LG Optimus Black (P970)";
> +	compatible =3D "lge,omap3-sniper", "ti,omap36xx", "ti,omap3";
> +
> +	cpus {
> +		cpu@0 {
> +			cpu0-supply =3D <&vcc>;
> +		};
> +	};
> +
> +	memory {
> +		device_type =3D "memory";
> +		reg =3D <0x80000000 0x20000000>; /* 512 MB */
> +	};
> +};
> +
> +&omap3_pmx_core {
> +	pinctrl-names =3D "default";
> +
> +	uart3_pins: pinmux_uart3_pins {
> +		pinctrl-single,pins =3D <
> +			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)	/* uart3_rx_irrx */
> +			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)	/* uart3_tx_irtx */
> +		>;
> +	};
> +
> +	dp3t_sel_pins: pinmux_dp3t_sel_pins {
> +		pinctrl-single,pins =3D <
> +			OMAP3_CORE1_IOPAD(0x2196, PIN_OUTPUT | MUX_MODE4)	/* gpio_161 */
> +			OMAP3_CORE1_IOPAD(0x2198, PIN_OUTPUT | MUX_MODE4)	/* gpio_162 */
> +		>;
> +	};
> +
> +	i2c1_pins: pinmux_i2c1_pins {
> +		pinctrl-single,pins =3D <
> +			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)	/* i2c1_scl */
> +			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)	/* i2c1_sda */
> +		>;
> +	};
> +
> +	i2c2_pins: pinmux_i2c2_pins {
> +		pinctrl-single,pins =3D <
> +			OMAP3_CORE1_IOPAD(0x21be, PIN_INPUT | MUX_MODE0)	/* i2c2_scl */
> +			OMAP3_CORE1_IOPAD(0x21c0, PIN_INPUT | MUX_MODE0)	/* i2c2_sda */
> +		>;
> +	};
> +
> +	i2c3_pins: pinmux_i2c3_pins {
> +		pinctrl-single,pins =3D <
> +			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl */
> +			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda */
> +		>;
> +	};
> +
> +	lp8720_en_pin: pinmux_lp8720_en_pin {
> +		pinctrl-single,pins =3D <
> +			OMAP3_CORE1_IOPAD(0x2080, PIN_OUTPUT | MUX_MODE4)	/* gpio_37 */
> +		>;
> +	};
> +
> +	mmc1_pins: pinmux_mmc1_pins {
> +		pinctrl-single,pins =3D <
> +			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT | MUX_MODE0)	/* sdmmc1_clk */
> +			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT | MUX_MODE0)	/* sdmmc1_cmd */
> +			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat0 */
> +			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat1 */
> +			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat2 */
> +			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat3 */
> +		>;
> +	};
> +
> +	mmc2_pins: pinmux_mmc2_pins {
> +		pinctrl-single,pins =3D <
> +			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT | MUX_MODE0)	/* sdmmc2_clk */
> +			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT | MUX_MODE0)	/* sdmmc2_cmd */
> +			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT | MUX_MODE0)	/* sdmmc2_dat0 */
> +			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT | MUX_MODE0)	/* sdmmc2_dat1 */
> +			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT | MUX_MODE0)	/* sdmmc2_dat2 */
> +			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT | MUX_MODE0)	/* sdmmc2_dat3 */
> +			OMAP3_CORE1_IOPAD(0x2164, PIN_INPUT | MUX_MODE0)	/* sdmmc2_dat4 */
> +			OMAP3_CORE1_IOPAD(0x2166, PIN_INPUT | MUX_MODE0)	/* sdmmc2_dat5 */
> +			OMAP3_CORE1_IOPAD(0x2168, PIN_INPUT | MUX_MODE0)	/* sdmmc2_dat6 */
> +			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE0)	/* sdmmc2_dat7 */
> +		>;
> +	};
> +};
> +
> +&omap3_pmx_wkup {
> +	pinctrl-names =3D "default";
> +
> +	mmc1_cd_pin: pinmux_mmc1_cd_pin {
> +		pinctrl-single,pins =3D <
> +			OMAP3_WKUP_IOPAD(0x2a1a, PIN_INPUT | MUX_MODE4)		/* gpio_10 */
> +		>;
> +	};
> +};
> +
> +&gpio2 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio5 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio6 {
> +	ti,no-reset-on-init;
> +};
> +
> +&uart3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart3_pins &dp3t_sel_pins>;
> +
> +	interrupts-extended =3D <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
> +};
> +
> +&i2c1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c1_pins>;
> +
> +	clock-frequency =3D <2600000>;
> +
> +	twl: twl@48 {
> +		reg =3D <0x48>;
> +		interrupts =3D <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent =3D <&intc>;
> +
> +		twl_power: power {
> +			compatible =3D "ti,twl4030-power";
> +			ti,use_poweroff;
> +		};
> +	};
> +};
> +
> +#include "twl4030.dtsi"
> +#include "twl4030_omap3.dtsi"
> +
> +&i2c2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c2_pins>;
> +
> +	clock-frequency =3D <400000>;
> +};
> +
> +&i2c3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c3_pins>;
> +
> +	clock-frequency =3D <400000>;
> +
> +	lp8720@7d {
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&lp8720_en_pin>;
> +
> +		compatible =3D "ti,lp8720";
> +		reg =3D <0x7d>;
> +
> +		enable-gpios =3D <&gpio2 5 GPIO_ACTIVE_HIGH>; /* gpio_37 */
> +
> +		lp8720_ldo1: ldo1 {
> +			regulator-min-microvolt =3D <3000000>;
> +			regulator-max-microvolt =3D <3000000>;
> +		};
> +	};
> +};
> +
> +&mmc1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc1_pins &mmc1_cd_pin>;
> +	vmmc-supply =3D <&lp8720_ldo1>;
> +	cd-gpios =3D <&gpio1 10 GPIO_ACTIVE_LOW>; /* gpio 10 */
> +	bus-width =3D <4>;
> +};
> +
> +&mmc2 {
> +

Please discard this newline in case v2 gets merged.

> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc2_pins>;
> +	vmmc-supply =3D <&vmmc2>;
> +	ti,non-removable;
> +	bus-width =3D <8>;
> +};
> +
> +&mmc3 {
> +	status =3D "disabled";
> +};
> +
> +/*
> + * The TWL4030 VAUX2 and VDAC regulators power sensors that are slaves o=
n I2C3.
> + * When not powered, these sensors cause the I2C3 clock to stay low at a=
ll times,
> + * making it impossible to reach other devices on I2C3.
> + */
> +
> +&vaux2 {
> +	regulator-min-microvolt =3D <2800000>;
> +	regulator-max-microvolt =3D <2800000>;
> +	regulator-always-on;
> +};
> +
> +&vdac {
> +	regulator-min-microvolt =3D <1800000>;
> +	regulator-max-microvolt =3D <1800000>;
> +	regulator-always-on;
> +};


--=-uKMkmFyrqv4pzcvoyayI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWtPpVAAoJEIT9weqP7pUMP8wP/25d+iVV6xRMVo7DOVJbEZr+
os1PE6sKJ1tQO8/rFETfGYP7L5ItQK73fAlmEL9lRO8R40VRUD5epSq5bic7o+y8
zDRKd2h59XD1p2Bn05jENqKyL1VHWJ67/SoNoUyWVQLTc/2bcm55NhLEq5940eA3
IApKfnAMbffBYCspyXxintduc0GQzw8YMEu1+WFiWCY+JeVHVi8BeQhtOy9BsSL4
TTorFX5ODA29nBKTg08+rX5wC+qvrJpgTnGo0xAwWxquLC1Rq5vDZwvYG7h4TPe9
PhQWlcZBrWMuRAjBbDih3f57i3Jz82gESJdUYe8LaufGUDb8wcwm9gXm9GGPR3XC
ZjRWYqGRDHDETbGRHULlDNA68eqLAck9GKRKprI0P7FHhmosHvfdQwR8eqXiWdlc
QJocbBig6RxgS90eOMHjythFuHAbxvtQdmh0i0IF7U9jDhzNQeAaqFWFzUeqNn0Y
ENS2vOAA69a1wa84O9TpiDQ6LKMrJwcKMUBrZx/FzkZBq5JK3SwnMLB5qSROm9Jq
9OeCWqbiHnulvwaRBTBLnLovHMcKRA1zvuO3hQsObQs5Z+UDv2WL4wnc9T6z7vd8
ReuSTTbg9CTCvI7eoC47mknltlDV/B3zVF+fVed+bzDLbKeYMKMA0foZvzFlutzS
SYZj2G9q/Woe3/Ll1m6A
=6gFZ
-----END PGP SIGNATURE-----

--=-uKMkmFyrqv4pzcvoyayI--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
