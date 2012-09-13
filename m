From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Thu, 13 Sep 2012 10:52:39 +0200
Message-ID: <20120913085239.GA14237@pengutronix.de>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <20120912131615.GB16547@pengutronix.de>
 <87pq5quaqr.fsf@deeprootsystems.com>
 <87wqzysuu3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87wqzysuu3.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

> Since this series is already merged, I suggest that the problem patch be
> reverted, at least for v3.7 and until the problem is better understood
> and tested.

I thought I'll give you guys some more days to fix the problem before
reverting.

>=20
> With that patch reverted, all my PM tests are passing.  Feel free to
> add:
>=20
> Tested-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>

Thanks. That indeed increases confidence in this series. I won't add the
tags to the tree, though, since that would mean rebasing.

All the best,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBRntcACgkQD27XaX1/VRvMwQCdEDlqABs/+Bulp91wrQxMinh/
CA0Anj0WpbScemghXiNK9XpGVU+iH11p
=B7pC
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
