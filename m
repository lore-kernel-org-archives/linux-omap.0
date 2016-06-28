From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v4 6/6] regulator: tps65218: Remove all the compatibles
Date: Tue, 28 Jun 2016 15:56:20 +0530
Message-ID: <577250CC.8020404@ti.com>
References: <1467105729-28249-1-git-send-email-j-keerthy@ti.com>
 <1467105729-28249-7-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467105729-28249-7-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>, dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org, broonie@kernel.org, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 28 June 2016 02:52 PM, Keerthy wrote:
> Remove all the individual compatibles for all the regulators
> and introduce id_table and update the driver accordingly
> to parse device tree nodes using the regulator framework.

Mark,

I just now pulled the linux-next and some conflicts arise due to:
https://lkml.org/lkml/2016/6/27/482

I am in the process of re-basing and testing. Only this patch needs to 
wait. So shall i send an updated version of this patch alone?

Regards,
Keerthy

>
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   drivers/regulator/tps65218-regulator.c | 131 +++++++++++----------------------
>   1 file changed, 45 insertions(+), 86 deletions(-)
>
> diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
> index 679ab2f..8106cc4 100644
> --- a/drivers/regulator/tps65218-regulator.c
> +++ b/drivers/regulator/tps65218-regulator.c
> @@ -31,10 +31,11 @@
>   enum tps65218_regulators { DCDC1, DCDC2, DCDC3, DCDC4,
>   			   DCDC5, DCDC6, LDO1, LS3 };
>
> -#define TPS65218_REGULATOR(_name, _id, _type, _ops, _n, _vr, _vm, _er, _em, \
> -			    _cr, _cm, _lr, _nlr, _delay, _fuv)		\
> +#define TPS65218_REGULATOR(_name, _of,  _id, _type, _ops, _n, _vr, _vm, _er,\
> +			   _em,  _cr, _cm, _lr, _nlr, _delay, _fuv)	\
>   	{							\
>   		.name			= _name,		\
> +		.of_match		= _of,			\
>   		.id			= _id,			\
>   		.ops			= &_ops,		\
>   		.n_voltages		= _n,			\
> @@ -53,14 +54,6 @@ enum tps65218_regulators { DCDC1, DCDC2, DCDC3, DCDC4,
>   		.fixed_uV		= _fuv			\
>   	}							\
>
> -#define TPS65218_INFO(_id, _nm, _min, _max)	\
> -	[_id] = {					\
> -		.id		= _id,			\
> -		.name		= _nm,			\
> -		.min_uV		= _min,			\
> -		.max_uV		= _max,			\
> -	}
> -
>   static const struct regulator_linear_range dcdc1_dcdc2_ranges[] = {
>   	REGULATOR_LINEAR_RANGE(850000, 0x0, 0x32, 10000),
>   	REGULATOR_LINEAR_RANGE(1375000, 0x33, 0x3f, 25000),
> @@ -76,36 +69,6 @@ static const struct regulator_linear_range dcdc4_ranges[] = {
>   	REGULATOR_LINEAR_RANGE(1600000, 0x10, 0x34, 50000),
>   };
>
> -static struct tps_info tps65218_pmic_regs[] = {
> -	TPS65218_INFO(DCDC1, "DCDC1", 850000, 1675000),
> -	TPS65218_INFO(DCDC2, "DCDC2", 850000, 1675000),
> -	TPS65218_INFO(DCDC3, "DCDC3", 900000, 3400000),
> -	TPS65218_INFO(DCDC4, "DCDC4", 1175000, 3400000),
> -	TPS65218_INFO(DCDC5, "DCDC5", 1000000, 1000000),
> -	TPS65218_INFO(DCDC6, "DCDC6", 1800000, 1800000),
> -	TPS65218_INFO(LDO1, "LDO1", 900000, 3400000),
> -	TPS65218_INFO(LS3, "LS3", -1, -1),
> -};
> -
> -#define TPS65218_OF_MATCH(comp, label) \
> -	{ \
> -		.compatible = comp, \
> -		.data = &label, \
> -	}
> -
> -static const struct of_device_id tps65218_of_match[] = {
> -	TPS65218_OF_MATCH("ti,tps65218-dcdc1", tps65218_pmic_regs[DCDC1]),
> -	TPS65218_OF_MATCH("ti,tps65218-dcdc2", tps65218_pmic_regs[DCDC2]),
> -	TPS65218_OF_MATCH("ti,tps65218-dcdc3", tps65218_pmic_regs[DCDC3]),
> -	TPS65218_OF_MATCH("ti,tps65218-dcdc4", tps65218_pmic_regs[DCDC4]),
> -	TPS65218_OF_MATCH("ti,tps65218-dcdc5", tps65218_pmic_regs[DCDC5]),
> -	TPS65218_OF_MATCH("ti,tps65218-dcdc6", tps65218_pmic_regs[DCDC6]),
> -	TPS65218_OF_MATCH("ti,tps65218-ldo1", tps65218_pmic_regs[LDO1]),
> -	TPS65218_OF_MATCH("ti,tps65218-ls3", tps65218_pmic_regs[LS3]),
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, tps65218_of_match);
> -
>   static int tps65218_pmic_set_voltage_sel(struct regulator_dev *dev,
>   					 unsigned selector)
>   {
> @@ -251,92 +214,88 @@ static struct regulator_ops tps65218_dcdc56_pmic_ops = {
>   };
>
>   static const struct regulator_desc regulators[] = {
> -	TPS65218_REGULATOR("DCDC1", TPS65218_DCDC_1, REGULATOR_VOLTAGE,
> -			   tps65218_dcdc12_ops, 64, TPS65218_REG_CONTROL_DCDC1,
> +	TPS65218_REGULATOR("DCDC1", "regulator-dcdc1", TPS65218_DCDC_1,
> +			   REGULATOR_VOLTAGE, tps65218_dcdc12_ops, 64,
> +			   TPS65218_REG_CONTROL_DCDC1,
>   			   TPS65218_CONTROL_DCDC1_MASK, TPS65218_REG_ENABLE1,
>   			   TPS65218_ENABLE1_DC1_EN, 0, 0, dcdc1_dcdc2_ranges,
>   			   2, 4000, 0),
> -	TPS65218_REGULATOR("DCDC2", TPS65218_DCDC_2, REGULATOR_VOLTAGE,
> -			   tps65218_dcdc12_ops, 64, TPS65218_REG_CONTROL_DCDC2,
> +	TPS65218_REGULATOR("DCDC2", "regulator-dcdc2", TPS65218_DCDC_2,
> +			   REGULATOR_VOLTAGE, tps65218_dcdc12_ops, 64,
> +			   TPS65218_REG_CONTROL_DCDC2,
>   			   TPS65218_CONTROL_DCDC2_MASK, TPS65218_REG_ENABLE1,
>   			   TPS65218_ENABLE1_DC2_EN, 0, 0, dcdc1_dcdc2_ranges,
>   			   2, 4000, 0),
> -	TPS65218_REGULATOR("DCDC3", TPS65218_DCDC_3, REGULATOR_VOLTAGE,
> -			   tps65218_ldo1_dcdc34_ops, 64,
> +	TPS65218_REGULATOR("DCDC3", "regulator-dcdc3", TPS65218_DCDC_3,
> +			   REGULATOR_VOLTAGE, tps65218_ldo1_dcdc34_ops, 64,
>   			   TPS65218_REG_CONTROL_DCDC3,
>   			   TPS65218_CONTROL_DCDC3_MASK, TPS65218_REG_ENABLE1,
>   			   TPS65218_ENABLE1_DC3_EN, 0, 0, ldo1_dcdc3_ranges, 2,
>   			   0, 0),
> -	TPS65218_REGULATOR("DCDC4", TPS65218_DCDC_4, REGULATOR_VOLTAGE,
> -			   tps65218_ldo1_dcdc34_ops, 53,
> +	TPS65218_REGULATOR("DCDC4", "regulator-dcdc4", TPS65218_DCDC_4,
> +			   REGULATOR_VOLTAGE, tps65218_ldo1_dcdc34_ops, 53,
>   			   TPS65218_REG_CONTROL_DCDC4,
>   			   TPS65218_CONTROL_DCDC4_MASK, TPS65218_REG_ENABLE1,
>   			   TPS65218_ENABLE1_DC4_EN, 0, 0, dcdc4_ranges, 2,
>   			   0, 0),
> -	TPS65218_REGULATOR("DCDC5", TPS65218_DCDC_5, REGULATOR_VOLTAGE,
> -			   tps65218_dcdc56_pmic_ops, 1, -1, -1,
> -			   TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC5_EN, 0, 0,
> -			   NULL, 0, 0, 1000000),
> -	TPS65218_REGULATOR("DCDC6", TPS65218_DCDC_6, REGULATOR_VOLTAGE,
> -			   tps65218_dcdc56_pmic_ops, 1, -1, -1,
> -			   TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC6_EN, 0, 0,
> -			   NULL, 0, 0, 1800000),
> -	TPS65218_REGULATOR("LDO1", TPS65218_LDO_1, REGULATOR_VOLTAGE,
> -			   tps65218_ldo1_dcdc34_ops, 64,
> +	TPS65218_REGULATOR("DCDC5", "regulator-dcdc5", TPS65218_DCDC_5,
> +			   REGULATOR_VOLTAGE, tps65218_dcdc56_pmic_ops, 1, -1,
> +			   -1, TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC5_EN, 0,
> +			   0, NULL, 0, 0, 1000000),
> +	TPS65218_REGULATOR("DCDC6", "regulator-dcdc6", TPS65218_DCDC_6,
> +			   REGULATOR_VOLTAGE, tps65218_dcdc56_pmic_ops, 1, -1,
> +			   -1, TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC6_EN, 0,
> +			   0, NULL, 0, 0, 1800000),
> +	TPS65218_REGULATOR("LDO1", "regulator-ldo1", TPS65218_LDO_1,
> +			   REGULATOR_VOLTAGE, tps65218_ldo1_dcdc34_ops, 64,
>   			   TPS65218_REG_CONTROL_LDO1,
>   			   TPS65218_CONTROL_LDO1_MASK, TPS65218_REG_ENABLE2,
>   			   TPS65218_ENABLE2_LDO1_EN, 0, 0, ldo1_dcdc3_ranges,
>   			   2, 0, 0),
> -	TPS65218_REGULATOR("LS3", TPS65218_LS_3, REGULATOR_CURRENT,
> -			   tps65218_ls3_ops, 0, 0, 0, TPS65218_REG_ENABLE2,
> -			   TPS65218_ENABLE2_LS3_EN, TPS65218_REG_CONFIG2,
> -			   TPS65218_CONFIG2_LS3ILIM_MASK, NULL, 0, 0, 0),
> +	TPS65218_REGULATOR("LS3", "regulator-ls3", TPS65218_LS_3,
> +			   REGULATOR_CURRENT, tps65218_ls3_ops, 0, 0, 0,
> +			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS3_EN,
> +			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS3ILIM_MASK,
> +			   NULL, 0, 0, 0),
>   };
>
>   static int tps65218_regulator_probe(struct platform_device *pdev)
>   {
>   	struct tps65218 *tps = dev_get_drvdata(pdev->dev.parent);
> -	struct regulator_init_data *init_data;
> -	const struct tps_info	*template;
>   	struct regulator_dev *rdev;
> -	const struct of_device_id	*match;
>   	struct regulator_config config = { };
> -	int id;
> -
> -	match = of_match_device(tps65218_of_match, &pdev->dev);
> -	if (!match)
> -		return -ENODEV;
> -
> -	template = match->data;
> -	id = template->id;
> -	init_data = of_get_regulator_init_data(&pdev->dev, pdev->dev.of_node,
> -					       &regulators[id]);
> +	int i;
>
> -	platform_set_drvdata(pdev, tps);
> -
> -	tps->info[id] = &tps65218_pmic_regs[id];
>   	config.dev = &pdev->dev;
> -	config.init_data = init_data;
> +	config.dev->of_node = tps->dev->of_node;
>   	config.driver_data = tps;
>   	config.regmap = tps->regmap;
> -	config.of_node = pdev->dev.of_node;
>
> -	rdev = devm_regulator_register(&pdev->dev, &regulators[id], &config);
> -	if (IS_ERR(rdev)) {
> -		dev_err(tps->dev, "failed to register %s regulator\n",
> -			pdev->name);
> -		return PTR_ERR(rdev);
> +	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
> +		rdev = devm_regulator_register(&pdev->dev, &regulators[i],
> +					       &config);
> +		if (IS_ERR(rdev)) {
> +			dev_err(tps->dev, "failed to register %s regulator\n",
> +				pdev->name);
> +			return PTR_ERR(rdev);
> +		}
>   	}
>
>   	return 0;
>   }
>
> +static const struct platform_device_id tps65218_regulator_id_table[] = {
> +	{ "tps65218-regulator", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, tps65218_regulator_id_table);
> +
>   static struct platform_driver tps65218_regulator_driver = {
>   	.driver = {
>   		.name = "tps65218-pmic",
> -		.of_match_table = tps65218_of_match,
>   	},
>   	.probe = tps65218_regulator_probe,
> +	.id_table = tps65218_regulator_id_table,
>   };
>
>   module_platform_driver(tps65218_regulator_driver);
>
