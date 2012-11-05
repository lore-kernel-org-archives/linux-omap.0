From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 6/7] i2c: omap: make reset a seperate function
Date: Mon, 5 Nov 2012 09:55:25 +0200
Message-ID: <20121105075525.GG32468@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-7-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49858 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab2KEIBt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 03:01:49 -0500
Content-Disposition: inline
In-Reply-To: <1352025873-27492-7-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de

--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 04, 2012 at 04:14:32PM +0530, Shubhrajyoti D wrote:
> Implement reset as a separate function.
> This will enable us to make sure that we don't do the
> calculation again on every transfer.
> Also at probe the reset is not added as the hwmod is doing that
> for us.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> todo: reprodue the errors and optimise the reset if possible.
>=20
>  drivers/i2c/busses/i2c-omap.c |   25 ++++++++++++++++---------
>  1 files changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index a87c20a..70d43b7 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -299,15 +299,9 @@ static void __omap_i2c_init(struct omap_i2c_dev *dev)
>  		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
>  }
> =20
> -static int omap_i2c_init(struct omap_i2c_dev *dev)
> +static int omap_i2c_reset(struct omap_i2c_dev *dev)
>  {
> -	u16 psc =3D 0, scll =3D 0, sclh =3D 0;
> -	u16 fsscll =3D 0, fssclh =3D 0, hsscll =3D 0, hssclh =3D 0;
> -	unsigned long fclk_rate =3D 12000000;
>  	unsigned long timeout;
> -	unsigned long internal_clk =3D 0;
> -	struct clk *fclk;
> -
>  	if (dev->rev >=3D OMAP_I2C_OMAP1_REV_2) {
>  		/* Disable I2C controller before soft reset */
>  		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
> @@ -353,6 +347,17 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			dev->westate =3D OMAP_I2C_WE_ALL;
>  		}
>  	}
> +	return 0;
> +}
> +
> +static int omap_i2c_init(struct omap_i2c_dev *dev)
> +{
> +	u16 psc =3D 0, scll =3D 0, sclh =3D 0;
> +	u16 fsscll =3D 0, fssclh =3D 0, hsscll =3D 0, hssclh =3D 0;
> +	unsigned long fclk_rate =3D 12000000;
> +	unsigned long internal_clk =3D 0;
> +	struct clk *fclk;
> +
> =20
>  	if (dev->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
>  		/*
> @@ -592,7 +597,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	dev->buf_len =3D 0;
>  	if (timeout =3D=3D 0) {
>  		dev_err(dev->dev, "controller timed out\n");
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		return -ETIMEDOUT;
>  	}
> =20
> @@ -602,7 +608,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	/* We have an error */
>  	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
>  			    OMAP_I2C_STAT_XUDF)) {
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		return -EIO;
>  	}
> =20
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl3DtAAoJEIaOsuA1yqREGFoP/jZRQEy4GNEdCa5ixS8icjqg
nXgIAUqaVgE5zNJwP9IMHSFTdhKF+9AMBUp2pDwERFLSjdK+/03BzFuytjGOHZAd
3QnzGaN5dYRnwhW++OGvORt4z8Ig1kNVk97/pBouK11QshP+ryEPuZlmurPfA69T
R6VYWEXy61Umi/HhybxVGEwcAEtlLgznupj0AFonxYNPo3YPMoU6TzAQNtzoSxhQ
+N/rdeZSz2nt9ny4qhWiULRyUs/fjo5V+yMMEUWSPvIb2k8nwcC/TQwQi5kCT48R
QkpU9OU+iBpiblDlPbMk4cBr105v17NJvoeqScu/9y8TBSiekhSMSoad5hQ3krHk
qE0tkfQz9gR57WpPSVhYie+AE5ug1GznbtgEAZfs3GZS1xnpPNFoQOpuNlB1k2fd
kXalkUdwBTT6iSi5k0v8VM2iqUxG4FTOUsf37No2sLV+KG8cV0dfFRY90GYth7Pb
kaBcAvJVaxu2mweftZhEGZmuAtlYm4fKzWnLjevtaMAiMhx/GEpbnngRwyYT3yj6
LNf7LC4cU3JSw8tXpB2heHyJMRUEA0ZTJPS0yoZfz0fNA7VW5CLWaMuN1JemXZcz
WbwOoVpfwR3UKE9We3iwUwmkiwZx0BrjDuu4DzC9iCKQVQgCrn+3PHVeAd6QYalF
WlS/J362KTqrIURWWCiM
=LqIp
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
