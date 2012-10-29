From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 1/2] i2c: omap: re-factor omap_i2c_init function
Date: Mon, 29 Oct 2012 21:50:51 +0200
Message-ID: <20121029195051.GB30152@arwen.pp.htv.fi>
References: <1351176199-6479-1-git-send-email-shubhrajyoti@ti.com>
 <1351176199-6479-2-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1351176199-6479-2-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2012 at 08:13:18PM +0530, Shubhrajyoti D wrote:
> re-factor omap_i2c_init() so that we can re-use it for resume.
> While at it also remove the bufstate variable as we write it
> in omap_i2c_resize_fifo for every transfer.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

FWIW:

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

(if I have time I will test this tomorrow and reply with a Tested-by)

> ---
> v4: add spaces for readability
>=20
>  drivers/i2c/busses/i2c-omap.c |   74 +++++++++++++++++++----------------=
-----
>  1 files changed, 35 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index be329e9..38acf1a 100644
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
> @@ -285,9 +284,34 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_=
dev *i2c_dev, int reg)
>  	}
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
> @@ -337,11 +361,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
> @@ -426,28 +447,18 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
>  	/* Enable interrupts */
>  	dev->iestate =3D (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>  			OMAP_I2C_IE_NACK | OMAP_I2C_IE_AL)  |
>  			((dev->fifo_size) ? (OMAP_I2C_IE_RDR |
>  				OMAP_I2C_IE_XDR) : 0);
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
> @@ -1267,23 +1278,8 @@ static int omap_i2c_runtime_resume(struct device *=
dev)
>  {
>  	struct omap_i2c_dev *_dev =3D dev_get_drvdata(dev);
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

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjt4bAAoJEIaOsuA1yqREEbUQAIEWQnZfuXmDv0qWKznN7jUs
WTywzrzvjTPf5DhOb3nB3eiSQKP3ShO1VLmhUAkdjIqG7c0fUMP6HuPHf8rqfrfB
whQVZWNxp2p0xsU4RoTV5/H/HD3f8FbOwe+WOEH67sVYWEUf7m4PzUPXOTW8jny5
Jj00DhQqa5th5R1cmCphlrvLNGGBuM1OXiQodekhGIP8iYcGKhH244wTYWLGfuge
Di3gJ07K8mnpEoJMyYGCIA/HRl1wVsl9JtLc0X1ibO8d/NwfVE0EQ7Wd6q45u6VD
2/GboGZ4mcPn4GvTyYroneBlCHjdd33JF90blVVPHhx0tl48vvtnN6oSr5Ee57tk
pdKSTD2ONabxvi2w3+5RHs36t7voG1lS2M/NvjRXnkvpET7kx4TQw0RZf4ck3hjX
W+l+Ad/pMz0aKdaBIonyayuEkNMUwmYLXspzq5H3MaybkaEc78Psoy43vbopQq7v
SlIiOieG5fIVQeq3UsxNjTf+YJ9SYFKw2FrwgoCbystT9m1xeE7Xj0k6cWgzGTdU
B6OSsTQSPj/dQVGl1pqQjQHJnJogdfwGetrFRv+EufKA7Wb1qECQLqNlI9a3KLot
yClcxVBE9W3Hu2wEFbjmAdrAnhcKe5W3+v+FMMF59v5IzLpd46pHgqqpGJo7g5/q
xPriNJHJLWCJho5mBkmH
=KK61
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
