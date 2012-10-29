From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 2/2] i2c: omap: make reset a seperate function
Date: Mon, 29 Oct 2012 21:52:23 +0200
Message-ID: <20121029195223.GC30152@arwen.pp.htv.fi>
References: <1351176199-6479-1-git-send-email-shubhrajyoti@ti.com>
 <1351176199-6479-3-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1351176199-6479-3-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2012 at 08:13:19PM +0530, Shubhrajyoti D wrote:
> Implement reset as a separate function.
> This will enable us to make sure that we don't do the
> calculation again on every transfer.
> Also at probe the reset is not added as the hwmod is doing that
> for us.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

(again, will test tomorrow if I have time)

Next step would be to figure out if it is necessary to reset the IP in
case of error. I don't think so, but only testing will say...

> ---
> some of the errors may not need a reset.
> will check and post separate patch.
>=20
>  drivers/i2c/busses/i2c-omap.c |   25 ++++++++++++++++---------
>  1 files changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 38acf1a..a25b7b0 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -309,15 +309,9 @@ static void __omap_i2c_init(struct omap_i2c_dev *dev)
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
> @@ -363,6 +357,17 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
> @@ -595,7 +600,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	if (timeout =3D=3D 0) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		ret =3D -ETIMEDOUT;
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		goto out;
>  	}
> =20
> @@ -606,7 +612,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
>  			    OMAP_I2C_STAT_XUDF)) {
>  		ret =3D -EIO;
> -		omap_i2c_init(dev);
> +		omap_i2c_reset(dev);
> +		__omap_i2c_init(dev);
>  		goto out;
>  	}
> =20
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjt53AAoJEIaOsuA1yqREdpoP/3ndTTWjmqI0R2q6t2RPPf7a
GPkn8ufJJXM5xgAKHO6BciwihqYLDvJ1yLvSJdnYTh4km1UuULIEoebWfAxHZ9DV
1rsv31hUrs37YkdGW4jTxWKb+LwEKeBxTgG3dh/uP0VKviM2Igu0NwfzNKQMRS+m
nLEHOPJt/B/mTDV2n5g+/dOH8rhOQQJ/ea/wO2YUKCTE4+xkdLGIspYtJuTSdO1s
OHj1WIwk3++Bcq15OflaIcJEeZGyaBxrUU5l+rEftsoytm7OrE1QZsgGW/F/TeEx
Q+GveD6Tai6BiiDe8CqD90DTJoDSxOpVppOZVuL/Vxs3cFodJovpsBub2WsAARLs
Jz0vTI/UbuhVuQ2KQ4YxE7eAkEGJGp2LjjBoylMA1eFcqEsLURABr2X3BkaZKu4J
RxAtLA7F7il0OMbIwbTyigePk+9iGNIesjbhXBozTBAWIMyPc59EthdPA9w+4BUX
NyuncTvMS2JaWEvcodFQ5my9xeQuXInxT7Ioq23evNqTo+z8A6OfaJEfykt+DWyA
uBIDV5mPLMklPSqSOdk2X5OelzX96UilFa5KvgsFKkASRp2jG4igd+Esf5dvazVg
M/jKSmIj9eqPM0gBPpkemm2UEn9677bNiCjii6/1pkBkrZ7CXf1weVdko7wir2kH
NJvuVEOY/SEsZ688NNeR
=cMH2
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
