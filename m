From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v3] mfd: tps65218: Use devm_regmap_add_irq_chip and clean
 up  error path in probe
Date: Sun, 9 Dec 2018 23:45:51 +0100
Message-ID: <20181209224551.3nouziwxu5kc5s7a@earth.universe>
References: <1544363971-28061-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="46vp3x4hcrfmaouo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544363971-28061-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, ladis@linux-mips.org
List-Id: linux-omap@vger.kernel.org


--46vp3x4hcrfmaouo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 09, 2018 at 07:29:31PM +0530, Keerthy wrote:
> Use devm_regmap_add_irq_chip and clean up error path in probe
> and also the remove function.
>=20
> Reported-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>=20
> Changes in v2:
>=20
>   * Cleaned up remove function as well.
>=20
> Changes in v3:
>=20
>   * Deleted the remove function which was just returning 0
>=20
>  drivers/mfd/tps65218.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 910f569..8bcdecf 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -235,9 +235,9 @@ static int tps65218_probe(struct i2c_client *client,
> =20
>  	mutex_init(&tps->tps_lock);
> =20
> -	ret =3D regmap_add_irq_chip(tps->regmap, tps->irq,
> -			IRQF_ONESHOT, 0, &tps65218_irq_chip,
> -			&tps->irq_data);
> +	ret =3D devm_regmap_add_irq_chip(&client->dev, tps->regmap, tps->irq,
> +				       IRQF_ONESHOT, 0, &tps65218_irq_chip,
> +				       &tps->irq_data);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -253,26 +253,9 @@ static int tps65218_probe(struct i2c_client *client,
>  			      ARRAY_SIZE(tps65218_cells), NULL, 0,
>  			      regmap_irq_get_domain(tps->irq_data));
> =20
> -	if (ret < 0)
> -		goto err_irq;
> -
> -	return 0;
> -
> -err_irq:
> -	regmap_del_irq_chip(tps->irq, tps->irq_data);
> -
>  	return ret;
>  }
> =20
> -static int tps65218_remove(struct i2c_client *client)
> -{
> -	struct tps65218 *tps =3D i2c_get_clientdata(client);
> -
> -	regmap_del_irq_chip(tps->irq, tps->irq_data);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id tps65218_id_table[] =3D {
>  	{ "tps65218", TPS65218 },
>  	{ },
> @@ -285,7 +268,6 @@ static int tps65218_remove(struct i2c_client *client)
>  		.of_match_table =3D of_tps65218_match_table,
>  	},
>  	.probe		=3D tps65218_probe,
> -	.remove		=3D tps65218_remove,
>  	.id_table       =3D tps65218_id_table,
>  };
> =20
> --=20
> 1.9.1
>=20

--46vp3x4hcrfmaouo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwNmxUACgkQ2O7X88g7
+pr4ew//Sz8SQqfvzGLLwlUXV7FTeDS3AzeHfdls0UbKgEitpt/NW9uf/lJPF35k
pp3KA0TCyjcNGyoIHxJ43M3+zd9I5HD2u8zJTMrN5f7U9pYlZ9K4egoj7GyuK/MM
hO6nFiD5fNS6FS3VtEwuD6xJVtdBO3qOU3rDkwysTeIfVIyQBIjt2DXxhsY+BSJe
UrxU9ibi97UMvPK47O4m8Yv7ndULhwF3tE0q6ng9H0XwLsb/arpmcxajjn1/R89b
vIS9RWy8ZUH2JO0aADsXgPqHQz4YW7wri2bkiGZK61isZ24Nhhxa2RBwaCHpKGSz
HF99KY8q5KYHQx12HecOg2sfhLNDc4uVzzThl9WYgqT4NpksvbZD6x4GzF54Kjnj
gUpwnSsV2xdMvp2fFMc90LwruOOrp7qgqe9KfKhysbnhMEXrozpDHTQ1bhAk9ZAu
m/Anopl304sN7Y/NaRkw+TI1Be8yeHtDJs+fsv3+tZjeca5bQPje3Okc9qkBEc++
wjbTpmGgPOxGLi6as/77+Trk+o+bxyUFV/ZDhZQFLp0hYByKVN8o/fE2qBT6XRKh
a6m5aX0K2BfUhAeUPcnXQCr4rDKALKQOAjfSc+G7IJ5k+cHJnw7dDn3GRT+XI/V4
ondOjOT0249ZG0VSxpw6xv2HcChT6blKBOzpZJspESmZqjSXLnM=
=dD04
-----END PGP SIGNATURE-----

--46vp3x4hcrfmaouo--
