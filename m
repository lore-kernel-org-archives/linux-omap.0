From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 5/7] i2c: omap: re-factor omap_i2c_init function
Date: Mon, 5 Nov 2012 09:54:48 +0200
Message-ID: <20121105075448.GF32468@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-6-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352025873-27492-6-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2012 at 04:14:31PM +0530, Shubhrajyoti D wrote:
> re-factor omap_i2c_init() so that we can re-use it for resume.
> While at it also remove the bufstate variable as we write it
> in omap_i2c_resize_fifo for every transfer.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-omap.c |   75 +++++++++++++++++++----------------=
------
>  1 files changed, 35 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 8a54efc..a87c20a 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -209,7 +209,6 @@ struct omap_i2c_dev {
>  	u16			pscstate;
>  	u16			scllstate;
>  	u16			sclhstate;
> -	u16			bufstate;
>  	u16			syscstate;
>  	u16			westate;
>  	u16			errata;
> @@ -275,9 +274,34 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_=
dev *i2c_dev, int reg)
>  				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
>  }
> =20
> +static void __omap_i2c_init(struct omap_i2c_dev *dev)
> +{
> +
> +	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +
> +	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
> +	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
> +
> +	/* SCL low and high time values */
> +	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
> +	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
> +	if (dev->rev >=3D OMAP_I2C_REV_ON_3430_3530)
> +		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
> +
> +	/* Take the I2C module out of reset: */
> +	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> +
> +	/*
> +	 * Don't write to this register if the IE state is 0 as it can
> +	 * cause deadlock.
> +	 */
> +	if (dev->iestate)
> +		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
> +}
> +
>  static int omap_i2c_init(struct omap_i2c_dev *dev)
>  {
> -	u16 psc =3D 0, scll =3D 0, sclh =3D 0, buf =3D 0;
> +	u16 psc =3D 0, scll =3D 0, sclh =3D 0;
>  	u16 fsscll =3D 0, fssclh =3D 0, hsscll =3D 0, hssclh =3D 0;
>  	unsigned long fclk_rate =3D 12000000;
>  	unsigned long timeout;
> @@ -327,11 +351,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			 * REVISIT: Some wkup sources might not be needed.
>  			 */
>  			dev->westate =3D OMAP_I2C_WE_ALL;
> -			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> -							dev->westate);
>  		}
>  	}
> -	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> =20
>  	if (dev->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
>  		/*
> @@ -416,28 +437,17 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  		sclh =3D fclk_rate / (dev->speed * 2) - 7 + psc;
>  	}
> =20
> -	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
> -	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, psc);
> -
> -	/* SCL low and high time values */
> -	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
> -	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
> -
> -	/* Take the I2C module out of reset: */
> -	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> -
> -	/* Enable interrupts */
>  	dev->iestate =3D (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>  			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
>  			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
>  				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
> -	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
> -	if (dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
> -		dev->pscstate =3D psc;
> -		dev->scllstate =3D scll;
> -		dev->sclhstate =3D sclh;
> -		dev->bufstate =3D buf;
> -	}
> +
> +	dev->pscstate =3D psc;
> +	dev->scllstate =3D scll;
> +	dev->sclhstate =3D sclh;
> +
> +	__omap_i2c_init(dev);
> +
>  	return 0;
>  }
> =20
> @@ -1297,23 +1307,8 @@ static int omap_i2c_runtime_resume(struct device *=
dev)
>  	if (!_dev->regs)
>  		return 0;
> =20
> -	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
> -		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
> -		omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG, _dev->pscstate);
> -		omap_i2c_write_reg(_dev, OMAP_I2C_SCLL_REG, _dev->scllstate);
> -		omap_i2c_write_reg(_dev, OMAP_I2C_SCLH_REG, _dev->sclhstate);
> -		omap_i2c_write_reg(_dev, OMAP_I2C_BUF_REG, _dev->bufstate);
> -		omap_i2c_write_reg(_dev, OMAP_I2C_SYSC_REG, _dev->syscstate);
> -		omap_i2c_write_reg(_dev, OMAP_I2C_WE_REG, _dev->westate);
> -		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> -	}
> -
> -	/*
> -	 * Don't write to this register if the IE state is 0 as it can
> -	 * cause deadlock.
> -	 */
> -	if (_dev->iestate)
> -		omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, _dev->iestate);
> +	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
> +		__omap_i2c_init(_dev);
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

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl3DIAAoJEIaOsuA1yqREdHgQAK71CvlrG4R3a6wTp7cgRwr5
W52+QVGSS6h5Npt9qC12hefuYcfqAl01AaNI7oPXgsMcDOe9nHnrvEHSPnNUgNxR
St6MCNVN3d/lmY8B2SvkGUoja05j+7IPLb5MhyqqcJHPBCR7VGQqPoIjDeYxu6K6
+lsF7PavgV5/ZIZjI8qCFtqqOlz5NJlDMABeS7nKIURSMvMVE0cbaSyHz5koMl/q
jr8FMlBEgwf+uu6Cw5UjriTbfxzAsoU7mx/nG9ffeaYXb3+VKBGFsVr2Khm9RYV3
dz4QSO9MXKAO7pzeji6Ud9b0BZ3faMFg4R+1voYANck3dkl+AKL4zJH9MnKhXim/
QrhyXhrGVjAbsCfqfnPDZ+zLnRObhOP7BB1KhFQ/NwnHGXZCl016Cw1Vz4RgKARj
2OImkwXKW2FAveFSMWASyOoLv5Ty1rbVPvCIARSuL32pO1vkYbDojSk8+6+nrSi9
oegvt8mMM/nDvBim2lIsCpS+mWnp4FXrrORDJ2/KGJOpBm80fbWCGMuTMH868c7s
vCbZPIc0dXmp2LdyWojzU8Dlur33EtQrR3UindMqIyTlqjRYMw/6yVWD7obMzl8z
TrbXcuJtQVabnOCqbUkKFoDZleE6OyMoFm1LZpYlvj6WW5SyeGUfvrxxGw6s4i4w
Se4ybFDNv/bWLJ+qvCdK
=vjU5
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
