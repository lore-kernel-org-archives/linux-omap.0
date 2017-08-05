From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] regulator: make regulator_ops structures const
Date: Sat,  5 Aug 2017 15:43:57 +0530
Message-ID: <1501928037-12441-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, tony@atomide.com, liviu.dudau@arm.com, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Declare regulator_ops structures as const as they are either used as a
copy operation or stored in the const field of a regulator_desc structure.
As they are never modified after initialization, so make them const.
Done using Coccinelle:

@match disable optional_qualifier@
identifier s;
@@
static struct regulator_ops s={...};

@ref@
position p;
identifier match.s;
@@
s@p

@good1@
position ref.p;
identifier match.s,f,c;
expression e;
@@

(
e = s@p
|
e = s@p.f
|
c(...,s@p.f,...)
|
c(...,s@p,...)
)

@good2@
identifier y;
position ref.p;
identifier match.s;
@@
struct regulator_desc y ={...,.ops=&s@p,...};

@good3@
struct regulator_desc y;
identifier match.s;
position ref.p;
@@
y.ops=&s@p

@bad depends on !good1 && !good2 && !good3@
position ref.p;
identifier match.s;
@@
s@p

@depends on forall !bad disable optional_qualifier@
identifier match.s;
@@
static
+ const
struct regulator_ops s;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/regulator/anatop-regulator.c    |  2 +-
 drivers/regulator/bd9571mwv-regulator.c |  6 +++---
 drivers/regulator/cpcap-regulator.c     |  2 +-
 drivers/regulator/fixed.c               |  2 +-
 drivers/regulator/gpio-regulator.c      |  4 ++--
 drivers/regulator/lp873x-regulator.c    |  4 ++--
 drivers/regulator/lp87565-regulator.c   |  2 +-
 drivers/regulator/max8997-regulator.c   | 14 +++++++-------
 drivers/regulator/mc13783-regulator.c   |  4 ++--
 drivers/regulator/mc13892-regulator.c   |  8 ++++----
 drivers/regulator/sky81452-regulator.c  |  2 +-
 drivers/regulator/stw481x-vmmc.c        |  2 +-
 drivers/regulator/ti-abb-regulator.c    |  2 +-
 drivers/regulator/tps51632-regulator.c  |  2 +-
 drivers/regulator/tps6105x-regulator.c  |  2 +-
 drivers/regulator/tps62360-regulator.c  |  2 +-
 drivers/regulator/tps6507x-regulator.c  |  2 +-
 drivers/regulator/tps65086-regulator.c  |  4 ++--
 drivers/regulator/tps65090-regulator.c  |  8 ++++----
 drivers/regulator/tps65132-regulator.c  |  2 +-
 drivers/regulator/tps65217-regulator.c  |  4 ++--
 drivers/regulator/tps65218-regulator.c  |  8 ++++----
 drivers/regulator/tps6524x-regulator.c  |  2 +-
 drivers/regulator/tps6586x-regulator.c  |  8 ++++----
 drivers/regulator/tps65910-regulator.c  | 10 +++++-----
 drivers/regulator/tps65912-regulator.c  |  4 ++--
 drivers/regulator/tps80031-regulator.c  | 10 +++++-----
 drivers/regulator/twl-regulator.c       |  6 +++---
 drivers/regulator/twl6030-regulator.c   |  8 ++++----
 drivers/regulator/vexpress-regulator.c  |  4 ++--
 30 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 7d6478e..0a2865f 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -163,7 +163,7 @@ static int anatop_regmap_set_bypass(struct regulator_dev *reg, bool enable)
 	.map_voltage = regulator_map_voltage_linear,
 };
 
