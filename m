From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] regulator: palmas-regulator: constify regulator_ops structure
Date: Sat, 28 Jan 2017 20:23:55 +0530
Message-ID: <1485615235-30571-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Declare regulator_ops structure as const as it is only stored in the ops
field of a regulator_desc structure. This field is of type const, so
regulator_ops structures having this property can be made const too.

File size before: drivers/regulator/palmas-regulator.o
   text	   data	    bss	    dec	    hex	filename
   9752	   6296	    288	  16336	   3fd0 regulator/palmas-regulator.o

File size after: drivers/regulator/palmas-regulator.o
   text	   data	    bss	    dec	    hex	filename
  12856	   3480	      8	  16344	   3fd0 regulator/palmas-regulator.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/regulator/palmas-regulator.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index f11d41d..31ae5ee 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -528,7 +528,7 @@ static int palmas_smps_set_ramp_delay(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops palmas_ops_smps = {
+static const struct regulator_ops palmas_ops_smps = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -542,7 +542,7 @@ static int palmas_smps_set_ramp_delay(struct regulator_dev *rdev,
 	.set_ramp_delay		= palmas_smps_set_ramp_delay,
 };
 
-static struct regulator_ops palmas_ops_ext_control_smps = {
+static const struct regulator_ops palmas_ops_ext_control_smps = {
 	.set_mode		= palmas_set_mode_smps,
 	.get_mode		= palmas_get_mode_smps,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -553,7 +553,7 @@ static int palmas_smps_set_ramp_delay(struct regulator_dev *rdev,
 	.set_ramp_delay		= palmas_smps_set_ramp_delay,
 };
 
-static struct regulator_ops palmas_ops_smps10 = {
+static const struct regulator_ops palmas_ops_smps10 = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -565,7 +565,7 @@ static int palmas_smps_set_ramp_delay(struct regulator_dev *rdev,
 	.get_bypass		= regulator_get_bypass_regmap,
 };
 
-static struct regulator_ops tps65917_ops_smps = {
+static const struct regulator_ops tps65917_ops_smps = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -578,7 +578,7 @@ static int palmas_smps_set_ramp_delay(struct regulator_dev *rdev,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops tps65917_ops_ext_control_smps = {
+static const struct regulator_ops tps65917_ops_ext_control_smps = {
 	.set_mode		= palmas_set_mode_smps,
 	.get_mode		= palmas_get_mode_smps,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -602,7 +602,7 @@ static int palmas_is_enabled_ldo(struct regulator_dev *dev)
 	return !!(reg);
 }
 
-static struct regulator_ops palmas_ops_ldo = {
+static const struct regulator_ops palmas_ops_ldo = {
 	.is_enabled		= palmas_is_enabled_ldo,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -612,7 +612,7 @@ static int palmas_is_enabled_ldo(struct regulator_dev *dev)
 	.map_voltage		= regulator_map_voltage_linear,
 };
 
-static struct regulator_ops palmas_ops_ldo9 = {
+static const struct regulator_ops palmas_ops_ldo9 = {
 	.is_enabled		= palmas_is_enabled_ldo,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -624,23 +624,23 @@ static int palmas_is_enabled_ldo(struct regulator_dev *dev)
 	.get_bypass		= regulator_get_bypass_regmap,
 };
 
-static struct regulator_ops palmas_ops_ext_control_ldo = {
+static const struct regulator_ops palmas_ops_ext_control_ldo = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 };
 
-static struct regulator_ops palmas_ops_extreg = {
+static const struct regulator_ops palmas_ops_extreg = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 };
 
-static struct regulator_ops palmas_ops_ext_control_extreg = {
+static const struct regulator_ops palmas_ops_ext_control_extreg = {
 };
 
-static struct regulator_ops tps65917_ops_ldo = {
+static const struct regulator_ops tps65917_ops_ldo = {
 	.is_enabled		= palmas_is_enabled_ldo,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -651,7 +651,7 @@ static int palmas_is_enabled_ldo(struct regulator_dev *dev)
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops tps65917_ops_ldo_1_2 = {
+static const struct regulator_ops tps65917_ops_ldo_1_2 = {
 	.is_enabled		= palmas_is_enabled_ldo,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
-- 
1.9.1
