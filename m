From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 38/42] drivers: gpio: vr41xx: use
 devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 12:37:32 +0100
Message-ID: <20190312113732.GG31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-38-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552330521-4276-38-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:55:17PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>=20
> this driver deserves a bit more cleanup, to get rid of the global
> variable giu_base, which makes it single-instance-only.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-vr41xx.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
> index b13a49c..98cd715 100644
> --- a/drivers/gpio/gpio-vr41xx.c
> +++ b/drivers/gpio/gpio-vr41xx.c
> @@ -467,10 +467,9 @@ static int vr41xx_gpio_to_irq(struct gpio_chip *chip=
, unsigned offset)
> =20
>  static int giu_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
>  	unsigned int trigger, i, pin;
>  	struct irq_chip *chip;
> -	int irq, ret;
> +	int irq;
> =20
>  	switch (pdev->id) {
>  	case GPIO_50PINS_PULLUPDOWN:
> @@ -489,21 +488,14 @@ static int giu_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -EBUSY;
> -
> -	giu_base =3D ioremap(res->start, resource_size(res));
> -	if (!giu_base)
> -		return -ENOMEM;
> +	giu_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(giu_base))
> +		return PTR_ERR(giu_base);

The driver currently doesn't request the memory described in the
resource, so technically you're changing behaviour here and with your
change the driver could now fail if somebody else has already claimed
the memory.

Looking at arch/mips/vr41xx there doesn't seem to be an overlap between
the memory region used by the GIU device and any others, so this should
be safe. Not sure anyone still has hardware for this around to give it
a spin.

Thierry

> =20
>  	vr41xx_gpio_chip.parent =3D &pdev->dev;
> =20
> -	ret =3D gpiochip_add_data(&vr41xx_gpio_chip, NULL);
> -	if (!ret) {
> -		iounmap(giu_base);
> +	if (gpiochip_add_data(&vr41xx_gpio_chip, NULL))
>  		return -ENODEV;
> -	}
> =20
>  	giu_write(GIUINTENL, 0);
>  	giu_write(GIUINTENH, 0);
> @@ -534,7 +526,6 @@ static int giu_probe(struct platform_device *pdev)
>  static int giu_remove(struct platform_device *pdev)
>  {
>  	if (giu_base) {
> -		iounmap(giu_base);
>  		giu_base =3D NULL;
>  	}
> =20
> --=20
> 1.9.1
>=20

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHmfwACgkQ3SOs138+
s6GpPw/+PO40QInzGgfRGJGf5fQ2uQKUwIiH2EQxp0L7tmyvF/ZYodNb2Oy16DM4
ypJlpKtRU8udgnhj6h4Jr+rJ50Ak5Nz26aBltA0XVBpUm7eEfLbA3egfup3BtXDR
eERmniHeC83brj+qd2ttpngN0p4RF06BiUtpqWQwYbPaM6ZRhZfqRr5Y3m673vRn
Wm/uKpNVXJ+LjqDEbbwuawy9icfTjPK9u4x5W80H1Qw4AnQEH66cB6isB7kXCKNT
hVA1AKnc2wor3HEQxNBhGESwg5j1tzBYQK6RJ6fVB9cnpOFQGjPCIjYsyJdNf1wc
T27zc3UEL4Sy20crfEzVMaP23khdcdUFlyqLfnPfY3JmUT4NhhZr0FVUGP9iUHPa
hLDtXwUEt+Ojol9uIAyT8OePfSm797Xpk6t+WVpt3H8hrXvXdo77NGUUZXG/IInq
QAMeV/yN/iNOnUguWe7xjBHQLuVUbm+yuNCgKWFG+DOOKYjN8TLmuju1SeHHj/fx
wge65+PnS+SiHzaNz8icRZHaH9VWSGS2qCvEcMuoGJZjGyz3ajaqdzSVfm0TsnIT
R87r1B46OZC++ztZicofvfGtc1vInwaE8F1ikjKxa5VJoFofssI0HnzU+WHrgfcs
PO9mqyLDHjv569YoyX7NcEWdtXotVJT/GlYdkkI+SN70/7Va+4M=
=BSp7
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
