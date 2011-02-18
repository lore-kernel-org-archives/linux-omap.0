From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 1/4] OMAP: voltage: pre- and post-transition notifiers
Date: Fri, 18 Feb 2011 03:20:50 -0600
Message-ID: <1298020853-13761-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41181 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753393Ab1BRJWa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 04:22:30 -0500
Received: by yie30 with SMTP id 30so27060yie.23
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 01:22:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Turquette <mturquette@ti.com>

Introduce notifier infrastructure for VDD voltage transitions.  Users can
register a notifier prior to a VDD's volt_scale function getting called
(VOLTSCALE_PRECHANGE) or after the VDD has been scaled
(VOLTSCALE_POSTCHANGE).

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
All patches in this series based on PM branch (b6fb54b) plus Vishwa's 13
OMAP3 DVFS patches (http://marc.info/?l=linux-omap&m=129561825804975&w=2).
Only validated on Zoom3 since OMAP4 DVFS patches were not available.

 arch/arm/mach-omap2/voltage.c             |   47 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/voltage.h |   30 ++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index a0bd73b..0cbc58a 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -729,6 +729,9 @@ static int __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 		return -EINVAL;
 	}
 
+	/* initialize the voltage change notifier chain */
+	srcu_init_notifier_head(&vdd->volt_change_notify_chain);
+
 	if (!strcmp(vdd->voltdm.name, "mpu")) {
 		if (cpu_is_omap3630()) {
 			vdd->volt_data = omap36xx_vddmpu_volt_data;
@@ -912,6 +915,9 @@ static int __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
 		return -EINVAL;
 	}
 
+	/* initialize the voltage change notifier chain */
+	srcu_init_notifier_head(&vdd->volt_change_notify_chain);
+
 	if (!strcmp(vdd->voltdm.name, "mpu")) {
 		vdd->volt_data = omap44xx_vdd_mpu_volt_data;
 		vdd->vp_reg.tranxdone_status =
@@ -1201,7 +1207,9 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
 		unsigned long target_volt)
 {
+	int ret;
 	struct omap_vdd_info *vdd;
+	struct omap_volt_change_info v_info;
 
 	if (!voltdm || IS_ERR(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
@@ -1216,7 +1224,20 @@ int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
 		return -ENODATA;
 	}
 
-	return vdd->volt_scale(vdd, target_volt);
+	/* load notifier chain data */
+	v_info.target_volt = target_volt;
+	v_info.vdd = vdd;
+
+	srcu_notifier_call_chain(&vdd->volt_change_notify_chain,
+			VOLTSCALE_PRECHANGE, (void *)&v_info);
+
+	ret = vdd->volt_scale(vdd, target_volt);
+
+	if (!ret)
+		srcu_notifier_call_chain(&vdd->volt_change_notify_chain,
+				VOLTSCALE_POSTCHANGE, (void *)&v_info);
+
+	return ret;
 }
 
 /**
@@ -1437,6 +1458,30 @@ struct voltagedomain *omap_voltage_domain_lookup(char *name)
 	return ERR_PTR(-EINVAL);
 }
 
+int omap_voltage_register_notifier(struct omap_vdd_info *vdd,
+		struct notifier_block *nb)
+{
+	if (!vdd || IS_ERR(vdd)) {
+		pr_warning("%s: invalid VDD specified\n", __func__);
+		return -EINVAL;
+	}
+
+	return srcu_notifier_chain_register(&vdd->volt_change_notify_chain,
+			nb);
+}
+
+int omap_voltage_unregister_notifier(struct omap_vdd_info *vdd,
+		struct notifier_block *nb)
+{
+	if (!vdd || IS_ERR(vdd)) {
+		pr_warning("%s: invalid VDD specified\n", __func__);
+		return -EINVAL;
+	}
+
+	return srcu_notifier_chain_unregister(&vdd->volt_change_notify_chain,
+			nb);
+}
+
 /**
  * omap_voltage_late_init() - Init the various voltage parameters
  *
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index e0b7f22..017e65b 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -15,10 +15,14 @@
 #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
 
 #include <linux/err.h>
+#include <linux/notifier.h>
 
 #define VOLTSCALE_VPFORCEUPDATE		1
 #define VOLTSCALE_VCBYPASS		2
 
+#define VOLTSCALE_PRECHANGE		0
+#define VOLTSCALE_POSTCHANGE		1
+
 /*
  * OMAP3 GENERIC setup times. Revisit to see if these needs to be
  * passed from board or PMIC file
@@ -249,6 +253,7 @@ struct omap_vdd_info {
 	struct vc_reg_info vc_reg;
 	struct voltagedomain voltdm;
 	struct omap_vdd_dep_info *dep_vdd_info;
+	struct srcu_notifier_head volt_change_notify_chain;
 	int nr_dep_vdd;
 	struct dentry *debug_dir;
 	u32 curr_volt;
@@ -261,6 +266,17 @@ struct omap_vdd_info {
 		unsigned long target_volt);
 };
 
+/**
+ * omap_volt_change_info - container used by voltage notifier chain
+ *
+ * @vdd_info		: the voltage domain affected by the transition
+ * @target_volt		: voltage the affected domain is transitioning to
+ */
+struct omap_volt_change_info {
+	unsigned long target_volt;
+	struct omap_vdd_info *vdd;
+};
+
 unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm);
 void omap_vp_enable(struct voltagedomain *voltdm);
 void omap_vp_disable(struct voltagedomain *voltdm);
@@ -280,6 +296,10 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		int voltscale_method);
 /* API to get the voltagedomain pointer */
 struct voltagedomain *omap_voltage_domain_lookup(char *name);
+int omap_voltage_register_notifier(struct omap_vdd_info *vdd,
+		struct notifier_block *nb);
+int omap_voltage_unregister_notifier(struct omap_vdd_info *vdd,
+		struct notifier_block *nb);
 
 int omap_voltage_late_init(void);
 #else
@@ -298,6 +318,16 @@ static inline struct voltagedomain *omap_voltage_domain_lookup(char *name)
 {
 	return ERR_PTR(-EINVAL);
 }
+static inline int omap_voltage_register_notifier(struct omap_vdd_info *vdd,
+		struct notifier block *nb)
+{
+	return 0;
+}
+static inline int omap_voltage_unregister_notifier(struct omap_vdd_info *vdd,
+		struct notifier block *nb)
+{
+	return 0;
+}
 #endif
 
 #endif
-- 
1.7.1

