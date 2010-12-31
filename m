From: Thara Gopinath <thara@ti.com>
Subject: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
Date: Fri, 31 Dec 2010 13:37:58 +0530
Message-ID: <1293782878-9756-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32938 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab0LaIIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Dec 2010 03:08:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com, Thara Gopinath <thara@ti.com>

The smartreflex bit on twl4030 needs to be enabled by default irrespective
of whether smartreflex module is enabled on the OMAP side or not.
This is because without this bit enabled the voltage scaling through
vp forceupdate does not function properly on OMAP3.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
This patch is against LO master and has been
tested on OMAP3430 SDP and OMAP2430 SDP.

 arch/arm/mach-omap2/omap_twl.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 15f8c6c..a59f36b 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -58,7 +58,9 @@
 static bool is_offset_valid;
 static u8 smps_offset;
 
+#define TWL4030_DCDC_GLOBAL_CFG	0x06
 #define REG_SMPS_OFFSET         0xE0
+#define SMARTREFLEX_ENABLE	BIT(3)
 
 unsigned long twl4030_vsel_to_uv(const u8 vsel)
 {
@@ -256,6 +258,7 @@ int __init omap4_twl_init(void)
 int __init omap3_twl_init(void)
 {
 	struct voltagedomain *voltdm;
+	u8 temp;
 
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
@@ -267,6 +270,19 @@ int __init omap3_twl_init(void)
 		omap3_core_volt_info.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
 	}
 
+	/*
+	 * The smartreflex bit on twl4030 needs to be enabled by
+	 * default irrespective of whether smartreflex module is
+	 * enabled on the OMAP side or not. This is because without
+	 * this bit enabled the voltage scaling through
+	 * vp forceupdate does not function properly on OMAP3.
+	 */
+	twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
+			TWL4030_DCDC_GLOBAL_CFG);
+	temp |= SMARTREFLEX_ENABLE;
+	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
+			TWL4030_DCDC_GLOBAL_CFG);
+
 	voltdm = omap_voltage_domain_lookup("mpu");
 	omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
 
-- 
1.7.0.4

