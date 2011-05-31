From: Nishanth Menon <nm@ti.com>
Subject: [pm_wip/voltdm_nm][PATCH 1/2] OMAP3+: PM: VP: use uV for max and min voltage limits
Date: Tue, 31 May 2011 02:33:51 -0500
Message-ID: <1306827232-27728-2-git-send-email-nm@ti.com>
References: <1306827232-27728-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:51389 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757999Ab1EaHeC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 May 2011 03:34:02 -0400
Received: by gwj22 with SMTP id 22so2393622gwj.7
        for <linux-omap@vger.kernel.org>; Tue, 31 May 2011 00:34:00 -0700 (PDT)
In-Reply-To: <1306827232-27728-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

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
---
 arch/arm/mach-omap2/omap_twl.c |   17 -----------------
 arch/arm/mach-omap2/voltage.h  |   22 ++++++++++++++++++++--
 arch/arm/mach-omap2/vp.c       |    4 ++--
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 747a810..f474eca 100644
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
index f079167..7366793 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -109,6 +109,24 @@ struct omap_volt_data {
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
@@ -129,8 +147,8 @@ struct omap_voltdm_pmic {
 	u8 vp_erroroffset;
 	u8 vp_vstepmin;
 	u8 vp_vstepmax;
-	u8 vp_vddmin;
-	u8 vp_vddmax;
+	u32 vp_vddmin;
+	u32 vp_vddmax;
 	u8 vp_timeout_us;
 	u8 i2c_slave_addr;
 	u8 volt_reg_addr;
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index e7d38f6..4b3c1f0 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -64,8 +64,8 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	sys_clk_rate = voltdm->sys_clk.rate / 1000;
 
 	timeout = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
-	vddmin = voltdm->pmic->vp_vddmin;
-	vddmax = voltdm->pmic->vp_vddmax;
+	vddmin = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmin);
+	vddmax = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmax);
 
 	waittime = ((voltdm->pmic->step_size / voltdm->pmic->slew_rate) *
 		    sys_clk_rate) / 1000;
-- 
1.7.1

