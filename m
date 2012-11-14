From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Revert "ARM: OMAP: convert I2C driver to PM QoS for MPU
 latency constraints"
Date: Wed, 14 Nov 2012 11:51:02 +0100
Message-ID: <20121114105102.GD5954@pengutronix.de>
References: <alpine.DEB.2.00.1211061619461.20573@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1211061619461.20573-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2012 at 04:31:32PM +0000, Paul Walmsley wrote:
>=20
> This reverts commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc.

Here giving the patch name in parens would have really made sense.
Will fix that.

> This commit causes I2C timeouts to appear on several OMAP3430/3530-based
> boards:
>=20
>   http://marc.info/?l=3Dlinux-arm-kernel&m=3D135071372426971&w=3D2
>   http://marc.info/?l=3Dlinux-arm-kernel&m=3D135067558415214&w=3D2
>   http://marc.info/?l=3Dlinux-arm-kernel&m=3D135216013608196&w=3D2
>=20
> and appears to have been sent for merging before one of its prerequisites
> was merged:
>=20
>   http://marc.info/?l=3Dlinux-arm-kernel&m=3D135219411617621&w=3D2

Hmm, any ideas how to avoid such things in the future?

> Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>

Applied to for-current, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCjd5YACgkQD27XaX1/VRtTfgCcCDYM8HlwoMKphEKKlPB3VKB7
x0gAnRay7YjlB7kdDsXFK6oSvrCb4ygZ
=ePAo
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
