From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v9 3/9] OMAP3: PM: Modifying the macro name Main_Ref to all caps
Date: Thu, 14 Apr 2011 17:57:51 +0530
Message-ID: <1302784077-16697-4-git-send-email-leslyam@ti.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42249 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757330Ab1DNM1x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Apr 2011 08:27:53 -0400
In-Reply-To: <1302784077-16697-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Modifying the macro name Main_Ref to all caps(MAIN_REF).

Suggested by Nishanth Menon <nm@ti.com>

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 drivers/mfd/twl4030-power.c                  |    2 +-
 include/linux/i2c/twl.h                      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 5f1900c..e42b391 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -730,7 +730,7 @@ static struct twl4030_resconfig twl4030_rconfig[] __initdata = {
 	{ .resource = RES_RESET, .devgroup = -1,
 	  .type = 1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
 	},
-	{ .resource = RES_Main_Ref, .devgroup = -1,
+	{ .resource = RES_MAIN_REF, .devgroup = -1,
 	  .type = 1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
 	},
 	{ 0, 0},
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 8373d79..8162e43 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -120,7 +120,7 @@ static u8 res_config_addrs[] = {
 	[RES_HFCLKOUT]	= 0x8b,
 	[RES_32KCLKOUT]	= 0x8e,
 	[RES_RESET]	= 0x91,
-	[RES_Main_Ref]	= 0x94,
+	[RES_MAIN_REF]	= 0x94,
 };
 
 static int __init twl4030_write_script_byte(u8 address, u8 byte)
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 9d88b71..dcc2998 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -501,7 +501,7 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
 #define RES_32KCLKOUT           26
 #define RES_RESET               27
 /* Power Reference */
-#define RES_Main_Ref            28
+#define RES_MAIN_REF            28
 
 #define TOTAL_RESOURCES		28
 /*
-- 
1.7.1

