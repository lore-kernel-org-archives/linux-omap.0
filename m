From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv8 11/13] I2C: OMAP: decrease indentation level on data
 handling
Date: Mon, 18 Jun 2012 17:25:30 +0200
Message-ID: <20120618152530.GB10768@pengutronix.de>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-12-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33350 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab2FRPZd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 11:25:33 -0400
Content-Disposition: inline
In-Reply-To: <1340029828-20751-12-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Felipe Balbi <balbi@ti.com>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2012 at 08:00:26PM +0530, Shubhrajyoti D wrote:
> From: Felipe Balbi <balbi@ti.com>
>=20
> trivial patch, no functional changes.

This patch seems to be correct, but it is not trivial. In fact, it is
pretty easy to miss a "!" here which can cause subtle bugs.

>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Reviewed-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   63 ++++++++++++++++++++---------------=
------
>  1 files changed, 31 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 080193a..0e0ab8f 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -845,22 +845,7 @@ complete:
>  							>> 8) & 0x3F;
>  			}
>  			while (num_bytes--) {
> -				w =3D omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
> -				if (dev->buf_len) {
> -					*dev->buf++ =3D w;
> -					dev->buf_len--;
> -					/*
> -					 * Data reg in 2430, omap3 and
> -					 * omap4 is 8 bit wide
> -					 */
> -					if (dev->flags &
> -						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
> -						if (dev->buf_len) {
> -							*dev->buf++ =3D w >> 8;
> -							dev->buf_len--;
> -						}
> -					}
> -				} else {
> +				if (!dev->buf_len) {
>  					if (stat & OMAP_I2C_STAT_RRDY)
>  						dev_err(dev->dev,
>  							"RRDY IRQ while no data"
> @@ -871,6 +856,21 @@ complete:
>  								" requested\n");
>  					break;
>  				}
> +
> +				w =3D omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
> +				*dev->buf++ =3D w;
> +				dev->buf_len--;
> +				/*
> +				 * Data reg in 2430, omap3 and
> +				 * omap4 is 8 bit wide
> +				 */
> +				if (dev->flags &
> +						OMAP_I2C_FLAG_16BIT_DATA_REG) {
> +					if (dev->buf_len) {
> +						*dev->buf++ =3D w >> 8;
> +						dev->buf_len--;
> +					}
> +				}
>  			}
>  			omap_i2c_ack_stat(dev,
>  				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
> @@ -887,22 +887,7 @@ complete:
>  							& 0x3F;
>  			}
>  			while (num_bytes--) {
> -				w =3D 0;
> -				if (dev->buf_len) {
> -					w =3D *dev->buf++;
> -					dev->buf_len--;
> -					/*
> -					 * Data reg in 2430, omap3 and
> -					 * omap4 is 8 bit wide
> -					 */
> -					if (dev->flags &
> -						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
> -						if (dev->buf_len) {
> -							w |=3D *dev->buf++ << 8;
> -							dev->buf_len--;
> -						}
> -					}
> -				} else {
> +				if (!dev->buf_len) {
>  					if (stat & OMAP_I2C_STAT_XRDY)
>  						dev_err(dev->dev,
>  							"XRDY IRQ while no "
> @@ -914,6 +899,20 @@ complete:
>  					break;
>  				}
> =20
> +				w =3D *dev->buf++;
> +				dev->buf_len--;
> +				/*
> +				 * Data reg in 2430, omap3 and
> +				 * omap4 is 8 bit wide
> +				 */
> +				if (dev->flags &
> +						OMAP_I2C_FLAG_16BIT_DATA_REG) {
> +					if (dev->buf_len) {
> +						w |=3D *dev->buf++ << 8;
> +						dev->buf_len--;
> +					}
> +				}
> +
>  				if ((dev->errata & I2C_OMAP_ERRATA_I462) &&
>  				    errata_omap3_i462(dev, &stat, &err))
>  					goto complete;
> --=20
> 1.7.5.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/fSGoACgkQD27XaX1/VRuF3ACgvXuqiJwt1X6a1QYVdngK5tiJ
3nsAni1VOev5YVZIIB8tNItDlx4UA9JH
=JfYd
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
