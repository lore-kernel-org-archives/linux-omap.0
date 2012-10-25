From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] i2c: omap: re-factor omap_i2c_init function
Date: Thu, 25 Oct 2012 09:36:08 +0300
Message-ID: <20121025063608.GA5084@arwen.pp.htv.fi>
References: <1351147011-6500-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60699 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab2JYGmO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 02:42:14 -0400
Content-Disposition: inline
In-Reply-To: <1351147011-6500-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 12:06:51PM +0530, Shubhrajyoti D wrote:
> re-factor omap_i2c_init() so that we can re-use it for resume.
> While at it also remove the bufstate variable as we write it
> in omap_i2c_resize_fifo for every transfer.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> v2 - add the iestate 0 check back.
>    - Remove a stray change.
> - Applies on top of Felipe's patches.
> http://www.spinics.net/lists/linux-omap/msg79995.html
>=20
>=20
> Tested with Terro sys fix + Felipe's stop sched_clock() during suspend
> on omap3636 beagle both idle and suspend.
>=20
> Functional testing on omap4sdp.
>=20
>  drivers/i2c/busses/i2c-omap.c |   71 ++++++++++++++++++-----------------=
-----
>  1 files changed, 32 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 5e5cefb..3d400b1 100644
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
> @@ -285,9 +284,31 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_=
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

a few blank lines in this function wouldn't hurt and they would help
with readability.

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
> @@ -337,11 +358,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			 * REVISIT: Some wkup sources might not be needed.
>  			 */
>  			dev->westate =3D OMAP_I2C_WE_ALL;
> -			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> -							dev->westate);

remove the comment too since now that's done by some other function ?

>  		}
>  	}
> -	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> =20
>  	if (dev->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
>  		/*
> @@ -426,28 +444,18 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
> @@ -1268,23 +1276,8 @@ static int omap_i2c_runtime_resume(struct device *=
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

you continue to miss the changes in omap_i2c_xfer_msg() and your
explanation of why not doing it wasn't good enough IMHO.

--=20
balbi

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiN3YAAoJEIaOsuA1yqRE7EkP/1wYFZn+ISmiSeUXD5KHfwhQ
q4xpyedV4SIQrouLB/UGAZ/v9gYllEP7cKap6EGh10BG2gufrmilsBrJVZInrq2+
quEpP28/v7G0KuqjQpUduWBBQ8mddZxlK8RYdkszpT0WmRGd1vWjvZkpPD6EYdT6
pqOLwAM+SvivzJJGHwDs9e03iY2QYoYDjTuBMoDqDmxJr8Ydn3fcoOhAnriEpyON
+IkoL1VsU92zX4KfV7htCIGTQyQzcBmOgeJtUlAl3FyLiQhYrpczBR67iD+R7PoG
6EBCLrdAqPG6cnaAEtwy1X7wIdN5emqmnd9aIiTs95ChPIJaL1o5MHp+2cLOh4lU
Ne4IJb+zCQEecQV0u76pUExV0CN/7K07WRSxZjyWxYJ/YO3ZYYC9/yjLPvYn0sxJ
HwuIKah+HB0oN51wH9Lqqvlpx1mvXZ1X05QfOuvvWv9HzPFuuYWr962/gD856cNq
d+oEBISbqmsqQEoQ32M7gSSwyt6RN3f72V9gKZQPq/M3i8WDykQlvMnqPazQPfab
lN2dbBAkGubqUK9RhEgfejDXFVZk8DVUM0uljXy2oSESI4rjCC/1jf/ioEvAWzWB
jyGqNkyC6vEezrekDwF2txs/Jp/8ZnDl23G8ldkP7SpdEiDWOExQkXn/bpkncBqB
C51npbn1VXdWh3phCKRw
=Ylf1
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
