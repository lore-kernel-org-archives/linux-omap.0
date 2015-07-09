From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: omap: switch to dev_get_drvdata()
Date: Thu, 9 Jul 2015 21:46:17 +0200
Message-ID: <20150709194616.GG4744@katana>
References: <1435260890-32335-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GUPx2O/K0ibUojHx"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435260890-32335-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--GUPx2O/K0ibUojHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2015 at 02:34:48PM -0500, Felipe Balbi wrote:
> there's no need to fetch the platform_device
> in order to dereference it back to the dev
> pointer to access drvdata, we can use
> dev_get_drvdata() instead.
>=20
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Applied to for-next, thanks!


--GUPx2O/K0ibUojHx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVns+IAAoJEBQN5MwUoCm2nhkP/2sGj6JkWCzorUKT9H6R2p9F
WkkVrvYfEq1IHUN8bhddX243Ra1ZX0ZO7FRUIJMvYrK7u3egzHTwvie46DZ5TAjH
7sAoHD0/91cKDrq1TkV76WNwqUyMz3fko3JqSFkvVi73xg27qlmh2NGp2jZGzKiT
afjCVxkYSF6takItIyFqrCwxzMGISkbAOrZmR//IVe1HTrP7Jj3MMqVVJ2zFzdQW
s0gyd5IoC423GxpS5vG1UpxQX8HJGEMNSkVwtaijHZoIXixaIYDwdoZ6aYLagvyx
blUl7X9ziVeewrR3PWfpEFM7BXh/0Dk63UfUY6Kk1zclNdutfz0yg3HfKMmhkT7w
b2+uHPeDERD9aIqHU4iveCrj/Ze/aVEckNPWmpc5UnQVWulg3hbi5rDFI6AEmqx3
LdBBKJMauahk7V5kD0tN3+Bp3tg6AsPYMmmTIIPWEmL4OivVa2GjDMs7zxhCdkNo
wRPiV3mMQbKMxj3u1uDjmqa+DvJZLkSY6YmdroQhNp5LIL49BbZk1q0QViu9+eGN
vgV5m5iuQ5z5zmCC3vQ7NPE+zns5gLqR67uxT2ijO+hOWU8el3DPsDLQPQ1HFB9Y
K2uVrp3aPqzis7APwonKziQEeOLnaGP0Z1hdMC/8oh9KEo4iHFLIWFTyvuUNMxCq
zk7j2vSlc+uT5947xhCW
=/wf2
-----END PGP SIGNATURE-----

--GUPx2O/K0ibUojHx--
