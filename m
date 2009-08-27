From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 1/8] Regulator: Add TPS65023 regulator driver
Date: Thu, 27 Aug 2009 08:22:15 +0200
Message-ID: <63386a3d0908262322m3bb16d2dvff328b8c653b1f68@mail.gmail.com>
References: <1250052476-28763-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1250052476-28763-1-git-send-email-anuj.aggarwal-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anuj Aggarwal <anuj.aggarwal-l0cyMroinI0@public.gmane.org>
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

2009/8/12 Anuj Aggarwal <anuj.aggarwal-l0cyMroinI0@public.gmane.org>:

> Adding support for TI TPS65023 regulator driver
>
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal-l0cyMroinI0@public.gmane.org>
> ---
> =A0drivers/regulator/tps65023-regulator.c | =A0638 ++++++++++++++++++=
++++++++++++++
> =A01 files changed, 638 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/regulator/tps65023-regulator.c
>
> diff --git a/drivers/regulator/tps65023-regulator.c b/drivers/regulat=
or/tps65023-regulator.c
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
> + * Copyright (C) 2009 Texas Instrument Incorporated - http://www.ti.=
com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any k=
ind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the G=
NU
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
> +#define =A0 =A0 =A0 =A0TPS65023_REG_VERSION =A0 =A0 =A0 =A0 =A0 =A00
> +#define =A0 =A0 =A0 =A0TPS65023_REG_PGOODZ =A0 =A0 =A0 =A0 =A0 =A0 1
> +#define =A0 =A0 =A0 =A0TPS65023_REG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 2
> +#define =A0 =A0 =A0 =A0TPS65023_REG_REG_CTRL =A0 =A0 =A0 =A0 =A0 3
> +#define =A0 =A0 =A0 =A0TPS65023_REG_CON_CTRL =A0 =A0 =A0 =A0 =A0 4
> +#define =A0 =A0 =A0 =A0TPS65023_REG_CON_CTRL2 =A0 =A0 =A0 =A0 =A05
> +#define =A0 =A0 =A0 =A0TPS65023_REG_DEF_CORE =A0 =A0 =A0 =A0 =A0 6
> +#define =A0 =A0 =A0 =A0TPS65023_REG_DEFSLEW =A0 =A0 =A0 =A0 =A0 =A07
> +#define =A0 =A0 =A0 =A0TPS65023_REG_LDO_CTRL =A0 =A0 =A0 =A0 =A0 8
> +
> +/* PGOODZ bitfields */
> +#define =A0 =A0 =A0 =A0TPS65023_PGOODZ_PWRFAILZ =A0 =A0 =A0 =A0BIT(7=
)
> +#define =A0 =A0 =A0 =A0TPS65023_PGOODZ_LOWBATTZ =A0 =A0 =A0 =A0BIT(6=
)
> +#define =A0 =A0 =A0 =A0TPS65023_PGOODZ_VDCDC1 =A0 =A0 =A0 =A0 =A0BIT=
(5)
> +#define =A0 =A0 =A0 =A0TPS65023_PGOODZ_VDCDC2 =A0 =A0 =A0 =A0 =A0BIT=
(4)
> +#define =A0 =A0 =A0 =A0TPS65023_PGOODZ_VDCDC3 =A0 =A0 =A0 =A0 =A0BIT=
(3)
> +#define =A0 =A0 =A0 =A0TPS65023_PGOODZ_LDO2 =A0 =A0 =A0 =A0 =A0 =A0B=
IT(2)
> +#define =A0 =A0 =A0 =A0TPS65023_PGOODZ_LDO1 =A0 =A0 =A0 =A0 =A0 =A0B=
IT(1)
> +
> +/* MASK bitfields */
> +#define =A0 =A0 =A0 =A0TPS65023_MASK_PWRFAILZ =A0 =A0 =A0 =A0 =A0BIT=
(7)
> +#define =A0 =A0 =A0 =A0TPS65023_MASK_LOWBATTZ =A0 =A0 =A0 =A0 =A0BIT=
(6)
> +#define =A0 =A0 =A0 =A0TPS65023_MASK_VDCDC1 =A0 =A0 =A0 =A0 =A0 =A0B=
IT(5)
> +#define =A0 =A0 =A0 =A0TPS65023_MASK_VDCDC2 =A0 =A0 =A0 =A0 =A0 =A0B=
IT(4)
> +#define =A0 =A0 =A0 =A0TPS65023_MASK_VDCDC3 =A0 =A0 =A0 =A0 =A0 =A0B=
IT(3)
> +#define =A0 =A0 =A0 =A0TPS65023_MASK_LDO2 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
BIT(2)
> +#define =A0 =A0 =A0 =A0TPS65023_MASK_LDO1 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
BIT(1)
> +
> +/* REG_CTRL bitfields */
> +#define TPS65023_REG_CTRL_VDCDC1_EN =A0 =A0BIT(5)
> +#define TPS65023_REG_CTRL_VDCDC2_EN =A0 =A0BIT(4)
> +#define TPS65023_REG_CTRL_VDCDC3_EN =A0 =A0BIT(3)
> +#define TPS65023_REG_CTRL_LDO2_EN =A0 =A0 =A0BIT(2)
> +#define TPS65023_REG_CTRL_LDO1_EN =A0 =A0 =A0BIT(1)
> +
> +/* LDO_CTRL bitfields */
> +#define TPS65023_LDO_CTRL_LDOx_SHIFT(ldo_id) =A0 ((ldo_id)*4)
> +#define TPS65023_LDO_CTRL_LDOx_MASK(ldo_id) =A0 =A0(0xF0 >> ((ldo_id=
)*4))
> +
> +/* Number of step-down converters available */
> +#define TPS65023_NUM_DCDC =A0 =A0 =A0 =A0 =A0 =A0 =A03
> +/* Number of LDO voltage regulators =A0available */
> +#define TPS65023_NUM_LDO =A0 =A0 =A0 =A0 =A0 =A0 =A0 2
> +/* Number of total regulators available */
> +#define TPS65023_NUM_REGULATOR (TPS65023_NUM_DCDC + TPS65023_NUM_LDO=
)
> +
> +/* DCDCs */
> +#define TPS65023_DCDC_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00
> +#define TPS65023_DCDC_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A01
> +#define TPS65023_DCDC_3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A02
> +/* LDOs */
> +#define TPS65023_LDO_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3
> +#define TPS65023_LDO_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 4
> +
> +#define TPS65023_MAX_REG_ID =A0 =A0 =A0 =A0 =A0 =A0TPS65023_LDO_2
> +
> +/* Supported voltage values for regulators */
> +static const u16 VDCDC1_VSEL_table[] =3D {
> + =A0 =A0 =A0 800, 825, 850, 875,
> + =A0 =A0 =A0 900, 925, 950, 975,
> + =A0 =A0 =A0 1000, 1025, 1050, 1075,
> + =A0 =A0 =A0 1100, 1125, 1150, 1175,
> + =A0 =A0 =A0 1200, 1225, 1250, 1275,
> + =A0 =A0 =A0 1300, 1325, 1350, 1375,
> + =A0 =A0 =A0 1400, 1425, 1450, 1475,
> + =A0 =A0 =A0 1500, 1525, 1550, 1600,
> +};
> +
> +static const u16 LDO1_VSEL_table[] =3D {
> + =A0 =A0 =A0 1000, 1100, 1300, 1800,
> + =A0 =A0 =A0 2200, 2600, 2800, 3150,
> +};
> +
> +static const u16 LDO2_VSEL_table[] =3D {
> + =A0 =A0 =A0 1050, 1200, 1300, 1800,
> + =A0 =A0 =A0 2500, 2800, 3000, 3300,
> +};
> +
> +static unsigned int num_voltages[] =3D {ARRAY_SIZE(VDCDC1_VSEL_table=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, 0, A=
RRAY_SIZE(LDO1_VSEL_table),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_S=
IZE(LDO2_VSEL_table)};
> +
> +/* Regulator specific details */
> +struct tps_info {
> + =A0 =A0 =A0 const char *name;
> + =A0 =A0 =A0 unsigned min_uV;
> + =A0 =A0 =A0 unsigned max_uV;
> + =A0 =A0 =A0 bool fixed;
> + =A0 =A0 =A0 u8 table_len;
> + =A0 =A0 =A0 const u16 *table;
> +};
> +
> +/* PMIC details */
> +struct tps_pmic {
> + =A0 =A0 =A0 struct regulator_desc desc[TPS65023_NUM_REGULATOR];
> + =A0 =A0 =A0 struct i2c_client *client;
> + =A0 =A0 =A0 struct regulator_dev *rdev[TPS65023_NUM_REGULATOR];
> + =A0 =A0 =A0 const struct tps_info *info[TPS65023_NUM_REGULATOR];
> + =A0 =A0 =A0 struct mutex io_lock;
> +};
> +
> +static inline int tps_65023_read(struct tps_pmic *tps, u8 reg)
> +{
> + =A0 =A0 =A0 return i2c_smbus_read_byte_data(tps->client, reg);
> +}
> +
> +static inline int tps_65023_write(struct tps_pmic *tps, u8 reg, u8 v=
al)
> +{
> + =A0 =A0 =A0 return i2c_smbus_write_byte_data(tps->client, reg, val)=
;
> +}
> +
> +static int tps_65023_set_bits(struct tps_pmic *tps, u8 reg, u8 mask)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 u8 data;
> +
> + =A0 =A0 =A0 mutex_lock(&tps->io_lock);
> +
> + =A0 =A0 =A0 data =3D tps_65023_read(tps, reg);
> + =A0 =A0 =A0 if (data < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tps->client->dev, "Read from r=
eg 0x%x failed\n", reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 data |=3D mask;
> + =A0 =A0 =A0 err =3D tps_65023_write(tps, reg, data);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tps->client->dev, "Write for r=
eg 0x%x failed\n", reg);
> +
> +out:
> + =A0 =A0 =A0 mutex_unlock(&tps->io_lock);
> + =A0 =A0 =A0 return err;
> +}
> +
> +static int tps_65023_clear_bits(struct tps_pmic *tps, u8 reg, u8 mas=
k)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 u8 data;
> +
> + =A0 =A0 =A0 mutex_lock(&tps->io_lock);
> +
> + =A0 =A0 =A0 data =3D tps_65023_read(tps, reg);
> + =A0 =A0 =A0 if (data < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tps->client->dev, "Read from r=
eg 0x%x failed\n", reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 data &=3D ~mask;
> +
> + =A0 =A0 =A0 err =3D tps_65023_write(tps, reg, data);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tps->client->dev, "Write for r=
eg 0x%x failed\n", reg);
> +
> +out:
> + =A0 =A0 =A0 mutex_unlock(&tps->io_lock);
> + =A0 =A0 =A0 return err;
> +
> +}
> +
> +static int tps_65023_reg_read(struct tps_pmic *tps, u8 reg)
> +{
> + =A0 =A0 =A0 u8 data;
> +
> + =A0 =A0 =A0 mutex_lock(&tps->io_lock);
> +
> + =A0 =A0 =A0 data =3D tps_65023_read(tps, reg);
> + =A0 =A0 =A0 if (data < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tps->client->dev, "Read from r=
eg 0x%x failed\n", reg);
> +
> + =A0 =A0 =A0 mutex_unlock(&tps->io_lock);
> + =A0 =A0 =A0 return data;
> +}
> +
> +static int tps_65023_reg_write(struct tps_pmic *tps, u8 reg, u8 val)
> +{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 mutex_lock(&tps->io_lock);
> +
> + =A0 =A0 =A0 err =3D tps_65023_write(tps, reg, val);
> + =A0 =A0 =A0 if (err < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tps->client->dev, "Write for r=
eg 0x%x failed\n", reg);
> +
> + =A0 =A0 =A0 mutex_unlock(&tps->io_lock);
> + =A0 =A0 =A0 return err;
> +}
> +
> +static int tps65023_dcdc_is_enabled(struct regulator_dev *dev)
> +{
> + =A0 =A0 =A0 u8 data;
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int dcdc =3D rdev_get_id(dev);
> + =A0 =A0 =A0 u8 shift;
> +
> + =A0 =A0 =A0 if (dcdc < TPS65023_DCDC_1 || dcdc > TPS65023_DCDC_3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 shift =3D TPS65023_NUM_REGULATOR - dcdc;
> + =A0 =A0 =A0 data =3D tps_65023_reg_read(tps, TPS65023_REG_REG_CTRL)=
;
> +
> + =A0 =A0 =A0 if (data >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data &=3D (1 << shift);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data ? 1 : 0;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data;
> +}
> +
> +static int tps65023_ldo_is_enabled(struct regulator_dev *dev)
> +{
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int ldo =3D rdev_get_id(dev);
> + =A0 =A0 =A0 u8 shift;
> + =A0 =A0 =A0 u8 data;
> +
> + =A0 =A0 =A0 if (ldo < TPS65023_LDO_1 || ldo > TPS65023_LDO_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 shift =3D (ldo =3D=3D TPS65023_LDO_1 ? 1 : 2);
> + =A0 =A0 =A0 data =3D tps_65023_reg_read(tps, TPS65023_REG_REG_CTRL)=
;
> +
> + =A0 =A0 =A0 if (data >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data &=3D (1 << shift);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data ? 1 : 0;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data;
> +}
> +
> +static int tps65023_dcdc_enable(struct regulator_dev *dev)
> +{
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int dcdc =3D rdev_get_id(dev);
> + =A0 =A0 =A0 u8 shift;
> +
> + =A0 =A0 =A0 if (dcdc < TPS65023_DCDC_1 || dcdc > TPS65023_DCDC_3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 shift =3D TPS65023_NUM_REGULATOR - dcdc;
> + =A0 =A0 =A0 return tps_65023_set_bits(tps, TPS65023_REG_REG_CTRL, 1=
 << shift);
> +}
> +
> +static int tps65023_dcdc_disable(struct regulator_dev *dev)
> +{
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int dcdc =3D rdev_get_id(dev);
> + =A0 =A0 =A0 u8 shift;
> +
> + =A0 =A0 =A0 if (dcdc < TPS65023_DCDC_1 || dcdc > TPS65023_DCDC_3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 shift =3D TPS65023_NUM_REGULATOR - dcdc;
> + =A0 =A0 =A0 return tps_65023_clear_bits(tps, TPS65023_REG_REG_CTRL,=
 1 << shift);
> +}
> +
> +static int tps65023_ldo_enable(struct regulator_dev *dev)
> +{
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int ldo =3D rdev_get_id(dev);
> + =A0 =A0 =A0 u8 shift;
> +
> + =A0 =A0 =A0 if (ldo < TPS65023_LDO_1 || ldo > TPS65023_LDO_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 shift =3D (ldo =3D=3D TPS65023_LDO_1 ? 1 : 2);
> + =A0 =A0 =A0 return tps_65023_set_bits(tps, TPS65023_REG_REG_CTRL, 1=
 << shift);
> +}
> +
> +static int tps65023_ldo_disable(struct regulator_dev *dev)
> +{
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int ldo =3D rdev_get_id(dev);
> + =A0 =A0 =A0 u8 shift;
> +
> + =A0 =A0 =A0 if (ldo < TPS65023_LDO_1 || ldo > TPS65023_LDO_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 shift =3D (ldo =3D=3D TPS65023_LDO_1 ? 1 : 2);
> + =A0 =A0 =A0 return tps_65023_clear_bits(tps, TPS65023_REG_REG_CTRL,=
 1 << shift);
> +}
> +
> +static int tps65023_dcdc_get_voltage(struct regulator_dev *dev)
> +{
> + =A0 =A0 =A0 u8 data;
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int dcdc =3D rdev_get_id(dev);
> +
> + =A0 =A0 =A0 if (dcdc < TPS65023_DCDC_1 || dcdc > TPS65023_DCDC_3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (dcdc =3D=3D TPS65023_DCDC_1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D tps_65023_reg_read(tps, TPS650=
23_REG_DEF_CORE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data &=3D (tps->info[dcdc]->table_len -=
 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tps->info[dcdc]->table[data] * 1=
000;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tps->info[dcdc]->min_uV;
> +}
> +
> +static int tps65023_dcdc_set_voltage(struct regulator_dev *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int min=
_uV, int max_uV)
> +{
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int dcdc =3D rdev_get_id(dev);
> + =A0 =A0 =A0 int vsel;
> +
> + =A0 =A0 =A0 if (dcdc !=3D TPS65023_DCDC_1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (min_uV < tps->info[dcdc]->min_uV
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || min_uV > tps->info[d=
cdc]->max_uV)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (max_uV < tps->info[dcdc]->min_uV
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || max_uV > tps->info[d=
cdc]->max_uV)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 for (vsel =3D 0; vsel < tps->info[dcdc]->table_len; vse=
l++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int mV =3D tps->info[dcdc]->table[vsel]=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int uV =3D mV * 1000;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Break at the first in-range value */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (min_uV <=3D uV && uV <=3D max_uV)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* write to the register in case we found a match */
> + =A0 =A0 =A0 if (vsel =3D=3D tps->info[dcdc]->table_len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tps_65023_reg_write(tps, TPS6502=
3_REG_DEF_CORE, vsel);
> +}
> +
> +static int tps65023_ldo_get_voltage(struct regulator_dev *dev)
> +{
> + =A0 =A0 =A0 u8 data;
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int ldo =3D rdev_get_id(dev);
> +
> + =A0 =A0 =A0 if (ldo < TPS65023_LDO_1 || ldo > TPS65023_LDO_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 data =3D tps_65023_reg_read(tps, TPS65023_REG_LDO_CTRL)=
;
> + =A0 =A0 =A0 if (data < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data;
> +
> + =A0 =A0 =A0 data >>=3D (TPS65023_LDO_CTRL_LDOx_SHIFT(ldo - TPS65023=
_LDO_1));
> + =A0 =A0 =A0 data &=3D (tps->info[ldo]->table_len - 1);
> + =A0 =A0 =A0 return tps->info[ldo]->table[data] * 1000;
> +}
> +
> +static int tps65023_ldo_set_voltage(struct regulator_dev *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int min=
_uV, int max_uV)
> +{
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int ldo =3D rdev_get_id(dev);
> + =A0 =A0 =A0 int vsel;
> + =A0 =A0 =A0 u8 data;
> +
> + =A0 =A0 =A0 if (ldo < TPS65023_LDO_1 || ldo > TPS65023_LDO_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (min_uV < tps->info[ldo]->min_uV || min_uV > tps->in=
fo[ldo]->max_uV)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (max_uV < tps->info[ldo]->min_uV || max_uV > tps->in=
fo[ldo]->max_uV)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 for (vsel =3D 0; vsel < tps->info[ldo]->table_len; vsel=
++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int mV =3D tps->info[ldo]->table[vsel];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int uV =3D mV * 1000;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Break at the first in-range value */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (min_uV <=3D uV && uV <=3D max_uV)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (vsel =3D=3D tps->info[ldo]->table_len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 data =3D tps_65023_reg_read(tps, TPS65023_REG_LDO_CTRL)=
;
> + =A0 =A0 =A0 if (data < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data;
> +
> + =A0 =A0 =A0 data &=3D TPS65023_LDO_CTRL_LDOx_MASK(ldo - TPS65023_LD=
O_1);
> + =A0 =A0 =A0 data |=3D (vsel << (TPS65023_LDO_CTRL_LDOx_SHIFT(ldo - =
TPS65023_LDO_1)));
> + =A0 =A0 =A0 return tps_65023_reg_write(tps, TPS65023_REG_LDO_CTRL, =
data);
> +}
> +
> +static int tps65023_dcdc_list_voltage(struct regulator_dev *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 unsigned selector)
> +{
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int dcdc =3D rdev_get_id(dev);
> +
> + =A0 =A0 =A0 if (dcdc < TPS65023_DCDC_1 || dcdc > TPS65023_DCDC_3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (dcdc =3D=3D TPS65023_DCDC_1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (selector >=3D tps->info[dcdc]->tabl=
e_len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tps->info[dcdc]-=
>table[selector] * 1000;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tps->info[dcdc]->min_uV;
> +}
> +
> +static int tps65023_ldo_list_voltage(struct regulator_dev *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 unsigned selector)
> +{
> + =A0 =A0 =A0 struct tps_pmic *tps =3D rdev_get_drvdata(dev);
> + =A0 =A0 =A0 int ldo =3D rdev_get_id(dev);
> +
> + =A0 =A0 =A0 if (ldo < TPS65023_LDO_1 || ldo > TPS65023_LDO_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (selector >=3D tps->info[ldo]->table_len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tps->info[ldo]->table[selector] =
* 1000;
> +}
> +
> +/* Operations permitted on VDCDCx */
> +static struct regulator_ops tps65023_dcdc_ops =3D {
> + =A0 =A0 =A0 .is_enabled =3D tps65023_dcdc_is_enabled,
> + =A0 =A0 =A0 .enable =3D tps65023_dcdc_enable,
> + =A0 =A0 =A0 .disable =3D tps65023_dcdc_disable,
> + =A0 =A0 =A0 .get_voltage =3D tps65023_dcdc_get_voltage,
> + =A0 =A0 =A0 .set_voltage =3D tps65023_dcdc_set_voltage,
> + =A0 =A0 =A0 .list_voltage =3D tps65023_dcdc_list_voltage,
> +};
> +
> +/* Operations permitted on LDOx */
> +static struct regulator_ops tps65023_ldo_ops =3D {
> + =A0 =A0 =A0 .is_enabled =3D tps65023_ldo_is_enabled,
> + =A0 =A0 =A0 .enable =3D tps65023_ldo_enable,
> + =A0 =A0 =A0 .disable =3D tps65023_ldo_disable,
> + =A0 =A0 =A0 .get_voltage =3D tps65023_ldo_get_voltage,
> + =A0 =A0 =A0 .set_voltage =3D tps65023_ldo_set_voltage,
> + =A0 =A0 =A0 .list_voltage =3D tps65023_ldo_list_voltage,
> +};
> +
> +static
> +int tps_65023_probe(struct i2c_client *client, const struct i2c_devi=
ce_id *id)
> +{
> + =A0 =A0 =A0 static int desc_id;
> + =A0 =A0 =A0 const struct tps_info *info =3D (void *)id->driver_data=
;
> + =A0 =A0 =A0 struct regulator_init_data *init_data;
> + =A0 =A0 =A0 struct regulator_dev *rdev;
> + =A0 =A0 =A0 struct tps_pmic *tps;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_FUNC_=
SMBUS_BYTE_DATA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> +
> + =A0 =A0 =A0 /**
> + =A0 =A0 =A0 =A0* init_data points to array of regulator_init struct=
ures
> + =A0 =A0 =A0 =A0* coming from the board-evm file.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 init_data =3D client->dev.platform_data;
> +
> + =A0 =A0 =A0 if (!init_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> +
> + =A0 =A0 =A0 tps =3D kzalloc(sizeof(*tps), GFP_KERNEL);
> + =A0 =A0 =A0 if (!tps)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 tps->client =3D client;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < TPS65023_NUM_REGULATOR; i++, info++, =
init_data++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Store regulator specific information=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tps->info[i] =3D info;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tps->desc[i].name =3D info->name;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tps->desc[i].id =3D desc_id++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tps->desc[i].n_voltages =3D num_voltage=
s[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tps->desc[i].ops =3D (i > TPS65023_DCDC=
_3 ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &tps65023_ldo_ops : &tps65023_dcdc_ops);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tps->desc[i].type =3D REGULATOR_VOLTAGE=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tps->desc[i].owner =3D THIS_MODULE;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Register the regulators */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev =3D regulator_register(&tps->desc[=
i], &client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 init_data, tps=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(rdev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "=
failed to register %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 id->nam=
e);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Unregister */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (i)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulat=
or_unregister(tps->rdev[--i]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tps->client =3D NULL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* clear the client dat=
a in i2c */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_set_clientdata(clie=
nt, NULL);

You haven't yet set the clientdata at this point, so it is already NULL=
=2E
So this is unnecessary.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(tps);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(rdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Save regulator for cleanup */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tps->rdev[i] =3D rdev;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 i2c_set_clientdata(client, tps);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * tps_65023_remove - TPS65023 driver i2c remove handler
> + * @client: i2c driver client device structure
> + *
> + * Unregister TPS driver as an i2c client device driver
> + */
> +static int __devexit tps_65023_remove(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct tps_pmic *tps =3D i2c_get_clientdata(client);
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < TPS65023_NUM_REGULATOR; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_unregister(tps->rdev[i]);
> +
> + =A0 =A0 =A0 tps->client =3D NULL;
> +
> + =A0 =A0 =A0 /* clear the client data in i2c */
> + =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
> + =A0 =A0 =A0 kfree(tps);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct tps_info tps65023_regs[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VDCDC1",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D =A0800000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1600000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .table_len =3D ARRAY_SIZE(VDCDC1_VSEL_t=
able),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .table =3D VDCDC1_VSEL_table,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VDCDC2",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D =A03300000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3300000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .fixed =3D 1,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VDCDC3",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D =A01800000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1800000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .fixed =3D 1,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "LDO1",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1000000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3150000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .table_len =3D ARRAY_SIZE(LDO1_VSEL_tab=
le),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .table =3D LDO1_VSEL_table,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "LDO2",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1050000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3300000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .table_len =3D ARRAY_SIZE(LDO2_VSEL_tab=
le),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .table =3D LDO2_VSEL_table,
> + =A0 =A0 =A0 },
> +};
> +
> +static const struct i2c_device_id tps_65023_id =3D {
> + =A0 =A0 =A0 .name =3D "tps65023",
> + =A0 =A0 =A0 .driver_data =3D (unsigned long) &tps65023_regs[0],
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, tps_65023_id);
> +
> +static struct i2c_driver tps_65023_i2c_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "tps65023",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =3D tps_65023_probe,
> + =A0 =A0 =A0 .remove =3D __devexit_p(tps_65023_remove),
> + =A0 =A0 =A0 .id_table =3D &tps_65023_id,
> +};
> +
> +/**
> + * tps_65023_init
> + *
> + * Module init function
> + */
> +static int __init tps_65023_init(void)
> +{
> + =A0 =A0 =A0 return i2c_add_driver(&tps_65023_i2c_driver);
> +}
> +subsys_initcall(tps_65023_init);
> +
> +/**
> + * tps_65023_cleanup
> + *
> + * Module exit function
> + */
> +static void __exit tps_65023_cleanup(void)
> +{
> + =A0 =A0 =A0 i2c_del_driver(&tps_65023_i2c_driver);
> +}
> +module_exit(tps_65023_cleanup);
> +
> +MODULE_AUTHOR("Texas Instruments");
> +MODULE_DESCRIPTION("TPS65023 voltage regulator driver");
> +MODULE_LICENSE("GPLv2");
> --
> 1.6.2.4

Yours,
Linus Walleij
