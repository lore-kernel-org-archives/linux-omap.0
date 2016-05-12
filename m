From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/3] mfd: lp873x: Add lp873x PMIC support
Date: Thu, 12 May 2016 14:18:46 +0100
Message-ID: <20160512131846.GB1433@dell.open.watershed.co.uk>
References: <1462853079-10708-1-git-send-email-j-keerthy@ti.com>
 <1462853079-10708-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462853079-10708-3-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 10 May 2016, Keerthy wrote:

> The LP873X chip is a power management IC for Portable Navigation Syst=
ems
>     and Tablet Computing devices. It contains the following component=
s:
>=20
>      - Regulators.
>      - Configurable General Purpose Output Signals(GPO).
>=20
> PMIC interacts with the main processor through i2c. PMIC has
> couple of LDOs(Linear Regulators), couple of BUCKs (Step-Down DC-DC
> Converter Cores) and GPOs(General Purpose Output Signals). At this
> time only the regulator functionality is made available.
>=20
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
>=20
> Changes in v2:
>=20
>   * Used mfd_add_devices instead of of_pltaform_populate.

Didn't see this conversation, but of_platform_populate () is usually
okay?

>  drivers/mfd/Kconfig        |  15 +++
>  drivers/mfd/Makefile       |   2 +
>  drivers/mfd/lp873x.c       |  98 +++++++++++++++++
>  include/linux/mfd/lp873x.h | 265 +++++++++++++++++++++++++++++++++++=
++++++++++
>  4 files changed, 380 insertions(+)
>  create mode 100644 drivers/mfd/lp873x.c
>  create mode 100644 include/linux/mfd/lp873x.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index eea61e3..1d85f10 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1185,6 +1185,21 @@ config MFD_TPS65217
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tps65217.
> =20
> +config MFD_LP873X
> +	tristate "TI LP873X Power Management IC"
> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the LP873X series of
> +	  Power Management Integrated Circuits.
> +	  These include voltage regulators, Thermal protection, Configurabl=
e
> +	  general pirpose outputs and other features that are often used in
> +	  portable devices.

Please proof read this, including spell check and fix any grammatical
errors.

"other features" is too vague.  Either specify what they are, or
don't mention them at all.

