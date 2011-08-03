From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: OMAP: remove dev->idle, use usage counting
 provided by runtime PM
Date: Thu, 4 Aug 2011 01:36:05 +0300
Message-ID: <20110803223604.GB4036@legolas.emea.dhcp.ti.com>
References: <1312394960-21689-1-git-send-email-khilman@ti.com>
 <1312394960-21689-3-git-send-email-khilman@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1312394960-21689-3-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 03, 2011 at 11:09:20AM -0700, Kevin Hilman wrote:
> Current usage of runtime PM is not quite correct.  The actual
> idle/unidle of the I2C hardware should not happen until the runtime PM
> callbacks are called.  Therefore, change omap_i2c_[un]idle() functions
> to only be called from the runtime PM callbacks (when usage count
> transitions to/from zero.)
>=20
> Also, the runtime PM core does usage counting and replaces
> functionality currently managed by the dev->idle flag.  Remove usage
> of dev->idle in favor of using runtime PM, and checking status using
> pm_runtime_suspended().
>=20
> Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   58 ++++++++++++++++++++++++++---------=
-----
>  1 files changed, 38 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 12d0cbc..1b5325b 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -194,7 +194,6 @@ struct omap_i2c_dev {
>  						 */
>  	u8			rev;
>  	unsigned		b_hw:1;		/* bad h/w fixes */
> -	unsigned		idle:1;
>  	u16			iestate;	/* Saved interrupt register */
>  	u16			pscstate;
>  	u16			scllstate;
> @@ -269,12 +268,8 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
>  {
>  	struct omap_i2c_bus_platform_data *pdata;
> =20
> -	WARN_ON(!dev->idle);
> -
>  	pdata =3D dev->dev->platform_data;
> =20
> -	pm_runtime_get_sync(dev->dev);
> -
>  	if (pdata->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
>  		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
> @@ -285,7 +280,6 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
>  		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
>  		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>  	}
> -	dev->idle =3D 0;
> =20
>  	/*
>  	 * Don't write to this register if the IE state is 0 as it can
> @@ -300,8 +294,6 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
>  	struct omap_i2c_bus_platform_data *pdata;
>  	u16 iv;
> =20
> -	WARN_ON(dev->idle);
> -
>  	pdata =3D dev->dev->platform_data;
> =20
>  	dev->iestate =3D omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> @@ -315,12 +307,9 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
>  	} else {
>  		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
> =20
> -		/* Flush posted write before the dev->idle store occurs */
> +		/* Flush posted write */
>  		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
>  	}
> -	dev->idle =3D 1;
> -
> -	pm_runtime_put_sync(dev->dev);
>  }
> =20
>  static int omap_i2c_init(struct omap_i2c_dev *dev)
> @@ -644,7 +633,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_ms=
g msgs[], int num)
>  	int i;
>  	int r;
> =20
> -	omap_i2c_unidle(dev);
> +	pm_runtime_get_sync(dev->dev);
> =20
>  	r =3D omap_i2c_wait_for_bb(dev);
>  	if (r < 0)
> @@ -667,7 +656,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_ms=
g msgs[], int num)
> =20
>  	omap_i2c_wait_for_bb(dev);
>  out:
> -	omap_i2c_idle(dev);
> +	pm_runtime_put_sync(dev->dev);

I wonder if these pm_runtime_put need to be synchronous ? Could we just
call pm_runtime_put() instead ? Ditto to all other.

> @@ -1140,6 +1128,36 @@ omap_i2c_remove(struct platform_device *pdev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM_RUNTIME
> +static int omap_i2c_runtime_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev);

what happened to dev_get_drvdata(dev) ??

> +	omap_i2c_idle(_dev);
> +
> +	return 0;
> +}
> +
> +static int omap_i2c_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev);

ditto

> +	omap_i2c_unidle(_dev);
> +
> +	return 0;
> +}
> +
> +static struct dev_pm_ops omap_i2c_pm_ops =3D {
> +	.runtime_suspend =3D omap_i2c_runtime_suspend,
> +	.runtime_resume =3D omap_i2c_runtime_resume,
> +};
> +#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
> +#else
> +#define OMAP_I2C_PM_OPS NULL
> +#endif

OMAP_I2C_PM_OPS isn't used anywhere ??

--=20
balbi

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOOc1UAAoJEAv8Txj19kN17GYIAKboc0+3utgJvfuOJPuBSvhe
wsl+j+F+RvaThhdaa5BToQd/vlkmWpeBZnGRnWOffcdyoD1I+iTXlTTMtWP1e9M7
ffdw8ql2o7YwP8iZ60ueqyzCfgpHLT+luaz13yj6SVb6qpbRzS8rVBrl1+wwXhbF
C1DA6O733cjYeGtWwQ/0v77JQYpBj8oMFsScXkneaAsGR0ATv6TrMNJLBoJPm56Q
IKGnBrnZFmBq1XhXtdzxcsn4JGofabkQXjSAxHCJnIFGq3VZFtWGYNGMBq6u8Fkp
MiYvO9i2E+7hykomsPR4sgPYjlJlkX2Xm6yDqSUAuMLgcjGUAItmTi2RgMVS5Ks=
=0EDy
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
