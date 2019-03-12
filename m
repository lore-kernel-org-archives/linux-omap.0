From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 12/42] drivers: gpio: grgpio: use
 devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 12:23:58 +0100
Message-ID: <20190312112358.GC31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-12-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552330521-4276-12-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:54:51PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-grgpio.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
> index 45b8d6a..09d3dac 100644
> --- a/drivers/gpio/gpio-grgpio.c
> +++ b/drivers/gpio/gpio-grgpio.c
> @@ -333,7 +333,6 @@ static int grgpio_probe(struct platform_device *ofdev)
>  	void  __iomem *regs;
>  	struct gpio_chip *gc;
>  	struct grgpio_priv *priv;
> -	struct resource *res;
>  	int err;
>  	u32 prop;
>  	s32 *irqmap;
> @@ -344,8 +343,7 @@ static int grgpio_probe(struct platform_device *ofdev)
>  	if (!priv)
>  		return -ENOMEM;
> =20
> -	res =3D platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> -	regs =3D devm_ioremap_resource(&ofdev->dev, res);
> +	regs =3D devm_platform_ioremap_resource(&ofdev, 0);

Drop the &?

Thierry

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHls4ACgkQ3SOs138+
s6EWCQ/9EHCXbXLCc1FpDnsDfyTyDxLnFG5COjAUiU/kfkLGrNOlsMnZfoGEcyJs
i8EJl62h3GZ+VIfRhnhg+91tNb7zXVi0zt7uZ9aMn0CBomrgL38k3AaKhr7FLmzo
zW3eXxDPIoJSXK1SAyPxfKpw+WO4XY5Ztsx1UOQvdaVGkqNVRKbjtDuKbJz7Utwk
x5L9z6mAsfW0MQ7CWI40tTVjZsNcCLv+QKrE8/iLY1+nrE6u0BL/D3ppt4grD4Bv
UqECNlPWPMSj6mUoluJBq2FMvZcWiYAxqRDCza/CnT/j5RlGYWBPfhvKlfnrUumJ
1NCqXTPMSq125OcxNZwkakUtwVCl05wX6tXBkOuJrSLd93WN0b1Xw5ifPithkTCz
6XAd6/xfOnVUnFT8KftCLTnCF2mSoFLxY4jHDrdHgXNn9Xj2aNwIu8oiTqHkK/Y3
kuTjC+wOCiaCqEf817CMHmg6tXzxLaCM9sr+nzLrJkUL9I7ywyhYa/BYKOHpqWA1
Malob9RzkEG8jr72To6QZXqqLZGaK8iACWj2RIl+QRAs8P5NuSNO6zKJVoO5pe5P
Mp7owrzdbp1zlLcyhmrZDCdLaVXfYtfza8VpxBTfvlGAhV5uJb7ihLfXMD4CWEHj
frCV48106sgIZJI5I93fwYoWeaY76tJaPDtRQiiV5YOEvoPcM3Q=
=CAJm
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
