From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv8 13/13] I2C: OMAP: simplify omap_i2c_ack_stat()
Date: Mon, 18 Jun 2012 17:30:00 +0200
Message-ID: <20120618153000.GC10768@pengutronix.de>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-14-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340029828-20751-14-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2012 at 08:00:28PM +0530, Shubhrajyoti D wrote:
> From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>=20
> stat & BIT(1) is the same as BIT(1),

Not true. I'd guess you are missing some context in the patch
description.

> so let's
> simplify things a bit by removing "stat &" from
> all omap_i2c_ack_stat() calls.
>=20
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Reviewed-by : Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 6a79089..bac6305 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -763,7 +763,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev=
, u16 *stat, int *err)
> =20
>  	while (--timeout && !(*stat & OMAP_I2C_STAT_XUDF)) {
>  		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
> -			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
> +			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
>  							OMAP_I2C_STAT_XDR));
>  			return -ETIMEDOUT;
>  		}
> @@ -824,10 +824,11 @@ complete:
>  		 */
>  		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
>  					OMAP_I2C_STAT_AL)) {
> -			omap_i2c_ack_stat(dev, stat &
> -				(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
> -				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR |
> -				OMAP_I2C_STAT_ARDY));
> +			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
> +						OMAP_I2C_STAT_RDR |
> +						OMAP_I2C_STAT_XRDY |
> +						OMAP_I2C_STAT_XDR |
> +						OMAP_I2C_STAT_ARDY));
>  			omap_i2c_complete_cmd(dev, err);
>  			return IRQ_HANDLED;
>  		}
> @@ -874,8 +875,8 @@ complete:
>  					}
>  				}
>  			}
> -			omap_i2c_ack_stat(dev,
> -				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
> +			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
> +						OMAP_I2C_STAT_RDR));
>  			continue;
>  		}
> =20
> @@ -922,8 +923,8 @@ complete:
> =20
>  				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
>  			}
> -			omap_i2c_ack_stat(dev,
> -				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> +			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
> +						OMAP_I2C_STAT_XDR));
>  			continue;
>  		}
> =20
> --=20
> 1.7.5.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/fSXgACgkQD27XaX1/VRv3jwCfdJj7OpiPoJAKbZo/gLSVjRj2
qjEAn19jCswalChPXZGF0kP4BNC7OWmg
=8li4
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
