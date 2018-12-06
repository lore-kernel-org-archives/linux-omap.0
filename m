From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] mfd: tps65218: Use devm_regmap_add_irq_chip and clean up
 error path in probe
Date: Thu, 6 Dec 2018 21:51:55 +0100
Message-ID: <20181206205155.eucqfsq2xnk7kks5@earth.universe>
References: <1544117864-28276-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fx7rjpucokn4j6ls"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544117864-28276-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, lee.jones@linaro.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--fx7rjpucokn4j6ls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 06, 2018 at 11:07:44PM +0530, Keerthy wrote:
> Use devm_regmap_add_irq_chip and clean up error path in probe.
>=20
> Reported-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> Boot tested on am437x-gp-evm.

This is missing cleanup of remove path?

-- Sebastian

>  drivers/mfd/tps65218.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 910f569..2383621 100644
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
> @@ -253,14 +253,6 @@ static int tps65218_probe(struct i2c_client *client,
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
> --=20
> 1.9.1
>=20

--fx7rjpucokn4j6ls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwJi+cACgkQ2O7X88g7
+prk9g//STkhr5bWr4W9OLoALcNiIMfV3qqy40RM7dpeHfqlH7XAeFuQ6Fil5gTI
bCZNjbil/u9TI44thve3tnryeCYIxCJyYbRVrd6b36H6LeZtSzIMn56MWNgZZMbB
qDNBxTO7p5ypX6UNxFI7aLRXBc9RG8fp2QGEZXwhUZOhzyR21RgRbuPlwBqjPmn5
5wkxalY42KTAGlcTr+obrdIRnzwUgx9K7/KNH9QS3Io5dqbhVVFLr7UdVCIjsejZ
T2YN5lgSTNNPrio2BkOJrKtMLapFo/KkXzEXf42SYJ44Tf7yWjsXCsECvNqvuJTq
NlIAEl5aRSAwGWZyhELhW13zNJkvWxlDBl3hBEhgkBxj4mh97fwYChYyUy7OoYLj
113pBA7r8Zk5LDZ3vHv1lhPUjZOYd+gN8dn/eQrc19HiIIWZ6q2tcShocWfQrnLp
JO9YbsGr/1L4aUaLiJd27w69WPPbQu4ygiPV0+P2vK4zMuiZKzZnjYteABpaoi8r
O6yaR8ravzeZW8QR/1rTdMac1NsJ5u5QBjJ40hEGchAl4l4RaxAYJDJV9jnysoQn
g93ohH/AcjAyAztSBtBwZjKsIiVKich4URky/LT7K+VSgoWz7XwqXB7pOqgIwhXV
2hbH5rWJw+IcZrMjFQpJtB+LXgEXGdgLSAkyJHXRtl7suanHzrY=
=9QrH
-----END PGP SIGNATURE-----

--fx7rjpucokn4j6ls--
