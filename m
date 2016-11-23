From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: twl6030: Remove unused fields from struct twlreg_info" to the regulator tree
Date: Wed, 23 Nov 2016 16:31:36 +0000
Message-ID: <E1c9aSO-0006cY-CB@debutante>
References: <20161123131321.12413-2-axel.lin@ingics.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161123131321.12413-2-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Nicolae Rosia <Nicolae_Rosia@mentor.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: twl6030: Remove unused fields from struct twlreg_info

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

>From 3498c5e15db3af90aee7dbe9a0910225422b85c1 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 23 Nov 2016 21:13:21 +0800
Subject: [PATCH] regulator: twl6030: Remove unused fields from struct
 twlreg_info

The table_len, *table, remap and max_mV fields are not used, so remove
them.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl6030-regulator.c | 46 +++++++++++++----------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index a446137f57bb..4864b9d742c0 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -31,16 +31,8 @@ struct twlreg_info {
 	/* twl resource ID, for resource control state machine */
 	u8			id;
 
-	/* voltage in mV = table[VSEL]; table_len must be a power-of-two */
-	u8			table_len;
-	const u16		*table;
-
-	/* State REMAP default configuration */
-	u8			remap;
-
 	/* chip constraints on regulator behavior */
 	u16			min_mV;
-	u16			max_mV;
 
 	u8			flags;
 
@@ -535,11 +527,10 @@ static const struct twlreg_info TWL6030_INFO_##label = { \
 		}, \
 	}
 
-#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) \
+#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts) \
 static const struct twlreg_info TWL6030_INFO_##label = { \
 	.base = offset, \
 	.min_mV = min_mVolts, \
-	.max_mV = max_mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030_REG_##label, \
@@ -550,11 +541,10 @@ static const struct twlreg_info TWL6030_INFO_##label = { \
 		}, \
 	}
 
-#define TWL6032_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) \
+#define TWL6032_ADJUSTABLE_LDO(label, offset, min_mVolts) \
 static const struct twlreg_info TWL6032_INFO_##label = { \
 	.base = offset, \
 	.min_mV = min_mVolts, \
-	.max_mV = max_mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6032_REG_##label, \
@@ -570,7 +560,6 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 	.base = offset, \
 	.id = 0, \
 	.min_mV = mVolts, \
-	.remap = 0, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030##_REG_##label, \
@@ -588,7 +577,6 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 static const struct twlreg_info TWLSMPS_INFO_##label = { \
 	.base = offset, \
 	.min_mV = 600, \
-	.max_mV = 2100, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6032_REG_##label, \
@@ -606,22 +594,22 @@ static const struct twlreg_info TWLSMPS_INFO_##label = { \
 TWL6030_ADJUSTABLE_SMPS(VDD1);
 TWL6030_ADJUSTABLE_SMPS(VDD2);
 TWL6030_ADJUSTABLE_SMPS(VDD3);
-TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300);
-TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300);
-TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300);
-TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000, 3300);
-TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000, 3300);
-TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000, 3300);
+TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000);
+TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000);
+TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000);
+TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000);
+TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000);
+TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000);
 /* 6025 are renamed compared to 6030 versions */
-TWL6032_ADJUSTABLE_LDO(LDO2, 0x54, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO4, 0x58, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO3, 0x5c, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO5, 0x68, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO1, 0x6c, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO7, 0x74, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDO6, 0x60, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDOLN, 0x64, 1000, 3300);
-TWL6032_ADJUSTABLE_LDO(LDOUSB, 0x70, 1000, 3300);
+TWL6032_ADJUSTABLE_LDO(LDO2, 0x54, 1000);
+TWL6032_ADJUSTABLE_LDO(LDO4, 0x58, 1000);
+TWL6032_ADJUSTABLE_LDO(LDO3, 0x5c, 1000);
+TWL6032_ADJUSTABLE_LDO(LDO5, 0x68, 1000);
+TWL6032_ADJUSTABLE_LDO(LDO1, 0x6c, 1000);
+TWL6032_ADJUSTABLE_LDO(LDO7, 0x74, 1000);
+TWL6032_ADJUSTABLE_LDO(LDO6, 0x60, 1000);
+TWL6032_ADJUSTABLE_LDO(LDOLN, 0x64, 1000);
+TWL6032_ADJUSTABLE_LDO(LDOUSB, 0x70, 1000);
 TWL6030_FIXED_LDO(VANA, 0x50, 2100, 0);
 TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 0);
 TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0);
-- 
2.10.2
