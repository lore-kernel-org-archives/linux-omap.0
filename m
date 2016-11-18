From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: twl: split twl6030 logic into its own file" to the regulator tree
Date: Fri, 18 Nov 2016 12:01:57 +0000
Message-ID: <E1c7hrh-0005KL-Br@debutante>
References: <1478954535-17325-5-git-send-email-Nicolae_Rosia@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478954535-17325-5-git-send-email-Nicolae_Rosia@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: twl: split twl6030 logic into its own file

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From cac28ae60e3dae1814f12f0d24d041a67153692c Mon Sep 17 00:00:00 2001
From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Date: Sat, 12 Nov 2016 14:42:15 +0200
Subject: [PATCH] regulator: twl: split twl6030 logic into its own file

In order to not break existing users, we keep using the same
CONFIG symbol.
This makes it easier to add support for TWL6032 and refactor
mfd/twl-core.
Checkpatch warnings are inherited from twl-regulator.c and will
be addressed in a subsequent patch.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS                           |   1 +
 drivers/regulator/Makefile            |   2 +-
 drivers/regulator/twl-regulator.c     | 600 +------------------------
 drivers/regulator/twl6030-regulator.c | 805 ++++++++++++++++++++++++++++++++++
 4 files changed, 812 insertions(+), 596 deletions(-)
 create mode 100644 drivers/regulator/twl6030-regulator.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7e0064..1317123f100d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8721,6 +8721,7 @@ F:	drivers/regulator/tps65217-regulator.c
 F:	drivers/regulator/tps65218-regulator.c
 F:	drivers/regulator/tps65910-regulator.c
 F:	drivers/regulator/twl-regulator.c
+F:	drivers/regulator/twl6030-regulator.c
 F:	include/linux/i2c-omap.h
 
 OMAP DEVICE TREE SUPPORT
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 2142a5d3fc08..14294692beb9 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -104,7 +104,7 @@ obj-$(CONFIG_REGULATOR_TPS6586X) += tps6586x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65910) += tps65910-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65912) += tps65912-regulator.o
 obj-$(CONFIG_REGULATOR_TPS80031) += tps80031-regulator.o
-obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o
+obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o twl6030-regulator.o
 obj-$(CONFIG_REGULATOR_VEXPRESS) += vexpress-regulator.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-dcdc.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-isink.o
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 3f9f53d98ef0..d572b8a583e4 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -24,7 +24,7 @@
 #include <linux/delay.h>
 
 /*
- * The TWL4030/TW5030/TPS659x0/TWL6030 family chips include power management, a
+ * The TWL4030/TW5030/TPS659x0 family chips include power management, a
  * USB OTG transceiver, an RTC, ADC, PWM, and lots more.  Some versions
  * include an audio codec, battery charger, and more voltage regulators.
  * These chips are often used in OMAP-based systems.
@@ -81,33 +81,6 @@ struct twlreg_info {
 #define VREG_STATE		2
 #define VREG_VOLTAGE		3
 #define VREG_VOLTAGE_SMPS	4
-/* TWL6030 Misc register offsets */
-#define VREG_BC_ALL		1
-#define VREG_BC_REF		2
-#define VREG_BC_PROC		3
-#define VREG_BC_CLK_RST		4
-
-/* TWL6030 LDO register values for CFG_STATE */
-#define TWL6030_CFG_STATE_OFF	0x00
-#define TWL6030_CFG_STATE_ON	0x01
-#define TWL6030_CFG_STATE_OFF2	0x02
-#define TWL6030_CFG_STATE_SLEEP	0x03
-#define TWL6030_CFG_STATE_GRP_SHIFT	5
-#define TWL6030_CFG_STATE_APP_SHIFT	2
-#define TWL6030_CFG_STATE_APP_MASK	(0x03 << TWL6030_CFG_STATE_APP_SHIFT)
-#define TWL6030_CFG_STATE_APP(v)	(((v) & TWL6030_CFG_STATE_APP_MASK) >>\
-						TWL6030_CFG_STATE_APP_SHIFT)
-
-/* Flags for SMPS Voltage reading */
-#define SMPS_OFFSET_EN		BIT(0)
-#define SMPS_EXTENDED_EN	BIT(1)
-
-/* twl6032 SMPS EPROM values */
-#define TWL6030_SMPS_OFFSET		0xB0
-#define TWL6030_SMPS_MULT		0xB3
-#define SMPS_MULTOFFSET_SMPS4	BIT(0)
-#define SMPS_MULTOFFSET_VIO	BIT(1)
-#define SMPS_MULTOFFSET_SMPS3	BIT(6)
 
 static inline int
 twlreg_read(struct twlreg_info *info, unsigned slave_subgp, unsigned offset)
@@ -161,26 +134,6 @@ static int twl4030reg_is_enabled(struct regulator_dev *rdev)
 	return state & P1_GRP_4030;
 }
 
-static int twl6030reg_is_enabled(struct regulator_dev *rdev)
-{
-	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-	int			grp = 0, val;
-
-	if (!(twl_class_is_6030() && (info->features & TWL6032_SUBCLASS))) {
-		grp = twlreg_grp(rdev);
-		if (grp < 0)
-			return grp;
-		grp &= P1_GRP_6030;
-	} else {
-		grp = 1;
-	}
-
-	val = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_STATE);
-	val = TWL6030_CFG_STATE_APP(val);
-
-	return grp && (val == TWL6030_CFG_STATE_ON);
-}
-
 #define PB_I2C_BUSY	BIT(0)
 #define PB_I2C_BWEN	BIT(1)
 
@@ -266,23 +219,6 @@ static int twl4030reg_enable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static int twl6030reg_enable(struct regulator_dev *rdev)
-{
-	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-	int			grp = 0;
-	int			ret;
-
-	if (!(twl_class_is_6030() && (info->features & TWL6032_SUBCLASS)))
-		grp = twlreg_grp(rdev);
-	if (grp < 0)
-		return grp;
-
-	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
-			grp << TWL6030_CFG_STATE_GRP_SHIFT |
-			TWL6030_CFG_STATE_ON);
-	return ret;
-}
-
 static int twl4030reg_disable(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
@@ -300,23 +236,6 @@ static int twl4030reg_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static int twl6030reg_disable(struct regulator_dev *rdev)
-{
-	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-	int			grp = 0;
-	int			ret;
-
-	if (!(twl_class_is_6030() && (info->features & TWL6032_SUBCLASS)))
-		grp = P1_GRP_6030 | P2_GRP_6030 | P3_GRP_6030;
-
-	/* For 6030, set the off state for all grps enabled */
-	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
-			(grp) << TWL6030_CFG_STATE_GRP_SHIFT |
-			TWL6030_CFG_STATE_OFF);
-
-	return ret;
-}
-
 static int twl4030reg_get_status(struct regulator_dev *rdev)
 {
 	int	state = twlreg_grp(rdev);
@@ -333,33 +252,6 @@ static int twl4030reg_get_status(struct regulator_dev *rdev)
 		: REGULATOR_STATUS_STANDBY;
 }
 
