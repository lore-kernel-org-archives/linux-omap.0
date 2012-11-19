From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v4 1/4] i2c: introduce i2c-cbus-gpio driver
Date: Mon, 19 Nov 2012 09:59:29 +0100
Message-ID: <20121119085929.GC7775@pengutronix.de>
References: <1353256582-12166-1-git-send-email-aaro.koskinen@iki.fi>
 <1353256582-12166-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33769 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab2KSI7b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 03:59:31 -0500
Content-Disposition: inline
In-Reply-To: <1353256582-12166-2-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 18, 2012 at 06:36:19PM +0200, Aaro Koskinen wrote:
> Add i2c driver to enable access to devices behind CBUS on Nokia Internet
> Tablets.
>=20
> The patch also adds CBUS I2C configuration for N8x0 which is one of the
> users of this driver.
>=20
> Cc: linux-i2c@vger.kernel.org
> Acked-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to for-next, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCp9PEACgkQD27XaX1/VRvZuQCfaS7BF+xj4UUX+iguwmoqrlfJ
wxoAnj6Hy16qPNJgJUBStYk/PIDsFb62
=N8HC
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
