From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to
 configure pendown_gpio
Date: Thu, 3 Feb 2011 18:05:07 +0100
Message-ID: <20110203170507.GG6508@pengutronix.de>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: LW@karo-electronics.de, Dmitry Torokhov <dtor@mail.ru>, balbi@ti.com, charu@ti.com, grinberg@compulab.co.il, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com
List-Id: linux-omap@vger.kernel.org


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
> The ads7846 driver requests a gpio but does not currently
> configure it explicitly as an input. Use gpio_request_one
> to request and configure it at one shot.
>=20
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>

Since the two are won't be merged

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1K4EMACgkQD27XaX1/VRvL2ACgyaw9m7zC0HDAzxdyzdtVMErH
MgIAn3ut6eBPvzyMTAjzs9gtPlkSWaED
=LAs2
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--
