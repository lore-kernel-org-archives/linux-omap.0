From: Furquan Shaikh <furquan@chromium.org>
Subject: [PATCH 1/7] drivers/regulator: Rename of_map_mode to map_mode in regulator desc
Date: Tue, 24 Jan 2017 16:06:35 -0800
Message-ID: <20170125000641.25520-2-furquan@chromium.org>
References: <20170125000641.25520-1-furquan@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170125000641.25520-1-furquan@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Furquan Shaikh <furquan@chromium.org>
List-Id: linux-omap@vger.kernel.org

In order to extend regulator support to ACPI, it is necessary that all
the regulator descriptor structure members are generic and not tied to
just DeviceTree (OF). Thus, rename of_map_mode to map_mode to allow
drivers using ACPI regulators to define required map_mode callback.

Signed-off-by: Furquan Shaikh <furquan@chromium.org>
---
 drivers/regulator/max77802-regulator.c  | 12 ++++++------
 drivers/regulator/of_regulator.c        |  8 ++++----
 drivers/regulator/qcom_spmi-regulator.c |  2 +-
 drivers/regulator/twl-regulator.c       |  6 +++---
 drivers/regulator/twl6030-regulator.c   |  2 +-
 include/linux/regulator/driver.h        |  5 +++--
 6 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index 1d3539324d9a..ccacc492f6ff 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -379,7 +379,7 @@ static struct regulator_ops max77802_buck_dvs_ops = {
 	.vsel_mask	= MAX77802_VSEL_MASK,				\
 	.enable_reg	= MAX77802_REG_LDO1CTRL1 + num - 1,		\
 	.enable_mask	= MAX77802_OPMODE_MASK << MAX77802_OPMODE_SHIFT_LDO, \
-	.of_map_mode	= max77802_map_mode,				\
+	.map_mode	= max77802_map_mode,				\
 }
 
 /* LDOs 1, 2, 8, 15, 17, 27, 30, 35 */
@@ -400,7 +400,7 @@ static struct regulator_ops max77802_buck_dvs_ops = {
 	.vsel_mask	= MAX77802_VSEL_MASK,				\
 	.enable_reg	= MAX77802_REG_LDO1CTRL1 + num - 1,		\
 	.enable_mask	= MAX77802_OPMODE_MASK << MAX77802_OPMODE_SHIFT_LDO, \
-	.of_map_mode	= max77802_map_mode,				\
+	.map_mode	= max77802_map_mode,				\
 }
 
 /* BUCKs 1, 6 */
@@ -421,7 +421,7 @@ static struct regulator_ops max77802_buck_dvs_ops = {
 	.vsel_mask	= MAX77802_DVS_VSEL_MASK,			\
 	.enable_reg	= MAX77802_REG_BUCK ## num ## CTRL,		\
 	.enable_mask	= MAX77802_OPMODE_MASK,				\
-	.of_map_mode	= max77802_map_mode,				\
+	.map_mode	= max77802_map_mode,				\
 }
 
 /* BUCKS 2-4 */
@@ -443,7 +443,7 @@ static struct regulator_ops max77802_buck_dvs_ops = {
 	.enable_reg	= MAX77802_REG_BUCK ## num ## CTRL1,		\
 	.enable_mask	= MAX77802_OPMODE_MASK <<			\
 				MAX77802_OPMODE_BUCK234_SHIFT,		\
-	.of_map_mode	= max77802_map_mode,				\
+	.map_mode	= max77802_map_mode,				\
 }
 
 /* BUCK 5 */
@@ -464,7 +464,7 @@ static struct regulator_ops max77802_buck_dvs_ops = {
 	.vsel_mask	= MAX77802_VSEL_MASK,				\
 	.enable_reg	= MAX77802_REG_BUCK5CTRL,			\
 	.enable_mask	= MAX77802_OPMODE_MASK,				\
-	.of_map_mode	= max77802_map_mode,				\
+	.map_mode	= max77802_map_mode,				\
 }
 
 /* BUCKs 7-10 */
