From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv8 10/13] I2C: OMAP: simplify num_bytes handling
Date: Mon, 18 Jun 2012 17:22:57 +0200
Message-ID: <20120618152257.GA10768@pengutronix.de>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-11-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340029828-20751-11-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2012 at 08:00:25PM +0530, Shubhrajyoti D wrote:
> From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>=20
> trivial patch, no functional changes

Wrong. This patch does change some behaviour, are you aware of that?

So, please check if the side-effect is affectong the code and adapt the
commit message, if everything is okay.

>=20
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Reviewed-by : Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index e24eb1f..080193a 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -844,8 +844,7 @@ complete:
>  							OMAP_I2C_BUFSTAT_REG)
>  							>> 8) & 0x3F;
>  			}
> -			while (num_bytes) {
> -				num_bytes--;
> +			while (num_bytes--) {
>  				w =3D omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
>  				if (dev->buf_len) {
>  					*dev->buf++ =3D w;
> @@ -887,8 +886,7 @@ complete:
>  							OMAP_I2C_BUFSTAT_REG)
>  							& 0x3F;
>  			}
> -			while (num_bytes) {
> -				num_bytes--;
> +			while (num_bytes--) {
>  				w =3D 0;
>  				if (dev->buf_len) {
>  					w =3D *dev->buf++;
> --=20
> 1.7.5.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/fR9AACgkQD27XaX1/VRtEoACgvVS2bKkB1+YMp68CnVbjXvVl
b9gAniy08g9c6JsZ2VXdDqUU6Uuz5I/+
=QqmK
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
