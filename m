From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v6 1/4] power: supply: twl4030-charger: allocate iio by
 devm_iio_channel_get() and fix error path
Date: Wed, 14 Jun 2017 22:13:18 +0200
Message-ID: <20170614201317.36kwxhdvgh55qbcg@earth>
References: <cover.1497432355.git.hns@goldelico.com>
 <cf004f21916eb8bc1c9421b076c298d801b90de0.1497432355.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tb7pgrbwpcelzydg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cf004f21916eb8bc1c9421b076c298d801b90de0.1497432355.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Marek Belisko <marek@goldelico.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--tb7pgrbwpcelzydg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 14, 2017 at 11:25:53AM +0200, H. Nikolaus Schaller wrote:
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/power/supply/twl4030_charger.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 785a07bc4f39..9507c24495ba 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -1017,7 +1017,7 @@ static int twl4030_bci_probe(struct platform_device=
 *pdev)
>  		return ret;
>  	}
> =20
> -	bci->channel_vac =3D iio_channel_get(&pdev->dev, "vac");
> +	bci->channel_vac =3D devm_iio_channel_get(&pdev->dev, "vac");
>  	if (IS_ERR(bci->channel_vac)) {
>  		bci->channel_vac =3D NULL;
>  		dev_warn(&pdev->dev, "could not request vac iio channel");
> @@ -1044,7 +1044,7 @@ static int twl4030_bci_probe(struct platform_device=
 *pdev)
>  			       TWL4030_INTERRUPTS_BCIIMR1A);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to unmask interrupts: %d\n", ret);
> -		goto fail;
> +		return ret;
>  	}
> =20
>  	reg =3D ~(u32)(TWL4030_VBATOV | TWL4030_VBUSOV | TWL4030_ACCHGOV);
> @@ -1073,10 +1073,6 @@ static int twl4030_bci_probe(struct platform_devic=
e *pdev)
>  		twl4030_charger_enable_backup(0, 0);
> =20
>  	return 0;
> -fail:
> -	iio_channel_release(bci->channel_vac);
> -
> -	return ret;
>  }
> =20
>  static int twl4030_bci_remove(struct platform_device *pdev)
> @@ -1087,8 +1083,6 @@ static int twl4030_bci_remove(struct platform_devic=
e *pdev)
>  	twl4030_charger_enable_usb(bci, false);
>  	twl4030_charger_enable_backup(0, 0);
> =20
> -	iio_channel_release(bci->channel_vac);
> -
>  	device_remove_file(&bci->usb->dev, &dev_attr_mode);
>  	device_remove_file(&bci->ac->dev, &dev_attr_mode);
>  	/* mask interrupts */

Thanks, queued.

-- Sebastian

--tb7pgrbwpcelzydg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllBmN0ACgkQ2O7X88g7
+pqABg//VM+t+l0rzyu5Z5YT6vs02u/zv8ygTxQUmrbw1IcpZSUL6OBfTfVjraM7
kVE7DXughWfoNrSDSPap19HfXm3BGlTt7PRCy5aCxYYhco35UBPn2d8tzJH/poWd
2Lbymm8B3a4tbyRSRo0Ojoo8ywZZwXk/fxkQYGemaqHDWnemftWLGdOelmNWav+i
MePG/Eqnv/iWxwCrRSpt2Hc8tOXMBquasQzSjMuptL6Nl9Rm430KAIS0/DNnqXwT
FsW9Jwh4Z6hrAC6o6oZbqEiOcA3ATW6x9WWQYtHZ7B9gwFBhCmcn4CqOvBWYSaKO
CiHz4QW4lFdPT4gwbN5ladvyVFsH4hZfH5QdoulzdGh7MdFnnCcTaRKx8IcTJSvG
5yTTaOVZ1bRholA0eNMGDDXsxoCJQ4/U9zxFzq8DvubgwSxqga0+trhKlq7zu1jf
KC8/9XDqCYRI8IbuFWuMuWHgbo1ETN8SCDW9zbzBQ99h+N6L47JgqUKhN/8xq/qy
b0LAlDEgnioQU2pMeM3UTH1cgN+XyURqeIj7hJ1DwVb9rhwfdp6jxi3bzgjA7cHt
TWUfVgR/7x2hs96+et1oGOmNSYODG2Yr6hLGnF5TDoRA3OEO1ggkw8JgkUtrsyCu
FnZ7o7v6Ux1Ihu0oI+/xhQXQezPqAiOjRFE464sJnojqMqjR30A=
=EEaT
-----END PGP SIGNATURE-----

--tb7pgrbwpcelzydg--
