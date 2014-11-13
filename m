From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: Add devicetree for NovaTech OrionLXm
Date: Wed, 12 Nov 2014 18:59:34 -0600
Message-ID: <20141113005908.GA27381@saruman>
References: <1415832094-20991-1-git-send-email-george.mccollister@gmail.com>
 <1415832094-20991-2-git-send-email-george.mccollister@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415832094-20991-2-git-send-email-george.mccollister-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George McCollister <george.mccollister-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Carlos Garcia <carlos-FEoyFZUZMvJAfugRpC6u6w@public.gmane.org>, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM PORT" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:OMAP DEVICE TREE..." <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 12, 2014 at 04:41:33PM -0600, George McCollister wrote:
> diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-=
lxm.dts
> new file mode 100644
> index 0000000..0f7cbae
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-lxm.dts
> @@ -0,0 +1,354 @@
> +/*
> + * Copyright (C) 2014 NovaTech LLC - http://www.novatechweb.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +#include "am33xx.dtsi"
> +
> +/ {
> +	model =3D "NovaTech OrionLXm";
> +	compatible =3D "novatech,am335x-lxm", "ti,am33xx";
> +
> +	cpus {
> +		cpu@0 {
> +			cpu0-supply =3D <&vdd1_reg>;
> +		};
> +	};
> +
> +	memory {
> +		device_type =3D "memory";
> +		reg =3D <0x80000000 0x20000000>; /* 512 MB */
> +	};
> +
> +	vbat: fixedregulator@0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vbat";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-boot-on;
> +	};

I suppose this is the 5V on a power jack, or something like that ?

> +	vmmcsd_fixed: fixedregulator@0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vmmcsd_fixed";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;

but this... I know every other board devices this as a fixed regulator,
but is it really a fixed regulator or is supplied by one of the LDOs on
the PMIC ?