-static int twl6030reg_get_status(struct regulator_dev *rdev)
-{
-	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-	int			val;
-
-	val = twlreg_grp(rdev);
-	if (val < 0)
-		return val;
-
-	val = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_STATE);
-
-	switch (TWL6030_CFG_STATE_APP(val)) {
-	case TWL6030_CFG_STATE_ON:
-		return REGULATOR_STATUS_NORMAL;
-
-	case TWL6030_CFG_STATE_SLEEP:
-		return REGULATOR_STATUS_STANDBY;
-
-	case TWL6030_CFG_STATE_OFF:
-	case TWL6030_CFG_STATE_OFF2:
-	default:
-		break;
-	}
-
-	return REGULATOR_STATUS_OFF;
-}
-
 static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
@@ -392,36 +284,6 @@ static inline unsigned int twl4030reg_map_mode(unsigned int mode)
 	}
 }
 
-static int twl6030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
-{
-	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-	int grp = 0;
-	int val;
-
-	if (!(twl_class_is_6030() && (info->features & TWL6032_SUBCLASS)))
-		grp = twlreg_grp(rdev);
-
-	if (grp < 0)
-		return grp;
-
-	/* Compose the state register settings */
-	val = grp << TWL6030_CFG_STATE_GRP_SHIFT;
-	/* We can only set the mode through state machine commands... */
-	switch (mode) {
-	case REGULATOR_MODE_NORMAL:
-		val |= TWL6030_CFG_STATE_ON;
-		break;
-	case REGULATOR_MODE_STANDBY:
-		val |= TWL6030_CFG_STATE_SLEEP;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE, val);
-}
-
 /*----------------------------------------------------------------------*/
 
 /*
@@ -579,75 +441,6 @@ static struct regulator_ops twl4030smps_ops = {
 	.get_voltage	= twl4030smps_get_voltage,
 };
 
-static int twl6030coresmps_set_voltage(struct regulator_dev *rdev, int min_uV,
-	int max_uV, unsigned *selector)
-{
-	return -ENODEV;
-}
-
-static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
-{
-	return -ENODEV;
-}
-
-static struct regulator_ops twl6030coresmps_ops = {
-	.set_voltage	= twl6030coresmps_set_voltage,
-	.get_voltage	= twl6030coresmps_get_voltage,
-};
-
-static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsigned sel)
-{
-	struct twlreg_info *info = rdev_get_drvdata(rdev);
-
-	switch (sel) {
-	case 0:
-		return 0;
-	case 1 ... 24:
-		/* Linear mapping from 00000001 to 00011000:
-		 * Absolute voltage value = 1.0 V + 0.1 V × (sel – 00000001)
-		 */
-		return (info->min_mV + 100 * (sel - 1)) * 1000;
-	case 25 ... 30:
-		return -EINVAL;
-	case 31:
-		return 2750000;
-	default:
-		return -EINVAL;
-	}
-}
-
-static int
-twl6030ldo_set_voltage_sel(struct regulator_dev *rdev, unsigned selector)
-{
-	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-
-	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE,
-			    selector);
-}
-
-static int twl6030ldo_get_voltage_sel(struct regulator_dev *rdev)
-{
-	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-	int vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE);
-
-	return vsel;
-}
-
-static struct regulator_ops twl6030ldo_ops = {
-	.list_voltage	= twl6030ldo_list_voltage,
-
-	.set_voltage_sel = twl6030ldo_set_voltage_sel,
-	.get_voltage_sel = twl6030ldo_get_voltage_sel,
-
-	.enable		= twl6030reg_enable,
-	.disable	= twl6030reg_disable,
-	.is_enabled	= twl6030reg_is_enabled,
-
-	.set_mode	= twl6030reg_set_mode,
-
-	.get_status	= twl6030reg_get_status,
-};
-
 /*----------------------------------------------------------------------*/
 
 static struct regulator_ops twl4030fixed_ops = {
@@ -662,215 +455,6 @@ static struct regulator_ops twl4030fixed_ops = {
 	.get_status	= twl4030reg_get_status,
 };
 
-static struct regulator_ops twl6030fixed_ops = {
-	.list_voltage	= regulator_list_voltage_linear,
-
-	.enable		= twl6030reg_enable,
-	.disable	= twl6030reg_disable,
-	.is_enabled	= twl6030reg_is_enabled,
-
-	.set_mode	= twl6030reg_set_mode,
-
-	.get_status	= twl6030reg_get_status,
-};
-
-/*
- * SMPS status and control
- */
-
-static int twl6030smps_list_voltage(struct regulator_dev *rdev, unsigned index)
-{
-	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-
-	int voltage = 0;
-
-	switch (info->flags) {
-	case SMPS_OFFSET_EN:
-		voltage = 100000;
-		/* fall through */
-	case 0:
-		switch (index) {
-		case 0:
-			voltage = 0;
-			break;
-		case 58:
-			voltage = 1350 * 1000;
-			break;
-		case 59:
-			voltage = 1500 * 1000;
-			break;
-		case 60:
-			voltage = 1800 * 1000;
-			break;
-		case 61:
-			voltage = 1900 * 1000;
-			break;
-		case 62:
-			voltage = 2100 * 1000;
-			break;
-		default:
-			voltage += (600000 + (12500 * (index - 1)));
-		}
-		break;
-	case SMPS_EXTENDED_EN:
-		switch (index) {
-		case 0:
-			voltage = 0;
-			break;
-		case 58:
-			voltage = 2084 * 1000;
-			break;
-		case 59:
-			voltage = 2315 * 1000;
-			break;
-		case 60:
-			voltage = 2778 * 1000;
-			break;
-		case 61:
-			voltage = 2932 * 1000;
-			break;
-		case 62:
-			voltage = 3241 * 1000;
-			break;
-		default:
-			voltage = (1852000 + (38600 * (index - 1)));
-		}
-		break;
-	case SMPS_OFFSET_EN | SMPS_EXTENDED_EN:
-		switch (index) {
-		case 0:
-			voltage = 0;
-			break;
-		case 58:
-			voltage = 4167 * 1000;
-			break;
-		case 59:
-			voltage = 2315 * 1000;
-			break;
-		case 60:
-			voltage = 2778 * 1000;
-			break;
-		case 61:
-			voltage = 2932 * 1000;
-			break;
-		case 62:
-			voltage = 3241 * 1000;
-			break;
-		default:
-			voltage = (2161000 + (38600 * (index - 1)));
-		}
-		break;
-	}
-
-	return voltage;
-}
-
-static int twl6030smps_map_voltage(struct regulator_dev *rdev, int min_uV,
-				   int max_uV)
-{
-	struct twlreg_info *info = rdev_get_drvdata(rdev);
-	int vsel = 0;
-
-	switch (info->flags) {
-	case 0:
-		if (min_uV == 0)
-			vsel = 0;
-		else if ((min_uV >= 600000) && (min_uV <= 1300000)) {
-			vsel = DIV_ROUND_UP(min_uV - 600000, 12500);
-			vsel++;
-		}
-		/* Values 1..57 for vsel are linear and can be calculated
-		 * values 58..62 are non linear.
-		 */
-		else if ((min_uV > 1900000) && (min_uV <= 2100000))
-			vsel = 62;
-		else if ((min_uV > 1800000) && (min_uV <= 1900000))
-			vsel = 61;
-		else if ((min_uV > 1500000) && (min_uV <= 1800000))
-			vsel = 60;
-		else if ((min_uV > 1350000) && (min_uV <= 1500000))
-			vsel = 59;
-		else if ((min_uV > 1300000) && (min_uV <= 1350000))
-			vsel = 58;
-		else
-			return -EINVAL;
-		break;
-	case SMPS_OFFSET_EN:
-		if (min_uV == 0)
-			vsel = 0;
-		else if ((min_uV >= 700000) && (min_uV <= 1420000)) {
-			vsel = DIV_ROUND_UP(min_uV - 700000, 12500);
-			vsel++;
-		}
-		/* Values 1..57 for vsel are linear and can be calculated
-		 * values 58..62 are non linear.
-		 */
-		else if ((min_uV > 1900000) && (min_uV <= 2100000))
-			vsel = 62;
-		else if ((min_uV > 1800000) && (min_uV <= 1900000))
-			vsel = 61;
-		else if ((min_uV > 1350000) && (min_uV <= 1800000))
-			vsel = 60;
-		else if ((min_uV > 1350000) && (min_uV <= 1500000))
-			vsel = 59;
-		else if ((min_uV > 1300000) && (min_uV <= 1350000))
-			vsel = 58;
-		else
-			return -EINVAL;
-		break;
-	case SMPS_EXTENDED_EN:
-		if (min_uV == 0) {
-			vsel = 0;
-		} else if ((min_uV >= 1852000) && (max_uV <= 4013600)) {
-			vsel = DIV_ROUND_UP(min_uV - 1852000, 38600);
-			vsel++;
-		}
-		break;
-	case SMPS_OFFSET_EN|SMPS_EXTENDED_EN:
-		if (min_uV == 0) {
-			vsel = 0;
-		} else if ((min_uV >= 2161000) && (min_uV <= 4321000)) {
-			vsel = DIV_ROUND_UP(min_uV - 2161000, 38600);
-			vsel++;
-		}
-		break;
-	}
-
-	return vsel;
-}
-
-static int twl6030smps_set_voltage_sel(struct regulator_dev *rdev,
-				       unsigned int selector)
-{
-	struct twlreg_info *info = rdev_get_drvdata(rdev);
-
-	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS,
-			    selector);
-}
-
-static int twl6030smps_get_voltage_sel(struct regulator_dev *rdev)
-{
-	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-
-	return twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS);
-}
-
-static struct regulator_ops twlsmps_ops = {
-	.list_voltage		= twl6030smps_list_voltage,
-	.map_voltage		= twl6030smps_map_voltage,
-
-	.set_voltage_sel	= twl6030smps_set_voltage_sel,
-	.get_voltage_sel	= twl6030smps_get_voltage_sel,
-
-	.enable			= twl6030reg_enable,
-	.disable		= twl6030reg_disable,
-	.is_enabled		= twl6030reg_is_enabled,
-
-	.set_mode		= twl6030reg_set_mode,
-
-	.get_status		= twl6030reg_get_status,
-};
-
 /*----------------------------------------------------------------------*/
 
 #define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) \
