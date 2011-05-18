From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP/voltdm_c][PATCH 04/11] OMAP4: PM: VC: support configuration of i2c clks
Date: Wed, 18 May 2011 00:17:27 -0500
Message-ID: <1305695854-9638-5-git-send-email-nm@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44507 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754834Ab1ERFRk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 01:17:40 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I5HdS8005404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4I5Hd6l002251
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500 (CDT)
In-Reply-To: <1305695854-9638-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Patch "OMAP2+: voltage: split voltage controller (VC) code into dedicated layer"
splits out the hardcoded value in the code to vc's channel init.

This patch further isolates the configuration to remove out PMIC specific
configuration as high and low times are pmic specific.

Values are updated as well based on latest TI analysis done in android k35
kernel.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
note: Generates two over 80 char warnings, left as is for maintaining
code continuity.
WARNING: line over 80 characters
#71: FILE: arch/arm/mach-omap2/prm-regbits-44xx.h:1068:
+#define OMAP4430_HSCLH_MASK						(0xff << 16)
	WARNING: line over 80 characters
#75: FILE: arch/arm/mach-omap2/prm-regbits-44xx.h:1072:
	+#define OMAP4430_HSCLL_MASK						(0xff << 24)

 arch/arm/mach-omap2/omap_twl.c         |   13 +++++++++++++
 arch/arm/mach-omap2/prm-regbits-44xx.h |    8 ++++++++
 arch/arm/mach-omap2/vc.c               |   16 ++++++++++++----
 arch/arm/mach-omap2/voltage.h          |    8 ++++++++
 4 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 30f4323..82a91be 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -202,6 +202,10 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_MPU_SR_VOLT_REG,
 	.i2c_high_speed		= true,
+	.i2c_scll_low		= 0x28,
+	.i2c_scll_high		= 0x2C,
+	.i2c_hscll_low		= 0x0B,
+	.i2c_hscll_high		= 0x00,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
@@ -223,6 +227,10 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_IVA_SR_VOLT_REG,
 	.i2c_high_speed		= true,
+	.i2c_scll_low		= 0x28,
+	.i2c_scll_high		= 0x2C,
+	.i2c_hscll_low		= 0x0B,
+	.i2c_hscll_high		= 0x00,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
@@ -242,6 +250,11 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
 	.vp_vddmax		= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
+	.i2c_high_speed		= true,
+	.i2c_scll_low		= 0x28,
+	.i2c_scll_high		= 0x2C,
+	.i2c_hscll_low		= 0x0B,
+	.i2c_hscll_high		= 0x00,
 	.volt_reg_addr		= OMAP4_VDD_CORE_SR_VOLT_REG,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
diff --git a/arch/arm/mach-omap2/prm-regbits-44xx.h b/arch/arm/mach-omap2/prm-regbits-44xx.h
index 6d2776f..32a5eb5 100644
--- a/arch/arm/mach-omap2/prm-regbits-44xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-44xx.h
@@ -1063,6 +1063,14 @@
 #define OMAP4430_SCLL_SHIFT						8
 #define OMAP4430_SCLL_MASK						(0xff << 8)
 
+/* Used by PRM_VC_CFG_I2C_CLK */
+#define OMAP4430_HSCLH_SHIFT						16
+#define OMAP4430_HSCLH_MASK						(0xff << 16)
+
+/* Used by PRM_VC_CFG_I2C_CLK */
+#define OMAP4430_HSCLL_SHIFT						24
+#define OMAP4430_HSCLL_MASK						(0xff << 24)
+
 /* Used by PRM_RSTST */
 #define OMAP4430_SECURE_WDT_RST_SHIFT					4
 #define OMAP4430_SECURE_WDT_RST_MASK					(1 << 4)
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 8ca200d..79b9e86 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -191,14 +191,22 @@ static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
 static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
 {
 	static bool is_initialized;
-	u32 vc_val;
+	struct omap_voltdm_pmic *pmic = voltdm->pmic;
+	u32 vc_val = 0;
 
 	if (is_initialized)
 		return;
 
-	/* XXX These are magic numbers and do not belong! */
-	vc_val = (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4430_SCLH_SHIFT);
-	voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
+	if (pmic->i2c_high_speed) {
+		vc_val |= pmic->i2c_hscll_low << OMAP4430_HSCLL_SHIFT;
+		vc_val |= pmic->i2c_hscll_high << OMAP4430_HSCLH_SHIFT;
+	}
+
+	vc_val |= pmic->i2c_scll_low << OMAP4430_SCLL_SHIFT;
+	vc_val |= pmic->i2c_scll_high << OMAP4430_SCLH_SHIFT;
+
+	if (vc_val)
+		voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
 
 	is_initialized = true;
 }
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 2f7b268..3fe56e4 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -118,6 +118,10 @@ struct omap_volt_data {
  * @i2c_mcode: master code value for I2C high-speed preamble transmission
  * @vsel_to_uv:	PMIC API to convert vsel value to actual voltage in uV.
  * @uv_to_vsel:	PMIC API to convert voltage in uV to vsel value.
+ * @i2c_hscll_low: PMIC interface speed config for highspeed mode (T low)
+ * @i2c_hscll_high: PMIC interface speed config for highspeed mode (T high)
+ * @i2c_scll_low: PMIC interface speed config for fullspeed mode (T low)
+ * @i2c_scll_high: PMIC interface speed config for fullspeed mode (T high)
  */
 struct omap_voltdm_pmic {
 	int slew_rate;
@@ -137,6 +141,10 @@ struct omap_voltdm_pmic {
 	u8 volt_reg_addr;
 	u8 cmd_reg_addr;
 	bool i2c_high_speed;
+	u8 i2c_hscll_low;
+	u8 i2c_hscll_high;
+	u8 i2c_scll_low;
+	u8 i2c_scll_high;
 	u8 i2c_mcode;
 	unsigned long (*vsel_to_uv) (const u8 vsel);
 	u8 (*uv_to_vsel) (unsigned long uV);
-- 
1.7.0.4

