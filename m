From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 01/14] arm: OMAP3+: PM: VP: use uV for max and min voltage limits
Date: Tue, 21 Feb 2012 16:04:45 +0200
Message-ID: <1329833098-19900-2-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49219 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171Ab2BUOFx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:05:53 -0500
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

From: Nishanth Menon <nm@ti.com>

Every PMIC has it's own eccentricities, For example, one of the
PMIC has MSB set to 1 for a specific function - voltage enable!
using an hardcoded value specific for TWL when copied over to
such an implementation causes the system to crash as the MSB bit
was 0 and the voltage got disabled!.

Instead we use actual values and depend on the convertion routines
to abstract out the eccentricities of each PMIC.

With this, we can now move the voltages to a common location in
voltage.h as they are no longer dependent on PMICs and expect the
PMIC's conversion routines to set a cap if the voltage is out of
reach for the PMIC.

Reported-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |   17 -----------------
 arch/arm/mach-omap2/voltage.h  |   22 ++++++++++++++++++++--
 arch/arm/mach-omap2/vp.c       |    4 ++--
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index f515a1a..df4e7c3 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -30,16 +30,6 @@
 #define OMAP3_VP_VSTEPMAX_VSTEPMAX	0x04
 #define OMAP3_VP_VLIMITTO_TIMEOUT_US	200
 
-#define OMAP3430_VP1_VLIMITTO_VDDMIN	0x14
-#define OMAP3430_VP1_VLIMITTO_VDDMAX	0x42
-#define OMAP3430_VP2_VLIMITTO_VDDMIN	0x18
-#define OMAP3430_VP2_VLIMITTO_VDDMAX	0x2c
-
-#define OMAP3630_VP1_VLIMITTO_VDDMIN	0x18
-#define OMAP3630_VP1_VLIMITTO_VDDMAX	0x3c
-#define OMAP3630_VP2_VLIMITTO_VDDMIN	0x18
-#define OMAP3630_VP2_VLIMITTO_VDDMAX	0x30
-
 #define OMAP4_SRI2C_SLAVE_ADDR		0x12
 #define OMAP4_VDD_MPU_SR_VOLT_REG	0x55
 #define OMAP4_VDD_MPU_SR_CMD_REG	0x56
@@ -53,13 +43,6 @@
 #define OMAP4_VP_VSTEPMAX_VSTEPMAX	0x04
 #define OMAP4_VP_VLIMITTO_TIMEOUT_US	200
 
-#define OMAP4_VP_MPU_VLIMITTO_VDDMIN	0xA
-#define OMAP4_VP_MPU_VLIMITTO_VDDMAX	0x39
-#define OMAP4_VP_IVA_VLIMITTO_VDDMIN	0xA
-#define OMAP4_VP_IVA_VLIMITTO_VDDMAX	0x2D
-#define OMAP4_VP_CORE_VLIMITTO_VDDMIN	0xA
-#define OMAP4_VP_CORE_VLIMITTO_VDDMAX	0x28
-
 static bool is_offset_valid;
 static u8 smps_offset;
 /*
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 8829201..fa5b3dc 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -118,6 +118,24 @@ struct omap_volt_data {
 	u8	vp_errgain;
 };
 
+/* Min and max voltages from OMAP perspective */
+#define OMAP3430_VP1_VLIMITTO_VDDMIN	850000
+#define OMAP3430_VP1_VLIMITTO_VDDMAX	1425000
+#define OMAP3430_VP2_VLIMITTO_VDDMIN	900000
+#define OMAP3430_VP2_VLIMITTO_VDDMAX	1150000
+
+#define OMAP3630_VP1_VLIMITTO_VDDMIN	900000
+#define OMAP3630_VP1_VLIMITTO_VDDMAX	1350000
+#define OMAP3630_VP2_VLIMITTO_VDDMIN	900000
+#define OMAP3630_VP2_VLIMITTO_VDDMAX	1200000
+
+#define OMAP4_VP_MPU_VLIMITTO_VDDMIN	830000
+#define OMAP4_VP_MPU_VLIMITTO_VDDMAX	1410000
+#define OMAP4_VP_IVA_VLIMITTO_VDDMIN	830000
+#define OMAP4_VP_IVA_VLIMITTO_VDDMAX	1260000
+#define OMAP4_VP_CORE_VLIMITTO_VDDMIN	830000
+#define OMAP4_VP_CORE_VLIMITTO_VDDMAX	1200000
+
 /**
  * struct omap_voltdm_pmic - PMIC specific data required by voltage driver.
  * @slew_rate:	PMIC slew rate (in uv/us)
@@ -144,8 +162,8 @@ struct omap_voltdm_pmic {
 	u8 vp_erroroffset;
 	u8 vp_vstepmin;
 	u8 vp_vstepmax;
-	u8 vp_vddmin;
-	u8 vp_vddmax;
+	u32 vp_vddmin;
+	u32 vp_vddmax;
 	u8 vp_timeout_us;
 	bool i2c_high_speed;
 	u8 i2c_mcode;
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 807391d..6ee0b4a 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -53,8 +53,8 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	sys_clk_rate = voltdm->sys_clk.rate / 1000;
 
 	timeout = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
-	vddmin = voltdm->pmic->vp_vddmin;
-	vddmax = voltdm->pmic->vp_vddmax;
+	vddmin = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmin);
+	vddmax = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmax);
 
 	waittime = ((voltdm->pmic->step_size / voltdm->pmic->slew_rate) *
 		    sys_clk_rate) / 1000;
-- 
1.7.4.1

