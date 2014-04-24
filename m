From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] clk: Add driver for Palmas clk32kg and clk32kgaudio clocks
Date: Thu, 24 Apr 2014 12:09:14 +0300
Message-ID: <5358D4BA.4080104@ti.com>
References: <1396522348-31989-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396522348-31989-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, ldewangan@nvidia.com, linux-doc@vger.kernel.org, grant.likely@linaro.org
List-Id: linux-omap@vger.kernel.org

Hi Mike,

On 04/03/2014 01:52 PM, Peter Ujfalusi wrote:
> Palmas class of devices have either twl 32K clock outputs:
> CLK32K_KG and CLK32K_KGAUDIO
> or only one:
> CLK32K_KG (TPS659039 for example)
>=20
> Use separate compatible flags for the two 32K clock.
> A system which needs or have only one of the 32k clock from
> Palmas will need to add node(s) for each clock as separate section
> in the dts file.
> The two compatible property is:
> "ti,palmas-clk32kg" for clk32kg clock
> "ti,palmas-clk32kgaudio" for clk32kgaudio clock
>=20
> Apart from the register control of the clocks - which is done via
> the clock API there is a posibility to enable the external sleep
> control.
>=20
> See the documentation for more details.

Can you take a look at this and comment so I can resend it with
documentation/implementation separated.

Thanks,
P=E9ter

>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
>=20
> Part of the driver is based on the v4 of palmas clock driver from
> Laxman Dewangan, which can be found here:
> https://lkml.org/lkml/2013/10/9/146
>=20
> Since no updates followed after the comments and patches I have squas=
hed my
> updates to rewrite the original driver to be able to support more dev=
ices from
> the Palmas family.
>=20
> Regards,
> Peter
>=20
>  .../devicetree/bindings/clock/clk-palmas.txt       |  35 +++
>  drivers/clk/Kconfig                                |   7 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/clk-palmas.c                           | 307 +++++++++++=
++++++++++
>  include/dt-bindings/mfd/palmas.h                   |  18 ++
>  5 files changed, 368 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/clk-palma=
s.txt
>  create mode 100644 drivers/clk/clk-palmas.c
>  create mode 100644 include/dt-bindings/mfd/palmas.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/clk-palmas.txt b=
/Documentation/devicetree/bindings/clock/clk-palmas.txt
> new file mode 100644
> index 000000000000..4208886d834a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/clk-palmas.txt
> @@ -0,0 +1,35 @@
> +* Palmas 32KHz clocks *
> +
> +Palmas device has two clock output pins for 32KHz, KG and KG_AUDIO.
> +
> +This binding uses the common clock binding ./clock-bindings.txt.
> +
> +Required properties:
> +- compatible :	"ti,palmas-clk32kg" for clk32kg clock
> +		"ti,palmas-clk32kgaudio" for clk32kgaudio clock
> +- #clock-cells : shall be set to 0.
> +
> +Optional property:
> +- ti,external-sleep-control: The external enable input pins controll=
ed the
> +	enable/disable of clocks.  The external enable input pins ENABLE1,
> +	ENABLE2 and NSLEEP. The valid values for the external pins are:
> +		PALMAS_EXT_CONTROL_PIN_ENABLE1 for ENABLE1 pin
> +		PALMAS_EXT_CONTROL_PIN_ENABLE2 for ENABLE2 pin
> +		PALMAS_EXT_CONTROL_PIN_NSLEEP for NSLEEP pin
> +	Option 0 or missing this property means the clock is enabled/disabl=
ed
> +	via register access and these pins do not have any control.
> +	The macros of external control pins for DTS is defined at
> +	dt-bindings/mfd/palmas.h
> +
> +Example:
> +	#include <dt-bindings/mfd/palmas.h>
> +	...
> +	palmas: tps65913@58 {
> +		...
> +		clk32kg: palmas_clk32k@0 {
> +			compatible =3D "ti,palmas-clk32kg";
> +			#clock-cells =3D <0>;
> +			ti,external-sleep-control =3D <PALMAS_EXT_CONTROL_PIN_NSLEEP>;
> +		};
> +		...
> +	};
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 6f56d3a4f010..a070b77a1e17 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -109,6 +109,13 @@ config COMMON_CLK_KEYSTONE
>            Supports clock drivers for Keystone based SOCs. These SOCs=
 have local
