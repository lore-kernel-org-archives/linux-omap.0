From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] i2c: omap: re-factor omap_i2c_init function
Date: Tue, 23 Oct 2012 20:18:40 +0300
Message-ID: <20121023171840.GA32167@arwen.pp.htv.fi>
References: <1351006039-24332-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34141 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250Ab2JWRYq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 13:24:46 -0400
Content-Disposition: inline
In-Reply-To: <1351006039-24332-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 23, 2012 at 08:57:19PM +0530, Shubhrajyoti D wrote:
> re-factor omap_i2c_init() so that we can re-use it for resume.
> While at it also remove the bufstate variable as we write it
> in omap_i2c_resize_fifo for every transfer.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> Applies on Felipe's series
> http://www.spinics.net/lists/linux-omap/msg79995.html
>=20
> Tested with Terro sys fix + Felipe's stop sched_clock() during suspend
> on omap3636 beagle both idle and suspend.
>=20
> Functional testing on omap4sdp.
>=20
>  drivers/i2c/busses/i2c-omap.c |   68 +++++++++++++++++------------------=
------
>  1 files changed, 28 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 5e5cefb..338cee7 100644
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
> @@ -285,9 +284,26 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_=
dev *i2c_dev, int reg)
>  	}
>  }
> =20
> +static void __omap_i2c_init(struct omap_i2c_dev *dev)
> +{
> +
> +	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
> +	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
> +
> +	/* SCL low and high time values */
> +	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
> +	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
> +	if (dev->rev >=3D OMAP_I2C_REV_ON_3430_3530)
> +		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
> +	/* Take the I2C module out of reset: */
> +	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> +	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
> +
> +}
>  static int omap_i2c_init(struct omap_i2c_dev *dev)
>  {
> -	u16 psc =3D 0, scll =3D 0, sclh =3D 0, buf =3D 0;
> +	u16 psc =3D 0, scll =3D 0, sclh =3D 0;
>  	u16 fsscll =3D 0, fssclh =3D 0, hsscll =3D 0, hssclh =3D 0;
>  	unsigned long fclk_rate =3D 12000000;
>  	unsigned long timeout;
> @@ -337,11 +353,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
> @@ -426,28 +439,18 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
> @@ -1136,7 +1139,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  	if (IS_ERR_VALUE(r))
>  		goto err_free_mem;
> =20
> -	dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> +	dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG)  & 0xff;

trailing change. not part of $SUBJECT

>  	dev->errata =3D 0;
> =20
> @@ -1268,23 +1271,8 @@ static int omap_i2c_runtime_resume(struct device *=
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

this part is not on __omap_i2c_init() so you're potentially causing a
regression here.

> +	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
> +		__omap_i2c_init(_dev);

how has this been tested ? Did you validate suspend to ram and runtime
pm ?

>  	return 0;
>  }
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhtFvAAoJEIaOsuA1yqREGBEQAIPObh1wwRbry8zSx5UDC4Ij
pAOmGktHVfb0G2C92ZAQh02azfEldTXCKhTrmmVgka3pblpwR08GgWqVu+/vLHy5
b5g5HsOqDIwsnjzhXXkM1haBRd5x0+MNE2AhIYz4NRA5ad0KQjflR05M5a87JFw8
uD7VQ5dDJbJfvshpOSjWnI2xgI4wQi2SrdlwZDkVedBLL3QRDZrrmQvFMSokllvL
plAwL3zL+p5RDCTqMYglPdXB5gNYFh3VJddSIS9WoMT+xdQzmfBLvXfERR4ZVgKg
wMAWJ3/IpqMKMhbyHOOvZNQFVTO61At22Pq2odszqixKmr1BCKFj19AHw1bhaskH
9E1BkTuNSuK+Xn0kZGVqtSXePxffcW5d9kBpe6kX8yt1t3zVWsJC3WKcl4+mtDMZ
ZhBp2lVBgZ/+RAIi5Cci13cniSJZArhkbP2zhdyxQzSF54WOpHCQoMx7vuqY9nkR
BXc8dMaAXGEJrIL+xEXkXnUEbdHtvxjb8gHgISxlD6dz+dip7I0dvHFIBCVhq1+v
H8sN+hs/qfPiJIuMTD30RO0iBrmGZsIXWHsrnoGGo9O2YNi2aN1dryYlXlI2gqIM
sgve8A1zlJu5NozaGvUCDIrzFIiyniDXu5Pc2lmGXfR+r12uRd+K4jReyPEKHhoD
TlyWvDML2BTHbxboapVn
=qyO7
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
