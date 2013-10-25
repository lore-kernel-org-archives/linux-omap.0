From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
Date: Fri, 25 Oct 2013 14:46:01 +0300
Message-ID: <526A59F9.3010104@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com> <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com> <526A4585.30403@ti.com> <526A4708.7010309@ti.com> <526A4DEA.3050505@ti.com> <526A528C.2020204@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="S9V9ibJW4FHPUHh46Qt4dWkiTfJLESJnh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55204 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab3JYLq0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 07:46:26 -0400
In-Reply-To: <526A528C.2020204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-arm-kernel@lists.infradead.org

--S9V9ibJW4FHPUHh46Qt4dWkiTfJLESJnh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/10/13 14:14, Nishanth Menon wrote:

> lcd2_pins: pinmux_lcd2_pins {
> +		pinctrl-single,pins =3D <
> +			0x20 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_40 */
> +			0x46 (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpio_59 */
> +			0x56 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_104 */
> +		>;
>=20
> 3 pins are driven around 300uA at boot, even with display OFF -> which
> means wasted current that could have been optimized by hooking the pin
> to the dts node corresponding to the device and used by the driver
> appropriately.

One more clarification question.

The gpio 40 is used to enable powers for the picodlp. Shouldn't that one
have a pinctrl pull-down in any case? If it's left floating, and the
driver is not compiled in or doesn't start, the powers could get enabled
depending on sunspot, right?

And I guess the same goes for all gpios used to enable something.

 Tomi



--S9V9ibJW4FHPUHh46Qt4dWkiTfJLESJnh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSaln5AAoJEPo9qoy8lh71SLAP/iUefJYaRA2pieqbplKniwx9
gqW+YHdfeyKiFp2s/OTMKJBBxULnSp7VguHtYAqzCfKwtuA79nX6eGj7QYRfEJLM
9LF4KOQWbk2LP4Ye6iTFiFcHeZMHNQhZZS2do1NhyIvzbO5+YktouMgPT+WOBLSa
9KVcB9ipYhTiNos+cI2yDEsgCN3KULz7J3Myv83OyNPBYKsSpcDHdT8i7IBL3Pjb
cFAQwf3ChB7dZak4UlUdDqOc8Lw1YlfRNQEgi0rcFKssdOgsYl0exhlACiUbXox1
ok//rTttoSAb7VloRhvfouXi/IMqLkqyDiZcye6zNK9CcFc/8t2CDXhRHYTDCLAG
PvaYHo/LwMrkYARWADxNdx7bqpob3zwMWvvHwGaP3NuKESUjV38hbXS4GRpi1SGp
6IizBhEh2rFTYvmoOHusLlqDq8wOo/kKytcO86Iz95D+zrANHS9cm/6tCaVxwl30
tovS+l41+8+hGCXT0szKti/4N8RhfwJn5Gj3fodb+mwv+mOe0NjMH87zAssk/rcE
IotijYrV7PLuAn9EZ2sYLrXWl86cB9xP1JWwPzDtGn/rcSfhZK2ato+7XNzch6VZ
sAUJdXynoZqXeVx2z1shdOU3bc4mGPw4VKP2dD5SzOMbh2NlDh825rdzziTcknrp
RdlN1ctIPjjkZI0y6RJM
=H4pj
-----END PGP SIGNATURE-----

--S9V9ibJW4FHPUHh46Qt4dWkiTfJLESJnh--
