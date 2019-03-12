From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 10/42] drivers: gpio: ep93xx:
 devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 12:23:24 +0100
Message-ID: <20190312112324.GB31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-10-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552330521-4276-10-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:54:49PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-ep93xx.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
> index 71728d6..52e9a7b2 100644
> --- a/drivers/gpio/gpio-ep93xx.c
> +++ b/drivers/gpio/gpio-ep93xx.c
> @@ -393,16 +393,13 @@ static int ep93xx_gpio_add_bank(struct gpio_chip *g=
c, struct device *dev,
>  static int ep93xx_gpio_probe(struct platform_device *pdev)
>  {
>  	struct ep93xx_gpio *epg;
> -	struct resource *res;
>  	int i;
> -	struct device *dev =3D &pdev->dev;
> =20
> -	epg =3D devm_kzalloc(dev, sizeof(*epg), GFP_KERNEL);
> +	epg =3D devm_kzalloc(&odev->dev, sizeof(*epg), GFP_KERNEL);

odev -> pdev

You should write some scripts to compile-test these changes. Compilers
are good at catching these silly typos. Humans not so much.

Thierry

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHlqwACgkQ3SOs138+
s6EXlQ//UlPhWGa4orxXlExHArR+1/Kgj0PTzlH1CExKaqMqH7TZEDb9TOLPAp38
Yea3rxI53Y+OgGrqhKku98gdSclm414zA6DLyukxKZK42DFEyvQBmGDVetQXRMyF
+thSWF271Hh1ZHWFR1YB0WV7h3qmZv3KLzbVd7uWeWbfA1acXTo1kn/XKMkRNfrr
OU7upm0agz3CzWBnd4AhFPr+LhIaNMq92fg2VTmuMNQFR8sMFn2Nd1f/Rh73y8ZK
1OXg8amO4kMeGKMp6Q/ApWehhZb07JGUqatjVdxdEzIYedXlTjV/uPt8bTyv1xRG
3UJu6Qez7dMgoNVKDyXDo+6XAWKkYenVrrcEBD+HDAYVsO7CMRf8nP4lH8w+/YTi
7jWzhOaCmM4Rrl8aOhQ8eizZUyAa36vWKnm9k1KOmQwu5A2Pe8rg357MH5lExt2W
WCN7U8AlHLhDKSVQGiS2Ajw8MfYik+GQ4DY6BLRWn3FOGV+l3XWNGoQCrQm9JhpS
Lgq8AY4beeSk5W7/1ccXF3TWGHOcfGveBlQEM1avq64k8RD4q7PfgOrd6JW0ejr+
2BkR1urgcSzvdTgKfqeg+krpPNmyfvxIAhEX4/3Uj/09V8nb6a+jmvsznkG2OQ5f
ma/tRUrK74kFZlkoxR5mtHlSFksQA3qWKC1v8hweexhm7LUJD7Q=
=OJtP
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
