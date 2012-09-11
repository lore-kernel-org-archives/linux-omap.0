From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv7 18/23] i2c: omap: remove redundant status read
Date: Tue, 11 Sep 2012 23:54:41 +0200
Message-ID: <20120911215441.GC27031@pengutronix.de>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <1347356538-23835-19-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1347356538-23835-19-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2012 at 03:12:13PM +0530, Shubhrajyoti D wrote:
> Remove the redundant read of the status register.

Commit message is just repeating the subject.
Why was the read there and why can it be removed now?

>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 5d4bad4..498a462 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -946,7 +946,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  				num_bytes =3D dev->buf_len;
> =20
>  			ret =3D omap_i2c_transmit_data(dev, num_bytes, true);
> -			stat =3D omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
>  			if (ret < 0)
>  				goto out;
> =20
> @@ -962,7 +961,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  				num_bytes =3D dev->threshold;
> =20
>  			ret =3D omap_i2c_transmit_data(dev, num_bytes, false);
> -			stat =3D omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
>  			if (ret < 0)
>  				goto out;
> =20
> --=20
> 1.7.5.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBPsyEACgkQD27XaX1/VRvFPACeOZIDh6BMfr9juLYabBBQOvSP
UhMAoJXHqAOFcbDg0iZRvtXoK0/7zcKA
=UXTN
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
