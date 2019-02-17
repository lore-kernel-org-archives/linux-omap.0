From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: twl6030: Constify regulator_ops
Date: Sun, 17 Feb 2019 21:48:09 +0800
Message-ID: <20190217134809.18108-2-axel.lin@ingics.com>
References: <20190217134809.18108-1-axel.lin@ingics.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190217134809.18108-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolae Rosia <Nicolae_Rosia@mentor.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/twl6030-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index dcaa6512d760..15f19df6bc5d 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -244,7 +244,7 @@ static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
 	return -ENODEV;
 }
 
-static struct regulator_ops twl6030coresmps_ops = {
+static const struct regulator_ops twl6030coresmps_ops = {
 	.set_voltage	= twl6030coresmps_set_voltage,
 	.get_voltage	= twl6030coresmps_get_voltage,
 };
@@ -266,7 +266,7 @@ static int twl6030ldo_get_voltage_sel(struct regulator_dev *rdev)
 	return vsel;
 }
 
-static struct regulator_ops twl6030ldo_ops = {
+static const struct regulator_ops twl6030ldo_ops = {
 	.list_voltage	= regulator_list_voltage_linear_range,
 
 	.set_voltage_sel = twl6030ldo_set_voltage_sel,
@@ -281,7 +281,7 @@ static struct regulator_ops twl6030ldo_ops = {
 	.get_status	= twl6030reg_get_status,
 };
 
-static struct regulator_ops twl6030fixed_ops = {
+static const struct regulator_ops twl6030fixed_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 
 	.enable		= twl6030reg_enable,
@@ -472,7 +472,7 @@ static int twl6030smps_get_voltage_sel(struct regulator_dev *rdev)
 	return twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS);
 }
 
-static struct regulator_ops twlsmps_ops = {
+static const struct regulator_ops twlsmps_ops = {
 	.list_voltage		= twl6030smps_list_voltage,
 	.map_voltage		= twl6030smps_map_voltage,
 
-- 
2.17.1