> +	  This driver can also be built as a module.  If so, the module
> +	  will be called lp873x.
> +
>  config MFD_TPS65218
>  	tristate "TI TPS65218 Power Management chips"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 5eaa6465d..617c688 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -22,6 +22,8 @@ obj-$(CONFIG_HTC_EGPIO)		+=3D htc-egpio.o
>  obj-$(CONFIG_HTC_PASIC3)	+=3D htc-pasic3.o
>  obj-$(CONFIG_HTC_I2CPLD)	+=3D htc-i2cpld.o
> =20
> +obj-$(CONFIG_MFD_LP873X)	+=3D lp873x.o
> +
>  obj-$(CONFIG_MFD_DAVINCI_VOICECODEC)	+=3D davinci_voicecodec.o
>  obj-$(CONFIG_MFD_DM355EVM_MSP)	+=3D dm355evm_msp.o
>  obj-$(CONFIG_MFD_TI_AM335X_TSCADC)	+=3D ti_am335x_tscadc.o
> diff --git a/drivers/mfd/lp873x.c b/drivers/mfd/lp873x.c
> new file mode 100644
> index 0000000..6046adf
> --- /dev/null
> +++ b/drivers/mfd/lp873x.c
> @@ -0,0 +1,98 @@
> +/*
> + * LP873X chip family multi-function driver

No need to mention that it's an MFD, it's in drivers/mfd/ so we know
that.

> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warran=
ty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/regmap.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/lp873x.h>

Alphabetical.=20

> +static const struct regmap_config lp873x_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D LP873X_REG_MAX,
> +};
> +
> +static const struct mfd_cell lp873x_cells[] =3D {
> +	{ .name =3D "lp873x-regulator", },
> +};
> +
> +static const struct of_device_id of_lp873x_match_table[] =3D {
> +	{ .compatible =3D "ti,lp8733", },
> +	{ .compatible =3D "ti,lp8732", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_lp873x_match_table);

Put this just above where you first make use of it.

> +static const struct i2c_device_id lp873x_id_table[] =3D {
> +	{ "lp873x", LP873X },
> +	{ "lp8732", LP873X },
> +	{ "lp8733", LP873X },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, lp873x_id_table);

As above.

> +static int lp873x_probe(struct i2c_client *client,
> +			const struct i2c_device_id *ids)
> +{
> +	struct lp873x *lp873;
> +	int ret;
> +	unsigned int otpid;
> +
> +	lp873 =3D devm_kzalloc(&client->dev, sizeof(*lp873), GFP_KERNEL);
> +	if (!lp873)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, lp873);

Move this until just before mfd_add_devices()

> +	lp873->dev =3D &client->dev;

'\n' here.

> +	lp873->regmap =3D devm_regmap_init_i2c(client, &lp873x_regmap_confi=
g);
> +	if (IS_ERR(lp873->regmap)) {
> +		ret =3D PTR_ERR(lp873->regmap);
> +		dev_err(lp873->dev, "Failed to initialize register map: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&lp873->lp873_lock);
> +
> +	ret =3D regmap_read(lp873->regmap, LP873X_REG_OTP_REV, &otpid);
> +

Remove this line.

> +	if (ret) {
> +		dev_err(lp873->dev, "Failed to read otpid\n");

"OTP ID"

> +		return ret;
> +	}
> +
> +	lp873->rev =3D otpid & LP873X_OTP_REV_OTP_ID;
> +
> +	ret =3D mfd_add_devices(lp873->dev, PLATFORM_DEVID_AUTO, lp873x_cel=
ls,
> +			      ARRAY_SIZE(lp873x_cells), NULL, 0, NULL);
> +
> +	return ret;
> +}
> +
> +static struct i2c_driver lp873x_driver =3D {
> +	.driver		=3D {
> +		.name	=3D "lp873x",
> +		.of_match_table =3D of_lp873x_match_table,
> +	},
> +	.probe		=3D lp873x_probe,
> +	.id_table	=3D lp873x_id_table,
> +};
> +module_i2c_driver(lp873x_driver);
> +
> +MODULE_AUTHOR("J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>");
> +MODULE_DESCRIPTION("LP873X chip family multi-function driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/lp873x.h b/include/linux/mfd/lp873x.h
> new file mode 100644
> index 0000000..72f6ee9
> --- /dev/null
> +++ b/include/linux/mfd/lp873x.h
> @@ -0,0 +1,265 @@
> +/*
> + * Functions to access LP873X power management chip.
> + *
> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warran=
ty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __LINUX_MFD_LP873X_H
> +#define __LINUX_MFD_LP873X_H
> +
> +#include <linux/i2c.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +
> +/* LP873x chip id list */
> +#define LP873X			0x00
> +
> +/* All register addresses */
> +#define LP873X_REG_DEV_REV		0X00
> +#define LP873X_REG_OTP_REV		0X01
> +#define LP873X_REG_BUCK0_CTRL_1		0X02
> +#define LP873X_REG_BUCK0_CTRL_2		0X03
> +#define LP873X_REG_BUCK1_CTRL_1		0X04
> +#define LP873X_REG_BUCK1_CTRL_2		0X05
> +#define LP873X_REG_BUCK0_VOUT		0X06
> +#define LP873X_REG_BUCK1_VOUT		0X07
> +#define LP873X_REG_LDO0_CTRL		0X08
> +#define LP873X_REG_LDO1_CTRL            0X09
> +#define LP873X_REG_LDO0_VOUT		0X0A
> +#define LP873X_REG_LDO1_VOUT		0X0B
> +#define LP873X_REG_BUCK0_DELAY		0X0C
> +#define LP873X_REG_BUCK1_DELAY		0X0D
> +#define LP873X_REG_LDO0_DELAY		0X0E
> +#define LP873X_REG_LDO1_DELAY		0X0F
> +#define LP873X_REG_GPO_DELAY		0X10
> +#define LP873X_REG_GPO2_DELAY		0X11
> +#define LP873X_REG_GPO_CTRL		0X12
> +#define LP873X_REG_CONFIG		0X13
> +#define LP873X_REG_PLL_CTRL		0X14
> +#define LP873X_REG_PGOOD_CTRL1		0X15
> +#define LP873X_REG_PGOOD_CTRL2		0X16
> +#define LP873X_REG_PG_FAULT		0X17
> +#define LP873X_REG_RESET		0X18
> +#define LP873X_REG_INT_TOP_1		0X19
> +#define LP873X_REG_INT_TOP_2		0X1A
> +#define LP873X_REG_INT_BUCK		0X1B
> +#define LP873X_REG_INT_LDO		0X1C
> +#define LP873X_REG_TOP_STAT		0X1D
> +#define LP873X_REG_BUCK_STAT		0X1E
> +#define LP873X_REG_LDO_STAT		0x1F
> +#define LP873X_REG_TOP_MASK_1		0x20
> +#define LP873X_REG_TOP_MASK_2		0x21
> +#define LP873X_REG_BUCK_MASK		0x22
> +#define LP873X_REG_LDO_MASK		0x23
> +#define LP873X_REG_SEL_I_LOAD		0x24
> +#define LP873X_REG_I_LOAD_2		0x25
> +#define LP873X_REG_I_LOAD_1		0x26
> +
> +#define LP873X_REG_MAX			LP873X_REG_I_LOAD_1
> +
> +/* Register field definitions */
> +#define LP873X_DEV_REV_DEV_ID			0xC0
> +#define LP873X_DEV_REV_ALL_LAYER		0x30
> +#define LP873X_DEV_REV_METAL_LAYER		0x0F
> +
> +#define LP873X_OTP_REV_OTP_ID			0xFF
> +
> +#define LP873X_BUCK0_CTRL_1_BUCK0_FPWM		BIT(3)
> +#define LP873X_BUCK0_CTRL_1_BUCK0_RDIS_EN	BIT(2)
> +#define LP873X_BUCK0_CTRL_1_BUCK0_EN_PIN_CTRL	BIT(1)
> +#define LP873X_BUCK0_CTRL_1_BUCK0_EN		BIT(0)
> +
> +#define LP873X_BUCK0_CTRL_2_BUCK0_ILIM		0x38
> +#define LP873X_BUCK0_CTRL_2_BUCK0_SLEW_RATE	0x07
> +
> +#define LP873X_BUCK1_CTRL_1_BUCK1_FPWM		BIT(3)
> +#define LP873X_BUCK1_CTRL_1_BUCK1_RDIS_EN	BIT(2)
> +#define LP873X_BUCK1_CTRL_1_BUCK1_EN_PIN_CTRL	BIT(1)
> +#define LP873X_BUCK1_CTRL_1_BUCK1_EN		BIT(0)
> +
> +#define LP873X_BUCK1_CTRL_2_BUCK1_ILIM		0x38
> +#define LP873X_BUCK1_CTRL_2_BUCK1_SLEW_RATE	0x07
> +
> +#define LP873X_BUCK0_VOUT_BUCK0_VSET		0xFF
> +
> +#define LP873X_BUCK1_VOUT_BUCK1_VSET		0xFF
> +
> +#define LP873X_LDO0_CTRL_LDO0_RDIS_EN		BIT(2)
> +#define LP873X_LDO0_CTRL_LDO0_EN_PIN_CTRL	BIT(1)
> +#define LP873X_LDO0_CTRL_LDO0_EN		BIT(0)
> +
> +#define LP873X_LDO1_CTRL_LDO1_RDIS_EN		BIT(2)
> +#define LP873X_LDO1_CTRL_LDO1_EN_PIN_CTRL	BIT(1)
> +#define LP873X_LDO1_CTRL_LDO1_EN		BIT(0)
> +
> +#define LP873X_LDO0_VOUT_LDO0_VSET		0x1F
> +
> +#define LP873X_LDO1_VOUT_LDO1_VSET		0x1F
> +
> +#define LP873X_BUCK0_DELAY_BUCK0_SD_DELAY	0xF0
> +#define LP873X_BUCK0_DELAY_BUCK0_SU_DELAY	0x0F
> +
> +#define LP873X_BUCK1_DELAY_BUCK1_SD_DELAY	0xF0
> +#define LP873X_BUCK1_DELAY_BUCK1_SU_DELAY	0x0F
> +
> +#define LP873X_LDO0_DELAY_LDO0_SD_DELAY	0xF0
> +#define LP873X_LDO0_DELAY_LDO0_SU_DELAY	0x0F
> +
> +#define LP873X_LDO1_DELAY_LDO1_SD_DELAY	0xF0
> +#define LP873X_LDO1_DELAY_LDO1_SU_DELAY	0x0F
> +
> +#define LP873X_GPO_DELAY_GPO_SD_DELAY		0xF0
> +#define LP873X_GPO_DELAY_GPO_SU_DELAY		0x0F
> +
> +#define LP873X_GPO2_DELAY_GPO2_SD_DELAY	0xF0
> +#define LP873X_GPO2_DELAY_GPO2_SU_DELAY	0x0F
> +
> +#define LP873X_GPO_CTRL_GPO2_OD		BIT(6)
> +#define LP873X_GPO_CTRL_GPO2_EN_PIN_CTRL	BIT(5)
> +#define LP873X_GPO_CTRL_GPO2_EN		BIT(4)
> +#define LP873X_GPO_CTRL_GPO_OD			BIT(2)
> +#define LP873X_GPO_CTRL_GPO_EN_PIN_CTRL	BIT(1)
> +#define LP873X_GPO_CTRL_GPO_EN			BIT(0)
> +
> +#define LP873X_CONFIG_SU_DELAY_SEL		BIT(6)
> +#define LP873X_CONFIG_SD_DELAY_SEL		BIT(5)
> +#define LP873X_CONFIG_CLKIN_PIN_SEL		BIT(4)
> +#define LP873X_CONFIG_CLKIN_PD			BIT(3)
> +#define LP873X_CONFIG_EN_PD			BIT(2)
> +#define LP873X_CONFIG_TDIE_WARN_LEVEL		BIT(1)
> +#define LP873X_EN_SPREAD_SPEC			BIT(0)
> +
> +#define LP873X_PLL_CTRL_EN_PLL			BIT(6)
> +#define LP873X_EXT_CLK_FREQ			0x1F
> +
> +#define LP873X_PGOOD_CTRL1_PGOOD_POL		BIT(7)
> +#define LP873X_PGOOD_CTRL1_PGOOD_OD		BIT(6)
> +#define LP873X_PGOOD_CTRL1_PGOOD_WINDOW_LDO	BIT(5)
> +#define LP873X_PGOOD_CTRL1_PGOOD_WINDOWN_BUCK	BIT(4)
> +#define LP873X_PGOOD_CTRL1_PGOOD_EN_PGOOD_LDO1	BIT(3)
> +#define LP873X_PGOOD_CTRL1_PGOOD_EN_PGOOD_LDO0	BIT(2)
> +#define LP873X_PGOOD_CTRL1_PGOOD_EN_PGOOD_BUCK1	BIT(1)
> +#define LP873X_PGOOD_CTRL1_PGOOD_EN_PGOOD_BUCK0	BIT(0)
> +
> +#define LP873X_PGOOD_CTRL2_EN_PGOOD_TWARN	BIT(2)
> +#define LP873X_PGOOD_CTRL2_EN_PG_FAULT_GATE	BIT(1)
> +#define LP873X_PGOOD_CTRL2_PGOOD_MODE		BIT(0)
> +
> +#define LP873X_PG_FAULT_PG_FAULT_LDO1		BIT(3)
> +#define LP873X_PG_FAULT_PG_FAULT_LDO0		BIT(2)
> +#define LP873X_PG_FAULT_PG_FAULT_BUCK1		BIT(1)
> +#define LP873X_PG_FAULT_PG_FAULT_BUCK0		BIT(0)
> +
> +#define LP873X_RESET_SW_RESET			BIT(0)
> +
> +#define LP873X_INT_TOP_1_PGOOD_INT		BIT(7)
> +#define LP873X_INT_TOP_1_LDO_INT		BIT(6)
> +#define LP873X_INT_TOP_1_BUCK_INT		BIT(5)
> +#define LP873X_INT_TOP_1_SYNC_CLK_INT		BIT(4)
> +#define LP873X_INT_TOP_1_TDIE_SD_INT		BIT(3)
> +#define LP873X_INT_TOP_1_TDIE_WARN_INT		BIT(2)
> +#define LP873X_INT_TOP_1_OVP_INT		BIT(1)
> +#define LP873X_INT_TOP_1_I_MEAS_INT		BIT(0)
> +
> +#define LP873X_INT_TOP_2_RESET_REG_INT		BIT(0)
> +
> +#define LP873X_INT_BUCK_BUCK1_PG_INT		BIT(6)
> +#define LP873X_INT_BUCK_BUCK1_SC_INT		BIT(5)
> +#define LP873X_INT_BUCK_BUCK1_ILIM_INT		BIT(4)
> +#define LP873X_INT_BUCK_BUCK0_PG_INT		BIT(2)
> +#define LP873X_INT_BUCK_BUCK0_SC_INT		BIT(1)
> +#define LP873X_INT_BUCK_BUCK0_ILIM_INT		BIT(0)
> +
> +#define LP873X_INT_LDO_LDO1_PG_INT		BIT(6)
> +#define LP873X_INT_LDO_LDO1_SC_INT		BIT(5)
> +#define LP873X_INT_LDO_LDO1_ILIM_INT		BIT(4)
> +#define LP873X_INT_LDO_LDO0_PG_INT		BIT(2)
> +#define LP873X_INT_LDO_LDO0_SC_INT		BIT(1)
> +#define LP873X_INT_LDO_LDO0_ILIM_INT		BIT(0)
> +
> +#define LP873X_TOP_STAT_PGOOD_STAT		BIT(7)
> +#define LP873X_TOP_STAT_SYNC_CLK_STAT		BIT(4)
> +#define LP873X_TOP_STAT_TDIE_SD_STAT		BIT(3)
> +#define LP873X_TOP_STAT_TDIE_WARN_STAT		BIT(2)
> +#define LP873X_TOP_STAT_OVP_STAT		BIT(1)
> +
> +#define LP873X_BUCK_STAT_BUCK1_STAT		BIT(7)
> +#define LP873X_BUCK_STAT_BUCK1_PG_STAT		BIT(6)
> +#define LP873X_BUCK_STAT_BUCK1_ILIM_STAT	BIT(4)
> +#define LP873X_BUCK_STAT_BUCK0_STAT		BIT(3)
> +#define LP873X_BUCK_STAT_BUCK0_PG_STAT		BIT(2)
> +#define LP873X_BUCK_STAT_BUCK0_ILIM_STAT	BIT(0)
> +
> +#define LP873X_LDO_STAT_LDO1_STAT		BIT(7)
> +#define LP873X_LDO_STAT_LDO1_PG_STAT		BIT(6)
> +#define LP873X_LDO_STAT_LDO1_ILIM_STAT		BIT(4)
> +#define LP873X_LDO_STAT_LDO0_STAT		BIT(3)
> +#define LP873X_LDO_STAT_LDO0_PG_STAT		BIT(2)
> +#define LP873X_LDO_STAT_LDO0_ILIM_STAT		BIT(0)
> +
> +#define LP873X_TOP_MASK_1_PGOOD_INT_MASK	BIT(7)
> +#define LP873X_TOP_MASK_1_SYNC_CLK_MASK	BIT(4)
> +#define LP873X_TOP_MASK_1_TDIE_WARN_MASK	BIT(2)
> +#define LP873X_TOP_MASK_1_I_MEAS_MASK		BIT(0)
> +
> +#define LP873X_TOP_MASK_2_RESET_REG_MASK	BIT(0)
> +
> +#define LP873X_BUCK_MASK_BUCK1_PGF_MASK	BIT(7)
> +#define LP873X_BUCK_MASK_BUCK1_PGR_MASK	BIT(6)
> +#define LP873X_BUCK_MASK_BUCK1_ILIM_MASK	BIT(4)
> +#define LP873X_BUCK_MASK_BUCK0_PGF_MASK	BIT(3)
> +#define LP873X_BUCK_MASK_BUCK0_PGR_MASK	BIT(2)
> +#define LP873X_BUCK_MASK_BUCK0_ILIM_MASK	BIT(0)
> +
> +#define LP873X_LDO_MASK_LDO1_PGF_MASK		BIT(7)
> +#define LP873X_LDO_MASK_LDO1_PGR_MASK		BIT(6)
> +#define LP873X_LDO_MASK_LDO1_ILIM_MASK		BIT(4)
> +#define LP873X_LDO_MASK_LDO0_PGF_MASK		BIT(3)
> +#define LP873X_LDO_MASK_LDO0_PGR_MASK		BIT(2)
> +#define LP873X_LDO_MASK_LDO0_ILIM_MASK		BIT(0)
> +
> +#define LP873X_SEL_I_LOAD_CURRENT_BUCK_SELECT	BIT(0)
> +
> +#define LP873X_I_LOAD_2_BUCK_LOAD_CURRENT	BIT(0)
> +
> +#define LP873X_I_LOAD_1_BUCK_LOAD_CURRENT	0xFF
> +
> +#define LP873X_MAX_REG_ID		LP873X_LDO_1
> +
> +/* Number of step-down converters available */
> +#define LP873X_NUM_BUCK		2
> +/* Number of LDO voltage regulators available */
> +#define LP873X_NUM_LDO		2
> +/* Number of total regulators available */
> +#define LP873X_NUM_REGULATOR		(LP873X_NUM_BUCK + LP873X_NUM_LDO)
> +
> +enum lp873x_regulator_id {
> +	/* BUCK's */
> +	LP873X_BUCK_0,
> +	LP873X_BUCK_1,
> +	/* LDOs */
> +	LP873X_LDO_0,
> +	LP873X_LDO_1,
> +};
> +
> +/**
> + * struct lp873x - state holder for the lp873x driver
> + * Device data may be used to access the LP873X chip
> + */
> +struct lp873x {
> +	struct device *dev;
> +	unsigned long id;
> +	u8 rev;
> +	struct mutex lp873_lock;	/* lock guarding the data structure */
> +	struct regmap *regmap;

Are all of these used in >1 driver?

> +};
> +#endif /*  __LINUX_MFD_LP873X_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