-static struct regulator_ops anatop_core_rops = {
+static const struct regulator_ops anatop_core_rops = {
 	.enable = anatop_regmap_enable,
 	.disable = anatop_regmap_disable,
 	.is_enabled = anatop_regmap_is_enabled,
diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index c67a83d..8dee379 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -95,7 +95,7 @@ static int bd9571mwv_reg_set_voltage_sel_regmap(struct regulator_dev *rdev,
 }
 
 /* Operations permitted on AVS voltage regulator */
-static struct regulator_ops avs_ops = {
+static const struct regulator_ops avs_ops = {
 	.set_voltage_sel	= bd9571mwv_avs_set_voltage_sel_regmap,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= bd9571mwv_avs_get_voltage_sel_regmap,
@@ -103,7 +103,7 @@ static int bd9571mwv_reg_set_voltage_sel_regmap(struct regulator_dev *rdev,
 };
 
 /* Operations permitted on voltage regulators */
-static struct regulator_ops reg_ops = {
+static const struct regulator_ops reg_ops = {
 	.set_voltage_sel	= bd9571mwv_reg_set_voltage_sel_regmap,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -111,7 +111,7 @@ static int bd9571mwv_reg_set_voltage_sel_regmap(struct regulator_dev *rdev,
 };
 
 /* Operations permitted on voltage monitors */
-static struct regulator_ops vid_ops = {
+static const struct regulator_ops vid_ops = {
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index f541b80..0bd8b6a 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -258,7 +258,7 @@ static int cpcap_regulator_set_mode(struct regulator_dev *rdev,
 				  CPCAP_BIT_AUDIO_LOW_PWR, value);
 }
 
-static struct regulator_ops cpcap_regulator_ops = {
+static const struct regulator_ops cpcap_regulator_ops = {
 	.enable = cpcap_regulator_enable,
 	.disable = cpcap_regulator_disable,
 	.is_enabled = regulator_is_enabled_regmap,
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 988a747..ca0ddb6 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -94,7 +94,7 @@ struct fixed_voltage_data {
 	return config;
 }
 
-static struct regulator_ops fixed_voltage_ops = {
+static const struct regulator_ops fixed_voltage_ops = {
 };
 
 static int reg_fixed_voltage_probe(struct platform_device *pdev)
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 0fce06a..3f9a3ec 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -126,7 +126,7 @@ static int gpio_regulator_set_current_limit(struct regulator_dev *dev,
 	return 0;
 }
 
-static struct regulator_ops gpio_regulator_voltage_ops = {
+static const struct regulator_ops gpio_regulator_voltage_ops = {
 	.get_voltage = gpio_regulator_get_value,
 	.set_voltage = gpio_regulator_set_voltage,
 	.list_voltage = gpio_regulator_list_voltage,
@@ -243,7 +243,7 @@ static int gpio_regulator_set_current_limit(struct regulator_dev *dev,
 	return config;
 }
 
-static struct regulator_ops gpio_regulator_current_ops = {
+static const struct regulator_ops gpio_regulator_current_ops = {
 	.get_current_limit = gpio_regulator_get_value,
 	.set_current_limit = gpio_regulator_set_current_limit,
 };
diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index 70e3df6..2ec5e83 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -146,7 +146,7 @@ static int lp873x_buck_get_current_limit(struct regulator_dev *rdev)
 }
 
 /* Operations permitted on BUCK0, BUCK1 */
-static struct regulator_ops lp873x_buck01_ops = {
+static const struct regulator_ops lp873x_buck01_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -161,7 +161,7 @@ static int lp873x_buck_get_current_limit(struct regulator_dev *rdev)
 };
 
 /* Operations permitted on LDO0 and LDO1 */
-static struct regulator_ops lp873x_ldo01_ops = {
+static const struct regulator_ops lp873x_ldo01_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index cfdbe29..f20e048 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -136,7 +136,7 @@ static int lp87565_buck_get_current_limit(struct regulator_dev *rdev)
 }
 
 /* Operations permitted on BUCK0, BUCK1 */
-static struct regulator_ops lp87565_buck_ops = {
+static const struct regulator_ops lp87565_buck_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index 559b9ac..8766a37 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -747,7 +747,7 @@ static int max8997_reg_disable_suspend(struct regulator_dev *rdev)
 	return max8997_update_reg(i2c, reg, ~pattern, mask);
 }
 
-static struct regulator_ops max8997_ldo_ops = {
+static const struct regulator_ops max8997_ldo_ops = {
 	.list_voltage		= max8997_list_voltage,
 	.is_enabled		= max8997_reg_is_enabled,
 	.enable			= max8997_reg_enable,
@@ -757,7 +757,7 @@ static int max8997_reg_disable_suspend(struct regulator_dev *rdev)
 	.set_suspend_disable	= max8997_reg_disable_suspend,
 };
 
-static struct regulator_ops max8997_buck_ops = {
+static const struct regulator_ops max8997_buck_ops = {
 	.list_voltage		= max8997_list_voltage,
 	.is_enabled		= max8997_reg_is_enabled,
 	.enable			= max8997_reg_enable,
@@ -768,7 +768,7 @@ static int max8997_reg_disable_suspend(struct regulator_dev *rdev)
 	.set_suspend_disable	= max8997_reg_disable_suspend,
 };
 
-static struct regulator_ops max8997_fixedvolt_ops = {
+static const struct regulator_ops max8997_fixedvolt_ops = {
 	.list_voltage		= max8997_list_voltage,
 	.is_enabled		= max8997_reg_is_enabled,
 	.enable			= max8997_reg_enable,
@@ -776,7 +776,7 @@ static int max8997_reg_disable_suspend(struct regulator_dev *rdev)
 	.set_suspend_disable	= max8997_reg_disable_suspend,
 };
 
-static struct regulator_ops max8997_safeout_ops = {
+static const struct regulator_ops max8997_safeout_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 	.is_enabled		= max8997_reg_is_enabled,
 	.enable			= max8997_reg_enable,
@@ -786,7 +786,7 @@ static int max8997_reg_disable_suspend(struct regulator_dev *rdev)
 	.set_suspend_disable	= max8997_reg_disable_suspend,
 };
 
-static struct regulator_ops max8997_fixedstate_ops = {
+static const struct regulator_ops max8997_fixedstate_ops = {
 	.list_voltage		= max8997_list_voltage_charger_cv,
 	.get_voltage_sel	= max8997_get_voltage_sel,
 	.set_voltage		= max8997_set_voltage_charger_cv,
@@ -820,7 +820,7 @@ static int max8997_get_current_limit(struct regulator_dev *rdev)
 	return max8997_list_voltage(rdev, sel);
 }
 
-static struct regulator_ops max8997_charger_ops = {
+static const struct regulator_ops max8997_charger_ops = {
 	.is_enabled		= max8997_reg_is_enabled,
 	.enable			= max8997_reg_enable,
 	.disable		= max8997_reg_disable,
@@ -828,7 +828,7 @@ static int max8997_get_current_limit(struct regulator_dev *rdev)
 	.set_current_limit	= max8997_set_current_limit,
 };
 
-static struct regulator_ops max8997_charger_fixedstate_ops = {
+static const struct regulator_ops max8997_charger_fixedstate_ops = {
 	.get_current_limit	= max8997_get_current_limit,
 	.set_current_limit	= max8997_set_current_limit,
 };
diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index fe4c7d6..86e315e 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -230,7 +230,7 @@
 	5500000,
 };
 
-static struct regulator_ops mc13783_gpo_regulator_ops;
+static const struct regulator_ops mc13783_gpo_regulator_ops;
 
 #define MC13783_DEFINE(prefix, name, reg, vsel_reg, voltages)	\
 	MC13xxx_DEFINE(MC13783_REG_, name, reg, vsel_reg, voltages, \
@@ -384,7 +384,7 @@ static int mc13783_gpo_regulator_is_enabled(struct regulator_dev *rdev)
 	return (val & mc13xxx_regulators[id].enable_bit) != 0;
 }
 
-static struct regulator_ops mc13783_gpo_regulator_ops = {
+static const struct regulator_ops mc13783_gpo_regulator_ops = {
 	.enable = mc13783_gpo_regulator_enable,
 	.disable = mc13783_gpo_regulator_disable,
 	.is_enabled = mc13783_gpo_regulator_is_enabled,
diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index 0d17c92..2237f51 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -246,8 +246,8 @@
 	5000000,
 };
 
-static struct regulator_ops mc13892_gpo_regulator_ops;
-static struct regulator_ops mc13892_sw_regulator_ops;
+static const struct regulator_ops mc13892_gpo_regulator_ops;
+static const struct regulator_ops mc13892_sw_regulator_ops;
 
 
 #define MC13892_FIXED_DEFINE(name, reg, voltages)		\
@@ -391,7 +391,7 @@ static int mc13892_gpo_regulator_is_enabled(struct regulator_dev *rdev)
 }
 
 
-static struct regulator_ops mc13892_gpo_regulator_ops = {
+static const struct regulator_ops mc13892_gpo_regulator_ops = {
 	.enable = mc13892_gpo_regulator_enable,
 	.disable = mc13892_gpo_regulator_disable,
 	.is_enabled = mc13892_gpo_regulator_is_enabled,
@@ -483,7 +483,7 @@ static int mc13892_sw_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops mc13892_sw_regulator_ops = {
+static const struct regulator_ops mc13892_sw_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = mc13892_sw_regulator_set_voltage_sel,
diff --git a/drivers/regulator/sky81452-regulator.c b/drivers/regulator/sky81452-regulator.c
index 6478606..eb2b609 100644
--- a/drivers/regulator/sky81452-regulator.c
+++ b/drivers/regulator/sky81452-regulator.c
@@ -34,7 +34,7 @@
 #define SKY81452_LEN	0x40
 #define SKY81452_LOUT	0x1F
 
-static struct regulator_ops sky81452_reg_ops = {
+static const struct regulator_ops sky81452_reg_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_linear_range,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
diff --git a/drivers/regulator/stw481x-vmmc.c b/drivers/regulator/stw481x-vmmc.c
index 342f5da..edd8fa7 100644
--- a/drivers/regulator/stw481x-vmmc.c
+++ b/drivers/regulator/stw481x-vmmc.c
@@ -28,7 +28,7 @@
 	3300000,
 };
 
-static struct regulator_ops stw481x_vmmc_ops = {
+static const struct regulator_ops stw481x_vmmc_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.enable      = regulator_enable_regmap,
 	.disable     = regulator_disable_regmap,
diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index d2f9942..a263148 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -629,7 +629,7 @@ static int ti_abb_init_table(struct device *dev, struct ti_abb *abb,
 	return 0;
 }
 
-static struct regulator_ops ti_abb_reg_ops = {
+static const struct regulator_ops ti_abb_reg_ops = {
 	.list_voltage = regulator_list_voltage_table,
 
 	.set_voltage_sel = ti_abb_set_voltage_sel,
diff --git a/drivers/regulator/tps51632-regulator.c b/drivers/regulator/tps51632-regulator.c
index c139890..a15e415 100644
--- a/drivers/regulator/tps51632-regulator.c
+++ b/drivers/regulator/tps51632-regulator.c
@@ -108,7 +108,7 @@ static int tps51632_dcdc_set_ramp_delay(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops tps51632_dcdc_ops = {
+static const struct regulator_ops tps51632_dcdc_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
diff --git a/drivers/regulator/tps6105x-regulator.c b/drivers/regulator/tps6105x-regulator.c
index 584ef3d..c3d48a8 100644
--- a/drivers/regulator/tps6105x-regulator.c
+++ b/drivers/regulator/tps6105x-regulator.c
@@ -27,7 +27,7 @@
 	5000000, /* There is an additional 5V */
 };
 
-static struct regulator_ops tps6105x_regulator_ops = {
+static const struct regulator_ops tps6105x_regulator_ops = {
 	.enable		= regulator_enable_regmap,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/tps62360-regulator.c b/drivers/regulator/tps62360-regulator.c
index f6a6d36..315cd5d 100644
--- a/drivers/regulator/tps62360-regulator.c
+++ b/drivers/regulator/tps62360-regulator.c
@@ -233,7 +233,7 @@ static unsigned int tps62360_get_mode(struct regulator_dev *rdev)
 				REGULATOR_MODE_FAST : REGULATOR_MODE_NORMAL;
 }
 
-static struct regulator_ops tps62360_dcdc_ops = {
+static const struct regulator_ops tps62360_dcdc_ops = {
 	.get_voltage_sel	= tps62360_dcdc_get_voltage_sel,
 	.set_voltage_sel	= tps62360_dcdc_set_voltage_sel,
 	.list_voltage		= regulator_list_voltage_linear,
diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index c179a3a..2b3064f 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -349,7 +349,7 @@ static int tps6507x_pmic_set_voltage_sel(struct regulator_dev *dev,
 	return tps6507x_pmic_reg_write(tps, reg, data);
 }
 
-static struct regulator_ops tps6507x_pmic_ops = {
+static const struct regulator_ops tps6507x_pmic_ops = {
 	.is_enabled = tps6507x_pmic_is_enabled,
 	.enable = tps6507x_pmic_enable,
 	.disable = tps6507x_pmic_disable,
diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
index 45e96e1..3b61840 100644
--- a/drivers/regulator/tps65086-regulator.c
+++ b/drivers/regulator/tps65086-regulator.c
@@ -101,7 +101,7 @@ struct tps65086_regulator {
 };
 
 /* Operations permitted on regulators */
-static struct regulator_ops reg_ops = {
+static const struct regulator_ops reg_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -112,7 +112,7 @@ struct tps65086_regulator {
 };
 
 /* Operations permitted on load switches */
-static struct regulator_ops switch_ops = {
+static const struct regulator_ops switch_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index 395f35d..db341d9 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -57,7 +57,7 @@ struct tps65090_regulator {
 	int			overcurrent_wait;
 };
 
-static struct regulator_ops tps65090_ext_control_ops = {
+static const struct regulator_ops tps65090_ext_control_ops = {
 };
 
 /**
@@ -177,19 +177,19 @@ static int tps65090_fet_enable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static struct regulator_ops tps65090_reg_control_ops = {
+static const struct regulator_ops tps65090_reg_control_ops = {
 	.enable		= regulator_enable_regmap,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops tps65090_fet_control_ops = {
+static const struct regulator_ops tps65090_fet_control_ops = {
 	.enable		= tps65090_fet_enable,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops tps65090_ldo_ops = {
+static const struct regulator_ops tps65090_ldo_ops = {
 };
 
 #define tps65090_REG_DESC(_id, _sname, _en_reg, _en_bits, _nvolt, _volt, _ops) \
diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index 73978dd..8c18010 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -120,7 +120,7 @@ static int tps65132_regulator_is_enabled(struct regulator_dev *rdev)
 	return 1;
 }
 
-static struct regulator_ops tps65132_regulator_ops = {
+static const struct regulator_ops tps65132_regulator_ops = {
 	.enable = tps65132_regulator_enable,
 	.disable = tps65132_regulator_disable,
 	.is_enabled = tps65132_regulator_is_enabled,
diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index 5324dc9..74b1180 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -150,7 +150,7 @@ static int tps65217_pmic_set_suspend_disable(struct regulator_dev *dev)
 }
 
 /* Operations permitted on DCDCx, LDO2, LDO3 and LDO4 */
-static struct regulator_ops tps65217_pmic_ops = {
+static const struct regulator_ops tps65217_pmic_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65217_pmic_enable,
 	.disable		= tps65217_pmic_disable,
@@ -163,7 +163,7 @@ static int tps65217_pmic_set_suspend_disable(struct regulator_dev *dev)
 };
 
 /* Operations permitted on LDO1 */
-static struct regulator_ops tps65217_pmic_ldo1_ops = {
+static const struct regulator_ops tps65217_pmic_ldo1_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65217_pmic_enable,
 	.disable		= tps65217_pmic_disable,
diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 9aafbb0..d746f27 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -165,7 +165,7 @@ static int tps65218_pmic_set_suspend_disable(struct regulator_dev *dev)
 }
 
 /* Operations permitted on DCDC1, DCDC2 */
-static struct regulator_ops tps65218_dcdc12_ops = {
+static const struct regulator_ops tps65218_dcdc12_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -179,7 +179,7 @@ static int tps65218_pmic_set_suspend_disable(struct regulator_dev *dev)
 };
 
 /* Operations permitted on DCDC3, DCDC4 and LDO1 */
-static struct regulator_ops tps65218_ldo1_dcdc34_ops = {
+static const struct regulator_ops tps65218_ldo1_dcdc34_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -244,7 +244,7 @@ static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
 	return ls3_currents[index];
 }
 
-static struct regulator_ops tps65218_ls3_ops = {
+static const struct regulator_ops tps65218_ls3_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -254,7 +254,7 @@ static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
 };
 
 /* Operations permitted on DCDC5, DCDC6 */
-static struct regulator_ops tps65218_dcdc56_pmic_ops = {
+static const struct regulator_ops tps65218_dcdc56_pmic_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
diff --git a/drivers/regulator/tps6524x-regulator.c b/drivers/regulator/tps6524x-regulator.c
index 67cac26..c09223c 100644
--- a/drivers/regulator/tps6524x-regulator.c
+++ b/drivers/regulator/tps6524x-regulator.c
@@ -565,7 +565,7 @@ static int is_supply_enabled(struct regulator_dev *rdev)
 	return read_field(hw, &info->enable);
 }
 
-static struct regulator_ops regulator_ops = {
+static const struct regulator_ops regulator_ops = {
 	.is_enabled		= is_supply_enabled,
 	.enable			= enable_supply,
 	.disable		= disable_supply,
diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index 9e9d220..8186508 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -63,7 +63,7 @@ struct tps6586x_regulator {
 	int enable_reg[2];
 };
 
-static struct regulator_ops tps6586x_rw_regulator_ops = {
+static const struct regulator_ops tps6586x_rw_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -74,7 +74,7 @@ struct tps6586x_regulator {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_rw_linear_regulator_ops = {
+static const struct regulator_ops tps6586x_rw_linear_regulator_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
@@ -84,7 +84,7 @@ struct tps6586x_regulator {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_ro_regulator_ops = {
+static const struct regulator_ops tps6586x_ro_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -94,7 +94,7 @@ struct tps6586x_regulator {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_sys_regulator_ops = {
+static const struct regulator_ops tps6586x_sys_regulator_ops = {
 };
 
 static const unsigned int tps6586x_ldo0_voltages[] = {
diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 81672a5..1d3170e 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -762,7 +762,7 @@ static int tps65911_list_voltage(struct regulator_dev *dev, unsigned selector)
 }
 
 /* Regulator ops (except VRTC) */
-static struct regulator_ops tps65910_ops_dcdc = {
+static const struct regulator_ops tps65910_ops_dcdc = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -775,7 +775,7 @@ static int tps65911_list_voltage(struct regulator_dev *dev, unsigned selector)
 	.map_voltage		= regulator_map_voltage_ascend,
 };
 
-static struct regulator_ops tps65910_ops_vdd3 = {
+static const struct regulator_ops tps65910_ops_vdd3 = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -786,7 +786,7 @@ static int tps65911_list_voltage(struct regulator_dev *dev, unsigned selector)
 	.map_voltage		= regulator_map_voltage_ascend,
 };
 
-static struct regulator_ops tps65910_ops_vbb = {
+static const struct regulator_ops tps65910_ops_vbb = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -798,7 +798,7 @@ static int tps65911_list_voltage(struct regulator_dev *dev, unsigned selector)
 	.map_voltage		= regulator_map_voltage_iterate,
 };
 
-static struct regulator_ops tps65910_ops = {
+static const struct regulator_ops tps65910_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -810,7 +810,7 @@ static int tps65911_list_voltage(struct regulator_dev *dev, unsigned selector)
 	.map_voltage		= regulator_map_voltage_ascend,
 };
 
-static struct regulator_ops tps65911_ops = {
+static const struct regulator_ops tps65911_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
diff --git a/drivers/regulator/tps65912-regulator.c b/drivers/regulator/tps65912-regulator.c
index a4921a7..d615a3f 100644
--- a/drivers/regulator/tps65912-regulator.c
+++ b/drivers/regulator/tps65912-regulator.c
@@ -56,7 +56,7 @@ enum tps65912_regulators { DCDC1, DCDC2, DCDC3, DCDC4, LDO1, LDO2, LDO3,
 };
 
 /* Operations permitted on DCDCx */
-static struct regulator_ops tps65912_ops_dcdc = {
+static const struct regulator_ops tps65912_ops_dcdc = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -66,7 +66,7 @@ enum tps65912_regulators { DCDC1, DCDC2, DCDC3, DCDC4, LDO1, LDO2, LDO3,
 };
 
 /* Operations permitted on LDOx */
-static struct regulator_ops tps65912_ops_ldo = {
+static const struct regulator_ops tps65912_ops_ldo = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
diff --git a/drivers/regulator/tps80031-regulator.c b/drivers/regulator/tps80031-regulator.c
index d4cc60a..947cc49 100644
--- a/drivers/regulator/tps80031-regulator.c
+++ b/drivers/regulator/tps80031-regulator.c
@@ -378,7 +378,7 @@ static int tps80031_vbus_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static struct regulator_ops tps80031_dcdc_ops = {
+static const struct regulator_ops tps80031_dcdc_ops = {
 	.list_voltage		= tps80031_dcdc_list_voltage,
 	.set_voltage_sel	= tps80031_dcdc_set_voltage_sel,
 	.get_voltage_sel	= tps80031_dcdc_get_voltage_sel,
@@ -387,7 +387,7 @@ static int tps80031_vbus_disable(struct regulator_dev *rdev)
 	.is_enabled	= tps80031_reg_is_enabled,
 };
 
-static struct regulator_ops tps80031_ldo_ops = {
+static const struct regulator_ops tps80031_ldo_ops = {
 	.list_voltage		= tps80031_ldo_list_voltage,
 	.map_voltage		= tps80031_ldo_map_voltage,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
@@ -397,18 +397,18 @@ static int tps80031_vbus_disable(struct regulator_dev *rdev)
 	.is_enabled		= tps80031_reg_is_enabled,
 };
 
-static struct regulator_ops tps80031_vbus_sw_ops = {
+static const struct regulator_ops tps80031_vbus_sw_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= tps80031_vbus_enable,
 	.disable	= tps80031_vbus_disable,
 	.is_enabled	= tps80031_vbus_is_enabled,
 };
 
-static struct regulator_ops tps80031_vbus_hw_ops = {
+static const struct regulator_ops tps80031_vbus_hw_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 };
 
-static struct regulator_ops tps80031_ext_reg_ops = {
+static const struct regulator_ops tps80031_ext_reg_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= tps80031_reg_enable,
 	.disable	= tps80031_reg_disable,
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 6c9ec84..8c2e2be 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -392,7 +392,7 @@ static int twl4030ldo_get_voltage_sel(struct regulator_dev *rdev)
 	return vsel;
 }
 
-static struct regulator_ops twl4030ldo_ops = {
+static const struct regulator_ops twl4030ldo_ops = {
 	.list_voltage	= twl4030ldo_list_voltage,
 
 	.set_voltage_sel = twl4030ldo_set_voltage_sel,
@@ -430,14 +430,14 @@ static int twl4030smps_get_voltage(struct regulator_dev *rdev)
 	return vsel * 12500 + 600000;
 }
 
-static struct regulator_ops twl4030smps_ops = {
+static const struct regulator_ops twl4030smps_ops = {
 	.set_voltage	= twl4030smps_set_voltage,
 	.get_voltage	= twl4030smps_get_voltage,
 };
 
 /*----------------------------------------------------------------------*/
 
-static struct regulator_ops twl4030fixed_ops = {
+static const struct regulator_ops twl4030fixed_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 
 	.enable		= twl4030reg_enable,
diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 56aada3..22c0e8a 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -247,7 +247,7 @@ static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
 	return -ENODEV;
 }
 
-static struct regulator_ops twl6030coresmps_ops = {
+static const struct regulator_ops twl6030coresmps_ops = {
 	.set_voltage	= twl6030coresmps_set_voltage,
 	.get_voltage	= twl6030coresmps_get_voltage,
 };
@@ -290,7 +290,7 @@ static int twl6030ldo_get_voltage_sel(struct regulator_dev *rdev)
 	return vsel;
 }
 
-static struct regulator_ops twl6030ldo_ops = {
+static const struct regulator_ops twl6030ldo_ops = {
 	.list_voltage	= twl6030ldo_list_voltage,
 
 	.set_voltage_sel = twl6030ldo_set_voltage_sel,
@@ -305,7 +305,7 @@ static int twl6030ldo_get_voltage_sel(struct regulator_dev *rdev)
 	.get_status	= twl6030reg_get_status,
 };
 
-static struct regulator_ops twl6030fixed_ops = {
+static const struct regulator_ops twl6030fixed_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 
 	.enable		= twl6030reg_enable,
@@ -496,7 +496,7 @@ static int twl6030smps_get_voltage_sel(struct regulator_dev *rdev)
 	return twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS);
 }
 
-static struct regulator_ops twlsmps_ops = {
+static const struct regulator_ops twlsmps_ops = {
 	.list_voltage		= twl6030smps_list_voltage,
 	.map_voltage		= twl6030smps_map_voltage,
 
diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index c810cbb..ca4230f 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -46,11 +46,11 @@ static int vexpress_regulator_set_voltage(struct regulator_dev *regdev,
 	return regmap_write(reg->regmap, 0, min_uV);
 }
 
-static struct regulator_ops vexpress_regulator_ops_ro = {
+static const struct regulator_ops vexpress_regulator_ops_ro = {
 	.get_voltage = vexpress_regulator_get_voltage,
 };
 
-static struct regulator_ops vexpress_regulator_ops = {
+static const struct regulator_ops vexpress_regulator_ops = {
 	.get_voltage = vexpress_regulator_get_voltage,
 	.set_voltage = vexpress_regulator_set_voltage,
 };
-- 
1.9.1
