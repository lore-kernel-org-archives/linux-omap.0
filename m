From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/9] mfd: palmas: Add tps65917 support
Date: Tue, 17 Jun 2014 17:19:40 +0100
Message-ID: <20140617161940.GO29841@lee--X1>
References: <1401272423-25761-1-git-send-email-j-keerthy@ti.com>
 <1401272423-25761-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401272423-25761-5-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

> Add tps65917 PMIC support. tps65917 is a subset of palmas PMIC.
> Some of the register definitions and the interrupt mappings
> are different.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/palmas.c |  176 ++++++++++++++++++++++++++++++++++++++++=
++++++++--
>  1 file changed, 171 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index d280d78..485d755 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c

[...]

> +struct palmas_driver_data {
> +	unsigned int *features;
> +	struct regmap_irq_chip *irq_chip;
> +};
> +
> +static struct palmas_driver_data palmas_data =3D {
> +	.features =3D &palmas_features,
> +	.irq_chip =3D &palmas_irq_chip,
> +};
> +
> +static struct palmas_driver_data tps659038_data =3D {
> +	.features =3D &tps659038_features,
> +	.irq_chip =3D &palmas_irq_chip,
> +};
> +
> +static struct palmas_driver_data tps65917_data =3D {
> +	.features =3D &tps659038_features,
> +	.irq_chip =3D &tps65917_irq_chip,
> +};
> +

[...]

> @@ -375,6 +539,7 @@ static int palmas_i2c_probe(struct i2c_client *i2=
c,
>  {
>  	struct palmas *palmas;
>  	struct palmas_platform_data *pdata;
> +	struct palmas_driver_data *driver_data;
>  	struct device_node *node =3D i2c->dev.of_node;
>  	int ret =3D 0, i;
>  	unsigned int reg, addr, *features;
> @@ -408,7 +573,8 @@ static int palmas_i2c_probe(struct i2c_client *i2=
c,
>  	if (!match)
>  		return -ENODATA;
> =20
> -	features =3D (unsigned int *)match->data;
> +	driver_data =3D (struct palmas_driver_data *)match->data;
> +	features =3D (unsigned int *)driver_data->features;
>  	palmas->features =3D *features;

Couple of things a) I don't think the cast is required here and b) you
may as well do away with the local features variable here.

Just do:
  palmas->features =3D *driver_data->features;

Once fixed, re-submit with my:
  Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