>  	  a power sleep control module that gate the clock to the IPs and P=
LLs.
> =20
> +config COMMON_CLK_PALMAS
> +	tristate "Clock driver for TI Palmas devices"
> +	depends on MFD_PALMAS
> +	---help---
> +	  This driver supports TI Palmas devices 32KHz output KG and KG_AUD=
IO
> +	  using common clock framework.
> +
>  source "drivers/clk/qcom/Kconfig"
> =20
>  endmenu
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 5f8a28735c96..d67214debc12 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_MAX77686)	+=3D clk-max77686=
=2Eo
>  obj-$(CONFIG_ARCH_MOXART)		+=3D clk-moxart.o
>  obj-$(CONFIG_ARCH_NOMADIK)		+=3D clk-nomadik.o
>  obj-$(CONFIG_ARCH_NSPIRE)		+=3D clk-nspire.o
> +obj-$(CONFIG_COMMON_CLK_PALMAS)		+=3D clk-palmas.o
>  obj-$(CONFIG_CLK_PPC_CORENET)		+=3D clk-ppc-corenet.o
>  obj-$(CONFIG_COMMON_CLK_S2MPS11)	+=3D clk-s2mps11.o
>  obj-$(CONFIG_COMMON_CLK_SI5351)		+=3D clk-si5351.o
> diff --git a/drivers/clk/clk-palmas.c b/drivers/clk/clk-palmas.c
> new file mode 100644
> index 000000000000..e2b7d3cade26
> --- /dev/null
> +++ b/drivers/clk/clk-palmas.c
> @@ -0,0 +1,307 @@
> +/*
> + * Clock driver for Palmas device.
> + *
> + * Copyright (c) 2013, NVIDIA Corporation.
> + * Copyright (c) 2013-2014 Texas Instruments, Inc.
> + *
> + * Author:	Laxman Dewangan <ldewangan@nvidia.com>
> + *		Peter Ujfalusi <peter.ujfalusi@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any k=
ind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/palmas.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define PALMAS_CLOCK_DT_EXT_CONTROL_ENABLE1	1
> +#define PALMAS_CLOCK_DT_EXT_CONTROL_ENABLE2	2
> +#define PALMAS_CLOCK_DT_EXT_CONTROL_NSLEEP	3
> +
> +struct palmas_clk32k_desc {
> +	const char *clk_name;
> +	unsigned int control_reg;
> +	unsigned int enable_mask;
> +	unsigned int sleep_mask;
> +	unsigned int sleep_reqstr_id;
> +	int delay;
> +};
> +
> +struct palmas_clock_info {
> +	struct device *dev;
> +	struct clk *clk;
> +	struct clk_hw hw;
> +	struct palmas *palmas;
> +	struct palmas_clk32k_desc *clk_desc;
> +	int ext_control_pin;
> +};
> +
> +static inline struct palmas_clock_info *to_palmas_clks_info(struct c=
lk_hw *hw)
> +{
> +	return container_of(hw, struct palmas_clock_info, hw);
> +}
> +
> +static unsigned long palmas_clks_recalc_rate(struct clk_hw *hw,
> +					     unsigned long parent_rate)
> +{
> +	return 32768;
> +}
> +
> +static int palmas_clks_prepare(struct clk_hw *hw)
> +{
> +	struct palmas_clock_info *cinfo =3D to_palmas_clks_info(hw);
> +	int ret;
> +
> +	ret =3D palmas_update_bits(cinfo->palmas, PALMAS_RESOURCE_BASE,
> +				 cinfo->clk_desc->control_reg,
> +				 cinfo->clk_desc->enable_mask,
> +				 cinfo->clk_desc->enable_mask);
> +	if (ret < 0)
> +		dev_err(cinfo->dev, "Reg 0x%02x update failed, %d\n",
> +			cinfo->clk_desc->control_reg, ret);
> +	else if (cinfo->clk_desc->delay)
> +		udelay(cinfo->clk_desc->delay);
> +
> +	return ret;
> +}
> +
> +static void palmas_clks_unprepare(struct clk_hw *hw)
> +{
> +	struct palmas_clock_info *cinfo =3D to_palmas_clks_info(hw);
> +	int ret;
> +
> +	/*
> +	 * Clock can be disabled through external pin if it is externally
> +	 * controlled.
> +	 */
> +	if (cinfo->ext_control_pin)
> +		return;
> +
> +	ret =3D palmas_update_bits(cinfo->palmas, PALMAS_RESOURCE_BASE,
> +				 cinfo->clk_desc->control_reg,
> +				 cinfo->clk_desc->enable_mask, 0);
> +	if (ret < 0)
> +		dev_err(cinfo->dev, "Reg 0x%02x update failed, %d\n",
> +			cinfo->clk_desc->control_reg, ret);
> +}
> +
> +static int palmas_clks_is_prepared(struct clk_hw *hw)
> +{
> +	struct palmas_clock_info *cinfo =3D to_palmas_clks_info(hw);
> +	int ret;
> +	u32 val;
> +
> +	if (cinfo->ext_control_pin)
> +		return 1;
> +
> +	ret =3D palmas_read(cinfo->palmas, PALMAS_RESOURCE_BASE,
> +			  cinfo->clk_desc->control_reg, &val);
> +	if (ret < 0) {
> +		dev_err(cinfo->dev, "Reg 0x%02x read failed, %d\n",
> +			cinfo->clk_desc->control_reg, ret);
> +		return ret;
> +	}
> +	return !!(val & cinfo->clk_desc->enable_mask);
> +}
> +
> +static struct clk_ops palmas_clks_ops =3D {
> +	.prepare	=3D palmas_clks_prepare,
> +	.unprepare	=3D palmas_clks_unprepare,
> +	.is_prepared	=3D palmas_clks_is_prepared,
> +	.recalc_rate	=3D palmas_clks_recalc_rate,
> +};
> +
> +struct palmas_clks_of_match_data {
> +	struct clk_init_data init;
> +	struct palmas_clk32k_desc desc;
> +};
> +
> +static struct palmas_clks_of_match_data palmas_of_clk32kg =3D {
> +	.init =3D {
> +		.name =3D "clk32kg",
> +		.ops =3D &palmas_clks_ops,
> +		.flags =3D CLK_IS_ROOT | CLK_IGNORE_UNUSED,
> +	},
> +	.desc =3D {
> +		.clk_name =3D "clk32kg",
> +		.control_reg =3D PALMAS_CLK32KG_CTRL,
> +		.enable_mask =3D PALMAS_CLK32KG_CTRL_MODE_ACTIVE,
> +		.sleep_mask =3D PALMAS_CLK32KG_CTRL_MODE_SLEEP,
> +		.sleep_reqstr_id =3D PALMAS_EXTERNAL_REQSTR_ID_CLK32KG,
> +		.delay =3D 200,
> +	},
> +};
> +
> +static struct palmas_clks_of_match_data palmas_of_clk32kgaudio =3D {
> +	.init =3D {
> +		.name =3D "clk32kgaudio",
> +		.ops =3D &palmas_clks_ops,
> +		.flags =3D CLK_IS_ROOT | CLK_IGNORE_UNUSED,
> +	},
> +	.desc =3D {
> +		.clk_name =3D "clk32kgaudio",
> +		.control_reg =3D PALMAS_CLK32KGAUDIO_CTRL,
> +		.enable_mask =3D PALMAS_CLK32KG_CTRL_MODE_ACTIVE,
> +		.sleep_mask =3D PALMAS_CLK32KG_CTRL_MODE_SLEEP,
> +		.sleep_reqstr_id =3D PALMAS_EXTERNAL_REQSTR_ID_CLK32KGAUDIO,
> +		.delay =3D 200,
> +	},
> +};
> +
> +static struct of_device_id palmas_clks_of_match[] =3D {
> +	{
> +		.compatible =3D "ti,palmas-clk32kg",
> +		.data =3D &palmas_of_clk32kg,
> +	},
> +	{
> +		.compatible =3D "ti,palmas-clk32kgaudio",
> +		.data =3D &palmas_of_clk32kgaudio,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, palmas_clks_of_match);
> +
> +static void palmas_clks_get_clk_data(struct platform_device *pdev,
> +				     struct palmas_clock_info *cinfo)
> +{
> +	struct device_node *node =3D pdev->dev.of_node;
> +	unsigned int prop;
> +	int ret;
> +
> +	ret =3D of_property_read_u32(node, "ti,external-sleep-control",
> +				   &prop);
> +	if (ret)
> +		return;
> +
> +	switch (prop) {
> +	case PALMAS_CLOCK_DT_EXT_CONTROL_ENABLE1:
> +		prop =3D PALMAS_EXT_CONTROL_ENABLE1;
> +		break;
> +	case PALMAS_CLOCK_DT_EXT_CONTROL_ENABLE2:
> +		prop =3D PALMAS_EXT_CONTROL_ENABLE2;
> +		break;
> +	case PALMAS_CLOCK_DT_EXT_CONTROL_NSLEEP:
> +		prop =3D PALMAS_EXT_CONTROL_NSLEEP;
> +		break;
> +	default:
> +		dev_warn(&pdev->dev, "%s: Invalid ext control option: %u\n",
> +			 node->name, prop);
> +		prop =3D 0;
> +		break;
> +	}
> +	cinfo->ext_control_pin =3D prop;
> +}
> +
> +static int palmas_clks_init_configure(struct palmas_clock_info *cinf=
o)
> +{
> +	int ret;
> +
> +	ret =3D palmas_update_bits(cinfo->palmas, PALMAS_RESOURCE_BASE,
> +				 cinfo->clk_desc->control_reg,
> +				 cinfo->clk_desc->sleep_mask, 0);
> +	if (ret < 0) {
> +		dev_err(cinfo->dev, "Reg 0x%02x update failed, %d\n",
> +			cinfo->clk_desc->control_reg, ret);
> +		return ret;
> +	}
> +
> +	if (cinfo->ext_control_pin) {
> +		ret =3D clk_prepare(cinfo->clk);
> +		if (ret < 0) {
> +			dev_err(cinfo->dev, "Clock prep failed, %d\n", ret);
> +			return ret;
> +		}
> +
> +		ret =3D palmas_ext_control_req_config(cinfo->palmas,
> +					cinfo->clk_desc->sleep_reqstr_id,
> +					cinfo->ext_control_pin, true);
> +		if (ret < 0) {
> +			dev_err(cinfo->dev, "Ext config for %s failed, %d\n",
> +				cinfo->clk_desc->clk_name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +static int palmas_clks_probe(struct platform_device *pdev)
> +{
> +	struct palmas *palmas =3D dev_get_drvdata(pdev->dev.parent);
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct palmas_clks_of_match_data *match_data;
> +	const struct of_device_id *match;
> +	struct palmas_clock_info *cinfo;
> +	struct clk *clk;
> +	int ret;
> +
> +	match =3D of_match_device(palmas_clks_of_match, &pdev->dev);
> +	match_data =3D (struct palmas_clks_of_match_data *)match->data;
> +
> +	cinfo =3D devm_kzalloc(&pdev->dev, sizeof(*cinfo), GFP_KERNEL);
> +	if (!cinfo)
> +		return -ENOMEM;
> +
> +	palmas_clks_get_clk_data(pdev, cinfo);
> +	platform_set_drvdata(pdev, cinfo);
> +
> +	cinfo->dev =3D &pdev->dev;
> +	cinfo->palmas =3D palmas;
> +
> +	cinfo->clk_desc =3D &match_data->desc;
> +	cinfo->hw.init =3D &match_data->init;
> +	clk =3D devm_clk_register(&pdev->dev, &cinfo->hw);
> +	if (IS_ERR(clk)) {
> +		ret =3D PTR_ERR(clk);
> +		dev_err(&pdev->dev, "Fail to register clock %s, %d\n",
> +			match_data->desc.clk_name, ret);
> +		return ret;
> +	}
> +
> +	cinfo->clk =3D clk;
> +	ret =3D palmas_clks_init_configure(cinfo);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Clock config failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D of_clk_add_provider(node, of_clk_src_simple_get, cinfo->clk=
);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "Fail to add clock driver, %d\n", ret);
> +	return ret;
> +}
> +
> +static int palmas_clks_remove(struct platform_device *pdev)
> +{
> +	of_clk_del_provider(pdev->dev.of_node);
> +	return 0;
> +}
> +
> +static struct platform_driver palmas_clks_driver =3D {
> +	.driver =3D {
> +		.name =3D "palmas-clk",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D palmas_clks_of_match,
> +	},
> +	.probe =3D palmas_clks_probe,
> +	.remove =3D palmas_clks_remove,
> +};
> +
> +module_platform_driver(palmas_clks_driver);
> +
> +MODULE_DESCRIPTION("Clock driver for Palmas Series Devices");
> +MODULE_ALIAS("platform:palmas-clk");
> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/dt-bindings/mfd/palmas.h b/include/dt-bindings/m=
fd/palmas.h
> new file mode 100644
> index 000000000000..2c8ac4841385
> --- /dev/null
> +++ b/include/dt-bindings/mfd/palmas.h
> @@ -0,0 +1,18 @@
> +/*
> + * This header provides macros for Palmas device bindings.
> + *
> + * Copyright (c) 2013, NVIDIA Corporation.
> + *
> + * Author: Laxman Dewangan <ldewangan@nvidia.com>
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_PALMAS_H__
> +#define __DT_BINDINGS_PALMAS_H
> +
> +/* External control pins */
> +#define PALMAS_EXT_CONTROL_PIN_ENABLE1	1
> +#define PALMAS_EXT_CONTROL_PIN_ENABLE2	2
> +#define PALMAS_EXT_CONTROL_PIN_NSLEEP	3
> +
> +#endif /* __DT_BINDINGS_PALMAS_H */
>=20