@@ -908,66 +492,6 @@ static const struct twlreg_info TWL4030_INFO_##label = { \
 		}, \
 	}
 
-#define TWL6030_ADJUSTABLE_SMPS(label) \
-static const struct twlreg_info TWL6030_INFO_##label = { \
-	.desc = { \
-		.name = #label, \
-		.id = TWL6030_REG_##label, \
-		.ops = &twl6030coresmps_ops, \
-		.type = REGULATOR_VOLTAGE, \
-		.owner = THIS_MODULE, \
-		}, \
-	}
-
-#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) \
-static const struct twlreg_info TWL6030_INFO_##label = { \
-	.base = offset, \
-	.min_mV = min_mVolts, \
-	.max_mV = max_mVolts, \
-	.desc = { \
-		.name = #label, \
-		.id = TWL6030_REG_##label, \
-		.n_voltages = 32, \
-		.ops = &twl6030ldo_ops, \
-		.type = REGULATOR_VOLTAGE, \
-		.owner = THIS_MODULE, \
-		}, \
-	}
-
-#define TWL6032_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) \
-static const struct twlreg_info TWL6032_INFO_##label = { \
-	.base = offset, \
-	.min_mV = min_mVolts, \
-	.max_mV = max_mVolts, \
-	.desc = { \
-		.name = #label, \
-		.id = TWL6032_REG_##label, \
-		.n_voltages = 32, \
-		.ops = &twl6030ldo_ops, \
-		.type = REGULATOR_VOLTAGE, \
-		.owner = THIS_MODULE, \
-		}, \
-	}
-
-#define TWL6030_FIXED_LDO(label, offset, mVolts, turnon_delay) \
-static const struct twlreg_info TWLFIXED_INFO_##label = { \
-	.base = offset, \
-	.id = 0, \
-	.min_mV = mVolts, \
-	.remap = 0, \
-	.desc = { \
-		.name = #label, \
-		.id = TWL6030##_REG_##label, \
-		.n_voltages = 1, \
-		.ops = &twl6030fixed_ops, \
-		.type = REGULATOR_VOLTAGE, \
-		.owner = THIS_MODULE, \
-		.min_uV = mVolts * 1000, \
-		.enable_time = turnon_delay, \
-		.of_map_mode = NULL, \
-		}, \
-	}
-
 #define TWL4030_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
 			remap_conf) \
 static const struct twlreg_info TWLFIXED_INFO_##label = { \
@@ -988,21 +512,6 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 		}, \
 	}
 
-#define TWL6032_ADJUSTABLE_SMPS(label, offset) \
-static const struct twlreg_info TWLSMPS_INFO_##label = { \
-	.base = offset, \
-	.min_mV = 600, \
-	.max_mV = 2100, \
-	.desc = { \
-		.name = #label, \
-		.id = TWL6032_REG_##label, \
-		.n_voltages = 63, \
-		.ops = &twlsmps_ops, \
-		.type = REGULATOR_VOLTAGE, \
-		.owner = THIS_MODULE, \
-		}, \
-	}
-
 /*
  * We list regulators here if systems need some level of
  * software control over them after boot.
@@ -1023,60 +532,11 @@ TWL4030_ADJUSTABLE_LDO(VIO, 0x4b, 14, 1000, 0x08);
 TWL4030_ADJUSTABLE_SMPS(VDD1, 0x55, 15, 1000, 0x08);
 TWL4030_ADJUSTABLE_SMPS(VDD2, 0x63, 16, 1000, 0x08);
 /* VUSBCP is managed *only* by the USB subchip */
