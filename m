From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 02/21] ARM: OMAP: voltage: renamed vp_vddmin and vp_vddmax fields
Date: Tue, 25 Sep 2012 19:33:34 +0300
Message-ID: <1348590833-12335-3-git-send-email-t-kristo@ti.com>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60197 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757695Ab2IYQeJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 12:34:09 -0400
In-Reply-To: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

These are now called vddmin and vddmax, as these fields will be used
globally for selecting voltage ranges for a pmic channel, and not
only for voltage processor.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |   28 ++++++++++++++--------------
 arch/arm/mach-omap2/voltage.h  |    4 ++--
 arch/arm/mach-omap2/vp.c       |    4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index df4e7c3..c38a530 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -149,8 +149,8 @@ static struct omap_voltdm_pmic omap3_mpu_pmic = {
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
-	.vp_vddmin		= OMAP3430_VP1_VLIMITTO_VDDMIN,
-	.vp_vddmax		= OMAP3430_VP1_VLIMITTO_VDDMAX,
+	.vddmin			= OMAP3430_VP1_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3430_VP1_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP3_VDD_MPU_SR_CONTROL_REG,
@@ -170,8 +170,8 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
-	.vp_vddmin		= OMAP3430_VP2_VLIMITTO_VDDMIN,
-	.vp_vddmax		= OMAP3430_VP2_VLIMITTO_VDDMAX,
+	.vddmin			= OMAP3430_VP2_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3430_VP2_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP3_VDD_CORE_SR_CONTROL_REG,
@@ -191,8 +191,8 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
-	.vp_vddmin		= OMAP4_VP_MPU_VLIMITTO_VDDMIN,
-	.vp_vddmax		= OMAP4_VP_MPU_VLIMITTO_VDDMAX,
+	.vddmin			= OMAP4_VP_MPU_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_MPU_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_MPU_SR_VOLT_REG,
@@ -213,8 +213,8 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
-	.vp_vddmin		= OMAP4_VP_IVA_VLIMITTO_VDDMIN,
-	.vp_vddmax		= OMAP4_VP_IVA_VLIMITTO_VDDMAX,
+	.vddmin			= OMAP4_VP_IVA_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_IVA_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_IVA_SR_VOLT_REG,
@@ -235,8 +235,8 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
-	.vp_vddmin		= OMAP4_VP_CORE_VLIMITTO_VDDMIN,
-	.vp_vddmax		= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
+	.vddmin			= OMAP4_VP_CORE_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_CORE_SR_VOLT_REG,
@@ -272,10 +272,10 @@ int __init omap3_twl_init(void)
 		return -ENODEV;
 
 	if (cpu_is_omap3630()) {
-		omap3_mpu_pmic.vp_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
-		omap3_mpu_pmic.vp_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
-		omap3_core_pmic.vp_vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
-		omap3_core_pmic.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
+		omap3_mpu_pmic.vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
+		omap3_mpu_pmic.vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
+		omap3_core_pmic.vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
+		omap3_core_pmic.vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
 	}
 
 	/*
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 622ec4b..2242735 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -147,8 +147,8 @@ struct omap_voltdm_pmic {
 	u8 vp_erroroffset;
 	u8 vp_vstepmin;
 	u8 vp_vstepmax;
-	u32 vp_vddmin;
-	u32 vp_vddmax;
+	u32 vddmin;
+	u32 vddmax;
 	u8 vp_timeout_us;
 	bool i2c_high_speed;
 	u8 i2c_mcode;
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 40b3dcc..c585dfb 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -58,8 +58,8 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	sys_clk_rate = voltdm->sys_clk.rate / 1000;
 
 	timeout = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
-	vddmin = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmin);
-	vddmax = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmax);
+	vddmin = voltdm->pmic->uv_to_vsel(voltdm->pmic->vddmin);
+	vddmax = voltdm->pmic->uv_to_vsel(voltdm->pmic->vddmax);
 
 	waittime = DIV_ROUND_UP(voltdm->pmic->step_size * sys_clk_rate,
 				1000 * voltdm->pmic->slew_rate);
-- 
1.7.4.1

