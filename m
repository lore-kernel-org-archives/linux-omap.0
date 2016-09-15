From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/7] mfd: ab8500-debugfs: Prevent initialised field from being over-written
Date: Thu, 15 Sep 2016 11:45:16 +0100
Message-ID: <20160915104521.14286-3-lee.jones@linaro.org>
References: <20160915104521.14286-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915104521.14286-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Due to the lack of parity in the way array fields have been named/
numbered, a mistake was made where more debug fields were declared
than actually existed.  In doing so, 2 fields were added, which
although unclear, were already declared in the array.  The result
was that the latter declarations trashed the former ones.

This patch places the array back in the correct order and removes
the offending NULL entries.

While we're at it, let's ensure this doesn't happen again by naming
each field properly and add a new *_LAST define to describe how
many fields there should be.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-debugfs.c      | 50 ++++++++++++++++-----------------------
 include/linux/mfd/abx500/ab8500.h |  2 ++
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 0aecd7b..6c913c4 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -153,14 +153,14 @@ static struct hwreg_cfg hwreg_cfg = {
 
 #define AB8500_NAME_STRING "ab8500"
 #define AB8500_ADC_NAME_STRING "gpadc"
-#define AB8500_NUM_BANKS 24
+#define AB8500_NUM_BANKS AB8500_DEBUG_FIELD_LAST
 
 #define AB8500_REV_REG 0x80
 
 static struct ab8500_prcmu_ranges *debug_ranges;
 
 static struct ab8500_prcmu_ranges ab8500_debug_ranges[AB8500_NUM_BANKS] = {
-	[0x0] = {
+	[AB8500_M_FSM_RANK] = {
 		.num_ranges = 0,
 		.range = NULL,
 	},
@@ -315,7 +315,7 @@ static struct ab8500_prcmu_ranges ab8500_debug_ranges[AB8500_NUM_BANKS] = {
 			},
 		},
 	},
-	[0x9] = {
+	[AB8500_RESERVED] = {
 		.num_ranges = 0,
 		.range = NULL,
 	},
@@ -386,24 +386,6 @@ static struct ab8500_prcmu_ranges ab8500_debug_ranges[AB8500_NUM_BANKS] = {
 			},
 		},
 	},
-	[AB8500_DEVELOPMENT] = {
-		.num_ranges = 1,
-		.range = (struct ab8500_reg_range[]) {
-			{
-				.first = 0x00,
-				.last = 0x00,
-			},
-		},
-	},
-	[AB8500_DEBUG] = {
-		.num_ranges = 1,
-		.range = (struct ab8500_reg_range[]) {
-			{
-				.first = 0x05,
-				.last = 0x07,
-			},
-		},
-	},
 	[AB8500_AUDIO] = {
 		.num_ranges = 1,
 		.range = (struct ab8500_reg_range[]) {
@@ -463,19 +445,29 @@ static struct ab8500_prcmu_ranges ab8500_debug_ranges[AB8500_NUM_BANKS] = {
 			},
 		},
 	},
-	[0x11] = {
-		.num_ranges = 0,
-		.range = NULL,
+	[AB8500_DEVELOPMENT] = {
+		.num_ranges = 1,
+		.range = (struct ab8500_reg_range[]) {
+			{
+				.first = 0x00,
+				.last = 0x00,
+			},
+		},
 	},
-	[0x12] = {
-		.num_ranges = 0,
-		.range = NULL,
+	[AB8500_DEBUG] = {
+		.num_ranges = 1,
+		.range = (struct ab8500_reg_range[]) {
+			{
+				.first = 0x05,
+				.last = 0x07,
+			},
+		},
 	},
-	[0x13] = {
+	[AB8500_PROD_TEST] = {
 		.num_ranges = 0,
 		.range = NULL,
 	},
-	[0x14] = {
+	[AB8500_STE_TEST] = {
 		.num_ranges = 0,
 		.range = NULL,
 	},
diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 9475fee..d33c245 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -63,6 +63,8 @@ enum ab8500_version {
 #define AB8500_STE_TEST		0x14
 #define AB8500_OTP_EMUL		0x15
 
+#define AB8500_DEBUG_FIELD_LAST	0x16
+
 /*
  * Interrupts
  * Values used to index into array ab8500_irq_regoffset[] defined in
-- 
2.9.3