@@ -485,7 +485,7 @@ static struct regulator_ops max77802_buck_dvs_ops = {
 	.vsel_mask	= MAX77802_VSEL_MASK,				\
 	.enable_reg	= MAX77802_REG_BUCK7CTRL + (num - 7) * 3,	\
 	.enable_mask	= MAX77802_OPMODE_MASK,				\
-	.of_map_mode	= max77802_map_mode,				\
+	.map_mode	= max77802_map_mode,				\
 }
 
 static const struct regulator_desc regulators[] = {
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 4f613ec99500..13d4dc2c287e 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -100,8 +100,8 @@ static void of_get_regulation_constraints(struct device_node *np,
 	}
 
 	if (!of_property_read_u32(np, "regulator-initial-mode", &pval)) {
-		if (desc && desc->of_map_mode) {
-			ret = desc->of_map_mode(pval);
+		if (desc && desc->map_mode) {
+			ret = desc->map_mode(pval);
 			if (ret == -EINVAL)
 				pr_err("%s: invalid mode %u\n", np->name, pval);
 			else
@@ -139,8 +139,8 @@ static void of_get_regulation_constraints(struct device_node *np,
 
 		if (!of_property_read_u32(suspend_np, "regulator-mode",
 					  &pval)) {
-			if (desc && desc->of_map_mode) {
-				ret = desc->of_map_mode(pval);
+			if (desc && desc->map_mode) {
+				ret = desc->map_mode(pval);
 				if (ret == -EINVAL)
 					pr_err("%s: invalid mode %u\n",
 					       np->name, pval);
diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 16c5f84e06a7..54fe4aadd350 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1679,7 +1679,7 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 		vreg->desc.supply_name = reg->supply;
 		vreg->desc.of_match = reg->name;
 		vreg->desc.of_parse_cb = spmi_regulator_of_parse;
-		vreg->desc.of_map_mode = spmi_regulator_of_map_mode;
+		vreg->desc.map_mode = spmi_regulator_of_map_mode;
 
 		ret = spmi_regulator_match(vreg, reg->force_type);
 		if (ret)
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 6c9ec84121bd..023aa28c8a0f 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -466,7 +466,7 @@ static const struct twlreg_info TWL4030_INFO_##label = { \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		.enable_time = turnon_delay, \
-		.of_map_mode = twl4030reg_map_mode, \
+		.map_mode = twl4030reg_map_mode, \
 		}, \
 	}
 
@@ -482,7 +482,7 @@ static const struct twlreg_info TWL4030_INFO_##label = { \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		.enable_time = turnon_delay, \
-		.of_map_mode = twl4030reg_map_mode, \
+		.map_mode = twl4030reg_map_mode, \
 		}, \
 	}
 
@@ -501,7 +501,7 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 		.owner = THIS_MODULE, \
 		.min_uV = mVolts * 1000, \
 		.enable_time = turnon_delay, \
-		.of_map_mode = twl4030reg_map_mode, \
+		.map_mode = twl4030reg_map_mode, \
 		}, \
 	}
 
diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 4864b9d742c0..d7be72869f52 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -569,7 +569,7 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 		.owner = THIS_MODULE, \
 		.min_uV = mVolts * 1000, \
 		.enable_time = turnon_delay, \
-		.of_map_mode = NULL, \
+		.map_mode = NULL, \
 		}, \
 	}
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index dac8e7b16bc6..b50592a6f050 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -296,7 +296,8 @@ enum regulator_type {
  * @enable_time: Time taken for initial enable of regulator (in uS).
  * @off_on_delay: guard time (in uS), before re-enabling a regulator
  *
- * @of_map_mode: Maps a hardware mode defined in a DeviceTree to a standard mode
+ * @map_mode: Maps a hardware mode defined in device properties to a standard
+ *            mode.
  */
 struct regulator_desc {
 	const char *name;
@@ -350,7 +351,7 @@ struct regulator_desc {
 
 	unsigned int off_on_delay;
 
-	unsigned int (*of_map_mode)(unsigned int mode);
+	unsigned int (*map_mode)(unsigned int mode);
 };
 
 /**
-- 
2.11.0.483.g087da7b7c-goog
