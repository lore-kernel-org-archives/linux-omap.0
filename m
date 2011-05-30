From: Nishanth Menon <nm@ti.com>
Subject: [pm_wip/voltdm_nm][PATCH] OMAP3+: PM: VC: support configuring PMIC over I2C_SR
Date: Sun, 29 May 2011 21:39:15 -0500
Message-ID: <1306723155-17708-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:47536 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752611Ab1E3CjX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 29 May 2011 22:39:23 -0400
Received: by mail-gy0-f174.google.com with SMTP id 10so1284625gyd.19
        for <linux-omap@vger.kernel.org>; Sun, 29 May 2011 19:39:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Many simpler PMICs such as TPS65023 as discussed in:
http://marc.info/?t=129848405600010&r=1&w=2

With a single I2C interface do still have configuration registers that
may need population. Typical being slew rate, thermal shutdown
configuration etc. These devices are typically hooked on Application
Processor's(AP) standard I2C busses. Unfortunately, when hooked on
I2C_SR, unlike the standard I2C framework, we cannot read using
Voltage controller, but we can definitely write to them. Hence
for using PMICs such as these and others such as those used with
OMAP4460, it is imperative that we provide a hook to support the
device configuration.

To reuse code, we split the existing vc_bypass command into a reusable
subfunction which we use from both vc_bypass and the new function.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vc.c |   91 ++++++++++++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/vc.h |    2 +
 2 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 0b4d533..6f445e8 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -102,30 +102,29 @@ void omap_vc_post_scale(struct voltagedomain *voltdm,
 	voltdm->curr_volt = target_volt;
 }
 
-/* vc_bypass_scale_voltage - VC bypass method of voltage scaling */
-int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
-				 unsigned long target_volt)
+static int omap_vc_bypass_send_value(struct voltagedomain *voltdm,
+		struct omap_vc_channel *vc, u8 sa, u8 reg, u32 data)
 {
-	struct omap_vc_channel *vc = voltdm->vc;
 	u32 loop_cnt = 0, retries_cnt = 0;
 	u32 vc_valid, vc_bypass_val_reg, vc_bypass_value;
-	u8 target_vsel, current_vsel;
-	int ret;
 
-	ret = omap_vc_pre_scale(voltdm, target_volt, &target_vsel, &current_vsel);
-	if (ret)
-		return ret;
+	if (IS_ERR_OR_NULL(vc->common)) {
+		pr_err("%s voldm=%s bad value for vc->common\n",
+				__func__, voltdm->name);
+		return -EINVAL;
+	}
 
 	vc_valid = vc->common->valid;
 	vc_bypass_val_reg = vc->common->bypass_val_reg;
-	vc_bypass_value = (target_vsel << vc->common->data_shift) |
-		(vc->volt_reg_addr << vc->common->regaddr_shift) |
-		(vc->i2c_slave_addr << vc->common->slaveaddr_shift);
+	vc_bypass_value = (data << vc->common->data_shift) |
+		(reg << vc->common->regaddr_shift) |
+		(sa << vc->common->slaveaddr_shift);
 
 	voltdm->write(vc_bypass_value, vc_bypass_val_reg);
 	voltdm->write(vc_bypass_value | vc_valid, vc_bypass_val_reg);
 
 	vc_bypass_value = voltdm->read(vc_bypass_val_reg);
+
 	/*
 	 * Loop till the bypass command is acknowledged from the SMPS.
 	 * NOTE: This is legacy code. The loop count and retry count needs
@@ -147,10 +146,78 @@ int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
 		vc_bypass_value = voltdm->read(vc_bypass_val_reg);
 	}
 
+	return 0;
+
+}
+
+/* vc_bypass_scale_voltage - VC bypass method of voltage scaling */
+int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
+				 unsigned long target_volt)
+{
+	struct omap_vc_channel *vc;
+	u8 target_vsel, current_vsel;
+	int ret;
+
+	if (IS_ERR_OR_NULL(voltdm)) {
+		pr_err("%s bad voldm\n", __func__);
+		return -EINVAL;
+	}
+
+	vc = voltdm->vc;
+	if (IS_ERR_OR_NULL(vc)) {
+		pr_err("%s voldm=%s bad vc\n", __func__, voltdm->name);
+		return -EINVAL;
+	}
+
+	ret = omap_vc_pre_scale(voltdm, target_volt, &target_vsel, &current_vsel);
+	if (ret)
+		return ret;
+
+	ret = omap_vc_bypass_send_value(voltdm, vc, vc->i2c_slave_addr,
+					vc->volt_reg_addr, target_vsel);
+	if (ret)
+		return ret;
+
 	omap_vc_post_scale(voltdm, target_volt, target_vsel, current_vsel);
 	return 0;
 }
 
+/**
+ * omap_vc_bypass_send_i2c_msg() - Function to control PMIC registers over SRI2C
+ * @voltdm:	voltage domain
+ * @slave_addr:	slave address of the device.
+ * @reg_addr:	register address to access
+ * @data:	what do we want to write there
+ *
+ * Many simpler PMICs with a single I2C interface still have configuration
+ * registers that may need population. Typical being slew rate configurations
+ * thermal shutdown configuration etc. When these PMICs are hooked on I2C_SR,
+ * this function allows these configuration registers to be accessed.
+ *
+ * WARNING: Though this could be used for voltage register configurations over
+ * I2C_SR, DONOT use it for that purpose, all the Voltage controller's internal
+ * information is bypassed using this function and must be used judiciously.
+ */
+int omap_vc_bypass_send_i2c_msg(struct voltagedomain *voltdm, u8 slave_addr,
+				u8 reg_addr, u8 data)
+{
+	struct omap_vc_channel *vc;
+
+	if (IS_ERR_OR_NULL(voltdm)) {
+		pr_err("%s bad voldm\n", __func__);
+		return -EINVAL;
+	}
+
+	vc = voltdm->vc;
+	if (IS_ERR_OR_NULL(vc)) {
+		pr_err("%s voldm=%s bad vc\n", __func__, voltdm->name);
+		return -EINVAL;
+	}
+
+	return omap_vc_bypass_send_value(voltdm, vc, slave_addr,
+					reg_addr, data);
+}
+
 static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
 {
 	/*
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 96739a2..3af5336 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -133,5 +133,7 @@ void omap_vc_post_scale(struct voltagedomain *voltdm,
 			u8 target_vsel, u8 current_vsel);
 int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
 				 unsigned long target_volt);
+int omap_vc_bypass_send_i2c_msg(struct voltagedomain *voltdm,
+		u8 slave_addr, u8 reg_addr, u8 data);
 #endif
 
-- 
1.7.1

