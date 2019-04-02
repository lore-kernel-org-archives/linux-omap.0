From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: twl: Constify regulator_ops
Date: Wed,  3 Apr 2019 07:41:54 +0800
Message-ID: <20190402234154.22800-1-axel.lin@ingics.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
List-Id: linux-omap@vger.kernel.org

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/twl-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 402ea43c77d1..cdd81e1985ff 100644
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
-- 
2.17.1
