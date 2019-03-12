From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 03/42] drivers: gpio: amdpt: drop unneeded deref of
 &pdev->dev
Date: Tue, 12 Mar 2019 12:21:04 +0100
Message-ID: <20190312112104.GA31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-3-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552330521-4276-3-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:54:42PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> We already have the struct device* pointer in a local variable,
> so we can write this a bit shorter.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-amdpt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
> index 1ffd7c2..3220f3c 100644
> --- a/drivers/gpio/gpio-amdpt.c
> +++ b/drivers/gpio/gpio-amdpt.c
> @@ -91,7 +91,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
> =20
>  	pt_gpio->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pt_gpio->reg_base)) {
> -		dev_err(&pdev->dev, "Failed to map MMIO resource for PT GPIO.\n");
> +		dev_err(dev, "Failed to map MMIO resource for PT GPIO.\n");
>  		return PTR_ERR(pt_gpio->reg_base);
>  	}
> =20
> @@ -101,7 +101,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
>  			 pt_gpio->reg_base + PT_DIRECTION_REG, NULL,
>  			 BGPIOF_READ_OUTPUT_REG_SET);
>  	if (ret) {
> -		dev_err(&pdev->dev, "bgpio_init failed\n");
> +		dev_err(dev, "bgpio_init failed\n");
>  		return ret;
>  	}
> =20
> @@ -110,11 +110,11 @@ static int pt_gpio_probe(struct platform_device *pd=
ev)
>  	pt_gpio->gc.free             =3D pt_gpio_free;
>  	pt_gpio->gc.ngpio            =3D PT_TOTAL_GPIO;
>  #if defined(CONFIG_OF_GPIO)
> -	pt_gpio->gc.of_node          =3D pdev->dev.of_node;
> +	pt_gpio->gc.of_node          =3D dev.of_node;

"dev->of_node"?

Thierry

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHlhwACgkQ3SOs138+
s6GD7g//RLd4WtA1eIT8moMwWLKywkUMl3Nz89m1EIFFGKv2Q76AjTLCMykRiwTR
Pu6OtKodY+L2FpLDweXXz/HYtUbtiZn2/44t5vVAFadlJiMAiL0fFO8VYDW4DNE9
cmcWzeTdbJNg/DJXRbUVE932XhvEdUzWXw1ymBlD97FQYpvRy81FjjHgQ7tCYYQn
q+7u2dS+Q/9g5pFvz0oiG3TZyX6yWoXwIdSRTrU4O1QTpNgSt70xvKGg/NcCxYfe
TByHergN63iBB+0caCXkpbmc7X26QKfvZn1L7OfrCPUQEZg5pOXJ69JGM3ELz6Rx
3xP/C+Lzhe0eS6E7sjbb7FA0XhBs9zlnMBLv8wz6miYJrj9YuEJEUJHoPDjlUTmk
gTnbhp79Ic8fbsNAIfnByHnZ6d1g/0Xis/LOyQ6WppARhrNXZxPt2XZZyiHel2t3
ozG03l1U4omMaj+W08euRQ9oX5UJAfR6Knd5ZD/TYcBQFDgyyIMjjsPzwhIC7cVL
REYCYrcYLQgOG/O0oUqmEQtJZXsF3OtLXDADYxoCGAD+6ri3O9NOxOlO+rwUDjEj
QmLu34BajBjOV6wx/5HSXOTbntd8Ej+stMUp/xVMeV7xRwTb0hKMUFUwNNL8Aw27
/dD0jGMO0vAcc0kUgTGgHkyJy3OetueR5RjzRMzdqegxq/D213M=
=6/o3
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
