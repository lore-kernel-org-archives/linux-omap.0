From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: core: only use set_scl for bus recovery after
 calling prepare_recovery
Date: Fri, 31 Jul 2015 12:51:37 +0200
Message-ID: <20150731105137.GG1522@katana>
References: <1436366106-11779-1-git-send-email-jlu@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436366106-11779-1-git-send-email-jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 04:35:06PM +0200, Jan Luebbe wrote:
> Using set_scl may be ineffective before calling the driver specific
> prepare_recovery callback, which might change into a test mode. So
> instead of setting SCL in i2c_generic_scl_recovery, move it to
> i2c_generic_recovery (after the optional prepare_recovery).
>=20
> Signed-off-by: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied to for-current, thanks!


--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVu1M5AAoJEBQN5MwUoCm2RwMQAIgVj0RIZiYnMMdBSZRjqpEe
5eWjfboo1G5op8cOdpG9716Wro181eanyVd0KX8Qf+pFsF5lmi7ILBVEoDJEcjql
JgUiZd+TATLuP8zeOSs1LVyJp1QE12jtXjvIzaT6PNXycLByQczuUhykS/pfYwa/
FNddZotNdLVyoVWn/Iw8CDwwZrYwEhBgoMVbdT/+Ai5c4weaFzJu0CelKRdC6xTZ
oMKrUGpb5AYlNYN4qh0yxIVFWslhaZG/Jrk5TXnHZWbKvWCIc38tGi/RrHxNPDle
QvpXF1NzyWzm93Ia97sPLzBdynaefXpRN2CXauanaScPWnT3kBjivVW1fEy9oetY
UCAUOCL/EZG+LYI2tNFgOI8nS9GYf8hQQklFdPsivkdU7cM9HgaR2dU2w44to72n
bAzNJlKi0UOL9VCsyQvw4KVhX5oYvFVVI8wj0WFGbI0OqhZ91QyDdD+qksxbYR8j
HxkqHNfj1+xODZPX7wr8zh7PmRus7HiIAM2SSfCd0ckZPh1opjQNUJmNQ62LjnUy
GeBWO7afctL4WdcOzfHgKveEk/VPCHilic3HvcvyM33v5R4e90kBTrdSk3a+SsX9
zXj2Q4+Lfmh5I9FAzx6kIOQSHo9JmQzGagi6SEFyPHzk+FK7DAw1RGIIDx+tez5z
MgLVjBb54ZxkZjmr8ZkZ
=AVUF
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
