From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 1/3] mfd: lp87565: Add lp87565 PMIC support
Date: Tue, 23 May 2017 08:38:49 +0530
Message-ID: <f62f225b-931e-c68b-4e59-243c0c0b0d02@ti.com>
References: <1495197739-17446-1-git-send-email-j-keerthy@ti.com>
 <1495197739-17446-2-git-send-email-j-keerthy@ti.com>
 <f6a16fe0-4212-bc73-090c-351b189ed864@ti.com>
 <986d6014-294c-c637-1c23-61fd2929fc30@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <986d6014-294c-c637-1c23-61fd2929fc30@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org
Cc: t-kristo@ti.com, tony@atomide.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Monday 22 May 2017 09:53 AM, Keerthy wrote:
> 
> 
> On Friday 19 May 2017 09:12 PM, Andrew F. Davis wrote:
>> On 05/19/2017 07:42 AM, Keerthy wrote:
>>> The LP87565 chip is a power management IC for Portable Navigation Systems
>>> and Tablet Computing devices. It contains the following components:
>>>
>>>         - Configurable Bucks(Single and multi-phase).
>>>         - Configurable General Purpose Output Signals (GPO).
>>>
>>> The LP87565-Q1 variant device uses two 2-phase outputs configuration,
>>> Buck0 is master for Buck0/1 output and Buck2 is master for Buck2/3
>>> output.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/mfd/lp87565.txt |  44 ++++
>>>  drivers/mfd/Kconfig                               |  14 ++
>>>  drivers/mfd/Makefile                              |   1 +
>>>  drivers/mfd/lp87565.c                             | 103 ++++++++
>>>  include/linux/mfd/lp87565.h                       | 275 ++++++++++++++++++++++
>>>  5 files changed, 437 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
>>>  create mode 100644 drivers/mfd/lp87565.c
>>>  create mode 100644 include/linux/mfd/lp87565.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
>>> new file mode 100644
>>> index 0000000..38a00a1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/lp87565.txt
>>> @@ -0,0 +1,44 @@
>>> +TI LP873565 PMIC MFD driver
>>> +
>>> +Required properties:
>>> +  - compatible:	"ti,lp87565", "ti,lp87565-q1"
>>
>> The of_device_id table in the driver only seems to match for
>> "ti,lp87565-q1", not "ti,lp87565".
> 
> I will add both. ti,lp87565 is the generic one and the ti,lp87565-q1 is
> a specific one with dual phase regulators.
> 
>>
>>> +  - reg:		I2C slave address.
>>> +  - gpio-controller:	Marks the device node as a GPIO Controller.
>>> +  - #gpio-cells:	Should be two.  The first cell is the pin number and
>>> +			the second cell is used to specify flags.
>>> +			See ../gpio/gpio.txt for more information.
>>> +  - xxx-in-supply:	Phandle to parent supply node of each regulator
>>> +			populated under regulators node. xxx should match
>>> +			the supply_name populated in driver.
>>> +  - regulators:	List of child nodes that specify the regulator
>>> +			initialization data.
>>> +Example:
>>> +
>>> +lp87565: lp87565@60 {
>>
>> pmic: lp87565@60 {
>>
>> Is more standard.
> 
> Sure. I will change that.
> 
> Thanks for reviewing.

Andrew,

In case there are 2 PMICs on a board this would be confusing.
Instead i would prefer to use:

lp87565_pmic: lp87565@60 {

There are already existing entries of that form.

Thanks,
Keerthy

> 
>>
>>> +	compatible = "ti,lp87565-q1";
>>> +	reg = <0x60>;
>>> +	gpio-controller;
>>> +	#gpio-cells = <2>;
>>> +
>>> +	buck10-in-supply =<&vsys_3v3>;
>>> +	buck23-in-supply =<&vsys_3v3>;
>>> +	regulators: regulators {
>>> +		buck10_reg: buck10 {
>>> +			/*VDD_MPU*/
>>> +			regulator-name = "buck10";
>>> +			regulator-min-microvolt = <850000>;
>>> +			regulator-max-microvolt = <1250000>;
>>> +			regulator-always-on;
>>> +			regulator-boot-on;
>>> +		};
>>> +
>>> +		buck23_reg: buck23 {
>>> +			/* VDD_GPU*/
>>> +			regulator-name = "buck23";
>>> +			regulator-min-microvolt = <850000>;
>>> +			regulator-max-microvolt = <1250000>;
>>> +			regulator-boot-on;
>>> +			regulator-always-on;
>>> +		};
>>> +	};
>>> +};
>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>> index 3eb5c93..5e884f3 100644
>>> --- a/drivers/mfd/Kconfig
>>> +++ b/drivers/mfd/Kconfig
>>> @@ -1325,6 +1325,20 @@ config MFD_TI_LP873X
>>>  	  This driver can also be built as a module. If so, the module
>>>  	  will be called lp873x.
>>>  
>>> +config MFD_TI_LP87565
>>> +	tristate "TI LP87565 Power Management IC"
>>> +	depends on I2C
>>> +	select MFD_CORE
>>> +	select REGMAP_I2C
>>> +	help
>>> +	  If you say yes here then you get support for the LP87565 series of
>>> +	  Power Management Integrated Circuits (PMIC).
>>> +	  These include voltage regulators, thermal protection, configurable
>>> +	  General Purpose Outputs (GPO) that are used in portable devices.
>>> +
>>> +	  This driver can also be built as a module. If so, the module
>>> +	  will be called lp87565.
>>> +
>>>  config MFD_TPS65218
>>>  	tristate "TI TPS65218 Power Management chips"
>>>  	depends on I2C
>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>> index c16bf1e..7edbe1b 100644
>>> --- a/drivers/mfd/Makefile
>>> +++ b/drivers/mfd/Makefile
>>> @@ -25,6 +25,7 @@ obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
>>>  obj-$(CONFIG_HTC_I2CPLD)	+= htc-i2cpld.o
>>>  
>>>  obj-$(CONFIG_MFD_TI_LP873X)	+= lp873x.o
>>> +obj-$(CONFIG_MFD_TI_LP87565)	+= lp87565.o
>>>  
>>>  obj-$(CONFIG_MFD_DAVINCI_VOICECODEC)	+= davinci_voicecodec.o
>>>  obj-$(CONFIG_MFD_DM355EVM_MSP)	+= dm355evm_msp.o
>>> diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
>>> new file mode 100644
>>> index 0000000..dff882f
>>> --- /dev/null
>>> +++ b/drivers/mfd/lp87565.c
>>> @@ -0,0 +1,103 @@
>>> +/*
>>> + * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
>>> + *
>>> + * Author: Keerthy <j-keerthy@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License as
>>> + * published by the Free Software Foundation version 2.
>>> + *
>>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>>> + * kind, whether express or implied; without even the implied warranty
>>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/mfd/core.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +#include <linux/mfd/lp87565.h>
>>> +
>>> +static const struct regmap_config lp87565_regmap_config = {
>>> +	.reg_bits = 8,
>>> +	.val_bits = 8,
>>> +	.max_register = LP87565_REG_MAX,
>>> +};
>>> +
>>> +static const struct mfd_cell lp87565_cells[] = {
>>> +	{ .name = "lp87565-q1-regulator", },
>>> +	{ .name = "lp87565-q1-gpio", },
>>> +};
>>> +
>>> +static const struct of_device_id of_lp87565_match_table[] = {
>>> +	{
>>> +		.compatible = "ti,lp87565-q1",
>>> +		.data = (void *)LP87565_DEVICE_TYPE_LP87565_Q1,
>>> +	},
>>> +	{}
>>> +};
>>> +MODULE_DEVICE_TABLE(of, of_lp87565_match_table);
>>> +
>>> +static int lp87565_probe(struct i2c_client *client,
>>> +			 const struct i2c_device_id *ids)
>>> +{
>>> +	struct lp87565 *lp87565;
>>> +	const struct of_device_id *of_id;
>>> +	int ret;
>>> +	unsigned int otpid;
>>> +
>>> +	lp87565 = devm_kzalloc(&client->dev, sizeof(*lp87565), GFP_KERNEL);
>>> +	if (!lp87565)
>>> +		return -ENOMEM;
>>> +
>>> +	lp87565->dev = &client->dev;
>>> +
>>> +	lp87565->regmap = devm_regmap_init_i2c(client, &lp87565_regmap_config);
>>> +	if (IS_ERR(lp87565->regmap)) {
>>> +		ret = PTR_ERR(lp87565->regmap);
>>> +		dev_err(lp87565->dev,
>>> +			"Failed to initialize register map: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = regmap_read(lp87565->regmap, LP87565_REG_OTP_REV, &otpid);
>>> +	if (ret) {
>>> +		dev_err(lp87565->dev, "Failed to read OTP ID\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	lp87565->rev = otpid & LP87565_OTP_REV_OTP_ID;
>>> +	of_id = of_match_device(of_lp87565_match_table, &client->dev);
>>> +	if (of_id)
>>> +		lp87565->dev_type = (enum lp87565_device_type)of_id->data;
>>> +
>>> +	i2c_set_clientdata(client, lp87565);
>>> +
>>> +	ret = mfd_add_devices(lp87565->dev, PLATFORM_DEVID_AUTO, lp87565_cells,
>>> +			      ARRAY_SIZE(lp87565_cells), NULL, 0, NULL);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct i2c_device_id lp87565_id_table[] = {
>>> +	{ "lp87565-q1", 0 },
>>> +	{ },
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, lp87565_id_table);
>>> +
>>> +static struct i2c_driver lp87565_driver = {
>>> +	.driver	= {
>>> +		.name	= "lp87565",
>>> +		.of_match_table = of_lp87565_match_table,
>>> +	},
>>> +	.probe		= lp87565_probe,
>>> +	.id_table	= lp87565_id_table,
>>> +};
>>> +module_i2c_driver(lp87565_driver);
>>> +
>>> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
>>> +MODULE_DESCRIPTION("lp87565 chip family Multi-Function Device driver");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/include/linux/mfd/lp87565.h b/include/linux/mfd/lp87565.h
>>> new file mode 100644
>>> index 0000000..6112365
>>> --- /dev/null
>>> +++ b/include/linux/mfd/lp87565.h
>>> @@ -0,0 +1,275 @@
>>> +/*
>>> + * Functions to access LP87565 power management chip.
>>> + *
>>> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License as
>>> + * published by the Free Software Foundation version 2.
>>> + *
>>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>>> + * kind, whether express or implied; without even the implied warranty
>>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#ifndef __LINUX_MFD_LP87565_H
>>> +#define __LINUX_MFD_LP87565_H
>>> +
>>> +#include <linux/i2c.h>
>>> +#include <linux/regulator/driver.h>
>>> +#include <linux/regulator/machine.h>
>>> +
>>> +enum lp87565_device_type {
>>> +	LP87565_DEVICE_TYPE_UNKNOWN	= 0,
>>> +	LP87565_DEVICE_TYPE_LP87565_Q1,
>>> +};
>>> +
>>> +/* All register addresses */
>>> +#define LP87565_REG_DEV_REV		0X00
>>> +#define LP87565_REG_OTP_REV		0X01
>>> +#define LP87565_REG_BUCK0_CTRL_1		0X02
>>> +#define LP87565_REG_BUCK0_CTRL_2		0X03
>>> +
>>> +#define LP87565_REG_BUCK1_CTRL_1		0X04
>>> +#define LP87565_REG_BUCK1_CTRL_2		0X05
>>> +
>>> +#define LP87565_REG_BUCK2_CTRL_1		0X06
>>> +#define LP87565_REG_BUCK2_CTRL_2		0X07
>>> +
>>> +#define LP87565_REG_BUCK3_CTRL_1		0X08
>>> +#define LP87565_REG_BUCK3_CTRL_2		0X09
>>> +
>>> +#define LP87565_REG_BUCK0_VOUT			0X0A
>>> +#define LP87565_REG_BUCK0_FLOOR_VOUT		0X0B
>>> +
>>> +#define LP87565_REG_BUCK1_VOUT			0X0C
>>> +#define LP87565_REG_BUCK1_FLOOR_VOUT		0X0D
>>> +
>>> +#define LP87565_REG_BUCK2_VOUT			0X0E
>>> +#define LP87565_REG_BUCK2_FLOOR_VOUT		0X0F
>>> +
>>> +#define LP87565_REG_BUCK3_VOUT			0X10
>>> +#define LP87565_REG_BUCK3_FLOOR_VOUT		0X11
>>> +
>>> +#define LP87565_REG_BUCK0_DELAY			0X12
>>> +#define LP87565_REG_BUCK1_DELAY			0X13
>>> +
>>> +#define LP87565_REG_BUCK2_DELAY			0X14
>>> +#define LP87565_REG_BUCK3_DELAY			0X15
>>> +
>>> +#define LP87565_REG_GPO2_DELAY			0X16
>>> +#define LP87565_REG_GPO3_DELAY			0X17
>>> +#define LP87565_REG_RESET			0X18
>>> +#define LP87565_REG_CONFIG			0X19
>>> +
>>> +#define LP87565_REG_INT_TOP_1			0X1A
>>> +#define LP87565_REG_INT_TOP_2			0X1B
>>> +
>>> +#define LP87565_REG_INT_BUCK_0_1		0X1C
>>> +#define LP87565_REG_INT_BUCK_2_3		0X1D
>>> +#define LP87565_REG_TOP_STAT			0X1E
>>> +#define LP87565_REG_BUCK_0_1_STAT		0X1F
>>> +#define LP87565_REG_BUCK_2_3_STAT		0x20
>>> +
>>> +#define LP87565_REG_TOP_MASK_1			0x21
>>> +#define LP87565_REG_TOP_MASK_2			0x22
>>> +
>>> +#define LP87565_REG_BUCK_0_1_MASK		0x23
>>> +#define LP87565_REG_BUCK_2_3_MASK		0x24
>>> +#define LP87565_REG_SEL_I_LOAD			0x25
>>> +
>>> +#define LP87565_REG_I_LOAD_2			0x26
>>> +#define LP87565_REG_I_LOAD_1			0x27
>>> +
>>> +#define LP87565_REG_PGOOD_CTRL1			0x28
>>> +#define LP87565_REG_PGOOD_CTRL2			0x29
>>> +#define LP87565_REG_PGOOD_FLT			0x2A
>>> +#define LP87565_REG_PLL_CTRL			0x2B
>>> +#define LP87565_REG_PIN_FUNCTION		0x2C
>>> +#define LP87565_REG_GPIO_CONFIG			0x2D
>>> +#define LP87565_REG_GPIO_IN			0x2E
>>> +#define LP87565_REG_GPIO_OUT			0x2F
>>> +
>>> +#define LP87565_REG_MAX			LP87565_REG_GPIO_OUT
>>> +
>>> +/* Register field definitions */
>>> +#define LP87565_DEV_REV_DEV_ID			0xC0
>>> +#define LP87565_DEV_REV_ALL_LAYER		0x30
>>> +#define LP87565_DEV_REV_METAL_LAYER		0x0F
>>> +
>>> +#define LP87565_OTP_REV_OTP_ID			0xFF
>>> +
>>> +#define LP87565_BUCK_CTRL_1_EN			BIT(7)
>>> +#define LP87565_BUCK_CTRL_1_EN_PIN_CTRL		BIT(6)
>>> +#define LP87565_BUCK_CTRL_1_PIN_SELECT_EN	0x30
>>> +
>>> +#define LP87565_BUCK_CTRL_1_ROOF_FLOOR_EN	BIT(3)
>>> +#define LP87565_BUCK_CTRL_1_RDIS_EN		BIT(2)
>>> +#define LP87565_BUCK_CTRL_1_FPWM		BIT(1)
>>> +/* Bit0 is reserved for BUCK1 and BUCK3 and valid only for BUCK0 and BUCK2 */
>>> +#define LP87565_BUCK_CTRL_1_FPWM_MP_0_2		BIT(0)
>>> +
>>> +#define LP87565_BUCK_CTRL_2_ILIM		0x38
>>> +#define LP87565_BUCK_CTRL_2_SLEW_RATE		0x07
>>> +
>>> +#define LP87565_BUCK_VSET			0xFF
>>> +#define LP87565_BUCK_FLOOR_VSET			0xFF
>>> +
>>> +#define LP87565_BUCK_SHUTDOWN_DELAY		0xF0
>>> +#define LP87565_BUCK_STARTUP_DELAY		0x0F
>>> +
>>> +#define LP87565_GPIO_SHUTDOWN_DELAY		0xF0
>>> +#define LP87565_GPIO_STARTUP_DELAY		0x0F
>>> +
>>> +#define LP87565_RESET_SW_RESET			BIT(0)
>>> +
>>> +#define LP87565_CONFIG_DOUBLE_DELAY		BIT(7)
>>> +#define LP87565_CONFIG_CLKIN_PD			BIT(6)
>>> +#define LP87565_CONFIG_EN4_PD			BIT(5)
>>> +#define LP87565_CONFIG_EN3_PD			BIT(4)
>>> +#define LP87565_CONFIG_TDIE_WARN_LEVEL		BIT(3)
>>> +#define LP87565_CONFIG_EN2_PD			BIT(2)
>>> +#define LP87565_CONFIG_EN1_PD			BIT(1)
>>> +
>>> +#define LP87565_INT_GPIO			BIT(7)
>>> +#define LP87565_INT_BUCK23			BIT(6)
>>> +#define LP87565_INT_BUCK01			BIT(5)
>>> +#define LP87565_NO_SYNC_CLK			BIT(4)
>>> +#define LP87565_TDIE_SD				BIT(3)
>>> +#define LP87565_TDIE_WARN			BIT(2)
>>> +#define LP87565_INT_OVP				BIT(1)
>>> +#define LP87565_I_LOAD_READY			BIT(0)
>>> +
>>> +#define LP87565_INT_TOP2_RESET_REG		BIT(0)
>>> +
>>> +#define LP87565_BUCK1_PG_INT			BIT(6)
>>> +#define LP87565_BUCK1_SC_INT			BIT(5)
>>> +#define LP87565_BUCK1_ILIM_INT			BIT(4)
>>> +#define LP87565_BUCK0_PG_INT			BIT(2)
>>> +#define LP87565_BUCK0_SC_INT			BIT(1)
>>> +#define LP87565_BUCK0_ILIM_INT			BIT(0)
>>> +
>>> +#define LP87565_BUCK3_PG_INT			BIT(6)
>>> +#define LP87565_BUCK3_SC_INT			BIT(5)
>>> +#define LP87565_BUCK3_ILIM_INT			BIT(4)
>>> +#define LP87565_BUCK2_PG_INT			BIT(2)
>>> +#define LP87565_BUCK2_SC_INT			BIT(1)
>>> +#define LP87565_BUCK2_ILIM_INT			BIT(0)
>>> +
>>> +#define LP87565_SYNC_CLK_STAT			BIT(4)
>>> +#define LP87565_TDIE_SD_STAT			BIT(3)
>>> +#define LP87565_TDIE_WARN_STAT			BIT(2)
>>> +#define LP87565_OVP_STAT			BIT(1)
>>> +
>>> +#define LP87565_BUCK1_STAT			BIT(7)
>>> +#define LP87565_BUCK1_PG_STAT			BIT(6)
>>> +#define LP87565_BUCK1_ILIM_STAT			BIT(4)
>>> +#define LP87565_BUCK0_STAT			BIT(3)
>>> +#define LP87565_BUCK0_PG_STAT			BIT(2)
>>> +#define LP87565_BUCK0_ILIM_STAT			BIT(0)
>>> +
>>> +#define LP87565_BUCK3_STAT			BIT(7)
>>> +#define LP87565_BUCK3_PG_STAT			BIT(6)
>>> +#define LP87565_BUCK3_ILIM_STAT			BIT(4)
>>> +#define LP87565_BUCK2_STAT			BIT(3)
>>> +#define LP87565_BUCK2_PG_STAT			BIT(2)
>>> +#define LP87565_BUCK2_ILIM_STAT			BIT(0)
>>> +
>>> +#define LPL87565_GPIO_MASK			BIT(7)
>>> +#define LPL87565_SYNC_CLK_MASK			BIT(4)
>>> +#define LPL87565_TDIE_WARN_MASK			BIT(2)
>>> +#define LPL87565_I_LOAD_READY_MASK		BIT(0)
>>> +
>>> +#define LPL87565_RESET_REG_MASK			BIT(0)
>>> +
>>> +#define LPL87565_BUCK1_PG_MASK			BIT(6)
>>> +#define LPL87565_BUCK1_ILIM_MASK		BIT(4)
>>> +#define LPL87565_BUCK0_PG_MASK			BIT(2)
>>> +#define LPL87565_BUCK0_ILIM_MASK		BIT(0)
>>> +
>>> +#define LPL87565_BUCK3_PG_MASK			BIT(6)
>>> +#define LPL87565_BUCK3_ILIM_MASK		BIT(4)
>>> +#define LPL87565_BUCK2_PG_MASK			BIT(2)
>>> +#define LPL87565_BUCK2_ILIM_MASK		BIT(0)
>>> +
>>> +#define LP87565_LOAD_CURRENT_BUCK_SELECT	0x3
>>> +
>>> +#define LP87565_I_LOAD2_BUCK_LOAD_CURRENT	0x3
>>> +#define LP87565_I_LOAD1_BUCK_LOAD_CURRENT	0xFF
>>> +
>>> +#define LP87565_PG3_SEL				0xC0
>>> +#define LP87565_PG2_SEL				0x30
>>> +#define LP87565_PG1_SEL				0x0C
>>> +#define LP87565_PG0_SEL				0x03
>>> +
>>> +#define LP87565_HALF_DAY			BIT(7)
>>> +#define LP87565_EN_PG0_NINT			BIT(6)
>>> +#define LP87565_PGOOD_SET_DELAY			BIT(5)
>>> +#define LP87565_EN_PGFLT_STAT			BIT(4)
>>> +#define LP87565_PGOOD_WINDOW			BIT(2)
>>> +#define LP87565_PGOOD_OD			BIT(1)
>>> +#define LP87565_PGOOD_POL			BIT(0)
>>> +
>>> +#define LP87565_PG3_FLT				BIT(3)
>>> +#define LP87565_PG2_FLT				BIT(2)
>>> +#define LP87565_PG1_FLT				BIT(1)
>>> +#define LP87565_PG0_FLT				BIT(0)
>>> +
>>> +#define LP87565_PLL_MODE			0xC0
>>> +#define LP87565_EXT_CLK_FREQ			0x1F
>>> +
>>> +#define LP87565_EN_SPREAD_SPEC			BIT(7)
>>> +#define LP87565_EN_PIN_CTRL_GPIO3		BIT(6)
>>> +#define LP87565_EN_PIN_SELECT_GPIO3		BIT(5)
>>> +#define LP87565_EN_PIN_CTRL_GPIO2		BIT(4)
>>> +#define LP87565_EN_PIN_SELECT_GPIO2		BIT(3)
>>> +#define LP87565_GPIO3_SEL			BIT(2)
>>> +#define LP87565_GPIO2_SEL			BIT(1)
>>> +#define LP87565_GPIO1_SEL			BIT(0)
>>> +
>>> +#define LP87565_GOIO3_OD			BIT(6)
>>> +#define LP87565_GOIO2_OD			BIT(5)
>>> +#define LP87565_GOIO1_OD			BIT(4)
>>> +#define LP87565_GOIO3_DIR			BIT(2)
>>> +#define LP87565_GOIO2_DIR			BIT(1)
>>> +#define LP87565_GOIO1_DIR			BIT(0)
>>> +
>>> +#define LP87565_GOIO3_IN			BIT(2)
>>> +#define LP87565_GOIO2_IN			BIT(1)
>>> +#define LP87565_GOIO1_IN			BIT(0)
>>> +
>>> +#define LP87565_GOIO3_OUT			BIT(2)
>>> +#define LP87565_GOIO2_OUT			BIT(1)
>>> +#define LP87565_GOIO1_OUT			BIT(0)
>>> +
>>> +/* Number of step-down converters available */
>>> +#define LP87565_NUM_BUCK		6
>>> +
>>> +enum LP87565_regulator_id {
>>> +	/* BUCK's */
>>> +	LP87565_BUCK_0,
>>> +	LP87565_BUCK_1,
>>> +	LP87565_BUCK_2,
>>> +	LP87565_BUCK_3,
>>> +	LP87565_BUCK_10,
>>> +	LP87565_BUCK_23,
>>> +};
>>> +
>>> +/**
>>> + * struct LP87565 - state holder for the LP87565 driver
>>> + * @dev: struct device pointer for MFD device
>>> + * @rev: revision of the LP87565
>>> + * @dev_type: The device type for example lp87565-q1
>>> + * @lock: lock guarding the data structure
>>> + * @regmap: register map of the LP87565 PMIC
>>> + *
>>> + * Device data may be used to access the LP87565 chip
>>> + */
>>> +struct lp87565 {
>>> +	struct device *dev;
>>> +	u8 rev;
>>> +	u8 dev_type;
>>> +	struct regmap *regmap;
>>> +};
>>> +#endif /* __LINUX_MFD_LP87565_H */
>>>
