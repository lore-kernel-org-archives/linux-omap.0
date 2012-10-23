From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: re-factor omap_i2c_init function
Date: Tue, 23 Oct 2012 22:11:24 +0300
Message-ID: <20121023191124.GB853@arwen.pp.htv.fi>
References: <1351006039-24332-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1351006039-24332-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 23, 2012 at 08:57:19PM +0530, Shubhrajyoti D wrote:
> re-factor omap_i2c_init() so that we can re-use it for resume.
> While at it also remove the bufstate variable as we write it
> in omap_i2c_resize_fifo for every transfer.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
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
> =20
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
> +	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
> +		__omap_i2c_init(_dev);
> =20
>  	return 0;
>  }

another thing, the few places in omap_i2c_xfer_msg() which are currently
calling omap_i2c_init() should also be converted to call the newly added
__omap_i2c_init(). We don't need to recalculate any of those clock
dividers and whatnot.

--=20
balbi

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhuvcAAoJEIaOsuA1yqRE+RMP/RZ27EEkhnWMt/PZj87ht4o4
5N5lzEsoCNub1fb3UQ3BVULL0Mvst08/eu9qboapt0dzAAGmPsojdpiqxRGXF1ka
/tP85SCOU8GDcACPNw/Sup7HxqR9hd0dhvBBhOClxuJJqkR4L8EDoxDWqw8YAxZH
g4wb0yGM+q4o736bq2PoxFYUmblKBuGPmlOCYtHy/TfwLRrOdFSbLm2yF+KLMWnS
9Xd9KUeyWE2JYOoF6E+rNnM1VZrZoYbwHw+FkqSD6mb3p/9rR+BHggqFW/O+nqCT
IAd2avppOodpoJP/pJa58GgHPteoubLXvYAD7hvD+R1KxHr10OgGRypx4+cI2Yi/
rgenUlf+Xhq/5mc7W/tI8+vNJrjUUuTdIbwu7Itdb1OJgTzxAKPKu19ai0jP8K6I
VizQbzjcwNZRQ983dpAt6YT3nJOH6kXo3iab0D5q/p4YGYv2/RvvXSDUnZOjVbUp
NhlyM7yTjLuycNN21Ign9O86zcyxcXLbgkwZOuYTKrLHXbTG+u0UIfxJ+1S4lAQo
Wkmbs38SfKfWxLnAe/nF5o9kH3Cchzlb9uDDrZLX+fXBQtaV+scX5gMW1UZQC+cj
kFCeFRzblxgHPZI8QUtJP+dgqvPsMCuLwlIfckmunt1LfkqX9sg1Ozu/weE2tYWn
e2kcv9eql6dw9+oC/4uu
=YXZ3
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
