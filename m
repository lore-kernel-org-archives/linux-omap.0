From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] arm/dts: am335x-evmsk enable display and lcd panel
 support
Date: Fri, 9 May 2014 21:29:18 +0200
Message-ID: <20140509192918.GA18138@katana>
References: <1399661354-10022-1-git-send-email-detheridge@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51995 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757323AbaEIT3Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 15:29:25 -0400
Content-Disposition: inline
In-Reply-To: <1399661354-10022-1-git-send-email-detheridge@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Darren Etheridge <detheridge@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, Wolfram Sang <wsa@sang-engineering.com>, linux-arm-kernel@lists.infradead.org, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2014 at 01:49:14PM -0500, Darren Etheridge wrote:
> Add the necessary nodes to enable the LCD controller and the
> LCD panel that is attached to the Texas Instruments AM335x
> EVMSK platform.  Also setup the necessary pin mux within the
> DT file to drive the LCD connector and add the correct
> pinmux settings for the lcd pins to be configured to when
> the SoC goes into sleep state for the minimum power
> consumption.
>=20
> For the sleep mode LCD pin settings, MUX_MODE7 is chosen as
> this corresponds to switching the pins into input GPIO's with
> an internal pulldown.  Which has been determined to offer the
> lowest power solution vs leaving the pins configured in LCD
> mode.
>=20
> Signed-off-by: Darren Etheridge <detheridge@ti.com>

In general:

Acked-by: Wolfram Sang <wsa@sang-engineering.com>

> +	lcd_pins_sleep: lcd_pins_sleep {
> +		pinctrl-single,pins =3D <
> +			0x20 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad8.lcd_data23 */
> +			0x24 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad9.lcd_data22 */
> +			0x28 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad10.lcd_data21 */
> +			0x2c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad11.lcd_data20 */
> +			0x30 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad12.lcd_data19 */
> +			0x34 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad13.lcd_data18 */
> +			0x38 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad14.lcd_data17 */
> +			0x3c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad15.lcd_data16 */
> +			0xa0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data0.lcd_data0 */
> +			0xa4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data1.lcd_data1 */
> +			0xa8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data2.lcd_data2 */
> +			0xac (PULL_DISABLE | MUX_MODE7)	/* lcd_data3.lcd_data3 */
> +			0xb0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data4.lcd_data4 */
> +			0xb4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data5.lcd_data5 */
> +			0xb8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data6.lcd_data6 */
> +			0xbc (PULL_DISABLE | MUX_MODE7)	/* lcd_data7.lcd_data7 */
> +			0xc0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data8.lcd_data8 */
> +			0xc4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data9.lcd_data9 */
> +			0xc8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data10.lcd_data10 */
> +			0xcc (PULL_DISABLE | MUX_MODE7)	/* lcd_data11.lcd_data11 */
> +			0xd0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data12.lcd_data12 */
> +			0xd4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data13.lcd_data13 */
> +			0xd8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data14.lcd_data14 */
> +			0xdc (PULL_DISABLE | MUX_MODE7)	/* lcd_data15.lcd_data15 */
> +			0xe0 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.lcd_vsync */
> +			0xe4 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.lcd_hsync */
> +			0xe8 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.lcd_pclk */
> +			0xec (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.lcd_ac_bias_e=
n */

Maybe a comment why LCD0-15 are handled differently?


--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTbSyNAAoJEBQN5MwUoCm2mEkQAISZ/Mh+puZM7ejzvb16VNzC
HYUUlNei/dKpf5b4ZaROfYYYCUzuOzlHZHjkNTCKO44VrLsix30YlGcvXiHTgmGN
Fm86gSAfO7R0a6PV19ULU5II4LMvaa5afki+ob/EcUL+cMtzyoSnks+Pyb3xMNiu
k12sMChZQBWoUlbBE8ZgmIowEUTityuG0LTEbGFXM5uWXXq9yOR3Bw8mFHFD6zt+
hOO6i0ZGFHLfUEySc/tE3cNZnC3vOoyDJrKnd0YruisMSATkaroerPuz8j5zAHgH
Tx7IRlMsYMPZxNdxICOApPzNCMkp5H58xNH9GIsgvzsZNArH9pY5GV4s6HaEitJT
ezK8lVx94+xzo6Ws4qlg64zKEmmsIABDKuNQEOrsKD4RJhUNILK4q4EB12TwA/gd
KH2m2VULYwba/se9n/o/e2tzKTrrYJ19Xl4W++hYc6t2aisfMSYaEi/vOG6SLKxF
pYu1RseT1WAPvgPyELZL3EjMR4ikjVaHNbPd+rkw0513+hOkiHqQXMtEPHudFZbW
b8VGFHQv1qk3RLSqDQxEidJd4w142PxX2SBd/4+7cHYhtdfcxAZjZt7y3Xlox0iG
bkCd1BZeFFkx5Utq9oYbgkv2DnaT9ivZeARlEKSH8Og2wGbZAbV4Rll2oRzkfe6w
nJtlACQvJPEDLLRDCdXB
=/bCK
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
