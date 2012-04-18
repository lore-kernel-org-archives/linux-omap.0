From: jean.pihet@newoldbits.com
Subject: [PATCH 6/6] ARM: OMAP3: powerdomain data: add wake-up latency figures
Date: Wed, 18 Apr 2012 15:45:20 +0200
Message-ID: <1334756720-29166-7-git-send-email-j-pihet@ti.com>
References: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61532 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab2DRNpx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 09:45:53 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so7543586wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 06:45:52 -0700 (PDT)
In-Reply-To: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Figures are added to the power domains structs for RET and OFF modes.

Note: the latency figures for MPU, PER, CORE, NEON have been obtained
from actual measurements.
The latency figures for the other power domains are preliminary and
shall be added.

Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
for a detailed explanation on where are the numbers coming from.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/powerdomains3xxx_data.c |   83 +++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index b7ea468..34103f81 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -32,6 +32,19 @@
 
 /*
  * Powerdomains
+ *
+ * The wakeup_lat values are derived from HW and SW measurements on
+ * the actual target. For more details cf.
+ * http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement#Results_for_individual_power_domains
+ *
+ * Note: the latency figures for MPU, PER, CORE, NEON have been obtained
+ * from actual measurements.
+ * The latency figures for the other power domains are preliminary and
+ * shall be added.
+ *
+ * Note: only the SW restore timing values are taken into account.
+ * The HW impact of the sys_clkreq and sys_offmode signals is not taken
+ * into account - TDB
  */
 
 static struct powerdomain iva2_pwrdm = {
@@ -52,6 +65,13 @@ static struct powerdomain iva2_pwrdm = {
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
 	.voltdm           = { .name = "mpu_iva" },
 };
 
@@ -68,6 +88,13 @@ static struct powerdomain mpu_3xxx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_OFF_ON,
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1830,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 121,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "mpu_iva" },
 };
 
@@ -95,6 +122,13 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 3082,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 153,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "core" },
 };
 
@@ -117,6 +151,13 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 3082,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 153,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "core" },
 };
 
@@ -132,6 +173,13 @@ static struct powerdomain dss_pwrdm = {
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
 	.voltdm           = { .name = "core" },
 };
 
@@ -153,6 +201,13 @@ static struct powerdomain sgx_pwrdm = {
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
 	.voltdm           = { .name = "core" },
 };
 
@@ -168,6 +223,13 @@ static struct powerdomain cam_pwrdm = {
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
 	.voltdm           = { .name = "core" },
 };
 
@@ -183,6 +245,13 @@ static struct powerdomain per_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 671,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 31,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "core" },
 };
 
@@ -197,6 +266,13 @@ static struct powerdomain neon_pwrdm = {
 	.prcm_offs	  = OMAP3430_NEON_MOD,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 0,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 0,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "mpu_iva" },
 };
 
@@ -219,6 +295,13 @@ static struct powerdomain usbhost_pwrdm = {
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
 	.voltdm           = { .name = "core" },
 };
 
-- 
1.7.7.6