-/* 6030 REG with base as PMC Slave Misc : 0x0030 */
-/* Turnon-delay and remap configuration values for 6030 are not
-   verified since the specification is not public */
-TWL6030_ADJUSTABLE_SMPS(VDD1);
-TWL6030_ADJUSTABLE_SMPS(VDD2);
-TWL6030_ADJUSTABLE_SMPS(VDD3);
-TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300);
-TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300);
-TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300);
-TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000, 3300);
-TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000, 3300);
-TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000, 3300);
-/* 6025 are renamed compared to 6030 versions */
-TWL6032_ADJUSTABLE_LDO(LDO2, 0x54, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO4, 0x58, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO3, 0x5c, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO5, 0x68, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO1, 0x6c, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO7, 0x74, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO6, 0x60, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDOLN, 0x64, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDOUSB, 0x70, 1000, 3300);
 TWL4030_FIXED_LDO(VINTANA1, 0x3f, 1500, 11, 100, 0x08);
 TWL4030_FIXED_LDO(VINTDIG, 0x47, 1500, 13, 100, 0x08);
 TWL4030_FIXED_LDO(VUSB1V5, 0x71, 1500, 17, 100, 0x08);
 TWL4030_FIXED_LDO(VUSB1V8, 0x74, 1800, 18, 100, 0x08);
 TWL4030_FIXED_LDO(VUSB3V1, 0x77, 3100, 19, 150, 0x08);
-TWL6030_FIXED_LDO(VANA, 0x50, 2100, 0);
-TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 0);
-TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0);
-TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 0);
-TWL6030_FIXED_LDO(V1V8, 0x16, 1800, 0);
-TWL6030_FIXED_LDO(V2V1, 0x1c, 2100, 0);
-TWL6032_ADJUSTABLE_SMPS(SMPS3, 0x34);
-TWL6032_ADJUSTABLE_SMPS(SMPS4, 0x10);
-TWL6032_ADJUSTABLE_SMPS(VIO, 0x16);
-
-static u8 twl_get_smps_offset(void)
-{
-	u8 value;
-
-	twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &value,
-			TWL6030_SMPS_OFFSET);
-	return value;
-}
-
-static u8 twl_get_smps_mult(void)
-{
-	u8 value;
-
-	twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &value,
-			TWL6030_SMPS_MULT);
-	return value;
-}
 
 #define TWL_OF_MATCH(comp, family, label) \
 	{ \
@@ -1106,38 +566,11 @@ static const struct of_device_id twl_of_match[] = {
 	TWL4030_OF_MATCH("ti,twl4030-vio", VIO),
 	TWL4030_OF_MATCH("ti,twl4030-vdd1", VDD1),
 	TWL4030_OF_MATCH("ti,twl4030-vdd2", VDD2),
-	TWL6030_OF_MATCH("ti,twl6030-vdd1", VDD1),
-	TWL6030_OF_MATCH("ti,twl6030-vdd2", VDD2),
-	TWL6030_OF_MATCH("ti,twl6030-vdd3", VDD3),
-	TWL6030_OF_MATCH("ti,twl6030-vaux1", VAUX1_6030),
-	TWL6030_OF_MATCH("ti,twl6030-vaux2", VAUX2_6030),
-	TWL6030_OF_MATCH("ti,twl6030-vaux3", VAUX3_6030),
-	TWL6030_OF_MATCH("ti,twl6030-vmmc", VMMC),
-	TWL6030_OF_MATCH("ti,twl6030-vpp", VPP),
-	TWL6030_OF_MATCH("ti,twl6030-vusim", VUSIM),
-	TWL6032_OF_MATCH("ti,twl6032-ldo2", LDO2),
-	TWL6032_OF_MATCH("ti,twl6032-ldo4", LDO4),
-	TWL6032_OF_MATCH("ti,twl6032-ldo3", LDO3),
-	TWL6032_OF_MATCH("ti,twl6032-ldo5", LDO5),
-	TWL6032_OF_MATCH("ti,twl6032-ldo1", LDO1),
-	TWL6032_OF_MATCH("ti,twl6032-ldo7", LDO7),
-	TWL6032_OF_MATCH("ti,twl6032-ldo6", LDO6),
-	TWL6032_OF_MATCH("ti,twl6032-ldoln", LDOLN),
-	TWL6032_OF_MATCH("ti,twl6032-ldousb", LDOUSB),
 	TWLFIXED_OF_MATCH("ti,twl4030-vintana1", VINTANA1),
 	TWLFIXED_OF_MATCH("ti,twl4030-vintdig", VINTDIG),
 	TWLFIXED_OF_MATCH("ti,twl4030-vusb1v5", VUSB1V5),
 	TWLFIXED_OF_MATCH("ti,twl4030-vusb1v8", VUSB1V8),
 	TWLFIXED_OF_MATCH("ti,twl4030-vusb3v1", VUSB3V1),
-	TWLFIXED_OF_MATCH("ti,twl6030-vana", VANA),
-	TWLFIXED_OF_MATCH("ti,twl6030-vcxio", VCXIO),
-	TWLFIXED_OF_MATCH("ti,twl6030-vdac", VDAC),
-	TWLFIXED_OF_MATCH("ti,twl6030-vusb", VUSB),
-	TWLFIXED_OF_MATCH("ti,twl6030-v1v8", V1V8),
-	TWLFIXED_OF_MATCH("ti,twl6030-v2v1", V2V1),
-	TWLSMPS_OF_MATCH("ti,twl6032-smps3", SMPS3),
-	TWLSMPS_OF_MATCH("ti,twl6032-smps4", SMPS4),
-	TWLSMPS_OF_MATCH("ti,twl6032-vio", VIO),
 	{},
 };
 MODULE_DEVICE_TABLE(of, twl_of_match);
@@ -1193,27 +626,6 @@ static int twlreg_probe(struct platform_device *pdev)
 		break;
 	}
 
-	switch (id) {
-	case TWL6032_REG_SMPS3:
-		if (twl_get_smps_mult() & SMPS_MULTOFFSET_SMPS3)
-			info->flags |= SMPS_EXTENDED_EN;
-		if (twl_get_smps_offset() & SMPS_MULTOFFSET_SMPS3)
-			info->flags |= SMPS_OFFSET_EN;
-		break;
-	case TWL6032_REG_SMPS4:
-		if (twl_get_smps_mult() & SMPS_MULTOFFSET_SMPS4)
-			info->flags |= SMPS_EXTENDED_EN;
-		if (twl_get_smps_offset() & SMPS_MULTOFFSET_SMPS4)
-			info->flags |= SMPS_OFFSET_EN;
-		break;
-	case TWL6032_REG_VIO:
-		if (twl_get_smps_mult() & SMPS_MULTOFFSET_VIO)
-			info->flags |= SMPS_EXTENDED_EN;
-		if (twl_get_smps_offset() & SMPS_MULTOFFSET_VIO)
-			info->flags |= SMPS_OFFSET_EN;
-		break;
-	}
-
 	config.dev = &pdev->dev;
 	config.init_data = initdata;
 	config.driver_data = info;
