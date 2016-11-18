From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: twl-regulator: rework fixed regulator definition" to the regulator tree
Date: Fri, 18 Nov 2016 12:02:06 +0000
Message-ID: <E1c7hrq-0005N8-5P@debutante>
References: <1478954535-17325-4-git-send-email-Nicolae_Rosia@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478954535-17325-4-git-send-email-Nicolae_Rosia@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: twl-regulator: rework fixed regulator definition

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

>From dab780a3b489b038a47d8fbbc49c33aae1e7a682 Mon Sep 17 00:00:00 2001
From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Date: Sat, 12 Nov 2016 14:42:14 +0200
Subject: [PATCH] regulator: twl-regulator: rework fixed regulator definition

TWL603X and TWL4030 are different and have different code logic.
Rework the regulator definition method so we can split the file
easily in twl4030 and twl6030.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl-regulator.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 210681d6b743..23f7b31f6355 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -898,15 +898,6 @@ static struct regulator_ops twlsmps_ops = {
 
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
@@ -983,8 +974,27 @@ static const struct twlreg_info TWL6032_INFO_##label = { \
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
@@ -992,14 +1002,14 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
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
2.10.2
