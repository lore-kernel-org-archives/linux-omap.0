From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH 3/4] regulator: twl-regulator: rework fixed regulator definition
Date: Sat, 12 Nov 2016 14:42:14 +0200
Message-ID: <1478954535-17325-4-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478954535-17325-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478954535-17325-1-git-send-email-Nicolae_Rosia@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>
List-Id: linux-omap@vger.kernel.org

TWL603X and TWL4030 are different and have different code logic.
Rework the regulator definition method so we can split the file
easily in twl4030 and twl6030.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 drivers/regulator/twl-regulator.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index e0d81f8..3f9f53d 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -873,15 +873,6 @@ static struct regulator_ops twlsmps_ops = {
 
 /*----------------------------------------------------------------------*/
 
-#define TWL4030_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
-			remap_conf) \
-		TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
-			remap_conf, TWL4030, twl4030fixed_ops, \
-			twl4030reg_map_mode)
-#define TWL6030_FIXED_LDO(label, offset, mVolts, turnon_delay) \
-		TWL_FIXED_LDO(label, offset, mVolts, 0x0, turnon_delay, \
-			0x0, TWL6030, twl6030fixed_ops, NULL)
-
 #define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) \
 static const struct twlreg_info TWL4030_INFO_##label = { \
 	.base = offset, \
@@ -958,8 +949,27 @@ static const struct twlreg_info TWL6032_INFO_##label = { \
 		}, \
 	}
 
-#define TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, remap_conf, \
-		family, operations, map_mode) \
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
+#define TWL4030_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
+			remap_conf) \
 static const struct twlreg_info TWLFIXED_INFO_##label = { \
 	.base = offset, \
 	.id = num, \
@@ -967,14 +977,14 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 	.remap = remap_conf, \
 	.desc = { \
 		.name = #label, \
-		.id = family##_REG_##label, \
+		.id = TWL4030##_REG_##label, \
 		.n_voltages = 1, \
-		.ops = &operations, \
+		.ops = &twl4030fixed_ops, \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		.min_uV = mVolts * 1000, \
 		.enable_time = turnon_delay, \
-		.of_map_mode = map_mode, \
+		.of_map_mode = twl4030reg_map_mode, \
 		}, \
 	}
 
-- 
2.5.5
