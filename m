From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 07/19] omap3+: voltage: add transdone apis
Date: Sat, 19 Feb 2011 17:31:46 +0530
Message-ID: <1298116918-30744-8-git-send-email-nm@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44205 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556Ab1BSMDF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 07:03:05 -0500
Received: by gyd8 with SMTP id 8so1941940gyd.34
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 04:03:03 -0800 (PST)
In-Reply-To: <1298116918-30744-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Transdone event in Voltage processor gives us fine grained status on
the current status of the voltage communication with the PMIC.
Unfortunately, irq generation by VP is based on the start of the
transmission to VC from VP, not at the end (or the completion of
the voltage setting). Hence any users of voltage layer who need
to know fine grained information such as confirmation if the voltage
is actually send to PMIC, needs to depend on this status.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c             |   64 ++++++++++++++++++++++-------
 arch/arm/plat-omap/include/plat/voltage.h |    2 +
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 08f0abf..77cb0cd 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -639,8 +639,8 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 		struct omap_volt_data *target_volt)
 {
 	u32 vpconfig;
-	u16 mod, ocp_mod;
-	u8 target_vsel, current_vsel, prm_irqst_reg;
+	u16 mod;
+	u8 target_vsel, current_vsel;
 	int ret, timeout = 0;
 
 	ret = _pre_volt_scale(vdd, target_volt, &target_vsel, &current_vsel);
@@ -648,18 +648,13 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 		return ret;
 
 	mod = vdd->vp_reg.prm_mod;
-	ocp_mod = vdd->ocp_mod;
-	prm_irqst_reg = vdd->prm_irqst_reg;
-
 	/*
 	 * Clear all pending TransactionDone interrupt/status. Typical latency
 	 * is <3us
 	 */
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
-		vdd->write_reg(vdd->vp_reg.tranxdone_status,
-				ocp_mod, prm_irqst_reg);
-		if (!(vdd->read_reg(ocp_mod, prm_irqst_reg) &
-				vdd->vp_reg.tranxdone_status))
+		omap_vp_clear_transdone(&vdd->voltdm);
+		if (!omap_vp_is_transdone(&vdd->voltdm))
 				break;
 		udelay(1);
 	}
@@ -691,7 +686,7 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	 * Depends on SMPSWAITTIMEMIN/MAX and voltage change
 	 */
 	timeout = 0;
-	omap_test_timeout((vdd->read_reg(ocp_mod, prm_irqst_reg) &
+	omap_test_timeout((vdd->read_reg(vdd->ocp_mod, vdd->prm_irqst_reg) &
 			vdd->vp_reg.tranxdone_status),
 			VP_TRANXDONE_TIMEOUT, timeout);
 	if (timeout >= VP_TRANXDONE_TIMEOUT)
@@ -707,11 +702,9 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	 */
 	timeout = 0;
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
-		vdd->write_reg(vdd->vp_reg.tranxdone_status,
-				ocp_mod, prm_irqst_reg);
-		if (!(vdd->read_reg(ocp_mod, prm_irqst_reg) &
-				vdd->vp_reg.tranxdone_status))
-				break;
+		omap_vp_clear_transdone(&vdd->voltdm);
+		if (!omap_vp_is_transdone(&vdd->voltdm))
+			break;
 		udelay(1);
 	}
 
@@ -1269,6 +1262,47 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 }
 
 /**
+ * omap_vp_is_transdone() - is voltage transfer done on vp?
+ * @voltdm:	pointer to the VDD which is to be scaled.
+ *
+ * VP's transdone bit is the only way to ensure that the transfer
+ * of the voltage value has actually been send over to the PMIC
+ * This is hence useful for all users of voltage domain to precisely
+ * identify once the PMIC voltage has been set by the voltage processor
+ */
+bool omap_vp_is_transdone(struct voltagedomain *voltdm)
+{
+	struct omap_vdd_info *vdd;
+
+	if (IS_ERR_OR_NULL(voltdm)) {
+		pr_warning("%s: Bad Params vdm=%p\n", __func__, voltdm);
+		return false;
+	}
+
+	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
+	return (vdd->read_reg(vdd->ocp_mod, vdd->prm_irqst_reg) &
+			vdd->vp_reg.tranxdone_status) ? true : false;
+}
+
+/**
+ * omap_vp_clear_transdone() - clear voltage transfer done status on vp
+ * @voltdm:	pointer to the VDD which is to be scaled.
+ */
+bool omap_vp_clear_transdone(struct voltagedomain *voltdm)
+{
+	struct omap_vdd_info *vdd;
+
+	if (IS_ERR_OR_NULL(voltdm)) {
+		pr_warning("%s: Bad Params vdm=%p\n", __func__, voltdm);
+		return false;
+	}
+
+	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
+	vdd->write_reg(vdd->vp_reg.tranxdone_status,
+			vdd->ocp_mod, vdd->prm_irqst_reg);
+	return true;
+}
+/**
  * omap_voltage_scale_vdd() - API to scale voltage of a particular
  *				voltage domain.
  * @voltdm:	pointer to the VDD which is to be scaled.
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 52df49f..332c581 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -124,6 +124,8 @@ void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 		unsigned long volt);
 struct omap_volt_data *omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
+bool omap_vp_is_transdone(struct voltagedomain *voltdm);
+bool omap_vp_clear_transdone(struct voltagedomain *voltdm);
 struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm);
 #ifdef CONFIG_PM
 int omap_voltage_register_pmic(struct voltagedomain *voltdm,
-- 
1.7.1

