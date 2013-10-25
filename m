From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
Date: Fri, 25 Oct 2013 14:17:14 +0300
Message-ID: <526A533A.6080903@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com> <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com> <526A4585.30403@ti.com> <526A4708.7010309@ti.com> <526A4DEA.3050505@ti.com> <526A528C.2020204@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="jKw6pxCpMlrOiJQrgkriuXJ1QW5NgAX1S"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58318 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab3JYLRp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 07:17:45 -0400
In-Reply-To: <526A528C.2020204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-arm-kernel@lists.infradead.org

--jKw6pxCpMlrOiJQrgkriuXJ1QW5NgAX1S
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/10/13 14:14, Nishanth Menon wrote:

> one additional angle before I forget - this is something we do as part
> of power optimization - to identify pins which are programmed for a
> pull in non-functional scenario as it has direct impact on idle power
> numbers.
>=20
> For example patch #3 in this series
> &omap4_pmx_core {
> pinctrl-0
> ...
> 	&lcd2_pins
> ..
> }
> &lcd2_pins
>=20
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
>=20
> Unfortunately, folks feel simplifying the driver is traditionally a
> better alternative but with a 400 odd pins on a typical SoC of today,
> these defaults add up and end user tends to suffer with bad overall
> power numbers :(..

Good point. I guess that also makes my point of having default values
for GPIOs a bit silly. Driving the GPIO high by default would be ever
worse than the mux pull-up, I believe.

 Tomi



--jKw6pxCpMlrOiJQrgkriuXJ1QW5NgAX1S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSalM6AAoJEPo9qoy8lh71JEEQAI+OORcKAXlSDkDmqMMecdLK
ATNTcm4vkB+5NeuCxXdlTkw884fCqFkrCj+Xmtwjz5BKw7/RJfDblHhaOgMEPOYH
xXSGMgasai8J7TgFeJP0NdIkjsksKn+YXMUujdGvMQUEut4Hdwk7OHTW4/Z1MSjR
tdefIN/k9Rnn8p8sgjkjgbrgUCXQhC8Kx6M3O/BeAkUKyrZfiw7YbAs8YHTuSm13
wKP/QaUZj1ryo7nWLpNcp8hLsTF+D6pWopgncYfkl49AT2yWIC6pLv74Lkh0IJY/
5nESjFIWcJUBZERH17k7fJlVS2nMm+cSsOvK80v3mQ6f9nwpITi1uKKt8MJWzgK1
nrB1HMYSGRu5Lp7GCDDIBbvF0WTBMeaz1XtvwTDDviMTBCYt1r3sHgQcweHbeDhK
5/q66u5HUbIFQ8+bbhp27t0EMG/ASU4cCHmucm8eavaqYeJi+W0D8duUFNENpI2Y
ihj5ikzHbR7X61ybbAmjmqroY0mJrIZZRNooVZDJq6aw7uthN+r0SZe+v552nBdE
Y2gARm+UhUI1njyNtUQe7JZ88bvl++IMbAe7bWaplwfIhSxs7FCxMOgrzWanXZ5u
x4NRcjwlv+Vof/1boUkul1knvpuYMI9pKIy+M21peZ3rUAWigbYN/QNr5g4+bRKo
EA/JS6xsOyDspNZmGQSI
=HIRi
-----END PGP SIGNATURE-----

--jKw6pxCpMlrOiJQrgkriuXJ1QW5NgAX1S--
