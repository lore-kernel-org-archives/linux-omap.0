From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap4-panda: add DPI pinmuxing
Date: Tue, 29 Oct 2013 12:15:54 +0200
Message-ID: <526F8ADA.3030003@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="EDsDRAx4bjShFdHUoOwk91nChTG3tQ9nj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57057 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab3J2KQU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Oct 2013 06:16:20 -0400
In-Reply-To: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

--EDsDRAx4bjShFdHUoOwk91nChTG3tQ9nj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 25/10/13 13:07, Tomi Valkeinen wrote:
> New u-boot versions no longer set the pinmuxing for Panda's DPI output,=

> and the muxing has to be done in the .dts file.
>=20
> Add pinmuxing for DPI and TFP410. Without these, the DVI output on Pand=
a
> does not work with recent u-boot.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

The two latter patches in this series needs more work and can be
dropped, but this one should be applied to make Panda work properly with
new u-boots.

 Tomi

> ---
>  arch/arm/boot/dts/omap4-panda-common.dtsi | 43 +++++++++++++++++++++++=
++++++++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/=
dts/omap4-panda-common.dtsi
> index faa95b5..fcb8856 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -129,6 +129,8 @@
>  			&twl6040_pins
>  			&mcpdm_pins
>  			&mcbsp1_pins
> +			&dss_dpi_pins
> +			&tfp410_pins
>  			&dss_hdmi_pins
>  			&tpd12s015_pins
>  			&hsusbb1_pins
> @@ -166,6 +168,47 @@
>  		>;
>  	};
> =20
> +	dss_dpi_pins: pinmux_dss_dpi_pins {
> +		pinctrl-single,pins =3D <
> +			0x122 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data23 */
> +			0x124 (PIN_OUTPUT | MUX_MODE5) 	/* dispc2_data22 */
> +			0x126 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data21 */
> +			0x128 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data20 */
> +			0x12a (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data19 */
> +			0x12c (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data18 */
> +			0x12e (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data15 */
> +			0x130 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data14 */
> +			0x132 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data13 */
> +			0x134 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data12 */
> +			0x136 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data11 */
> +
> +			0x174 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data10 */
> +			0x176 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data9 */
> +			0x178 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data16 */
> +			0x17a (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data17 */
> +			0x17c (PIN_OUTPUT | MUX_MODE5)	/* dispc2_hsync */
> +			0x17e (PIN_OUTPUT | MUX_MODE5)	/* dispc2_pclk */
> +			0x180 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_vsync */
> +			0x182 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_de */
> +			0x184 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data8 */
> +			0x186 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data7 */
> +			0x188 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data6 */
> +			0x18a (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data5 */
> +			0x18c (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data4 */
> +			0x18e (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data3 */
> +
> +			0x190 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data2 */
> +			0x192 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data1 */
> +			0x194 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data0 */
> +		>;
> +	};
> +
> +	tfp410_pins: pinmux_tfp410_pins {
> +		pinctrl-single,pins =3D <
> +			0x144 (PIN_OUTPUT | MUX_MODE3)	/* gpio_0 */
> +		>;
> +	};
> +
>  	dss_hdmi_pins: pinmux_dss_hdmi_pins {
>  		pinctrl-single,pins =3D <
>  			0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
>=20



--EDsDRAx4bjShFdHUoOwk91nChTG3tQ9nj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSb4raAAoJEPo9qoy8lh715mEP/0vPez1P7RUIym0xO9RcMcHi
YWHO6cGF7VZdvLpTengRrWB6dqqf6xXrD9RKvQ4KtVrRDhBgUKHh5xg3FHNEeLut
VniQ2dI1mjwvo/TUmJxAgT5XM+9eybYLaz6Ztc84BzvXQ3l4SsqvR41bBy7NcNxl
8OElklcBsTcTcuboGSm1yKAPNy5iFIQecJGOKQhU5gAkbe7w6PGDu9aDwgn/EGmk
PsYQjsXWgcKybu0AOyU3x3tClpk5m1hXTq2FHbfVZhQtKqiAE7HLQeya62udoOEB
3G/ImTuJ27H0O/yZvVtVjNYmgJKNDoWUYZFBgVDF+M9DO9dobsu7n5sEn42YHYF6
AddlWiu2djijqEvKGrCb0h/wKl3xz8ByWwAR2D1CqCUfqZ/4WorUP7s5evQXtnph
cfUOgrAnf0XBVdDEhPPMhXaUAnvrd8vrLYFzrMW13R2vM2F3/UCYogabcsVlx9n7
bxq31ubMmvWaorcYuB5SGY9QQeX0AIIxPykRB29JzHdoftiM/QLEPvGt9HyVwxX8
3lqELmkdgNtbirghXgoddhzrjBvZF97WgM0SGAm9OyFQMTH4iOqz2EVMTdb7Fn0T
bLE1on6FxkdwOdqZI4zZzHMU5rAXM6141G/CXRM85o0vsmN2FTTtBm6gfI85uBea
+a15W+ARYruYmm266lDD
=o1Gx
-----END PGP SIGNATURE-----

--EDsDRAx4bjShFdHUoOwk91nChTG3tQ9nj--
