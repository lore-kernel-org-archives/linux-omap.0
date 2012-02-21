From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 02/14] arm: omap: voltage: renamed vp_vddmin and vp_vddmax fields
Date: Tue, 21 Feb 2012 16:04:46 +0200
Message-ID: <1329833098-19900-3-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35673 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171Ab2BUOFy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:05:54 -0500
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

These are now called vddmin and vddmax, as these fields will be used
globally for selecting voltage ranges for a pmic channel, and not
only for voltage processor.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |   27 ++++++++++-----------------
 arch/arm/mach-omap2/voltage.h  |    4 ++--
 arch/arm/mach-omap2/vp.c       |    4 ++--
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index df4e7c3..5224fbd 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -149,8 +149,8 @@ static struct omap_voltdm_pmic omap3_mpu_pmic = {
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
-	.vp_vddmin		= OMAP3430_VP1_VLIMITTO_VDDMIN,
-	.vp_vddmax		= OMAP3430_VP1_VLIMITTO_VDDMAX,
+	.vddmin			= 600000,
+	.vddmax			= 1450000,
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP3_VDD_MPU_SR_CONTROL_REG,
@@ -170,8 +170,8 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
-	.vp_vddmin		= OMAP3430_VP2_VLIMITTO_VDDMIN,
-	.vp_vddmax		= OMAP3430_VP2_VLIMITTO_VDDMAX,
+	.vddmin			= 600000,
+	.vddmax			= 1450000,
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP3_VDD_CORE_SR_CONTROL_REG,
@@ -191,8 +191,8 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
-	.vp_vddmin		= OMAP4_VP_MPU_VLIMITTO_VDDMIN,
-	.vp_vddmax		= OMAP4_VP_MPU_VLIMITTO_VDDMAX,
+	.vddmin			= 0,
+	.vddmax			= 1500000,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_MPU_SR_VOLT_REG,
@@ -213,8 +213,8 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
-	.vp_vddmin		= OMAP4_VP_IVA_VLIMITTO_VDDMIN,
-	.vp_vddmax		= OMAP4_VP_IVA_VLIMITTO_VDDMAX,
+	.vddmin			= 0,
+	.vddmax			= 1500000,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_IVA_SR_VOLT_REG,
@@ -235,8 +235,8 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
-	.vp_vddmin		= OMAP4_VP_CORE_VLIMITTO_VDDMIN,
-	.vp_vddmax		= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
+	.vddmin			= 0,
+	.vddmax			= 1500000,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_CORE_SR_VOLT_REG,
@@ -271,13 +271,6 @@ int __init omap3_twl_init(void)
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
 
-	if (cpu_is_omap3630()) {
-		omap3_mpu_pmic.vp_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
-		omap3_mpu_pmic.vp_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
-		omap3_core_pmic.vp_vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
-		omap3_core_pmic.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
-	}
-
 	/*
 	 * The smartreflex bit on twl4030 specifies if the setting of voltage
 	 * is done over the I2C_SR path. Since this setting is independent of
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index fa5b3dc..949938d 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -162,8 +162,8 @@ struct omap_voltdm_pmic {
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
index 6ee0b4a..d9e0650 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -53,8 +53,8 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	sys_clk_rate = voltdm->sys_clk.rate / 1000;
 
 	timeout = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
-	vddmin = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmin);
-	vddmax = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmax);
+	vddmin = voltdm->pmic->uv_to_vsel(voltdm->pmic->vddmin);
+	vddmax = voltdm->pmic->uv_to_vsel(voltdm->pmic->vddmax);
 
 	waittime = ((voltdm->pmic->step_size / voltdm->pmic->slew_rate) *
 		    sys_clk_rate) / 1000;
-- 
1.7.4.1

