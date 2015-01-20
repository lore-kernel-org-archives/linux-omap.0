From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 13/14] mfd: twl-core: Constify struct regmap_config and
 reg_default array
Date: Tue, 20 Jan 2015 11:59:59 +0000
Message-ID: <20150120115959.GY13701@x1>
References: <1420448493-9355-1-git-send-email-k.kozlowski@samsung.com>
 <1420448493-9355-13-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420448493-9355-13-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 05 Jan 2015, Krzysztof Kozlowski wrote:

> The regmap_config struct may be const because it is not modified by t=
he
> driver and regmap_init() accepts pointer to const. Make array of
> struct reg_default const as well.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> ---
>  drivers/mfd/twl-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied with Tony's Ack, thanks.

> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index db11b4f40611..489674a2497e 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -207,7 +207,7 @@ static struct twl_mapping twl4030_map[] =3D {
>  	{ 2, TWL5031_BASEADD_INTERRUPTS },
>  };
> =20
> -static struct reg_default twl4030_49_defaults[] =3D {
> +static const struct reg_default twl4030_49_defaults[] =3D {
>  	/* Audio Registers */
>  	{ 0x01, 0x00}, /* CODEC_MODE	*/
>  	{ 0x02, 0x00}, /* OPTION	*/
> @@ -306,7 +306,7 @@ static const struct regmap_access_table twl4030_4=
9_volatile_table =3D {
>  	.n_yes_ranges =3D ARRAY_SIZE(twl4030_49_volatile_ranges),
>  };
> =20
> -static struct regmap_config twl4030_regmap_config[4] =3D {
> +static const struct regmap_config twl4030_regmap_config[4] =3D {
>  	{
>  		/* Address 0x48 */
>  		.reg_bits =3D 8,
> @@ -369,7 +369,7 @@ static struct twl_mapping twl6030_map[] =3D {
>  	{ 1, TWL6030_BASEADD_GASGAUGE },
>  };
> =20
> -static struct regmap_config twl6030_regmap_config[3] =3D {
> +static const struct regmap_config twl6030_regmap_config[3] =3D {
>  	{
>  		/* Address 0x48 */
>  		.reg_bits =3D 8,
> @@ -1087,7 +1087,7 @@ twl_probe(struct i2c_client *client, const stru=
ct i2c_device_id *id)
>  	struct twl4030_platform_data	*pdata =3D dev_get_platdata(&client->d=
ev);
>  	struct device_node		*node =3D client->dev.of_node;
>  	struct platform_device		*pdev;
> -	struct regmap_config		*twl_regmap_config;
> +	const struct regmap_config	*twl_regmap_config;
>  	int				irq_base =3D 0;
>  	int				status;
>  	unsigned			i, num_slaves;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
