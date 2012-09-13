From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/4] i2c: introduce i2c-cbus driver
Date: Thu, 13 Sep 2012 12:53:09 +0200
Message-ID: <20120913105309.GF14237@pengutronix.de>
References: <1346703805-31598-1-git-send-email-aaro.koskinen@iki.fi>
 <1346703805-31598-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42404 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab2IMKxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 06:53:12 -0400
Content-Disposition: inline
In-Reply-To: <1346703805-31598-2-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2012 at 11:23:22PM +0300, Aaro Koskinen wrote:
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

My main question is: what is CBUS? It doesn't look like an I2C/SMBUS
host controller, but some bit-banging protocol? As such, it shouldn't go
to i2c/busses/. And the protocol doesn't look much like I2C, neither.
There is no ACK/NACK/START/STOP, so I wonder if it should be in i2c
after all...

Jean, maybe you want to have a glimpse on this as well?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBRuxUACgkQD27XaX1/VRuuYwCfYxpuY6TytsCY+hsOIPbu/Jp5
Z2kAoIE9EVeyC8gLZV38/galqUxZmMud
=vXgG
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
