From: Kyle Manna <kyle.manna@fuel7.com>
Subject: [PATCH v3 5/6] regulator: TPS65910: Move regulator defs to header
Date: Thu,  3 Nov 2011 12:08:05 -0500
Message-ID: <1320340086-15371-6-git-send-email-kyle.manna@fuel7.com>
References: <1320340086-15371-1-git-send-email-kyle.manna@fuel7.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320340086-15371-1-git-send-email-kyle.manna@fuel7.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kyle Manna <kyle.manna@fuel7.com>
List-Id: linux-omap@vger.kernel.org

Move the regulator defintions to the header so that platform board file
can use them to configure specific regulators.

Signed-off-by: Kyle Manna <kyle.manna@fuel7.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/tps65910-regulator.c |   24 ------------------------
 include/linux/mfd/tps65910.h           |   25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 66d2d60..44b4f22 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -25,30 +25,6 @@
 #include <linux/gpio.h>
 #include <linux/mfd/tps65910.h>
 
-#define TPS65910_REG_VRTC		0
-#define TPS65910_REG_VIO		1
-#define TPS65910_REG_VDD1		2
-#define TPS65910_REG_VDD2		3
-#define TPS65910_REG_VDD3		4
-#define TPS65910_REG_VDIG1		5
-#define TPS65910_REG_VDIG2		6
-#define TPS65910_REG_VPLL		7
-#define TPS65910_REG_VDAC		8
-#define TPS65910_REG_VAUX1		9
-#define TPS65910_REG_VAUX2		10
-#define TPS65910_REG_VAUX33		11
-#define TPS65910_REG_VMMC		12
-
-#define TPS65911_REG_VDDCTRL		4
-#define TPS65911_REG_LDO1		5
-#define TPS65911_REG_LDO2		6
-#define TPS65911_REG_LDO3		7
-#define TPS65911_REG_LDO4		8
-#define TPS65911_REG_LDO5		9
-#define TPS65911_REG_LDO6		10
-#define TPS65911_REG_LDO7		11
-#define TPS65911_REG_LDO8		12
-
 #define TPS65910_SUPPLY_STATE_ENABLED	0x1
 
 /* supported VIO voltages in milivolts */
diff --git a/include/linux/mfd/tps65910.h b/include/linux/mfd/tps65910.h
index 503ded3..84108bb 100644
--- a/include/linux/mfd/tps65910.h
+++ b/include/linux/mfd/tps65910.h
@@ -746,6 +746,31 @@
 #define TPS65910_GPIO_STS				BIT(1)
 #define TPS65910_GPIO_SET				BIT(0)
 
+/* Regulator Index Definitions */
+#define TPS65910_REG_VRTC				0
+#define TPS65910_REG_VIO				1
+#define TPS65910_REG_VDD1				2
+#define TPS65910_REG_VDD2				3
+#define TPS65910_REG_VDD3				4
+#define TPS65910_REG_VDIG1				5
+#define TPS65910_REG_VDIG2				6
+#define TPS65910_REG_VPLL				7
+#define TPS65910_REG_VDAC				8
+#define TPS65910_REG_VAUX1				9
+#define TPS65910_REG_VAUX2				10
+#define TPS65910_REG_VAUX33				11
+#define TPS65910_REG_VMMC				12
+
+#define TPS65911_REG_VDDCTRL				4
+#define TPS65911_REG_LDO1				5
+#define TPS65911_REG_LDO2				6
+#define TPS65911_REG_LDO3				7
+#define TPS65911_REG_LDO4				8
+#define TPS65911_REG_LDO5				9
+#define TPS65911_REG_LDO6				10
+#define TPS65911_REG_LDO7				11
+#define TPS65911_REG_LDO8				12
+
 /**
  * struct tps65910_board
  * Board platform data may be used to initialize regulators.
-- 
1.7.5.4
