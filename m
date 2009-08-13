From: Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
Subject: Re: [PATCHv2 1/8] Regulator: Add TPS65023 regulator driver
Date: Thu, 13 Aug 2009 11:47:09 +0100
Message-ID: <1250160429.6407.106.camel@odin>
References: <1250052476-28763-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1250052476-28763-1-git-send-email-anuj.aggarwal-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anuj Aggarwal <anuj.aggarwal-l0cyMroinI0@public.gmane.org>
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2009-08-12 at 10:17 +0530, Anuj Aggarwal wrote:
> Adding support for TI TPS65023 regulator driver
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/regulator/tps65023-regulator.c |  638 ++++++++++++++++++++++++++++++++
>  1 files changed, 638 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/regulator/tps65023-regulator.c
> 
> diff --git a/drivers/regulator/tps65023-regulator.c b/drivers/regulator/tps65023-regulator.c
> new file mode 100644
> index 0000000..dbaf295
> --- /dev/null
> +++ b/drivers/regulator/tps65023-regulator.c
> @@ -0,0 +1,638 @@
> +/*
> + * tps65023-regulator.c
> + *
> + * Supports TPS65023 Regulator
> + *
> + * Copyright (C) 2009 Texas Instrument Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +
> +/* Register definitions */
> +#define	TPS65023_REG_VERSION		0
> +#define	TPS65023_REG_PGOODZ		1
> +#define	TPS65023_REG_MASK		2
> +#define	TPS65023_REG_REG_CTRL		3
> +#define	TPS65023_REG_CON_CTRL		4
> +#define	TPS65023_REG_CON_CTRL2		5
> +#define	TPS65023_REG_DEF_CORE		6
> +#define	TPS65023_REG_DEFSLEW		7
> +#define	TPS65023_REG_LDO_CTRL		8
> +
> +/* PGOODZ bitfields */
> +#define	TPS65023_PGOODZ_PWRFAILZ	BIT(7)
> +#define	TPS65023_PGOODZ_LOWBATTZ	BIT(6)
> +#define	TPS65023_PGOODZ_VDCDC1		BIT(5)
> +#define	TPS65023_PGOODZ_VDCDC2		BIT(4)
> +#define	TPS65023_PGOODZ_VDCDC3		BIT(3)
> +#define	TPS65023_PGOODZ_LDO2		BIT(2)
> +#define	TPS65023_PGOODZ_LDO1		BIT(1)
> +
> +/* MASK bitfields */
> +#define	TPS65023_MASK_PWRFAILZ		BIT(7)
> +#define	TPS65023_MASK_LOWBATTZ		BIT(6)
> +#define	TPS65023_MASK_VDCDC1		BIT(5)
> +#define	TPS65023_MASK_VDCDC2		BIT(4)
> +#define	TPS65023_MASK_VDCDC3		BIT(3)
> +#define	TPS65023_MASK_LDO2		BIT(2)
> +#define	TPS65023_MASK_LDO1		BIT(1)
> +
> +/* REG_CTRL bitfields */
> +#define TPS65023_REG_CTRL_VDCDC1_EN	BIT(5)
> +#define TPS65023_REG_CTRL_VDCDC2_EN	BIT(4)
> +#define TPS65023_REG_CTRL_VDCDC3_EN	BIT(3)
> +#define TPS65023_REG_CTRL_LDO2_EN	BIT(2)
> +#define TPS65023_REG_CTRL_LDO1_EN	BIT(1)
> +
> +/* LDO_CTRL bitfields */
> +#define TPS65023_LDO_CTRL_LDOx_SHIFT(ldo_id)	((ldo_id)*4)
> +#define TPS65023_LDO_CTRL_LDOx_MASK(ldo_id)	(0xF0 >> ((ldo_id)*4))
> +
> +/* Number of step-down converters available */
> +#define TPS65023_NUM_DCDC		3
> +/* Number of LDO voltage regulators  available */
> +#define TPS65023_NUM_LDO		2
> +/* Number of total regulators available */
> +#define TPS65023_NUM_REGULATOR	(TPS65023_NUM_DCDC + TPS65023_NUM_LDO)
> +
> +/* DCDCs */
> +#define TPS65023_DCDC_1			0
> +#define TPS65023_DCDC_2			1
> +#define TPS65023_DCDC_3			2
> +/* LDOs */
> +#define TPS65023_LDO_1			3
> +#define TPS65023_LDO_2			4
> +
> +#define TPS65023_MAX_REG_ID		TPS65023_LDO_2
> +
> +/* Supported voltage values for regulators */
> +static const u16 VDCDC1_VSEL_table[] = {
> +	800, 825, 850, 875,
> +	900, 925, 950, 975,
> +	1000, 1025, 1050, 1075,
> +	1100, 1125, 1150, 1175,
> +	1200, 1225, 1250, 1275,
> +	1300, 1325, 1350, 1375,
> +	1400, 1425, 1450, 1475,
> +	1500, 1525, 1550, 1600,
> +};
> +
> +static const u16 LDO1_VSEL_table[] = {
> +	1000, 1100, 1300, 1800,
> +	2200, 2600, 2800, 3150,
> +};
> +
> +static const u16 LDO2_VSEL_table[] = {
> +	1050, 1200, 1300, 1800,
> +	2500, 2800, 3000, 3300,
> +};
> +
> +static unsigned int num_voltages[] = {ARRAY_SIZE(VDCDC1_VSEL_table),
> +				0, 0, ARRAY_SIZE(LDO1_VSEL_table),
> +				ARRAY_SIZE(LDO2_VSEL_table)};
> +
> +/* Regulator specific details */
> +struct tps_info {
> +	const char *name;
> +	unsigned min_uV;
> +	unsigned max_uV;
> +	bool fixed;
> +	u8 table_len;
> +	const u16 *table;
> +};
> +
> +/* PMIC details */
> +struct tps_pmic {
> +	struct regulator_desc desc[TPS65023_NUM_REGULATOR];
> +	struct i2c_client *client;
> +	struct regulator_dev *rdev[TPS65023_NUM_REGULATOR];
> +	const struct tps_info *info[TPS65023_NUM_REGULATOR];
> +	struct mutex io_lock;
> +};
> +
> +static inline int tps_65023_read(struct tps_pmic *tps, u8 reg)
> +{
> +	return i2c_smbus_read_byte_data(tps->client, reg);
> +}
> +
> +static inline int tps_65023_write(struct tps_pmic *tps, u8 reg, u8 val)
> +{
> +	return i2c_smbus_write_byte_data(tps->client, reg, val);
> +}
> +
> +static int tps_65023_set_bits(struct tps_pmic *tps, u8 reg, u8 mask)
> +{
> +	int err;
> +	u8 data;
> +
> +	mutex_lock(&tps->io_lock);
> +
> +	data = tps_65023_read(tps, reg);
> +	if (data < 0) {

data can never be less than 0 as it's unsigned.

> +		dev_err(&tps->client->dev, "Read from reg 0x%x failed\n", reg);
> +		err = data;
> +		goto out;
> +	}
> +
> +	data |= mask;
> +	err = tps_65023_write(tps, reg, data);
> +	if (err)
> +		dev_err(&tps->client->dev, "Write for reg 0x%x failed\n", reg);
> +
> +out:
> +	mutex_unlock(&tps->io_lock);
> +	return err;
> +}
> +
> +static int tps_65023_clear_bits(struct tps_pmic *tps, u8 reg, u8 mask)
> +{
> +	int err;
> +	u8 data;
> +
> +	mutex_lock(&tps->io_lock);
> +
> +	data = tps_65023_read(tps, reg);
> +	if (data < 0) {

ditto.
> +		dev_err(&tps->client->dev, "Read from reg 0x%x failed\n", reg);
> +		err = data;
> +		goto out;
> +	}
> +
> +	data &= ~mask;
> +
> +	err = tps_65023_write(tps, reg, data);
> +	if (err)
> +		dev_err(&tps->client->dev, "Write for reg 0x%x failed\n", reg);
> +
> +out:
> +	mutex_unlock(&tps->io_lock);
> +	return err;
> +
> +}
> +
> +static int tps_65023_reg_read(struct tps_pmic *tps, u8 reg)
> +{
> +	u8 data;
> +
> +	mutex_lock(&tps->io_lock);
> +
> +	data = tps_65023_read(tps, reg);
> +	if (data < 0)
> +		dev_err(&tps->client->dev, "Read from reg 0x%x failed\n", reg);
> +

ditto

> +	mutex_unlock(&tps->io_lock);
> +	return data;
> +}
> +
> +static int tps_65023_reg_write(struct tps_pmic *tps, u8 reg, u8 val)
> +{
> +	int err;
> +
> +	mutex_lock(&tps->io_lock);
> +
> +	err = tps_65023_write(tps, reg, val);
> +	if (err < 0)
> +		dev_err(&tps->client->dev, "Write for reg 0x%x failed\n", reg);
> +
> +	mutex_unlock(&tps->io_lock);
> +	return err;
> +}
> +
> +static int tps65023_dcdc_is_enabled(struct regulator_dev *dev)
> +{
> +	u8 data;
> +	struct tps_pmic *tps = rdev_get_drvdata(dev);
> +	int dcdc = rdev_get_id(dev);
> +	u8 shift;
> +
> +	if (dcdc < TPS65023_DCDC_1 || dcdc > TPS65023_DCDC_3)
> +		return -EINVAL;
> +
> +	shift = TPS65023_NUM_REGULATOR - dcdc;
> +	data = tps_65023_reg_read(tps, TPS65023_REG_REG_CTRL);
> +
> +	if (data >= 0) {
> +		data &= (1 << shift);
> +		return data ? 1 : 0;
> +	} else
> +		return data;

data always >=0 here.

> +}
> +
> +static int tps65023_ldo_is_enabled(struct regulator_dev *dev)
> +{
> +	struct tps_pmic *tps = rdev_get_drvdata(dev);
> +	int ldo = rdev_get_id(dev);
> +	u8 shift;
> +	u8 data;
> +
> +	if (ldo < TPS65023_LDO_1 || ldo > TPS65023_LDO_2)
> +		return -EINVAL;
> +
> +	shift = (ldo == TPS65023_LDO_1 ? 1 : 2);
> +	data = tps_65023_reg_read(tps, TPS65023_REG_REG_CTRL);
> +
> +	if (data >= 0) {
> +		data &= (1 << shift);
> +		return data ? 1 : 0;
> +	} else
> +		return data;

ditto.

A few more unsigned data comparisons in this file. Please fix.

There is also trailing white space in this patch. Please use
scripts/cleanfile to remove trailing white space.

Thanks

Liam
