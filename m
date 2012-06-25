From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv10 4/7] I2C: OMAP: Do not initialise the completion
 everytime
Date: Mon, 25 Jun 2012 15:33:45 +0300
Message-ID: <20120625123345.GC30463@arwen.pp.htv.fi>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
 <1340622702-21622-5-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340622702-21622-5-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 25, 2012 at 04:41:39PM +0530, Shubhrajyoti D wrote:
> Use INIT_COMPLETION instead of init_completion in transfer.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-omap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index c771c28..f1109f4 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -493,7 +493,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	w |=3D OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
>  	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
> =20
> -	init_completion(&dev->cmd_complete);
> +	INIT_COMPLETION(dev->cmd_complete);
>  	dev->cmd_err =3D 0;
> =20
>  	w =3D OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
> @@ -1003,6 +1003,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  	}
> =20
>  	platform_set_drvdata(pdev, dev);
> +	init_completion(&dev->cmd_complete);
> =20
>  	dev->reg_shift =3D (dev->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
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

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6FqpAAoJEIaOsuA1yqREV4IP/Rn9D4amOpWt0DZ2Uek3U0Pz
6pfT3sHPpiQYsjITXMY/zTErxT5NW3RkHHC6cW80Lkr9OWt7aSLc5cG1wF+O8hir
Nfhyt5cf8PBsoF22ff9Zy/o3PxQ8iIrsINFIa4R2Sa81GmL/gBV0GY13OKxprPhL
PeiNox8aAmjbv/XgVyyCaEdaSVjN8U+lHYWdh8dd5vLUN8lYuwK8wHX3emCv2AMv
mt8qgvK2mtBMLP5E0S1DqnIiDfu4qfD4zf36aNstBw1n7Xest3XMBlhkLvd3Im3G
YzhsEXNFHhhILUB2K3lEHm9KnfvSkVgQwPUppXEFNI/1HYUdi08iRcuPYWjzK8CE
DedhwYwlHfO5iyI4RdZ0PN17rWx13ervSFiU7UvV2Ib5utWVoSk5e3MQKJYh5KYr
h0omMwV/iuKhzkFntBF9EL9cZe0ewIEV+0wRIuq/5egEHkbELGHhmFjH+5F9k3ud
XSfhnTwnVT+sOvFbd23mGS7Z/Z+pIHuFvL0Nz7l85TnF3yxOMvPNrWKQBVGmwaHS
O+lRnlDCcDdFWM82mMH638wcRChx0Ss4S8uTQnQg8W3uHVEBllaTUzBT++zsqvVg
AiljRG5pAlGNeMeBYAd3MSC48mOYpGtRE13evtvf8Q3MAtAmUq6u0O17GpH6SeVP
uJRd5tA/f8yOd2C3XiRk
=N8tx
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
