From: balajitk@ti.com
Subject: [PATCH] twl6030: add base addr for ID0, ID1, ID2
Date: Thu, 18 Feb 2010 22:30:19 +0530
Message-ID: <1266512419-22566-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60992 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758537Ab0BRRAb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 12:00:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, sameo@linux.intel.com
Cc: tony@atomide.com, santosh.shilimkar@ti.com, Balaji T K <balajitk@ti.com>

From: Balaji T K <balajitk@ti.com>

Add base address for generic slave ID0, ID1, ID2
and introduced one more entry to align RTC module number between
twl4030 and twl6030

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mfd/twl-core.c  |    7 +++++--
 include/linux/i2c/twl.h |    5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 2a76065..d820e87 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -204,6 +204,7 @@
 /* subchip/slave 3 0x4B - AUDIO */
 #define TWL6030_BASEADD_AUDIO		0x0000
 #define TWL6030_BASEADD_RSV		0x0000
+#define TWL6030_BASEADD_ZERO		0x0000
 
 /* Few power values */
 #define R_CFG_BOOT			0x05
@@ -319,9 +320,11 @@ static struct twl_mapping twl6030_map[] = {
 	{ SUB_CHIP_ID1, TWL6030_BASEADD_CHARGER },
 	{ SUB_CHIP_ID1, TWL6030_BASEADD_GASGAUGE },
 	{ SUB_CHIP_ID1, TWL6030_BASEADD_PWM },
-	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
-	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+	{ SUB_CHIP_ID0, TWL6030_BASEADD_ZERO },
+	{ SUB_CHIP_ID1, TWL6030_BASEADD_ZERO },
 
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_ZERO },
+	{ SUB_CHIP_ID2, TWL6030_BASEADD_ZERO },
 	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
 	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
 	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index bf1c5be..fcf9286 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -80,6 +80,11 @@
 #define TWL_MODULE_PM_MASTER	TWL4030_MODULE_PM_MASTER
 #define TWL_MODULE_PM_RECEIVER	TWL4030_MODULE_PM_RECEIVER
 #define TWL_MODULE_RTC		TWL4030_MODULE_RTC
+#define TWL_MODULE_PWM		TWL4030_MODULE_PWM0
+
+#define TWL6030_MODULE_ID0	0x0D
+#define TWL6030_MODULE_ID1	0x0E
+#define TWL6030_MODULE_ID2	0x0F
 
 #define GPIO_INTR_OFFSET	0
 #define KEYPAD_INTR_OFFSET	1
-- 
1.6.0.4

