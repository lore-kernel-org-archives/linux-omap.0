From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] regulator: lp87565: Add support for lp87565 PMIC
 regulators
Date: Fri, 19 May 2017 10:53:07 -0500
Message-ID: <d7637719-a3f8-b711-f773-75ec5da8880b@ti.com>
References: <1495197739-17446-1-git-send-email-j-keerthy@ti.com>
 <1495197739-17446-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495197739-17446-3-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: t-kristo-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 05/19/2017 07:42 AM, Keerthy wrote:
> The regulators set consists of 4 BUCKs. The output
> voltages are configurable and are meant to supply power to the
> main processor and other components. The ramp delay is configurable
> for all BUCKs. The BUCKs can be configured in single phase or
> multiphase modes.
> 
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/regulator/Kconfig             |   8 ++
>  drivers/regulator/Makefile            |   1 +
>  drivers/regulator/lp87565-regulator.c | 244 ++++++++++++++++++++++++++++++++++
>  3 files changed, 253 insertions(+)
>  create mode 100644 drivers/regulator/lp87565-regulator.c
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 48db87d..7c34ff8 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -365,6 +365,14 @@ config REGULATOR_LP8755
>  	  chip contains six step-down DC/DC converters which can support
>  	  9 mode multiphase configuration.
>  
> +config REGULATOR_LP87565
> +	tristate "TI LP87565 Power regulators"
> +	depends on MFD_TI_LP87565 && OF
> +	help
> +	  This driver supports LP87565 voltage regulator chips. LP87565
> +	  provides four step-down converters. It supports software based
> +	  voltage control for different voltage domains
> +
>  config REGULATOR_LP8788
>  	tristate "TI LP8788 Power Regulators"
>  	depends on MFD_LP8788
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index dc3503f..fee6b8c 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
>  obj-$(CONFIG_REGULATOR_LP3972) += lp3972.o
>  obj-$(CONFIG_REGULATOR_LP872X) += lp872x.o
>  obj-$(CONFIG_REGULATOR_LP873X) += lp873x-regulator.o
> +obj-$(CONFIG_REGULATOR_LP87565) += lp87565-regulator.o
>  obj-$(CONFIG_REGULATOR_LP8788) += lp8788-buck.o
>  obj-$(CONFIG_REGULATOR_LP8788) += lp8788-ldo.o
>  obj-$(CONFIG_REGULATOR_LP8755) += lp8755.o
> diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
> new file mode 100644
> index 0000000..5849cf3
> --- /dev/null
> +++ b/drivers/regulator/lp87565-regulator.c
> @@ -0,0 +1,244 @@
> +/*
> + * Regulator driver for LP87565 PMIC
> + *
> + * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether expressed or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License version 2 for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/mfd/lp87565.h>
> +
> +#define LP87565_REGULATOR(_name, _id, _of, _ops, _n, _vr, _vm, _er, _em, \
> +			 _delay, _lr, _cr)				\
> +	[_id] = {							\
> +		.desc = {						\
> +			.name			= _name,		\
> +			.supply_name		= _of "-in",		\
> +			.id			= _id,			\
> +			.of_match		= of_match_ptr(_of),	\
> +			.regulators_node	= of_match_ptr("regulators"),\
> +			.ops			= &_ops,		\
> +			.n_voltages		= _n,			\
> +			.type			= REGULATOR_VOLTAGE,	\
> +			.owner			= THIS_MODULE,		\
> +			.vsel_reg		= _vr,			\
> +			.vsel_mask		= _vm,			\
> +			.enable_reg		= _er,			\
> +			.enable_mask		= _em,			\
> +			.ramp_delay		= _delay,		\
> +			.linear_ranges		= _lr,			\
> +			.n_linear_ranges	= ARRAY_SIZE(_lr),	\
> +		},							\
> +		.ctrl2_reg = _cr,					\
> +	}
> +
> +#define LP87565_Q1_MIN_IDX	LP87565_BUCK_10

Unused?

> +
> +struct lp87565_regulator {
> +	struct regulator_desc desc;
> +	unsigned int ctrl2_reg;
> +};
> +
> +static const struct lp87565_regulator regulators[];
> +
> +static const struct regulator_linear_range buck0_1_2_3_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x17, 10000),
> +	REGULATOR_LINEAR_RANGE(735000, 0x18, 0x9d, 5000),
> +	REGULATOR_LINEAR_RANGE(1420000, 0x9e, 0xff, 20000),
> +};
> +
> +static unsigned int lp87565_buck_ramp_delay[] = {
> +	30000, 15000, 10000, 7500, 3800, 1900, 940, 470
> +};
> +
> +/* LP87565 BUCK current limit */
> +static const unsigned int lp87565_buck_uA[] = {
> +	1500000, 2000000, 2500000, 3000000, 3500000, 4000000, 4500000, 5000000,
> +};
> +
> +static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
> +				       int ramp_delay)
> +{
> +	int id = rdev_get_id(rdev);
> +	struct lp87565 *lp87565 = rdev_get_drvdata(rdev);
> +	unsigned int reg;
> +	int ret;
> +
> +	if (ramp_delay <= 470)
> +		reg = 7;
> +	else if (ramp_delay <= 940)
> +		reg = 6;
> +	else if (ramp_delay <= 1900)
> +		reg = 5;
> +	else if (ramp_delay <= 3800)
> +		reg = 4;
> +	else if (ramp_delay <= 7500)
> +		reg = 3;
> +	else if (ramp_delay <= 10000)
> +		reg = 2;
> +	else if (ramp_delay <= 15000)
> +		reg = 1;
> +	else
> +		reg = 0;
> +
> +	ret = regmap_update_bits(lp87565->regmap, regulators[id].ctrl2_reg,
> +				 LP87565_BUCK_CTRL_2_SLEW_RATE,
> +				 reg << __ffs(LP87565_BUCK_CTRL_2_SLEW_RATE));
> +	if (ret) {
> +		dev_err(lp87565->dev, "SLEW RATE write failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	rdev->constraints->ramp_delay = lp87565_buck_ramp_delay[reg];
> +
> +	return 0;
> +}
> +
> +static int lp87565_buck_set_current_limit(struct regulator_dev *rdev,
> +					  int min_uA, int max_uA)
> +{
> +	int id = rdev_get_id(rdev);
> +	struct lp87565 *lp87565 = rdev_get_drvdata(rdev);
> +	int i;
> +
> +	for (i = ARRAY_SIZE(lp87565_buck_uA) - 1; i >= 0; i--) {
> +		if (lp87565_buck_uA[i] >= min_uA &&
> +		    lp87565_buck_uA[i] <= max_uA)
> +			return regmap_update_bits(lp87565->regmap,
> +						  regulators[id].ctrl2_reg,
> +						  LP87565_BUCK_CTRL_2_ILIM,
> +						  i << __ffs(LP87565_BUCK_CTRL_2_ILIM));
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int lp87565_buck_get_current_limit(struct regulator_dev *rdev)
> +{
> +	int id = rdev_get_id(rdev);
> +	struct lp87565 *lp87565 = rdev_get_drvdata(rdev);
> +	int ret;
> +	unsigned int val;
> +
> +	ret = regmap_read(lp87565->regmap, regulators[id].ctrl2_reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	val = (val & LP87565_BUCK_CTRL_2_ILIM) >>
> +	       __ffs(LP87565_BUCK_CTRL_2_ILIM);
> +
> +	return (val < ARRAY_SIZE(lp87565_buck_uA)) ?
> +			lp87565_buck_uA[val] : -EINVAL;
> +}
> +
> +/* Operations permitted on BUCK0, BUCK1 */
> +static struct regulator_ops lp87565_buck_ops = {
> +	.is_enabled		= regulator_is_enabled_regmap,
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> +	.list_voltage		= regulator_list_voltage_linear_range,
> +	.map_voltage		= regulator_map_voltage_linear_range,
> +	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
> +	.set_ramp_delay		= lp87565_buck_set_ramp_delay,
> +	.set_current_limit	= lp87565_buck_set_current_limit,
> +	.get_current_limit	= lp87565_buck_get_current_limit,
> +};
> +
> +static const struct lp87565_regulator regulators[] = {
> +	LP87565_REGULATOR("BUCK0", LP87565_BUCK_0, "buck0", lp87565_buck_ops,
> +			  256, LP87565_REG_BUCK0_VOUT, LP87565_BUCK_VSET,
> +			  LP87565_REG_BUCK0_CTRL_1,
> +			  LP87565_BUCK_CTRL_1_EN, 3800,
> +			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
> +	LP87565_REGULATOR("BUCK1", LP87565_BUCK_1, "buck1", lp87565_buck_ops,
> +			  256, LP87565_REG_BUCK1_VOUT, LP87565_BUCK_VSET,
> +			  LP87565_REG_BUCK1_CTRL_1,
> +			  LP87565_BUCK_CTRL_1_EN, 3800,
> +			  buck0_1_2_3_ranges, LP87565_REG_BUCK1_CTRL_2),
> +	LP87565_REGULATOR("BUCK2", LP87565_BUCK_2, "buck2", lp87565_buck_ops,
> +			  256, LP87565_REG_BUCK2_VOUT, LP87565_BUCK_VSET,
> +			  LP87565_REG_BUCK2_CTRL_1,
> +			  LP87565_BUCK_CTRL_1_EN, 3800,
> +			  buck0_1_2_3_ranges, LP87565_REG_BUCK2_CTRL_2),
> +	LP87565_REGULATOR("BUCK3", LP87565_BUCK_3, "buck3", lp87565_buck_ops,
> +			  256, LP87565_REG_BUCK3_VOUT, LP87565_BUCK_VSET,
> +			  LP87565_REG_BUCK3_CTRL_1,
> +			  LP87565_BUCK_CTRL_1_EN, 3800,
> +			  buck0_1_2_3_ranges, LP87565_REG_BUCK3_CTRL_2),
> +	LP87565_REGULATOR("BUCK10", LP87565_BUCK_10, "buck10", lp87565_buck_ops,
> +			  256, LP87565_REG_BUCK0_VOUT, LP87565_BUCK_VSET,
> +			  LP87565_REG_BUCK0_CTRL_1,
> +			  LP87565_BUCK_CTRL_1_EN, 3800,
> +			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
> +	LP87565_REGULATOR("BUCK23", LP87565_BUCK_23, "buck23", lp87565_buck_ops,
> +			  256, LP87565_REG_BUCK2_VOUT, LP87565_BUCK_VSET,
> +			  LP87565_REG_BUCK2_CTRL_1,
> +			  LP87565_BUCK_CTRL_1_EN, 3800,
> +			  buck0_1_2_3_ranges, LP87565_REG_BUCK2_CTRL_2),
> +};
> +
> +static int lp87565_regulator_probe(struct platform_device *pdev)
> +{
> +	struct lp87565 *lp87565 = dev_get_drvdata(pdev->dev.parent);
> +	struct regulator_config config = { };
> +	struct regulator_dev *rdev;
> +	int i, min_idx = LP87565_BUCK_1, max_idx = LP87565_BUCK_3;
> +
> +	platform_set_drvdata(pdev, lp87565);
> +
> +	config.dev = &pdev->dev;
> +	config.dev->of_node = lp87565->dev->of_node;
> +	config.driver_data = lp87565;
> +	config.regmap = lp87565->regmap;
> +
> +	if (lp87565->dev_type == LP87565_DEVICE_TYPE_LP87565_Q1) {
> +		min_idx = LP87565_BUCK_10;
> +		max_idx = LP87565_BUCK_23;
> +	}
> +
> +	for (i = min_idx; i <= max_idx; i++) {
> +		rdev = devm_regulator_register(&pdev->dev, &regulators[i].desc,
> +					       &config);
> +		if (IS_ERR(rdev)) {
> +			dev_err(lp87565->dev, "failed to register %s regulator\n",
> +				pdev->name);
> +			return PTR_ERR(rdev);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id lp87565_regulator_id_table[] = {
> +	{ "lp87565-regulator", },
> +	{ "lp87565-q1-regulator", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, lp87565_regulator_id_table);
> +
> +static struct platform_driver lp87565_regulator_driver = {
> +	.driver = {
> +		.name = "lp87565-pmic",
> +	},
> +	.probe = lp87565_regulator_probe,
> +	.id_table = lp87565_regulator_id_table,
> +};
> +module_platform_driver(lp87565_regulator_driver);
> +
> +MODULE_AUTHOR("J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>");
> +MODULE_DESCRIPTION("LP87565 voltage regulator driver");
> +MODULE_ALIAS("platform:lp87565-pmic");

Is this needed? This name is not used, and the above MODULE_DEVICE_TABLE
should take care of the needed aliases.

> +MODULE_LICENSE("GPL v2");
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
