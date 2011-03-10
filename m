From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v2 7/7] OMAP: PM CONSTRAINTS: add power domains wake-up latency figures
Date: Thu, 10 Mar 2011 18:47:27 +0100
Message-ID: <1299779247-20511-8-git-send-email-j-pihet@ti.com>
References: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55430 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab1CJRrx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 12:47:53 -0500
Received: by mail-wy0-f174.google.com with SMTP id 21so1681959wya.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 09:47:53 -0800 (PST)
In-Reply-To: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

Figures are added to the power domains structs.

Note: the figures are preliminary figures. More accurate measurements
are needed. Also the conditions of measurements shall be investigated
and described.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomains3xxx_data.c |   63 +++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index e1bec56..64973d1 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -31,6 +31,9 @@
 
 /*
  * Powerdomains
+ *
+ * The wakeup_lat values are derived from measurements on
+ * the actual target.
  */
 
 static struct powerdomain iva2_pwrdm = {
@@ -52,6 +55,12 @@ static struct powerdomain iva2_pwrdm = {
 		[2] = PWRSTS_OFF_ON,
 		[3] = PWRDM_POWER_ON,
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1100,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 350,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain mpu_3xxx_pwrdm = {
@@ -68,6 +77,12 @@ static struct powerdomain mpu_3xxx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_OFF_ON,
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 95,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 45,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /*
@@ -98,6 +113,12 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 100,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 60,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain core_3xxx_es3_1_pwrdm = {
@@ -121,6 +142,12 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 100,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 60,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain dss_pwrdm = {
@@ -136,6 +163,12 @@ static struct powerdomain dss_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 70,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 20,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /*
@@ -157,6 +190,12 @@ static struct powerdomain sgx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain cam_pwrdm = {
@@ -172,6 +211,12 @@ static struct powerdomain cam_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 850,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 35,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain per_pwrdm = {
@@ -187,6 +232,12 @@ static struct powerdomain per_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 200,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 110,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain emu_pwrdm = {
@@ -201,6 +252,12 @@ static struct powerdomain neon_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 200,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 35,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain usbhost_pwrdm = {
@@ -223,6 +280,12 @@ static struct powerdomain usbhost_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 800,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 150,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain dpll1_pwrdm = {
-- 
1.7.2.3

