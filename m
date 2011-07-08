From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 3/4] omap: attach external controller to VDD1/VDD2
Date: Fri, 8 Jul 2011 18:56:27 +0300
Message-ID: <1310140588-26078-4-git-send-email-t-kristo@ti.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37420 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612Ab1GHP5I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 11:57:08 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lrg@ti.com, broonie@opensource.wolfsonmicro.com

Instiante a twlreg_ext_ctrl structure in the OMAP voltage code for
VDD1 and VDD2 and attach it as an external controller for these
regulators. It will allow the OMAP voltage code to take over the
default regulator driver code for ->set_voltage() and ->get_voltage().

TODO:

 * Does this really belong to the OMAP voltage code ? The PowerIC
   attached to the OMAP may not be the traditional TWL, so maybe this
   code belongs to a more board-specific location (but then we have
   the question of avoiding too much duplication of this code
   throughout the different board files)

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/voltage.c                 |   37 +++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.h                 |    4 +++
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +
 3 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 9ef3789..e9b9bbb 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -59,6 +59,9 @@ static struct dentry *voltage_dir;
 /* Init function pointers */
 static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 					unsigned long target_volt);
+static int omap_twlreg_ext_ctrl_get_voltage(struct twlreg_ext_ctrl *ext_ctrl);
+static int omap_twlreg_ext_ctrl_set_voltage(struct twlreg_ext_ctrl *ext_ctrl,
+					    int min_uV, int max_uV);
 
 static u32 omap3_voltage_read_reg(u16 mod, u8 offset)
 {
@@ -1029,6 +1032,19 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 	}
 }
 
+static int omap_twlreg_ext_ctrl_get_voltage(struct twlreg_ext_ctrl *ext_ctrl)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *) ext_ctrl->data;
+	return omap_vp_get_curr_volt(voltdm);
+}
+
+static int omap_twlreg_ext_ctrl_set_voltage(struct twlreg_ext_ctrl *ext_ctrl,
+					    int min_uV, int max_uV)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *) ext_ctrl->data;
+	return omap_voltage_scale_vdd(voltdm, min_uV);
+}
+
 /**
  * omap_voltage_domain_lookup() - API to get the voltage domain pointer
  * @name:	Name of the voltage domain
@@ -1071,6 +1087,8 @@ struct voltagedomain *omap_voltage_domain_lookup(char *name)
 int __init omap_voltage_late_init(void)
 {
 	int i;
+	struct twlreg_ext_ctrl *ctrl;
+	struct voltagedomain *voltdm;
 
 	if (!vdd_info) {
 		pr_err("%s: Voltage driver support not added\n",
@@ -1088,6 +1106,25 @@ int __init omap_voltage_late_init(void)
 		omap_vc_init(vdd_info[i]);
 		vp_init(vdd_info[i]);
 		vdd_debugfs_init(vdd_info[i]);
+
+		voltdm = &vdd_info[i]->voltdm;
+		/* Attach twlreg external controller */
+		if (voltdm->reg_name) {
+			ctrl = kmalloc(sizeof(struct twlreg_ext_ctrl),
+				GFP_KERNEL);
+			if (!ctrl) {
+				pr_err("%s: can't alloc twlreg_ext_ctrl for"
+				       " vdd_%s\n", __func__, voltdm->name);
+				return -ENOMEM;
+			}
+			ctrl->set_voltage = omap_twlreg_ext_ctrl_set_voltage;
+			ctrl->get_voltage = omap_twlreg_ext_ctrl_get_voltage;
+			ctrl->data = voltdm;
+
+			twlreg_attach_external_controller(voltdm->reg_name,
+				ctrl);
+			voltdm->twl_ext_ctrl = ctrl;
+		}
 	}
 
 	return 0;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index e9f5408..1fb1d85 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -15,6 +15,7 @@
 #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
 
 #include <linux/err.h>
+#include <linux/regulator/twl.h>
 
 #include "vc.h"
 #include "vp.h"
@@ -52,9 +53,12 @@ struct omap_vfsm_instance_data {
  * struct voltagedomain - omap voltage domain global structure.
  * @name:	Name of the voltage domain which can be used as a unique
  *		identifier.
+ * @twl_ext_ctrl:  External controller for the voltage domain
  */
 struct voltagedomain {
 	char *name;
+	char *reg_name;
+	struct twlreg_ext_ctrl *twl_ext_ctrl;
 };
 
 /**
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index def230f..02a93c5 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -43,6 +43,7 @@ static struct omap_vdd_info omap3_vdd1_info = {
 	.vfsm = &omap3_vdd1_vfsm_data,
 	.voltdm = {
 		.name = "mpu",
+		.reg_name = "VDD1",
 	},
 };
 
@@ -58,6 +59,7 @@ static struct omap_vdd_info omap3_vdd2_info = {
 	.vfsm = &omap3_vdd2_vfsm_data,
 	.voltdm = {
 		.name = "core",
+		.reg_name = "VDD2",
 	},
 };
 
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

