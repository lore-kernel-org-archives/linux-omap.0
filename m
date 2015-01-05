From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v8 4/8] can: c_can: Add syscon/regmap RAMINIT mechanism
Date: Mon, 5 Jan 2015 11:18:25 +0200
Message-ID: <54AA56E1.7030105@ti.com>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de> <1415988591-6032-5-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="1LM3iGQDECm3sRp7DMwwRArur2NrDv65L"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50461 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526AbbAEJSm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Jan 2015 04:18:42 -0500
In-Reply-To: <1415988591-6032-5-git-send-email-mkl@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, rogerq@ti.com
Cc: linux-can@vger.kernel.org, wsa@the-dreams.de, linux-omap@vger.kernel.org, kernel@pengutronix.de

--1LM3iGQDECm3sRp7DMwwRArur2NrDv65L
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Roger,

On 14/11/14 20:09, Marc Kleine-Budde wrote:
> From: Roger Quadros <rogerq@ti.com>
>=20
> Some TI SoCs like DRA7 have a RAMINIT register specification
> different from the other AMxx SoCs and as expected by the
> existing driver.
>=20
> To add more insanity, this register is shared with other
> IPs like DSS, PCIe and PWM.
>=20
> Provides a more generic mechanism to specify the RAMINIT
> register location and START/DONE bit position and use the
> syscon/regmap framework to access the register.

This patch updates the syscon regmap using regmap_read + regmap_write.
That's not a safe way to update the bits, as some other driver may touch
the register between the read and write. The change has to be made using
regmap_update_bits.

We don't have other drivers using the register at the moment, but I
presume we will sooner or later.

 Tomi



--1LM3iGQDECm3sRp7DMwwRArur2NrDv65L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUqlbkAAoJEPo9qoy8lh71u0sP/2BmQhqbrVg3RUHcOoeyrW0p
yZIMl3pcczQmFtNbUuzmuzYqGanvACXOjH0jsiQpdJ77QrPdZq6y8jdBRPgw86Sd
arGZisIwVTT+FWv7RM3w5ZJwl1vi0HjBC1LJgPNe9Js/AGjzrFJ9OifC6HHFsiwN
JY3/6nZI3vSPG/RUtdIm+C2O4MFhNCXjRVHW2W2HIh7jCzn8BWzrxbUeTuwye5y3
TEd2YSic9aQyEZ1iz7u00FT5m94IntABNPpcJzsdGjaAicvReoMI9gAPza4uLj/A
l/Sh4uxNEkcvqQa3za9jQB/eC0pKadxV4hxZbUAAxuD+t/Q+jo/M8nssJl7p3IdN
f0kaFhOmiL+VDX16ttszN2Y5sRyiSA5WTPh2lApCWqOB2aBHUuru/srFEmKEbd6p
Z5LfLUnkON7OdFiAZwOgskTb+WC7b6Gsxrv0bJycgVg1JHhkvXz03RYIyFJjJ8O3
pAWHWpHYbFIOMB901PDDCN7+5QBwIFWxfyBmZle1bKDlypvtmfJFe33z7uyNutnY
HerCvYp1EVagUinjCvAhQalgpXVQREElSqlWo/YDrVkh15KG+EW+dwlEMrSKqtvV
9uBwceo8Tw5f6i9pim2l8Pgl6f318d/PW5OKg8+wdaE7coLMtDl+LSb3Mg2HZIEk
aXxK0n/A506fcqWAdDfJ
=1K21
-----END PGP SIGNATURE-----

--1LM3iGQDECm3sRp7DMwwRArur2NrDv65L--