> +	};
> +};
> +
> +&am33xx_pinmux {
> +	mmc1_pins: pinmux_mmc1_pins {
> +		pinctrl-single,pins =3D <
> +			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3 */
> +			0xf4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2 */
> +			0xf8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1 */
> +			0xfc (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0 */
> +			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk */
> +			0x104 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd */
> +		>;
> +	};
> +
> +	i2c0_pins: pinmux_i2c0_pins {
> +		pinctrl-single,pins =3D <
> +			0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
> +			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
> +		>;
> +	};
> +
> +	i2c2_pins: pinmux_i2c2_pins {
> +		pinctrl-single,pins =3D <
> +			0x178 (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
> +			0x17c (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_rtsn.i2c2_scl */

on thing to keep in mind, if you already have external pullups, you
might not want to add internal pullups as you'd end up with both
resistors in parallel. For I2C the danger is minimal (unless you have a
ton of bus capacitance, then it changes high/low time), but it's best to
write a more "pristine" DTS. (and sure, I know pretty much every board
makes this mistake, but it's best if we don't proliferate the error)

> +&i2c0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c0_pins>;
> +
> +	status =3D "okay";
> +	clock-frequency =3D <400000>;
> +
> +	serial_config1: serial_config1@20 {
> +		compatible =3D "nxp,pca9539";
> +		reg =3D <0x20>;
> +	};
> +
> +	serial_config2: serial_config2@21 {
> +		compatible =3D "nxp,pca9539";
> +		reg =3D <0x21>;
> +	};
> +
> +	tps: tps@2d {
> +		reg =3D <0x2d>;

which TPS device ? no compatible ?

> +/include/ "tps65910.dtsi"

oh... okay.

> +&tps {
> +	vcc1-supply =3D <&vbat>;
> +	vcc2-supply =3D <&vbat>;
> +	vcc3-supply =3D <&vbat>;
> +	vcc4-supply =3D <&vbat>;
> +	vcc5-supply =3D <&vbat>;
> +	vcc6-supply =3D <&vbat>;
> +	vcc7-supply =3D <&vbat>;
> +	vccio-supply =3D <&vbat>;
> +
> +	regulators {
> +		vrtc_reg: regulator@0 {
> +			regulator-always-on;

this should not be always on, you want to pass this as supply to the RTC
module so it can manage it. It's also best to give names to all
regulators, so people know what they're used for.

> +		};
> +
> +		vio_reg: regulator@1 {
> +			regulator-always-on;
> +		};
> +
> +		vdd1_reg: regulator@2 {
> +			regulator-name =3D "vdd_mpu";
> +			regulator-min-microvolt =3D <600000>;
> +			regulator-max-microvolt =3D <1500000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		vdd2_reg: regulator@3 {
> +			regulator-always-on;
> +		};
> +
> +		vdd3_reg: regulator@4 {
> +			regulator-always-on;
> +		};
> +
> +		vdig1_reg: regulator@5 {
> +			regulator-always-on;
> +		};
> +
> +		vdig2_reg: regulator@6 {
> +			regulator-always-on;
> +		};
> +
> +		vpll_reg: regulator@7 {
> +			regulator-always-on;
> +		};
> +
> +		vdac_reg: regulator@8 {
> +			regulator-always-on;
> +		};
> +
> +		vaux1_reg: regulator@9 {
> +			regulator-always-on;
> +		};
> +
> +		vaux2_reg: regulator@10 {
> +			regulator-always-on;
> +		};
> +
> +		vaux33_reg: regulator@11 {

isn't this the supply to the other MMC slot ?

> +			regulator-always-on;
> +		};
> +
> +		vmmc_reg: regulator@12 {
> +			regulator-min-microvolt =3D <3300000>;
> +			regulator-max-microvolt =3D <3300000>;
> +			regulator-always-on;
> +		};
> +	};
> +};
> +
> +&sham {
> +	status =3D "okay";
> +};
> +
> +&aes {
> +	status =3D "okay";
> +};

just making sure, are you really using them ?

> +&mmc1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc1_pins>;
> +	bus-width =3D <4>;
> +	status =3D "okay";
> +	vmmc-supply =3D <&vmmc_reg>;
> +	ti,vcc-aux-disable-is-sleep;

this binding isn't documented anywhere. What was it supposed to do ?

--=20
balbi

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZAJ2AAoJEIaOsuA1yqREEP4QAJlCXEZghs1ScbFYFUvdPD4R
0LXjYoVGRnUS1w8/BM7Jj3t+gpL1fOatk1v1fBtDDP8s+1UCtDRT5eHB+wJArLW5
EilaCaKz4KJBt0pArzgPDUHpJUMQGe9plWyZgxheEmgVj0ljwEt49v8iOXRqF0Fx
BZYTSyGZbsSI8M90wLHgpORzN82So51yr9xBj9MEnGAHFLevU5f3D6auzRZ7ZCYw
1yQRukNKN9dl7u/VWKDroJoM34ij01LEYYp8v1wcOVfcqxO5syCDBZaykYPsB79d
Aqn8AGp+j8uGninD869/qhYh5xdVMmOgLwgwclPMX01+/kyzOWosS+fN0h9Ji5fO
e2PtkBIfvklrLvP9/Ds/aEhlgn1n2RKDeplA5B1ZsL8FXmYqWByyUBrGTTupNglQ
8Yqah3eirTsmJRxDsu8b/Xo1CZnxyxGVFtQv9UiRkI5+IgvKTBGwQ7pNCEKB8b9T
NinikIrNOxqRxoJT5ZLWRfuksD2mzGfiHIHya5bKNovhLOxkdEehCmQE/s4WuGo0
vEAIKKM2lqvjxv41MLUkhYso3WxMwWa8Qxq33oNZkEw7sopL9OjK1oom27zJDkaY
uT4+grySq45uY76RAh6owSF78ghpXYK0eyfwwWvbo5UXGzCBpgo1Hy+AmODzn/Lx
gCw19f7TxU5uL8LkhD2A
=N5JM
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
