From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip/voltdm_nm][PATCH 07/10] OMAP3+: PM: VP: use uV for max and min voltage limits
Date: Mon,  6 Jun 2011 21:16:10 -0500
Message-ID: <1307412972-25854-8-git-send-email-nm@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49668 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756655Ab1FGCQs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 22:16:48 -0400
Received: by gyf1 with SMTP id 1so1917441gyf.20
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 19:16:47 -0700 (PDT)
In-Reply-To: <1307412972-25854-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

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

The corresponding voltage values are arrived at by using the
following pre-existing equations:
TWL4030/5030 for OMAP3430/OMAP3630:(twl4030_vsel_to_uv)
	(((vsel * 125) + 6000)) * 100
TWL6030 (OMAP4430):(twl6030_uv_to_vsel)
	((((vsel - 1) * 1266) + 70900)) * 10

Reported-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
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
index 0a4232f..b3349a0 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -118,6 +118,24 @@ struct omap_volt_data {
  */
 #define USE_DEFAULT_CHANNEL_I2C_PARAM  0x8000
 
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
@@ -138,8 +156,8 @@ struct omap_voltdm_pmic {
 	u8 vp_erroroffset;
 	u8 vp_vstepmin;
 	u8 vp_vstepmax;
-	u8 vp_vddmin;
-	u8 vp_vddmax;
+	u32 vp_vddmin;
+	u32 vp_vddmax;
 	u8 vp_timeout_us;
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 3807620..4677921 100644
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

