From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Wed, 12 Sep 2012 15:16:15 +0200
Message-ID: <20120912131615.GB16547@pengutronix.de>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1347447496-16793-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2012 at 04:27:54PM +0530, Shubhrajyoti D wrote:
> Changes since v1:
>        - removed tabification on patch 6/17
>        - removed dev_err() which was introduced on patch 09/17
> Changes since v2:
>         - do not set full fifo depth in the RDR interrupt.
>         - some changelog updates.
>         - rebase to the Wolfram's tree.
> Changes since v3:
>         - Remove a redundant read of status register
>         - Read the dev->buf_len variable instead of the register
>         as the information of the remaining bytes is there.
> Changes since v4:
>         - Ack the arbitration lost.
>         - Rebase to the i2c-embedded/for-next branch.
> Changes since v5:
>         - Rebase to latest mainline
>         - Added some more cleanup patches so as have a consolidated serie=
s.
> Changes since v6:
>         - Fix comments on setting the pdev to NULL.
>         - Trivial changelog update
> Changes since v7:
> 	- Remove a patch as the code is getting changed anyways
> 	- Changelogs update.
>=20
> Previous discussions can be found here=20
> http://www.spinics.net/lists/linux-i2c/msg09764.html
>=20
> This is the cleanup only series.
>  =20
> Tested on omap4sdp and 3430sdp.
>=20
> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd082=
17:
>=20
>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
>=20
> are available in the git repository at:
>   git://gitorious.org/linus-tree/linus-tree.git for_3.7/i2c/big_cleanups

Pushed to -next. Thanks to all involved!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBQix8ACgkQD27XaX1/VRugFACghynJfjUG3ERq7t0HUyUjZEOz
QSMAmgPJ2TC2IhdTvWjZVdr0TTemTW0J
=OEKu
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
