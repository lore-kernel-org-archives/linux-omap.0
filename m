From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/6] mfd: smsc-ece1099: Return directly after a function
 failure in smsc_i2c_probe()
Date: Tue, 28 Jun 2016 16:08:29 +0100
Message-ID: <20160628150829.GN24982@dell>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net>
 <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <de3598c4-f85a-6807-303a-55ee0ac707f2@users.sourceforge.net>
 <20160608111442.GB14888@dell>
 <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
 <7de4f21e-30a2-fab6-204d-890619ccbbe6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7de4f21e-30a2-fab6-204d-890619ccbbe6@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

On Sun, 26 Jun 2016, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Jun 2016 14:30:46 +0200
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Return directly if a call of the function "devm_regmap_init_i2c"
> or "regmap_write" failed.
>=20
> Delete the jump label "err" then.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mfd/smsc-ece1099.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/smsc-ece1099.c b/drivers/mfd/smsc-ece1099.c
> index 2aaf89f..cd18c09 100644
> --- a/drivers/mfd/smsc-ece1099.c
> +++ b/drivers/mfd/smsc-ece1099.c
> @@ -46,10 +46,8 @@ static int smsc_i2c_probe(struct i2c_client *i2c,
>  	}
> =20
>  	smsc->regmap =3D devm_regmap_init_i2c(i2c, &smsc_regmap_config);
> -	if (IS_ERR(smsc->regmap)) {
> -		ret =3D PTR_ERR(smsc->regmap);
> -		goto err;
> -	}
> +	if (IS_ERR(smsc->regmap))
> +		return PTR_ERR(smsc->regmap);
> =20
>  	i2c_set_clientdata(i2c, smsc);
>  	smsc->dev =3D &i2c->dev;
> @@ -68,7 +66,7 @@ static int smsc_i2c_probe(struct i2c_client *i2c,
> =20
>  	ret =3D regmap_write(smsc->regmap, SMSC_CLK_CTRL, smsc->clk);
>  	if (ret)
> -		goto err;
> +		return ret;
> =20
>  #ifdef CONFIG_OF
>  	if (i2c->dev.of_node)
> @@ -76,7 +74,6 @@ static int smsc_i2c_probe(struct i2c_client *i2c,
>  					   NULL, NULL, &i2c->dev);
>  #endif
> =20
> -err:
>  	return ret;
>  }
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
