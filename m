From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 07/19] OMAP3+: voltage: add transdone APIs
Date: Sat,  5 Mar 2011 20:59:10 +0530
Message-ID: <1299338962-5602-8-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:39037 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752937Ab1CEPau (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 10:30:50 -0500
Received: by yic13 with SMTP id 13so1516532yic.17
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 07:30:48 -0800 (PST)
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Nishanth Menon <nm@ti.com>

Transdone event in Voltage processor gives us fine grained status on
the current status of the voltage communication with the PMIC.
Unfortunately, IRQ generation by VP is based on the start of the
transmission to VC from VP, not at the end (or the completion of
the voltage setting). Hence any users of voltage layer who need
to know fine grained information such as confirmation if the voltage
is actually send to PMIC, needs to depend on this status.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |   57 +++++++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/voltage.h |    2 +
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index a12ac1e..2d70d13 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -455,10 +455,8 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	 * is <3us
 	 */
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
-		vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
-			       prm_irqst_ocp_mod_offs, prm_irqst_reg);
-		if (!(vdd->read_reg(prm_irqst_ocp_mod_offs, prm_irqst_reg) &
-		      vdd->vp_data->prm_irqst_data->tranxdone_status))
+		omap_vp_clear_transdone(&vdd->voltdm);
+		if (!omap_vp_is_transdone(&vdd->voltdm))
 			break;
 		udelay(1);
 	}
@@ -506,10 +504,8 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	 */
 	timeout = 0;
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
-		vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
-			       prm_irqst_ocp_mod_offs, prm_irqst_reg);
-		if (!(vdd->read_reg(prm_irqst_ocp_mod_offs, prm_irqst_reg) &
-		      vdd->vp_data->prm_irqst_data->tranxdone_status))
+		omap_vp_clear_transdone(&vdd->voltdm);
+		if (!omap_vp_is_transdone(&vdd->voltdm))
 			break;
 		udelay(1);
 	}
@@ -824,6 +820,51 @@ void omap_vp_disable(struct voltagedomain *voltdm)
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
+	return (vdd->read_reg(prm_irqst_ocp_mod_offs,
+		vdd->vp_data->prm_irqst_data->prm_irqst_reg) &
+		vdd->vp_data->prm_irqst_data->tranxdone_status) ? true : false;
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
+	vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
+			prm_irqst_ocp_mod_offs,
+			vdd->vp_data->prm_irqst_data->prm_irqst_reg);
+
+	return true;
+}
+
+/**
  * omap_voltage_scale_vdd() - API to scale voltage of a particular
  *				voltage domain.
  * @voltdm:	pointer to the VDD which is to be scaled.
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 6e9acd6..5b4e363 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -150,6 +150,8 @@ void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 		unsigned long volt);
 struct omap_volt_data *omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
+bool omap_vp_is_transdone(struct voltagedomain *voltdm);
+bool omap_vp_clear_transdone(struct voltagedomain *voltdm);
 struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm);
 int __init omap_voltage_early_init(s16 prm_mod, s16 prm_irqst_mod,
 				   struct omap_vdd_info *omap_vdd_array[],
-- 
1.7.1

