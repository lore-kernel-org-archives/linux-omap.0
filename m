From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 18/19] OMAP2+: VC: support PMICs with separate voltage and command registers
Date: Wed, 23 Mar 2011 17:00:32 -0700
Message-ID: <1300924833-26745-19-git-send-email-khilman@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:40523 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933394Ab1CXAAt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 20:00:49 -0400
Received: by mail-iw0-f175.google.com with SMTP id 10so11773584iwn.34
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 17:00:49 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

The VC layer can support PMICs with separate voltage and command
registers by putting the different registers in the PRM_VC_SMPS_VOL_RA
and PRCM_VC_SMPS_CMD_RA registers respectively.

The PMIC data must supply at least a voltage register address
(volt_reg_addr).  The command register address (cmd_reg_addr) is
optional.  If the PMIC data does not supply a separate command
register address, the VC will use the voltage register address for both.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |   10 +++++-----
 arch/arm/mach-omap2/vc.c       |    4 ++--
 arch/arm/mach-omap2/voltage.h  |    3 ++-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 57c325a..9428b00 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -158,7 +158,7 @@ static struct omap_volt_pmic_info omap3_mpu_volt_info = {
 	.vp_vddmax		= OMAP3430_VP1_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
-	.pmic_reg		= OMAP3_VDD_MPU_SR_CONTROL_REG,
+	.volt_reg_addr		= OMAP3_VDD_MPU_SR_CONTROL_REG,
 	.vsel_to_uv		= twl4030_vsel_to_uv,
 	.uv_to_vsel		= twl4030_uv_to_vsel,
 };
@@ -178,7 +178,7 @@ static struct omap_volt_pmic_info omap3_core_volt_info = {
 	.vp_vddmax		= OMAP3430_VP2_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
-	.pmic_reg		= OMAP3_VDD_CORE_SR_CONTROL_REG,
+	.volt_reg_addr		= OMAP3_VDD_CORE_SR_CONTROL_REG,
 	.vsel_to_uv		= twl4030_vsel_to_uv,
 	.uv_to_vsel		= twl4030_uv_to_vsel,
 };
@@ -198,7 +198,7 @@ static struct omap_volt_pmic_info omap4_mpu_volt_info = {
 	.vp_vddmax		= OMAP4_VP_MPU_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
-	.pmic_reg		= OMAP4_VDD_MPU_SR_VOLT_REG,
+	.volt_reg_addr		= OMAP4_VDD_MPU_SR_VOLT_REG,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
@@ -218,7 +218,7 @@ static struct omap_volt_pmic_info omap4_iva_volt_info = {
 	.vp_vddmax		= OMAP4_VP_IVA_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
-	.pmic_reg		= OMAP4_VDD_IVA_SR_VOLT_REG,
+	.volt_reg_addr		= OMAP4_VDD_IVA_SR_VOLT_REG,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
@@ -238,7 +238,7 @@ static struct omap_volt_pmic_info omap4_core_volt_info = {
 	.vp_vddmax		= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
-	.pmic_reg		= OMAP4_VDD_CORE_SR_VOLT_REG,
+	.volt_reg_addr		= OMAP4_VDD_CORE_SR_VOLT_REG,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 0c9a494..c561cfc 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -106,7 +106,7 @@ int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
 	vc_valid = vc->common->valid;
 	vc_bypass_val_reg = vc->common->bypass_val_reg;
 	vc_bypass_value = (target_vsel << vc->common->data_shift) |
-			(vdd->pmic_info->pmic_reg <<
+			(vdd->pmic_info->volt_reg_addr <<
 			vc->common->regaddr_shift) |
 			(vdd->pmic_info->i2c_slave_addr <<
 			vc->common->slaveaddr_shift);
@@ -250,7 +250,7 @@ void __init omap_vc_init(struct voltagedomain *voltdm)
 	vc_val = vdd->read_reg(vc->common->prm_mod,
 			       vc->common->smps_volra_reg);
 	vc_val &= ~vc->smps_volra_mask;
-	vc_val |= vdd->pmic_info->pmic_reg << vc->smps_volra_shift;
+	vc_val |= vdd->pmic_info->volt_reg_addr << vc->smps_volra_shift;
 	vdd->write_reg(vc_val, vc->common->prm_mod,
 		       vc->common->smps_volra_reg);
 
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index c5d3087..d26d839 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -117,7 +117,8 @@ struct omap_volt_pmic_info {
 	u8 vp_vddmax;
 	u8 vp_timeout_us;
 	u8 i2c_slave_addr;
-	u8 pmic_reg;
+	u8 volt_reg_addr;
+	u8 cmd_reg_addr;
 	unsigned long (*vsel_to_uv) (const u8 vsel);
 	u8 (*uv_to_vsel) (unsigned long uV);
 };
-- 
1.7.4