@@ -1227,9 +639,7 @@ static int twlreg_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, rdev);
 
-	if (twl_class_is_4030())
-		twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_REMAP,
-						info->remap);
+	twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_REMAP, info->remap);
 
 	/* NOTE:  many regulators support short-circuit IRQs (presentable
 	 * as REGULATOR_OVER_CURRENT notifications?) configured via:
@@ -1242,7 +652,7 @@ static int twlreg_probe(struct platform_device *pdev)
 	return 0;
 }
 
-MODULE_ALIAS("platform:twl_reg");
+MODULE_ALIAS("platform:twl4030_reg");
 
 static struct platform_driver twlreg_driver = {
 	.probe		= twlreg_probe,
@@ -1250,7 +660,7 @@ static struct platform_driver twlreg_driver = {
 	 * "twl_regulator.12" (and friends) to "twl_regulator.1".
 	 */
 	.driver  = {
-		.name  = "twl_reg",
+		.name  = "twl4030_reg",
 		.of_match_table = of_match_ptr(twl_of_match),
 	},
 };
@@ -1267,5 +677,5 @@ static void __exit twlreg_exit(void)
 }
 module_exit(twlreg_exit)
 
-MODULE_DESCRIPTION("TWL regulator driver");
+MODULE_DESCRIPTION("TWL4030 regulator driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
new file mode 100644
index 000000000000..a446137f57bb
--- /dev/null
+++ b/drivers/regulator/twl6030-regulator.c
@@ -0,0 +1,805 @@
+/*
+ * Split TWL6030 logic from twl-regulator.c:
+ * Copyright (C) 2008 David Brownell
+ *
+ * Copyright (C) 2016 Nicolae Rosia <nicolae.rosia@gmail.com>
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/i2c/twl.h>
+#include <linux/delay.h>
+
+struct twlreg_info {
+	/* start of regulator's PM_RECEIVER control register bank */
+	u8			base;
+
+	/* twl resource ID, for resource control state machine */
+	u8			id;
+
+	/* voltage in mV = table[VSEL]; table_len must be a power-of-two */
+	u8			table_len;
+	const u16		*table;
+
+	/* State REMAP default configuration */
+	u8			remap;
+
+	/* chip constraints on regulator behavior */
+	u16			min_mV;
+	u16			max_mV;
+
+	u8			flags;
+
+	/* used by regulator core */
+	struct regulator_desc	desc;
+
+	/* chip specific features */
+	unsigned long		features;
+
+	/* data passed from board for external get/set voltage */
+	void			*data;
+};
+
+
+/* LDO control registers ... offset is from the base of its register bank.
+ * The first three registers of all power resource banks help hardware to
+ * manage the various resource groups.
+ */
+/* Common offset in TWL4030/6030 */
+#define VREG_GRP		0
+/* TWL6030 register offsets */
+#define VREG_TRANS		1
+#define VREG_STATE		2
+#define VREG_VOLTAGE		3
+#define VREG_VOLTAGE_SMPS	4
+/* TWL6030 Misc register offsets */
+#define VREG_BC_ALL		1
+#define VREG_BC_REF		2
+#define VREG_BC_PROC		3
+#define VREG_BC_CLK_RST		4
+
+/* TWL6030 LDO register values for CFG_STATE */
+#define TWL6030_CFG_STATE_OFF	0x00
+#define TWL6030_CFG_STATE_ON	0x01
+#define TWL6030_CFG_STATE_OFF2	0x02
+#define TWL6030_CFG_STATE_SLEEP	0x03
+#define TWL6030_CFG_STATE_GRP_SHIFT	5
+#define TWL6030_CFG_STATE_APP_SHIFT	2
+#define TWL6030_CFG_STATE_APP_MASK	(0x03 << TWL6030_CFG_STATE_APP_SHIFT)
+#define TWL6030_CFG_STATE_APP(v)	(((v) & TWL6030_CFG_STATE_APP_MASK) >>\
+						TWL6030_CFG_STATE_APP_SHIFT)
+
+/* Flags for SMPS Voltage reading */
+#define SMPS_OFFSET_EN		BIT(0)
+#define SMPS_EXTENDED_EN	BIT(1)
+
+/* twl6032 SMPS EPROM values */
+#define TWL6030_SMPS_OFFSET		0xB0
+#define TWL6030_SMPS_MULT		0xB3
+#define SMPS_MULTOFFSET_SMPS4	BIT(0)
+#define SMPS_MULTOFFSET_VIO	BIT(1)
+#define SMPS_MULTOFFSET_SMPS3	BIT(6)
+
+static inline int
+twlreg_read(struct twlreg_info *info, unsigned slave_subgp, unsigned offset)
+{
+	u8 value;
+	int status;
+
+	status = twl_i2c_read_u8(slave_subgp,
+			&value, info->base + offset);
+	return (status < 0) ? status : value;
+}
+
+static inline int
+twlreg_write(struct twlreg_info *info, unsigned slave_subgp, unsigned offset,
+						 u8 value)
+{
+	return twl_i2c_write_u8(slave_subgp,
+			value, info->base + offset);
+}
+
+/* generic power resource operations, which work on all regulators */
+static int twlreg_grp(struct regulator_dev *rdev)
+{
+	return twlreg_read(rdev_get_drvdata(rdev), TWL_MODULE_PM_RECEIVER,
+								 VREG_GRP);
+}
+
+/*
+ * Enable/disable regulators by joining/leaving the P1 (processor) group.
+ * We assume nobody else is updating the DEV_GRP registers.
+ */
+/* definition for 6030 family */
+#define P3_GRP_6030	BIT(2)		/* secondary processor, modem, etc */
+#define P2_GRP_6030	BIT(1)		/* "peripherals" */
+#define P1_GRP_6030	BIT(0)		/* CPU/Linux */
+
+static int twl6030reg_is_enabled(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int			grp = 0, val;
+
+	if (!(twl_class_is_6030() && (info->features & TWL6032_SUBCLASS))) {
+		grp = twlreg_grp(rdev);
+		if (grp < 0)
+			return grp;
+		grp &= P1_GRP_6030;
+	} else {
+		grp = 1;
+	}
+
+	val = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_STATE);
+	val = TWL6030_CFG_STATE_APP(val);
+
+	return grp && (val == TWL6030_CFG_STATE_ON);
+}
+
+#define PB_I2C_BUSY	BIT(0)
+#define PB_I2C_BWEN	BIT(1)
+
+
+static int twl6030reg_enable(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int			grp = 0;
+	int			ret;
+
+	if (!(twl_class_is_6030() && (info->features & TWL6032_SUBCLASS)))
+		grp = twlreg_grp(rdev);
+	if (grp < 0)
+		return grp;
+
+	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
+			grp << TWL6030_CFG_STATE_GRP_SHIFT |
+			TWL6030_CFG_STATE_ON);
+	return ret;
+}
+
+static int twl6030reg_disable(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int			grp = 0;
+	int			ret;
+
+	if (!(twl_class_is_6030() && (info->features & TWL6032_SUBCLASS)))
+		grp = P1_GRP_6030 | P2_GRP_6030 | P3_GRP_6030;
+
+	/* For 6030, set the off state for all grps enabled */
+	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
+			(grp) << TWL6030_CFG_STATE_GRP_SHIFT |
+			TWL6030_CFG_STATE_OFF);
+
+	return ret;
+}
+
+static int twl6030reg_get_status(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int			val;
+
+	val = twlreg_grp(rdev);
+	if (val < 0)
+		return val;
+
+	val = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_STATE);
+
+	switch (TWL6030_CFG_STATE_APP(val)) {
+	case TWL6030_CFG_STATE_ON:
+		return REGULATOR_STATUS_NORMAL;
+
+	case TWL6030_CFG_STATE_SLEEP:
+		return REGULATOR_STATUS_STANDBY;
+
+	case TWL6030_CFG_STATE_OFF:
+	case TWL6030_CFG_STATE_OFF2:
+	default:
+		break;
+	}
+
+	return REGULATOR_STATUS_OFF;
+}
+
+static int twl6030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int grp = 0;
+	int val;
+
+	if (!(twl_class_is_6030() && (info->features & TWL6032_SUBCLASS)))
+		grp = twlreg_grp(rdev);
+
+	if (grp < 0)
+		return grp;
+
+	/* Compose the state register settings */
+	val = grp << TWL6030_CFG_STATE_GRP_SHIFT;
+	/* We can only set the mode through state machine commands... */
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val |= TWL6030_CFG_STATE_ON;
+		break;
+	case REGULATOR_MODE_STANDBY:
+		val |= TWL6030_CFG_STATE_SLEEP;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE, val);
+}
+
+static int twl6030coresmps_set_voltage(struct regulator_dev *rdev, int min_uV,
+	int max_uV, unsigned *selector)
+{
+	return -ENODEV;
+}
+
+static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
+{
+	return -ENODEV;
+}
+
+static struct regulator_ops twl6030coresmps_ops = {
+	.set_voltage	= twl6030coresmps_set_voltage,
+	.get_voltage	= twl6030coresmps_get_voltage,
+};
+
+static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsigned sel)
+{
+	struct twlreg_info *info = rdev_get_drvdata(rdev);
+
+	switch (sel) {
+	case 0:
+		return 0;
+	case 1 ... 24:
+		/* Linear mapping from 00000001 to 00011000:
+		 * Absolute voltage value = 1.0 V + 0.1 V × (sel – 00000001)
+		 */
+		return (info->min_mV + 100 * (sel - 1)) * 1000;
+	case 25 ... 30:
+		return -EINVAL;
+	case 31:
+		return 2750000;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int
+twl6030ldo_set_voltage_sel(struct regulator_dev *rdev, unsigned selector)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+
+	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE,
+			    selector);
+}
+
+static int twl6030ldo_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE);
+
+	return vsel;
+}
+
+static struct regulator_ops twl6030ldo_ops = {
+	.list_voltage	= twl6030ldo_list_voltage,
+
+	.set_voltage_sel = twl6030ldo_set_voltage_sel,
+	.get_voltage_sel = twl6030ldo_get_voltage_sel,
+
+	.enable		= twl6030reg_enable,
+	.disable	= twl6030reg_disable,
+	.is_enabled	= twl6030reg_is_enabled,
+
+	.set_mode	= twl6030reg_set_mode,
+
+	.get_status	= twl6030reg_get_status,
+};
+
+static struct regulator_ops twl6030fixed_ops = {
+	.list_voltage	= regulator_list_voltage_linear,
+
+	.enable		= twl6030reg_enable,
+	.disable	= twl6030reg_disable,
+	.is_enabled	= twl6030reg_is_enabled,
+
+	.set_mode	= twl6030reg_set_mode,
+
+	.get_status	= twl6030reg_get_status,
+};
+
+/*
+ * SMPS status and control
+ */
+
+static int twl6030smps_list_voltage(struct regulator_dev *rdev, unsigned index)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+
+	int voltage = 0;
+
+	switch (info->flags) {
+	case SMPS_OFFSET_EN:
+		voltage = 100000;
+		/* fall through */
+	case 0:
+		switch (index) {
+		case 0:
+			voltage = 0;
+			break;
+		case 58:
+			voltage = 1350 * 1000;
+			break;
+		case 59:
+			voltage = 1500 * 1000;
+			break;
+		case 60:
+			voltage = 1800 * 1000;
+			break;
+		case 61:
+			voltage = 1900 * 1000;
+			break;
+		case 62:
+			voltage = 2100 * 1000;
+			break;
+		default:
+			voltage += (600000 + (12500 * (index - 1)));
+		}
+		break;
+	case SMPS_EXTENDED_EN:
+		switch (index) {
+		case 0:
+			voltage = 0;
+			break;
+		case 58:
+			voltage = 2084 * 1000;
+			break;
+		case 59:
+			voltage = 2315 * 1000;
+			break;
+		case 60:
+			voltage = 2778 * 1000;
+			break;
+		case 61:
+			voltage = 2932 * 1000;
+			break;
+		case 62:
+			voltage = 3241 * 1000;
+			break;
+		default:
+			voltage = (1852000 + (38600 * (index - 1)));
+		}
+		break;
+	case SMPS_OFFSET_EN | SMPS_EXTENDED_EN:
+		switch (index) {
+		case 0:
+			voltage = 0;
+			break;
+		case 58:
+			voltage = 4167 * 1000;
+			break;
+		case 59:
+			voltage = 2315 * 1000;
+			break;
+		case 60:
+			voltage = 2778 * 1000;
+			break;
+		case 61:
+			voltage = 2932 * 1000;
+			break;
+		case 62:
+			voltage = 3241 * 1000;
+			break;
+		default:
+			voltage = (2161000 + (38600 * (index - 1)));
+		}
+		break;
+	}
+
+	return voltage;
+}
+
+static int twl6030smps_map_voltage(struct regulator_dev *rdev, int min_uV,
+				   int max_uV)
+{
+	struct twlreg_info *info = rdev_get_drvdata(rdev);
+	int vsel = 0;
+
+	switch (info->flags) {
+	case 0:
+		if (min_uV == 0)
+			vsel = 0;
+		else if ((min_uV >= 600000) && (min_uV <= 1300000)) {
+			vsel = DIV_ROUND_UP(min_uV - 600000, 12500);
+			vsel++;
+		}
+		/* Values 1..57 for vsel are linear and can be calculated
+		 * values 58..62 are non linear.
+		 */
+		else if ((min_uV > 1900000) && (min_uV <= 2100000))
+			vsel = 62;
+		else if ((min_uV > 1800000) && (min_uV <= 1900000))
+			vsel = 61;
+		else if ((min_uV > 1500000) && (min_uV <= 1800000))
+			vsel = 60;
+		else if ((min_uV > 1350000) && (min_uV <= 1500000))
+			vsel = 59;
+		else if ((min_uV > 1300000) && (min_uV <= 1350000))
+			vsel = 58;
+		else
+			return -EINVAL;
+		break;
+	case SMPS_OFFSET_EN:
+		if (min_uV == 0)
+			vsel = 0;
+		else if ((min_uV >= 700000) && (min_uV <= 1420000)) {
+			vsel = DIV_ROUND_UP(min_uV - 700000, 12500);
+			vsel++;
+		}
+		/* Values 1..57 for vsel are linear and can be calculated
+		 * values 58..62 are non linear.
+		 */
+		else if ((min_uV > 1900000) && (min_uV <= 2100000))
+			vsel = 62;
+		else if ((min_uV > 1800000) && (min_uV <= 1900000))
+			vsel = 61;
+		else if ((min_uV > 1350000) && (min_uV <= 1800000))
+			vsel = 60;
+		else if ((min_uV > 1350000) && (min_uV <= 1500000))
+			vsel = 59;
+		else if ((min_uV > 1300000) && (min_uV <= 1350000))
+			vsel = 58;
+		else
+			return -EINVAL;
+		break;
+	case SMPS_EXTENDED_EN:
+		if (min_uV == 0) {
+			vsel = 0;
+		} else if ((min_uV >= 1852000) && (max_uV <= 4013600)) {
+			vsel = DIV_ROUND_UP(min_uV - 1852000, 38600);
+			vsel++;
+		}
+		break;
+	case SMPS_OFFSET_EN|SMPS_EXTENDED_EN:
+		if (min_uV == 0) {
+			vsel = 0;
+		} else if ((min_uV >= 2161000) && (min_uV <= 4321000)) {
+			vsel = DIV_ROUND_UP(min_uV - 2161000, 38600);
+			vsel++;
+		}
+		break;
+	}
+
+	return vsel;
+}
+
+static int twl6030smps_set_voltage_sel(struct regulator_dev *rdev,
+				       unsigned int selector)
+{
+	struct twlreg_info *info = rdev_get_drvdata(rdev);
+
+	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS,
+			    selector);
+}
+
+static int twl6030smps_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+
+	return twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS);
+}
+
+static struct regulator_ops twlsmps_ops = {
+	.list_voltage		= twl6030smps_list_voltage,
+	.map_voltage		= twl6030smps_map_voltage,
+
+	.set_voltage_sel	= twl6030smps_set_voltage_sel,
+	.get_voltage_sel	= twl6030smps_get_voltage_sel,
+
+	.enable			= twl6030reg_enable,
+	.disable		= twl6030reg_disable,
+	.is_enabled		= twl6030reg_is_enabled,
+
+	.set_mode		= twl6030reg_set_mode,
+
+	.get_status		= twl6030reg_get_status,
+};
+
+/*----------------------------------------------------------------------*/
+
+#define TWL6030_ADJUSTABLE_SMPS(label) \
+static const struct twlreg_info TWL6030_INFO_##label = { \
+	.desc = { \
+		.name = #label, \
+		.id = TWL6030_REG_##label, \
+		.ops = &twl6030coresmps_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
+
+#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) \
+static const struct twlreg_info TWL6030_INFO_##label = { \
+	.base = offset, \
+	.min_mV = min_mVolts, \
+	.max_mV = max_mVolts, \
+	.desc = { \
+		.name = #label, \
+		.id = TWL6030_REG_##label, \
+		.n_voltages = 32, \
+		.ops = &twl6030ldo_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
+
+#define TWL6032_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) \
+static const struct twlreg_info TWL6032_INFO_##label = { \
+	.base = offset, \
+	.min_mV = min_mVolts, \
+	.max_mV = max_mVolts, \
+	.desc = { \
+		.name = #label, \
+		.id = TWL6032_REG_##label, \
+		.n_voltages = 32, \
+		.ops = &twl6030ldo_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
+
+#define TWL6030_FIXED_LDO(label, offset, mVolts, turnon_delay) \
+static const struct twlreg_info TWLFIXED_INFO_##label = { \
+	.base = offset, \
+	.id = 0, \
+	.min_mV = mVolts, \
+	.remap = 0, \
+	.desc = { \
+		.name = #label, \
+		.id = TWL6030##_REG_##label, \
+		.n_voltages = 1, \
+		.ops = &twl6030fixed_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		.min_uV = mVolts * 1000, \
+		.enable_time = turnon_delay, \
+		.of_map_mode = NULL, \
+		}, \
+	}
+
+#define TWL6032_ADJUSTABLE_SMPS(label, offset) \
+static const struct twlreg_info TWLSMPS_INFO_##label = { \
+	.base = offset, \
+	.min_mV = 600, \
+	.max_mV = 2100, \
+	.desc = { \
+		.name = #label, \
+		.id = TWL6032_REG_##label, \
+		.n_voltages = 63, \
+		.ops = &twlsmps_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
+
+/* VUSBCP is managed *only* by the USB subchip */
+/* 6030 REG with base as PMC Slave Misc : 0x0030 */
+/* Turnon-delay and remap configuration values for 6030 are not
+   verified since the specification is not public */
+TWL6030_ADJUSTABLE_SMPS(VDD1);
+TWL6030_ADJUSTABLE_SMPS(VDD2);
+TWL6030_ADJUSTABLE_SMPS(VDD3);
+TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300);
+TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300);
+TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300);
+TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000, 3300);
+TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000, 3300);
+TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000, 3300);
+/* 6025 are renamed compared to 6030 versions */
+TWL6032_ADJUSTABLE_LDO(LDO2, 0x54, 1000, 3300);
+TWL6032_ADJUSTABLE_LDO(LDO4, 0x58, 1000, 3300);
+TWL6032_ADJUSTABLE_LDO(LDO3, 0x5c, 1000, 3300);
+TWL6032_ADJUSTABLE_LDO(LDO5, 0x68, 1000, 3300);
+TWL6032_ADJUSTABLE_LDO(LDO1, 0x6c, 1000, 3300);
+TWL6032_ADJUSTABLE_LDO(LDO7, 0x74, 1000, 3300);
+TWL6032_ADJUSTABLE_LDO(LDO6, 0x60, 1000, 3300);
+TWL6032_ADJUSTABLE_LDO(LDOLN, 0x64, 1000, 3300);
+TWL6032_ADJUSTABLE_LDO(LDOUSB, 0x70, 1000, 3300);
+TWL6030_FIXED_LDO(VANA, 0x50, 2100, 0);
+TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 0);
+TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0);
+TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 0);
+TWL6030_FIXED_LDO(V1V8, 0x16, 1800, 0);
+TWL6030_FIXED_LDO(V2V1, 0x1c, 2100, 0);
+TWL6032_ADJUSTABLE_SMPS(SMPS3, 0x34);
+TWL6032_ADJUSTABLE_SMPS(SMPS4, 0x10);
+TWL6032_ADJUSTABLE_SMPS(VIO, 0x16);
+
+static u8 twl_get_smps_offset(void)
+{
+	u8 value;
+
+	twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &value,
+			TWL6030_SMPS_OFFSET);
+	return value;
+}
+
+static u8 twl_get_smps_mult(void)
+{
+	u8 value;
+
+	twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &value,
+			TWL6030_SMPS_MULT);
+	return value;
+}
+
+#define TWL_OF_MATCH(comp, family, label) \
+	{ \
+		.compatible = comp, \
+		.data = &family##_INFO_##label, \
+	}
+
+#define TWL6030_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWL6030, label)
+#define TWL6032_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWL6032, label)
+#define TWLFIXED_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLFIXED, label)
+#define TWLSMPS_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLSMPS, label)
+
+static const struct of_device_id twl_of_match[] = {
+	TWL6030_OF_MATCH("ti,twl6030-vdd1", VDD1),
+	TWL6030_OF_MATCH("ti,twl6030-vdd2", VDD2),
+	TWL6030_OF_MATCH("ti,twl6030-vdd3", VDD3),
+	TWL6030_OF_MATCH("ti,twl6030-vaux1", VAUX1_6030),
+	TWL6030_OF_MATCH("ti,twl6030-vaux2", VAUX2_6030),
+	TWL6030_OF_MATCH("ti,twl6030-vaux3", VAUX3_6030),
+	TWL6030_OF_MATCH("ti,twl6030-vmmc", VMMC),
+	TWL6030_OF_MATCH("ti,twl6030-vpp", VPP),
+	TWL6030_OF_MATCH("ti,twl6030-vusim", VUSIM),
+	TWL6032_OF_MATCH("ti,twl6032-ldo2", LDO2),
+	TWL6032_OF_MATCH("ti,twl6032-ldo4", LDO4),
+	TWL6032_OF_MATCH("ti,twl6032-ldo3", LDO3),
+	TWL6032_OF_MATCH("ti,twl6032-ldo5", LDO5),
+	TWL6032_OF_MATCH("ti,twl6032-ldo1", LDO1),
+	TWL6032_OF_MATCH("ti,twl6032-ldo7", LDO7),
+	TWL6032_OF_MATCH("ti,twl6032-ldo6", LDO6),
+	TWL6032_OF_MATCH("ti,twl6032-ldoln", LDOLN),
+	TWL6032_OF_MATCH("ti,twl6032-ldousb", LDOUSB),
+	TWLFIXED_OF_MATCH("ti,twl6030-vana", VANA),
+	TWLFIXED_OF_MATCH("ti,twl6030-vcxio", VCXIO),
+	TWLFIXED_OF_MATCH("ti,twl6030-vdac", VDAC),
+	TWLFIXED_OF_MATCH("ti,twl6030-vusb", VUSB),
+	TWLFIXED_OF_MATCH("ti,twl6030-v1v8", V1V8),
+	TWLFIXED_OF_MATCH("ti,twl6030-v2v1", V2V1),
+	TWLSMPS_OF_MATCH("ti,twl6032-smps3", SMPS3),
+	TWLSMPS_OF_MATCH("ti,twl6032-smps4", SMPS4),
+	TWLSMPS_OF_MATCH("ti,twl6032-vio", VIO),
+	{},
+};
+MODULE_DEVICE_TABLE(of, twl_of_match);
+
+static int twlreg_probe(struct platform_device *pdev)
+{
+	int id;
+	struct twlreg_info		*info;
+	const struct twlreg_info	*template;
+	struct regulator_init_data	*initdata;
+	struct regulation_constraints	*c;
+	struct regulator_dev		*rdev;
+	const struct of_device_id	*match;
+	struct regulator_config		config = { };
+
+	match = of_match_device(twl_of_match, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	template = match->data;
+	if (!template)
+		return -ENODEV;
+
+	id = template->desc.id;
+	initdata = of_get_regulator_init_data(&pdev->dev, pdev->dev.of_node,
+						&template->desc);
+	if (!initdata)
+		return -EINVAL;
+
+	info = devm_kmemdup(&pdev->dev, template, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	/* Constrain board-specific capabilities according to what
+	 * this driver and the chip itself can actually do.
+	 */
+	c = &initdata->constraints;
+	c->valid_modes_mask &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY;
+	c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE
+				| REGULATOR_CHANGE_MODE
+				| REGULATOR_CHANGE_STATUS;
+
+	switch (id) {
+	case TWL6032_REG_SMPS3:
+		if (twl_get_smps_mult() & SMPS_MULTOFFSET_SMPS3)
+			info->flags |= SMPS_EXTENDED_EN;
+		if (twl_get_smps_offset() & SMPS_MULTOFFSET_SMPS3)
+			info->flags |= SMPS_OFFSET_EN;
+		break;
+	case TWL6032_REG_SMPS4:
+		if (twl_get_smps_mult() & SMPS_MULTOFFSET_SMPS4)
+			info->flags |= SMPS_EXTENDED_EN;
+		if (twl_get_smps_offset() & SMPS_MULTOFFSET_SMPS4)
+			info->flags |= SMPS_OFFSET_EN;
+		break;
+	case TWL6032_REG_VIO:
+		if (twl_get_smps_mult() & SMPS_MULTOFFSET_VIO)
+			info->flags |= SMPS_EXTENDED_EN;
+		if (twl_get_smps_offset() & SMPS_MULTOFFSET_VIO)
+			info->flags |= SMPS_OFFSET_EN;
+		break;
+	}
+
+	config.dev = &pdev->dev;
+	config.init_data = initdata;
+	config.driver_data = info;
+	config.of_node = pdev->dev.of_node;
+
+	rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
+	if (IS_ERR(rdev)) {
+		dev_err(&pdev->dev, "can't register %s, %ld\n",
+				info->desc.name, PTR_ERR(rdev));
+		return PTR_ERR(rdev);
+	}
+	platform_set_drvdata(pdev, rdev);
+
+	/* NOTE:  many regulators support short-circuit IRQs (presentable
+	 * as REGULATOR_OVER_CURRENT notifications?) configured via:
+	 *  - SC_CONFIG
+	 *  - SC_DETECT1 (vintana2, vmmc1/2, vaux1/2/3/4)
+	 *  - SC_DETECT2 (vusb, vdac, vio, vdd1/2, vpll2)
+	 *  - IT_CONFIG
+	 */
+
+	return 0;
+}
+
+MODULE_ALIAS("platform:twl6030_reg");
+
+static struct platform_driver twlreg_driver = {
+	.probe		= twlreg_probe,
+	/* NOTE: short name, to work around driver model truncation of
+	 * "twl_regulator.12" (and friends) to "twl_regulator.1".
+	 */
+	.driver  = {
+		.name  = "twl6030_reg",
+		.of_match_table = of_match_ptr(twl_of_match),
+	},
+};
+
+static int __init twlreg_init(void)
+{
+	return platform_driver_register(&twlreg_driver);
+}
+subsys_initcall(twlreg_init);
+
+static void __exit twlreg_exit(void)
+{
+	platform_driver_unregister(&twlreg_driver);
+}
+module_exit(twlreg_exit)
+
+MODULE_DESCRIPTION("TWL6030 regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.10.2
