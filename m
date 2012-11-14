From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv3 0/7] i2c: omap: updates
Date: Wed, 14 Nov 2012 13:04:00 +0100
Message-ID: <20121114120400.GH5954@pengutronix.de>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352118223-3796-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2012 at 05:53:35PM +0530, Shubhrajyoti D wrote:

> Shubhrajyoti D (8):
>       i2c: omap: Fix the revision register read
>       i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
>       i2c: omap: remove the dtrev
>       ARM: i2c: omap: Remove the i207 errata flag
>       i2c: omap: re-factor omap_i2c_init function
>       i2c: omap: make reset a seperate function
>       i2c: omap: Restore i2c context always
>       i2c: omap: cleanup the sysc write

Pushed the series to for-next, after fixing a trivial merge conflict
caused by reverting the QoS patch.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCjiLAACgkQD27XaX1/VRvj3gCbBIwgj4s0oWuHPpNHlGktwuks
QbgAmwQ/GEnt/U/H1v6WWMGJ6yEIy+PR
=KyJr
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--
