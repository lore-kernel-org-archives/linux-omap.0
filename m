From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: Drop owner assignment from i2c_drivers
Date: Fri, 10 Jul 2015 07:44:58 +0100
Message-ID: <20150710064458.GB12199@x1>
References: <1436504740-9439-1-git-send-email-k.kozlowski@samsung.com>
 <1436504740-9439-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436504740-9439-2-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Michael Hennerich <michael.hennerich@analog.com>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tony Lindgren <tony@atomide.com>, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 10 Jul 2015, Krzysztof Kozlowski wrote:

> i2c_driver does not need to set an owner because i2c_register_driver(=
)
> will set it.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>=20
> ---
>=20
> The coccinelle script which generated the patch was sent here:
> http://www.spinics.net/lists/kernel/msg2029903.html
> ---
>  drivers/mfd/88pm800.c             | 1 -
>  drivers/mfd/88pm805.c             | 1 -
>  drivers/mfd/88pm860x-core.c       | 1 -
>  drivers/mfd/aat2870-core.c        | 1 -
>  drivers/mfd/ab3100-core.c         | 1 -
>  drivers/mfd/adp5520.c             | 1 -
>  drivers/mfd/arizona-i2c.c         | 1 -
>  drivers/mfd/as3711.c              | 1 -
>  drivers/mfd/as3722.c              | 1 -
>  drivers/mfd/axp20x.c              | 1 -
>  drivers/mfd/bcm590xx.c            | 1 -
>  drivers/mfd/cros_ec_i2c.c         | 1 -
>  drivers/mfd/da903x.c              | 1 -
>  drivers/mfd/da9052-i2c.c          | 1 -
>  drivers/mfd/da9055-i2c.c          | 1 -
>  drivers/mfd/da9063-i2c.c          | 1 -
>  drivers/mfd/intel_soc_pmic_core.c | 1 -
>  drivers/mfd/lm3533-core.c         | 1 -
>  drivers/mfd/lp3943.c              | 1 -
>  drivers/mfd/lp8788.c              | 1 -
>  drivers/mfd/max14577.c            | 1 -
>  drivers/mfd/max77686.c            | 1 -
>  drivers/mfd/max77693.c            | 1 -
>  drivers/mfd/max8907.c             | 1 -
>  drivers/mfd/max8925-i2c.c         | 1 -
>  drivers/mfd/max8997.c             | 1 -
>  drivers/mfd/max8998.c             | 1 -
>  drivers/mfd/mc13xxx-i2c.c         | 1 -
>  drivers/mfd/palmas.c              | 1 -
>  drivers/mfd/rc5t583.c             | 1 -
>  drivers/mfd/retu-mfd.c            | 1 -
>  drivers/mfd/sec-core.c            | 1 -
>  drivers/mfd/si476x-i2c.c          | 1 -
>  drivers/mfd/smsc-ece1099.c        | 1 -
>  drivers/mfd/stmpe-i2c.c           | 1 -
>  drivers/mfd/tc3589x.c             | 1 -
>  drivers/mfd/tps6507x.c            | 1 -
>  drivers/mfd/tps65090.c            | 1 -
>  drivers/mfd/tps65217.c            | 1 -
>  drivers/mfd/tps65218.c            | 1 -
>  drivers/mfd/tps6586x.c            | 1 -
>  drivers/mfd/tps65910.c            | 1 -
>  drivers/mfd/tps65912-i2c.c        | 1 -
>  drivers/mfd/tps80031.c            | 1 -
>  drivers/mfd/twl6040.c             | 1 -
>  drivers/mfd/wm831x-i2c.c          | 1 -
>  drivers/mfd/wm8350-i2c.c          | 1 -
>  drivers/mfd/wm8400-core.c         | 1 -
>  drivers/mfd/wm8994-core.c         | 1 -
>  49 files changed, 49 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
> index 841717a2842c..f2d9fb4c4e8e 100644
> --- a/drivers/mfd/88pm800.c
> +++ b/drivers/mfd/88pm800.c
> @@ -609,7 +609,6 @@ static int pm800_remove(struct i2c_client *client=
)
>  static struct i2c_driver pm800_driver =3D {
>  	.driver =3D {
>  		.name =3D "88PM800",
> -		.owner =3D THIS_MODULE,
>  		.pm =3D &pm80x_pm_ops,
>  		},
>  	.probe =3D pm800_probe,
> diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
> index e9d50644660c..39f2302e137b 100644
> --- a/drivers/mfd/88pm805.c
> +++ b/drivers/mfd/88pm805.c
> @@ -267,7 +267,6 @@ static int pm805_remove(struct i2c_client *client=
)
>  static struct i2c_driver pm805_driver =3D {
>  	.driver =3D {
>  		.name =3D "88PM805",
> -		.owner =3D THIS_MODULE,
>  		.pm =3D &pm80x_pm_ops,
>  		},
>  	.probe =3D pm805_probe,
> diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.=
c
> index e03b7f45b8f7..cb47d6e00ebe 100644
> --- a/drivers/mfd/88pm860x-core.c
> +++ b/drivers/mfd/88pm860x-core.c
> @@ -1258,7 +1258,6 @@ MODULE_DEVICE_TABLE(of, pm860x_dt_ids);
>  static struct i2c_driver pm860x_driver =3D {
>  	.driver	=3D {
>  		.name	=3D "88PM860x",
> -		.owner	=3D THIS_MODULE,
>  		.pm     =3D &pm860x_pm_ops,
>  		.of_match_table	=3D pm860x_dt_ids,
>  	},
> diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
> index 4e6e03d63e12..29b6a2d4ac72 100644
> --- a/drivers/mfd/aat2870-core.c
> +++ b/drivers/mfd/aat2870-core.c
> @@ -500,7 +500,6 @@ MODULE_DEVICE_TABLE(i2c, aat2870_i2c_id_table);
>  static struct i2c_driver aat2870_i2c_driver =3D {
>  	.driver =3D {
>  		.name	=3D "aat2870",
> -		.owner	=3D THIS_MODULE,
>  		.pm	=3D &aat2870_pm_ops,
>  	},
>  	.probe		=3D aat2870_i2c_probe,
> diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
> index 4659ac1db039..f0afb44271f8 100644
> --- a/drivers/mfd/ab3100-core.c
> +++ b/drivers/mfd/ab3100-core.c
> @@ -972,7 +972,6 @@ MODULE_DEVICE_TABLE(i2c, ab3100_id);
>  static struct i2c_driver ab3100_driver =3D {
>  	.driver =3D {
>  		.name	=3D "ab3100",
> -		.owner	=3D THIS_MODULE,
>  	},
>  	.id_table	=3D ab3100_id,
>  	.probe		=3D ab3100_probe,
> diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
> index f495b8b57dd7..ae88654595dc 100644
> --- a/drivers/mfd/adp5520.c
> +++ b/drivers/mfd/adp5520.c
> @@ -351,7 +351,6 @@ MODULE_DEVICE_TABLE(i2c, adp5520_id);
>  static struct i2c_driver adp5520_driver =3D {
>  	.driver =3D {
>  		.name	=3D "adp5520",
> -		.owner	=3D THIS_MODULE,
>  		.pm	=3D &adp5520_pm,
>  	},
>  	.probe		=3D adp5520_probe,
> diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
> index 920276f53326..cea1b409fa27 100644
> --- a/drivers/mfd/arizona-i2c.c
> +++ b/drivers/mfd/arizona-i2c.c
> @@ -105,7 +105,6 @@ MODULE_DEVICE_TABLE(i2c, arizona_i2c_id);
>  static struct i2c_driver arizona_i2c_driver =3D {
>  	.driver =3D {
>  		.name	=3D "arizona",
> -		.owner	=3D THIS_MODULE,
>  		.pm	=3D &arizona_pm_ops,
>  		.of_match_table	=3D of_match_ptr(arizona_of_match),
>  	},
> diff --git a/drivers/mfd/as3711.c b/drivers/mfd/as3711.c
> index d9706ede8d39..d001f7e238f5 100644
> --- a/drivers/mfd/as3711.c
> +++ b/drivers/mfd/as3711.c
> @@ -211,7 +211,6 @@ MODULE_DEVICE_TABLE(i2c, as3711_i2c_id);
>  static struct i2c_driver as3711_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "as3711",
> -		   .owner =3D THIS_MODULE,
>  		   .of_match_table =3D of_match_ptr(as3711_of_match),
>  	},
>  	.probe =3D as3711_i2c_probe,
> diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
> index 39fa554f13bb..924ea90494ae 100644
> --- a/drivers/mfd/as3722.c
> +++ b/drivers/mfd/as3722.c
> @@ -437,7 +437,6 @@ MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
>  static struct i2c_driver as3722_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "as3722",
> -		.owner =3D THIS_MODULE,
>  		.of_match_table =3D as3722_of_match,
>  	},
>  	.probe =3D as3722_i2c_probe,
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 6df91556faf3..8c2c3c4c9a56 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -613,7 +613,6 @@ static int axp20x_i2c_remove(struct i2c_client *i=
2c)
>  static struct i2c_driver axp20x_i2c_driver =3D {
>  	.driver =3D {
>  		.name	=3D "axp20x",
> -		.owner	=3D THIS_MODULE,
>  		.of_match_table	=3D of_match_ptr(axp20x_of_match),
>  		.acpi_match_table =3D ACPI_PTR(axp20x_acpi_match),
>  	},
> diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
> index e334de000e8c..da2af5b4f855 100644
> --- a/drivers/mfd/bcm590xx.c
> +++ b/drivers/mfd/bcm590xx.c
> @@ -117,7 +117,6 @@ MODULE_DEVICE_TABLE(i2c, bcm590xx_i2c_id);
>  static struct i2c_driver bcm590xx_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "bcm590xx",
> -		   .owner =3D THIS_MODULE,
>  		   .of_match_table =3D of_match_ptr(bcm590xx_of_match),
>  	},
>  	.probe =3D bcm590xx_i2c_probe,
> diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/mfd/cros_ec_i2c.c
> index b9a0963ca5c3..d06e4b46db80 100644
> --- a/drivers/mfd/cros_ec_i2c.c
> +++ b/drivers/mfd/cros_ec_i2c.c
> @@ -353,7 +353,6 @@ MODULE_DEVICE_TABLE(i2c, cros_ec_i2c_id);
>  static struct i2c_driver cros_ec_driver =3D {
>  	.driver	=3D {
>  		.name	=3D "cros-ec-i2c",
> -		.owner	=3D THIS_MODULE,
>  		.pm	=3D &cros_ec_i2c_pm_ops,
>  	},
>  	.probe		=3D cros_ec_i2c_probe,
> diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
> index e0a2e0ee603b..ef7fe2ae2fa4 100644
> --- a/drivers/mfd/da903x.c
> +++ b/drivers/mfd/da903x.c
> @@ -550,7 +550,6 @@ static int da903x_remove(struct i2c_client *clien=
t)
>  static struct i2c_driver da903x_driver =3D {
>  	.driver	=3D {
>  		.name	=3D "da903x",
> -		.owner	=3D THIS_MODULE,
>  	},
>  	.probe		=3D da903x_probe,
>  	.remove		=3D da903x_remove,
> diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
> index ec39287a245b..02887001e800 100644
> --- a/drivers/mfd/da9052-i2c.c
> +++ b/drivers/mfd/da9052-i2c.c
> @@ -195,7 +195,6 @@ static struct i2c_driver da9052_i2c_driver =3D {
>  	.id_table =3D da9052_i2c_id,
>  	.driver =3D {
>  		.name =3D "da9052",
> -		.owner =3D THIS_MODULE,
>  #ifdef CONFIG_OF
>  		.of_match_table =3D dialog_dt_ids,
>  #endif
> diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
> index d4d4c165eb95..b53e100f577c 100644
> --- a/drivers/mfd/da9055-i2c.c
> +++ b/drivers/mfd/da9055-i2c.c
> @@ -79,7 +79,6 @@ static struct i2c_driver da9055_i2c_driver =3D {
>  	.id_table =3D da9055_i2c_id,
>  	.driver =3D {
>  		.name =3D "da9055-pmic",
> -		.owner =3D THIS_MODULE,
>  		.of_match_table =3D of_match_ptr(da9055_of_match),
>  	},
>  };
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> index 6f3a7c0001f9..2d4e3e0f4e94 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -264,7 +264,6 @@ MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
>  static struct i2c_driver da9063_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "da9063",
> -		.owner =3D THIS_MODULE,
>  		.of_match_table =3D of_match_ptr(da9063_dt_ids),
>  	},
>  	.probe    =3D da9063_i2c_probe,
> diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_so=
c_pmic_core.c
> index 27e7552a29dd..ffbf6f6680b0 100644
> --- a/drivers/mfd/intel_soc_pmic_core.c
> +++ b/drivers/mfd/intel_soc_pmic_core.c
> @@ -157,7 +157,6 @@ MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_mat=
ch);
>  static struct i2c_driver intel_soc_pmic_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "intel_soc_pmic_i2c",
> -		.owner =3D THIS_MODULE,
>  		.pm =3D &intel_soc_pmic_pm_ops,
>  		.acpi_match_table =3D ACPI_PTR(intel_soc_pmic_acpi_match),
>  	},
> diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
> index d42fbb667d8c..643f3750e830 100644
> --- a/drivers/mfd/lm3533-core.c
> +++ b/drivers/mfd/lm3533-core.c
> @@ -640,7 +640,6 @@ MODULE_DEVICE_TABLE(i2c, lm3533_i2c_ids);
>  static struct i2c_driver lm3533_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "lm3533",
> -		   .owner =3D THIS_MODULE,
>  	},
>  	.id_table	=3D lm3533_i2c_ids,
>  	.probe		=3D lm3533_i2c_probe,
> diff --git a/drivers/mfd/lp3943.c b/drivers/mfd/lp3943.c
> index 335b930112b2..eecbb13de1bd 100644
> --- a/drivers/mfd/lp3943.c
> +++ b/drivers/mfd/lp3943.c
> @@ -154,7 +154,6 @@ static struct i2c_driver lp3943_driver =3D {
>  	.remove =3D lp3943_remove,
>  	.driver =3D {
>  		.name =3D "lp3943",
> -		.owner =3D THIS_MODULE,
>  		.of_match_table =3D of_match_ptr(lp3943_of_match),
>  	},
>  	.id_table =3D lp3943_ids,
> diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
> index a30bc15fe5ba..acf616559512 100644
> --- a/drivers/mfd/lp8788.c
> +++ b/drivers/mfd/lp8788.c
> @@ -221,7 +221,6 @@ MODULE_DEVICE_TABLE(i2c, lp8788_ids);
>  static struct i2c_driver lp8788_driver =3D {
>  	.driver =3D {
>  		.name =3D "lp8788",
> -		.owner =3D THIS_MODULE,
>  	},
>  	.probe =3D lp8788_probe,
>  	.remove =3D lp8788_remove,
> diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
> index 3bf8def82f1e..56e216dedc91 100644
> --- a/drivers/mfd/max14577.c
> +++ b/drivers/mfd/max14577.c
> @@ -532,7 +532,6 @@ static SIMPLE_DEV_PM_OPS(max14577_pm, max14577_su=
spend, max14577_resume);
>  static struct i2c_driver max14577_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "max14577",
> -		.owner =3D THIS_MODULE,
>  		.pm =3D &max14577_pm,
>  		.of_match_table =3D max14577_dt_match,
>  	},
> diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
> index 760d08d7923d..d19be64cd32b 100644
> --- a/drivers/mfd/max77686.c
> +++ b/drivers/mfd/max77686.c
> @@ -391,7 +391,6 @@ static SIMPLE_DEV_PM_OPS(max77686_pm, max77686_su=
spend, max77686_resume);
>  static struct i2c_driver max77686_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "max77686",
> -		   .owner =3D THIS_MODULE,
>  		   .pm =3D &max77686_pm,
>  		   .of_match_table =3D of_match_ptr(max77686_pmic_dt_match),
>  	},
> diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
> index cb14afa97e6f..229f21f10534 100644
> --- a/drivers/mfd/max77693.c
> +++ b/drivers/mfd/max77693.c
> @@ -372,7 +372,6 @@ static const struct of_device_id max77693_dt_matc=
h[] =3D {
>  static struct i2c_driver max77693_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "max77693",
> -		   .owner =3D THIS_MODULE,
>  		   .pm =3D &max77693_pm,
>  		   .of_match_table =3D of_match_ptr(max77693_dt_match),
>  	},
> diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
> index 232749c8813d..2974c8b1273b 100644
> --- a/drivers/mfd/max8907.c
> +++ b/drivers/mfd/max8907.c
> @@ -321,7 +321,6 @@ MODULE_DEVICE_TABLE(i2c, max8907_i2c_id);
>  static struct i2c_driver max8907_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "max8907",
> -		.owner =3D THIS_MODULE,
>  		.of_match_table =3D of_match_ptr(max8907_of_match),
>  	},
>  	.probe =3D max8907_i2c_probe,
> diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
> index c880c895c5a6..b0fe8103e401 100644
> --- a/drivers/mfd/max8925-i2c.c
> +++ b/drivers/mfd/max8925-i2c.c
> @@ -245,7 +245,6 @@ MODULE_DEVICE_TABLE(of, max8925_dt_ids);
>  static struct i2c_driver max8925_driver =3D {
>  	.driver	=3D {
>  		.name	=3D "max8925",
> -		.owner	=3D THIS_MODULE,
>  		.pm     =3D &max8925_pm_ops,
>  		.of_match_table =3D max8925_dt_ids,
>  	},
> diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
> index 595364ee178a..d3cfa9cf5c8f 100644
> --- a/drivers/mfd/max8997.c
> +++ b/drivers/mfd/max8997.c
> @@ -508,7 +508,6 @@ static const struct dev_pm_ops max8997_pm =3D {
>  static struct i2c_driver max8997_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "max8997",
> -		   .owner =3D THIS_MODULE,
>  		   .pm =3D &max8997_pm,
>  		   .of_match_table =3D of_match_ptr(max8997_pmic_dt_match),
>  	},
> diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
> index a37cb7444b6e..a7afe3bf27fc 100644
> --- a/drivers/mfd/max8998.c
> +++ b/drivers/mfd/max8998.c
> @@ -377,7 +377,6 @@ static const struct dev_pm_ops max8998_pm =3D {
>  static struct i2c_driver max8998_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "max8998",
> -		   .owner =3D THIS_MODULE,
>  		   .pm =3D &max8998_pm,
>  		   .of_match_table =3D of_match_ptr(max8998_dt_match),
>  	},
> diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
> index 68b844811566..67e4c9aa7d18 100644
> --- a/drivers/mfd/mc13xxx-i2c.c
> +++ b/drivers/mfd/mc13xxx-i2c.c
> @@ -96,7 +96,6 @@ static int mc13xxx_i2c_remove(struct i2c_client *cl=
ient)
>  static struct i2c_driver mc13xxx_i2c_driver =3D {
>  	.id_table =3D mc13xxx_i2c_device_id,
>  	.driver =3D {
> -		.owner =3D THIS_MODULE,
>  		.name =3D "mc13xxx",
>  		.of_match_table =3D mc13xxx_dt_ids,
>  	},
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index 28cb048f4760..8f8bacb67a15 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -719,7 +719,6 @@ static struct i2c_driver palmas_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "palmas",
>  		   .of_match_table =3D of_palmas_match_tbl,
> -		   .owner =3D THIS_MODULE,
>  	},
>  	.probe =3D palmas_i2c_probe,
>  	.remove =3D palmas_i2c_remove,
> diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
> index df276ad9f40b..e10f02f5d551 100644
> --- a/drivers/mfd/rc5t583.c
> +++ b/drivers/mfd/rc5t583.c
> @@ -322,7 +322,6 @@ MODULE_DEVICE_TABLE(i2c, rc5t583_i2c_id);
>  static struct i2c_driver rc5t583_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "rc5t583",
> -		   .owner =3D THIS_MODULE,
>  		   },
>  	.probe =3D rc5t583_i2c_probe,
>  	.remove =3D rc5t583_i2c_remove,
> diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
> index 2d64430c719b..d4c114abeb75 100644
> --- a/drivers/mfd/retu-mfd.c
> +++ b/drivers/mfd/retu-mfd.c
> @@ -311,7 +311,6 @@ MODULE_DEVICE_TABLE(i2c, retu_id);
>  static struct i2c_driver retu_driver =3D {
>  	.driver		=3D {
>  		.name =3D "retu-mfd",
> -		.owner =3D THIS_MODULE,
>  	},
>  	.probe		=3D retu_probe,
>  	.remove		=3D retu_remove,
> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
> index 4a69afb425ad..d206a3e8fe87 100644
> --- a/drivers/mfd/sec-core.c
> +++ b/drivers/mfd/sec-core.c
> @@ -486,7 +486,6 @@ MODULE_DEVICE_TABLE(i2c, sec_pmic_id);
>  static struct i2c_driver sec_pmic_driver =3D {
>  	.driver =3D {
>  		   .name =3D "sec_pmic",
> -		   .owner =3D THIS_MODULE,
>  		   .pm =3D &sec_pmic_pm_ops,
>  		   .of_match_table =3D of_match_ptr(sec_dt_match),
>  	},
> diff --git a/drivers/mfd/si476x-i2c.c b/drivers/mfd/si476x-i2c.c
> index e3deb466628b..fb4ce6d04c30 100644
> --- a/drivers/mfd/si476x-i2c.c
> +++ b/drivers/mfd/si476x-i2c.c
> @@ -873,7 +873,6 @@ MODULE_DEVICE_TABLE(i2c, si476x_id);
>  static struct i2c_driver si476x_core_driver =3D {
>  	.driver		=3D {
>  		.name	=3D "si476x-core",
> -		.owner  =3D THIS_MODULE,
>  	},
>  	.probe		=3D si476x_core_probe,
>  	.remove         =3D si476x_core_remove,
> diff --git a/drivers/mfd/smsc-ece1099.c b/drivers/mfd/smsc-ece1099.c
> index 03246880d484..a4c0df71c8b3 100644
> --- a/drivers/mfd/smsc-ece1099.c
> +++ b/drivers/mfd/smsc-ece1099.c
> @@ -98,7 +98,6 @@ MODULE_DEVICE_TABLE(i2c, smsc_i2c_id);
>  static struct i2c_driver smsc_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "smsc",
> -		   .owner =3D THIS_MODULE,
>  	},
>  	.probe =3D smsc_i2c_probe,
>  	.remove =3D smsc_i2c_remove,
> diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
> index 5c054031c3f8..2d420faa19b7 100644
> --- a/drivers/mfd/stmpe-i2c.c
> +++ b/drivers/mfd/stmpe-i2c.c
> @@ -112,7 +112,6 @@ MODULE_DEVICE_TABLE(i2c, stmpe_id);
>  static struct i2c_driver stmpe_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "stmpe-i2c",
> -		.owner =3D THIS_MODULE,
>  #ifdef CONFIG_PM
>  		.pm =3D &stmpe_dev_pm_ops,
>  #endif
> diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
> index 96d420dfc15d..27e157908ce0 100644
> --- a/drivers/mfd/tc3589x.c
> +++ b/drivers/mfd/tc3589x.c
> @@ -492,7 +492,6 @@ MODULE_DEVICE_TABLE(i2c, tc3589x_id);
>  static struct i2c_driver tc3589x_driver =3D {
>  	.driver =3D {
>  		.name	=3D "tc3589x",
> -		.owner	=3D THIS_MODULE,
>  		.pm	=3D &tc3589x_dev_pm_ops,
>  		.of_match_table =3D of_match_ptr(tc3589x_match),
>  	},
> diff --git a/drivers/mfd/tps6507x.c b/drivers/mfd/tps6507x.c
> index a2e1990c9de7..1ab3dd6c8adf 100644
> --- a/drivers/mfd/tps6507x.c
> +++ b/drivers/mfd/tps6507x.c
> @@ -129,7 +129,6 @@ MODULE_DEVICE_TABLE(of, tps6507x_of_match);
>  static struct i2c_driver tps6507x_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "tps6507x",
> -		   .owner =3D THIS_MODULE,
>  		   .of_match_table =3D of_match_ptr(tps6507x_of_match),
>  	},
>  	.probe =3D tps6507x_i2c_probe,
> diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
> index 14b62e11aff4..f88085ad9772 100644
> --- a/drivers/mfd/tps65090.c
> +++ b/drivers/mfd/tps65090.c
> @@ -259,7 +259,6 @@ MODULE_DEVICE_TABLE(i2c, tps65090_id_table);
>  static struct i2c_driver tps65090_driver =3D {
>  	.driver	=3D {
>  		.name	=3D "tps65090",
> -		.owner	=3D THIS_MODULE,
>  		.of_match_table =3D of_match_ptr(tps65090_of_match),
>  	},
>  	.probe		=3D tps65090_i2c_probe,
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 7d1cfc1d3ce0..bc455feb42be 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -248,7 +248,6 @@ MODULE_DEVICE_TABLE(i2c, tps65217_id_table);
>  static struct i2c_driver tps65217_driver =3D {
>  	.driver		=3D {
>  		.name	=3D "tps65217",
> -		.owner	=3D THIS_MODULE,
>  		.of_match_table =3D tps65217_of_match,
>  	},
>  	.id_table	=3D tps65217_id_table,
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 7af11a8b9753..cb38d725250f 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -280,7 +280,6 @@ MODULE_DEVICE_TABLE(i2c, tps65218_id_table);
>  static struct i2c_driver tps65218_driver =3D {
>  	.driver		=3D {
>  		.name	=3D "tps65218",
> -		.owner	=3D THIS_MODULE,
>  		.of_match_table =3D of_tps65218_match_table,
>  	},
>  	.probe		=3D tps65218_probe,
> diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
> index ae08b290cece..4a87c1fe3495 100644
> --- a/drivers/mfd/tps6586x.c
> +++ b/drivers/mfd/tps6586x.c
> @@ -610,7 +610,6 @@ MODULE_DEVICE_TABLE(i2c, tps6586x_id_table);
>  static struct i2c_driver tps6586x_driver =3D {
>  	.driver	=3D {
>  		.name	=3D "tps6586x",
> -		.owner	=3D THIS_MODULE,
>  		.of_match_table =3D of_match_ptr(tps6586x_of_match),
>  	},
>  	.probe		=3D tps6586x_i2c_probe,
> diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
> index 7612d89850dd..f7ab115483a9 100644
> --- a/drivers/mfd/tps65910.c
> +++ b/drivers/mfd/tps65910.c
> @@ -544,7 +544,6 @@ MODULE_DEVICE_TABLE(i2c, tps65910_i2c_id);
>  static struct i2c_driver tps65910_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "tps65910",
> -		   .owner =3D THIS_MODULE,
>  		   .of_match_table =3D of_match_ptr(tps65910_of_match),
>  	},
>  	.probe =3D tps65910_i2c_probe,
> diff --git a/drivers/mfd/tps65912-i2c.c b/drivers/mfd/tps65912-i2c.c
> index 6a6343ee95fe..7e55640b3ed5 100644
> --- a/drivers/mfd/tps65912-i2c.c
> +++ b/drivers/mfd/tps65912-i2c.c
> @@ -109,7 +109,6 @@ MODULE_DEVICE_TABLE(i2c, tps65912_i2c_id);
>  static struct i2c_driver tps65912_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "tps65912",
> -		   .owner =3D THIS_MODULE,
>  	},
>  	.probe =3D tps65912_i2c_probe,
>  	.remove =3D tps65912_i2c_remove,
> diff --git a/drivers/mfd/tps80031.c b/drivers/mfd/tps80031.c
> index ed6c5b0956e2..0812df3b0d47 100644
> --- a/drivers/mfd/tps80031.c
> +++ b/drivers/mfd/tps80031.c
> @@ -549,7 +549,6 @@ MODULE_DEVICE_TABLE(i2c, tps80031_id_table);
>  static struct i2c_driver tps80031_driver =3D {
>  	.driver	=3D {
>  		.name	=3D "tps80031",
> -		.owner	=3D THIS_MODULE,
>  	},
>  	.probe		=3D tps80031_probe,
>  	.remove		=3D tps80031_remove,
> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index c5265c1262c5..fbc9b6eb20a2 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -801,7 +801,6 @@ MODULE_DEVICE_TABLE(i2c, twl6040_i2c_id);
>  static struct i2c_driver twl6040_driver =3D {
>  	.driver =3D {
>  		.name =3D "twl6040",
> -		.owner =3D THIS_MODULE,
>  	},
>  	.probe		=3D twl6040_probe,
>  	.remove		=3D twl6040_remove,
> diff --git a/drivers/mfd/wm831x-i2c.c b/drivers/mfd/wm831x-i2c.c
> index a4cbefe5430f..824bcbaa9624 100644
> --- a/drivers/mfd/wm831x-i2c.c
> +++ b/drivers/mfd/wm831x-i2c.c
> @@ -93,7 +93,6 @@ static const struct dev_pm_ops wm831x_pm_ops =3D {
>  static struct i2c_driver wm831x_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "wm831x",
> -		.owner =3D THIS_MODULE,
>  		.pm =3D &wm831x_pm_ops,
>  	},
>  	.probe =3D wm831x_i2c_probe,
> diff --git a/drivers/mfd/wm8350-i2c.c b/drivers/mfd/wm8350-i2c.c
> index 6a16a8a6f9fa..9358f03b7938 100644
> --- a/drivers/mfd/wm8350-i2c.c
> +++ b/drivers/mfd/wm8350-i2c.c
> @@ -69,7 +69,6 @@ MODULE_DEVICE_TABLE(i2c, wm8350_i2c_id);
>  static struct i2c_driver wm8350_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "wm8350",
> -		   .owner =3D THIS_MODULE,
>  	},
>  	.probe =3D wm8350_i2c_probe,
>  	.remove =3D wm8350_i2c_remove,
> diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
> index c6fb5d16ca09..3bd44a45c378 100644
> --- a/drivers/mfd/wm8400-core.c
> +++ b/drivers/mfd/wm8400-core.c
> @@ -194,7 +194,6 @@ MODULE_DEVICE_TABLE(i2c, wm8400_i2c_id);
>  static struct i2c_driver wm8400_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "WM8400",
> -		.owner =3D THIS_MODULE,
>  	},
>  	.probe    =3D wm8400_i2c_probe,
>  	.remove   =3D wm8400_i2c_remove,
> diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
> index 53ae5af5d6e4..213da3416778 100644
> --- a/drivers/mfd/wm8994-core.c
> +++ b/drivers/mfd/wm8994-core.c
> @@ -677,7 +677,6 @@ static const struct dev_pm_ops wm8994_pm_ops =3D =
{
>  static struct i2c_driver wm8994_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "wm8994",
> -		.owner =3D THIS_MODULE,
>  		.pm =3D &wm8994_pm_ops,
>  		.of_match_table =3D of_match_ptr(wm8994_of_match),
>  	},

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
