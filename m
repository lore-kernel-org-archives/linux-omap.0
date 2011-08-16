From: jean.pihet@newoldbits.com
Subject: [PATCH 11/15] OMAP3: powerdomain data: add wake-up latency figures
Date: Tue, 16 Aug 2011 15:43:14 +0200
Message-ID: <1313502198-9298-12-git-send-email-j-pihet@ti.com>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36094 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab1HPNoH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 09:44:07 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so5889599wwf.1
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 06:44:06 -0700 (PDT)
In-Reply-To: <1313502198-9298-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.ke
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Figures are added to the power domains structs.

Note: the figures are preliminary figures. More accurate measurements
are needed. Also the conditions of measurements shall be investigated
and described.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomains3xxx_data.c |   77 +++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 469a920..64446e7 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -31,6 +31,13 @@
 
 /*
  * Powerdomains
+ *
+ * The wakeup_lat values are derived from measurements on
+ * the actual target.
+ *
+ * Note: the latency figures are preliminary and only used
+ * for the constraints framework validation.
+ * Actual figures and measurements conditions shall be added.
  */
 
 static struct powerdomain iva2_pwrdm = {
@@ -52,6 +59,13 @@ static struct powerdomain iva2_pwrdm = {
 		[2] = PWRSTS_OFF_ON,
 		[3] = PWRSTS_ON,
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1100,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 350,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain mpu_3xxx_pwrdm = {
@@ -68,6 +82,13 @@ static struct powerdomain mpu_3xxx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_OFF_ON,
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 95,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 45,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /*
@@ -98,6 +119,13 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 100,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 60,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain core_3xxx_es3_1_pwrdm = {
@@ -121,6 +149,13 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 100,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 60,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain dss_pwrdm = {
@@ -136,6 +171,13 @@ static struct powerdomain dss_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 70,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 20,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /*
@@ -157,6 +199,13 @@ static struct powerdomain sgx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain cam_pwrdm = {
@@ -172,6 +221,13 @@ static struct powerdomain cam_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 850,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 35,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain per_pwrdm = {
@@ -187,6 +243,13 @@ static struct powerdomain per_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 200,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 110,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain emu_pwrdm = {
@@ -201,6 +264,13 @@ static struct powerdomain neon_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 200,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 35,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain usbhost_pwrdm = {
@@ -223,6 +293,13 @@ static struct powerdomain usbhost_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 800,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 150,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain dpll1_pwrdm = {
-- 
1.7.4.1

