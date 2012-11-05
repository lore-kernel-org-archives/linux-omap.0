From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] ARM/dts: omap4-panda: Add pinmux configuration for
 HDMI
Date: Mon, 5 Nov 2012 15:17:27 +0200
Message-ID: <5097BC67.5050508@ti.com>
References: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com> <1352121259-5836-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE18F01895F41CF7143FBC828"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57111 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281Ab2KENRd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 08:17:33 -0500
In-Reply-To: <1352121259-5836-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, s-guiriec@ti.com

--------------enigE18F01895F41CF7143FBC828
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ricardo,

On 2012-11-05 15:14, Tomi Valkeinen wrote:
> From: Ricardo Neri <ricardo.neri@ti.com>
>=20
> Add the pinmux configuration for HDMI and TPD12S015A. Configure the
> gpios for the TPD12S015A and SDA, SCL and CEC for HDMI.
>=20
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/boot/dts/omap4-panda-a4.dts |   17 +++++++++++++++++
>  arch/arm/boot/dts/omap4-panda.dts    |   18 ++++++++++++++++++
>  arch/arm/boot/dts/omap4-pandaES.dts  |    9 +++++++++
>  3 files changed, 44 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap4-panda-a4.dts

Ricardo, I modified this and the other dts patch to add new .dts files
for the board revisions with external pull on the SCL/SDA lines. Can you
verify that these are correct?

 Tomi

> diff --git a/arch/arm/boot/dts/omap4-panda-a4.dts b/arch/arm/boot/dts/o=
map4-panda-a4.dts
> new file mode 100644
> index 0000000..75466d2
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap4-panda-a4.dts
> @@ -0,0 +1,17 @@
> +/*
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.c=
om/
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/include/ "omap4-panda.dts"
> +
> +/* Pandaboard Rev A4+ have external pullups on SCL & SDA */
> +&dss_hdmi_pins {
> +	pinctrl-single,pins =3D <
> +		0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
> +		0x5c 0x100	/* hdmi_scl.hdmi_scl INPUT | MODE 0 */
> +		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
> +		>;
> +};
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap=
4-panda.dts
> index e8f927c..8060f5b 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -65,6 +65,8 @@
>  			&twl6040_pins
>  			&mcpdm_pins
>  			&mcbsp1_pins
> +			&dss_hdmi_pins
> +			&tpd12s015_pins
>  	>;
> =20
>  	twl6040_pins: pinmux_twl6040_pins {
> @@ -92,6 +94,22 @@
>  			0xc4 0x100	/* abe_mcbsp1_fsx.abe_mcbsp1_fsx INPUT | MODE0 */
>  		>;
>  	};
> +
> +	dss_hdmi_pins: pinmux_dss_hdmi_pins {
> +		pinctrl-single,pins =3D <
> +			0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
> +			0x5c 0x118	/* hdmi_scl.hdmi_scl INPUT PULLUP | MODE 0 */
> +			0x5e 0x118	/* hdmi_sda.hdmi_sda INPUT PULLUP | MODE 0 */
> +		>;
> +	};
> +
> +	tpd12s015_pins: pinmux_tpd12s015_pins {
> +		pinctrl-single,pins =3D <
> +			0x22 0x3	/* gpmc_a17.gpio_41 OUTPUT | MODE3 */
> +			0x48 0x3	/* gpmc_nbe1.gpio_60 OUTPUT | MODE3 */
> +			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
> +		>;
> +	};
>  };
> =20
>  &i2c1 {
> diff --git a/arch/arm/boot/dts/omap4-pandaES.dts b/arch/arm/boot/dts/om=
ap4-pandaES.dts
> index d4ba43a..73bc1a6 100644
> --- a/arch/arm/boot/dts/omap4-pandaES.dts
> +++ b/arch/arm/boot/dts/omap4-pandaES.dts
> @@ -22,3 +22,12 @@
>  		"AFML", "Line In",
>  		"AFMR", "Line In";
>  };
> +
> +/* PandaboardES has external pullups on SCL & SDA */
> +&dss_hdmi_pins {
> +	pinctrl-single,pins =3D <
> +		0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
> +		0x5c 0x100	/* hdmi_scl.hdmi_scl INPUT | MODE 0 */
> +		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
> +		>;
> +};
>=20



--------------enigE18F01895F41CF7143FBC828
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQl7xnAAoJEPo9qoy8lh71MpMP/04PeFoxxsb627lZWyIZoKQU
IjA/kwmVE93lqhgkJGIk6ZVFW/3cfZC5RsIFR1f3de/gGfoiB8Rd/IlgO2lBt++3
0Asj03rcveZ39lULTu1mz83IKKXJAs5xfxPtSP7SNK8RCW1BaOkcSNJDogZhkLcA
m3aM1v3rCzYz3ZDua5tmMnDGafWG5BoJfMWbBdxOApOf2VcRplzPUBhUUuD8ZMm/
NdB9bicoy3Fy+BPrR1OzAcH0lCqx2ONyvR2WiYYbK7tN7dKLY9sXNnhLYdZsGYk5
gJDyorOqalRXo/XXTrJLxSXob7pocTme0hfPK9puory5odNLpHDQgZxPqyhuIA3J
tY5RFoxBPd+FIbDyObb7yJmXkdDVS9eTwQMZZVAXf4aYg9b8QwXYzGcUAeWJKMrf
JLGvy73ImrRpfYZSPe9Er4vV9FQRT9Qh1aqs7v1K492SUsi9LTqVruzWNX2HqT0J
u0AdPY1AIhi70yawDdUe1FkutJ+0+M52gA9bKRyfFO4KEA8akvqeDL2g+IdG8789
04g+mHYtQNj5DBtryp1z+TQhhg9BnWEG8rWr0dkWveIGysfk9YjVPgLhrTw7OYvj
mSS3Bx/c9zv2jDoGQdIC0Dips5+r54woNB+hkjWE+l0BlSefJfRFc4Bucwv0SOYX
yu6iu461RXa+bzWpsrE5
=0ObK
-----END PGP SIGNATURE-----

--------------enigE18F01895F41CF7143FBC828--
