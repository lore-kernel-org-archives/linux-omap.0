From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 7/7] i2c: omap: Restore i2c context always
Date: Mon, 5 Nov 2012 09:56:27 +0200
Message-ID: <20121105075627.GH32468@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-8-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352025873-27492-8-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 04, 2012 at 04:14:33PM +0530, Shubhrajyoti D wrote:
> Currently the restore is done based on the flag
> OMAP_I2C_FLAG_RESET_REGS_POSTIDLE.
>=20
> This helps the following
> - The driver is always capable of restoring regardless
> of the off mode support being there or not.
>=20
> - While testing omap2430 it is found that in case of certain
> error paths (timeout) a reset is done. However the restore
> never happens as it is dependent on the POSTIDLE flag.
> The other option would be to call a restore in the reset
> case. As there are only a few registers to be restored
> the penalty in the idle case should not be much.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Looks ok to me, one less unnecessary flag.

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
> Todo: the flag could be deleted if the patch is accepted.
>=20
>  drivers/i2c/busses/i2c-omap.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 70d43b7..f66c5ab 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1314,8 +1314,7 @@ static int omap_i2c_runtime_resume(struct device *d=
ev)
>  	if (!_dev->regs)
>  		return 0;
> =20
> -	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
> -		__omap_i2c_init(_dev);
> +	__omap_i2c_init(_dev);
> =20
>  	return 0;
>  }
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl3ErAAoJEIaOsuA1yqREwFsP/RWBsOo/5tFM7PPRbtQatwp7
nmjskjHvU7KJwXOFwI9AY6geObQWjPJdv7YeNfJy9x1gfSoDurcVEkTRZsbyzHW5
pv0XaiQpgHkX9VDB2r4WvkU9U8cVz7J4kBYaGLlZlqGt/c9PjS8KmYcr53i4yb7R
60VTPA8VTl2a6jYEL4WCYIBU9aijRtr5VI0S93B8PnjOCOw7K1BnIzud/Fhe87UM
Q0ZP1W/Cf4qstOp4yVMsb8wQMf0+NiIT2RSqjkucnCu2jUkQkhOC3jWCdq0wkyj0
PdOUGCqHWbenZvZhOUXAoFUVoB7vwl0bfdB0Ai5ywvUC6CsvG4BJPh0kU+gImoga
6jqphx+0zC8FABI19PuhqwYxe3iUl+0PvQlRSAWDXsfyAK7KrpdUGZq6LecGpySG
SjQVheXqyok3NvTOPmMbUBBUq6g5n1vRXGuilyq1Z3qOf+pXS4qGEabXhFjr1Z+g
tZnf5DsFGHcy4xsuc5bGwJX2Mdek9dTtLQ6Q9REw41wTRU1wGnS0vUslpBT85M03
y2FQGr3Go3zep6/s2OO7DICYTv60ABxsUoK8fqtk442RzSiakkitRRt+IJiXwWmI
zVltC5MonkaYR4tYRNBN0y1x6XGONx3xOMortHt26FRK0YcWbWY7NG7F6b4Pe9Lc
kQ4fr9sZC/3BCznP0cCx
=yDvA
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
