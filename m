From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] omap-i2c: fix incorrect log message when using a
 device tree
Date: Wed, 12 Sep 2012 15:55:26 +0200
Message-ID: <20120912135526.GF16547@pengutronix.de>
References: <1346410975-29930-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1346410975-29930-1-git-send-email-florian.vaussard-p8DiymsW2f8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Philippe =?iso-8859-15?Q?R=E9tornaz?= <philippe.retornaz-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2012 at 01:02:55PM +0200, Florian Vaussard wrote:
> When booting using a device tree, the adapter number is dynamically
> assigned after the log message is sent.
> This patch modifies the log message to get a correct adapter id.
>=20
> Applies on 3.6-rc3. Tested on OMAP3 (Gumstix Overo).
>=20
> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>

Pushed to -next, thanks.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBQlE4ACgkQD27XaX1/VRsX4wCgj+sko33SgTtIbfsdFURSXFyj
8isAnjFgwfVyA266lBTPygRrYNl0v185
=qKkh
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
