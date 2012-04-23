From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv8 07/10] I2C: OMAP: Handle error check for pm runtime
Date: Mon, 23 Apr 2012 18:20:08 +0200
Message-ID: <20120423162008.GB27321@pengutronix.de>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-8-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334842101-20670-8-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 06:58:18PM +0530, Shubhrajyoti D wrote:
> If PM runtime get_sync fails return with the error
> so that no further reads/writes goes through the interface.
> This will avoid possible abort. Add a error message in case
> of failure with the cause of the failure.

I don't think the error message is especially helpful. You also use differe=
nt
string (probably typo).

>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   19 ++++++++++++++++---
>  1 files changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 44e8cfa..d555dcd 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -585,7 +585,11 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_m=
sg msgs[], int num)
>  	int i;
>  	int r;
> =20
> -	pm_runtime_get_sync(dev->dev);
> +	r =3D pm_runtime_get_sync(dev->dev);
> +	if (r < 0) {
> +		dev_err(dev->dev, "pm_runtime_get_sync failed %d\n", r);
> +		return r;
> +	}
> =20
>  	r =3D omap_i2c_wait_for_bb(dev);
>  	if (r < 0)
> @@ -1011,7 +1015,11 @@ omap_i2c_probe(struct platform_device *pdev)
>  		dev->regs =3D (u8 *)reg_map_ip_v1;
> =20
>  	pm_runtime_enable(dev->dev);
> -	pm_runtime_get_sync(dev->dev);
> +	r =3D pm_runtime_get_sync(dev->dev);
> +	if (r < 0) {
> +		dev_err(dev->dev, "pm_runtime_get_sync failed:%d\n", r);
> +		return r;
> +	}

Smatch says:

drivers/i2c/busses/i2c-omap.c:1021 omap_i2c_probe() warn: 'mem->start' was =
not released on error

In fact, you are leaking quite more.

> @@ -1103,12 +1111,17 @@ omap_i2c_remove(struct platform_device *pdev)
>  {
>  	struct omap_i2c_dev	*dev =3D platform_get_drvdata(pdev);
>  	struct resource		*mem;
> +	int ret;
> =20
>  	platform_set_drvdata(pdev, NULL);
> =20
>  	free_irq(dev->irq, dev);
>  	i2c_del_adapter(&dev->adapter);
> -	pm_runtime_get_sync(&pdev->dev);
> +	ret =3D pm_runtime_get_sync(&pdev->dev);
> +	if (ret < 0) {
> +		dev_err(dev->dev, "pm_runtime_get_sync failed %d\n", ret);
> +		return ret;
> +	}

I am no too familiar with runtime_pm. Is it really so bad to fail remove, w=
hen
get_sync has an error? Why is it checked and e.g. pm_runtime_put later is n=
ot?
Any pointers?

>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> --=20
> 1.7.5.4
>=20

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+VgTgACgkQD27XaX1/VRuqVgCfcHw6CY7cJhfEdZBQ+eQUfdeS
s+0AoMJGMz20uL+itvlgFSkQ0ZXS2To3
=lRnF
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
