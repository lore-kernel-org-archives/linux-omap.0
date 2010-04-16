From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 10/22] OMAP3: PM: Adding voltage table support in voltage driver.
Date: Fri, 16 Apr 2010 14:33:05 +0530
Message-ID: <1271408597-3066-11-git-send-email-thara@ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
 <1271408597-3066-2-git-send-email-thara@ti.com>
 <1271408597-3066-3-git-send-email-thara@ti.com>
 <1271408597-3066-4-git-send-email-thara@ti.com>
 <1271408597-3066-5-git-send-email-thara@ti.com>
 <1271408597-3066-6-git-send-email-thara@ti.com>
 <1271408597-3066-7-git-send-email-thara@ti.com>
 <1271408597-3066-8-git-send-email-thara@ti.com>
 <1271408597-3066-9-git-send-email-thara@ti.com>
 <1271408597-3066-10-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40658 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076Ab0DPJDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 05:03:32 -0400
In-Reply-To: <1271408597-3066-10-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch introduces the framework to create voltage table per
VDD basis in voltage driver. Each VDD will have one voltage table,
which in turn will contain one entry per voltage supported and
other data associated with the voltage like smartreflex N-target
values. This patch also generates voltage tables for VDD1 and VDD2 of
OMAP3430 and passes them as dev_attr to sr_device.c in order
to populate the smartreflex n-target values.

These voltage tables are extended in a later patch to contain more
voltage specific information like errminlimt and errorgain values.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 +-
 arch/arm/mach-omap2/smartreflex.c          |   27 +--------
 arch/arm/mach-omap2/smartreflex.h          |   13 +----
 arch/arm/mach-omap2/sr_device.c            |   42 ++----------
 arch/arm/mach-omap2/voltage.c              |   93 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/voltage.h              |   15 +++++
 6 files changed, 118 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 049e4e2..1f41310 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -23,6 +23,7 @@
 
 #include "prm-regbits-34xx.h"
 #include "smartreflex.h"
+#include "voltage.h"
 
 /*
  * OMAP3xxx hardware module integration data
@@ -240,14 +241,13 @@ static u32 omap34xx_sr1_test_nvalues[] = {
 };
 
 static struct omap_smartreflex_dev_data omap34xx_sr1_dev_attr = {
-	.volts_supported	= 5,
 	.efuse_sr_control	= OMAP343X_CONTROL_FUSE_SR,
 	.sennenable_shift	= OMAP343X_SR1_SENNENABLE_SHIFT,
 	.senpenable_shift	= OMAP343X_SR1_SENPENABLE_SHIFT,
 	.efuse_nvalues_offs	= omap34xx_sr1_efuse_offs,
 	.test_sennenable	= 0x3,
 	.test_senpenable	= 0x3,
-	.test_nvalues		= omap34xx_sr1_test_nvalues
+	.test_nvalues		= omap34xx_sr1_test_nvalues,
 };
 
 static struct omap_hwmod omap34xx_sr1_hwmod = {
@@ -276,14 +276,13 @@ static u32 omap34xx_sr2_test_nvalues[] = {
 };
 
 static struct omap_smartreflex_dev_data omap34xx_sr2_dev_attr = {
-	.volts_supported	= 3,
 	.efuse_sr_control	= OMAP343X_CONTROL_FUSE_SR,
 	.sennenable_shift	= OMAP343X_SR2_SENNENABLE_SHIFT,
 	.senpenable_shift	= OMAP343X_SR2_SENPENABLE_SHIFT,
 	.efuse_nvalues_offs	= omap34xx_sr2_efuse_offs,
 	.test_sennenable	= 0x3,
 	.test_senpenable	= 0x3,
-	.test_nvalues		= omap34xx_sr2_test_nvalues
+	.test_nvalues		= omap34xx_sr2_test_nvalues,
 };
 
 static struct omap_hwmod omap34xx_sr2_hwmod = {
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index a89f74f..d3222a5 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -31,6 +31,7 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
+#include "voltage.h"
 #include "smartreflex.h"
 
 #define SMARTREFLEX_NAME_LEN	16
@@ -110,30 +111,6 @@ static void sr_clk_disable(struct omap_sr *sr)
 	sr->is_sr_reset = 1;
 }
 
-static int sr_match_volt(struct omap_sr *sr, unsigned long volt,
-				struct omap_volt_data *volt_data)
-{
-	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
-	struct omap_device *odev = to_omap_device(sr->pdev);
-	struct omap_smartreflex_dev_data *sr_dev_data =
-					odev->hwmods[0]->dev_attr;
-	int i;
-
-	if (!pdata->sr_volt_data) {
-		pr_notice("voltage table does not exist for SR %d\n", sr->srid);
-		return false;
-	}
-	for (i = 0; i < sr_dev_data->volts_supported; i++) {
-		if (pdata->sr_volt_data[i].voltage == volt) {
-			*volt_data = pdata->sr_volt_data[i];
-			return true;
-		}
-	}
-	pr_notice("Unable to match the current voltage with \
-				the voltage table for SR %d\n", sr->srid);
-	return false;
-}
-
 static void sr_set_clk_length(struct omap_sr *sr)
 {
 	struct clk *sys_ck;
@@ -288,7 +265,7 @@ int sr_enable(int srid, unsigned long volt)
 		return false;
 	}
 
-	if (!sr_match_volt(sr, volt, &volt_data))
+	if (omap_match_volt(sr->srid, volt, &volt_data))
 		return false;
 
 	nvalue_reciprocal = volt_data.sr_nvalue;
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 073f6d0..0f60a97 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -107,17 +107,6 @@ extern struct dentry *pm_dbg_main_dir;
 #endif
 
 /**
- * omap_volt_data - Omap voltage specific data.
- *
- * @voltage	: The possible voltage value
- * @sr_nvalue	: Smartreflex N target value at voltage <voltage>
- */
-struct omap_volt_data {
-	unsigned long	voltage;
-	u32		sr_nvalue;
-};
-
-/**
  * omap_smartreflex_dev_data - Smartreflex device specific data
  *
  * @volts_supported	: Number of distinct voltages possible for the VDD
@@ -148,6 +137,7 @@ struct omap_smartreflex_dev_data {
 	u32 test_sennenable;
 	u32 test_senpenable;
 	u32 *test_nvalues;
+	struct omap_volt_data *volt_data;
 };
 
 #ifdef CONFIG_OMAP_SMARTREFLEX
@@ -188,7 +178,6 @@ struct omap_smartreflex_class_data {
 struct omap_smartreflex_data {
 	u32				senp_mod;
 	u32				senn_mod;
-	struct omap_volt_data		*sr_volt_data;
 	bool				enable_on_init;
 	int (*device_enable)(struct platform_device *pdev);
 	int (*device_shutdown)(struct platform_device *pdev);
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 544d575..c9b6533 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -28,6 +28,7 @@
 #include <plat/opp.h>
 
 #include "smartreflex.h"
+#include "voltage.h"
 
 #define MAX_HWMOD_NAME_LEN	16
 
@@ -47,13 +48,10 @@ static void __init sr_read_efuse(
 	int i;
 
 	if (WARN_ON(!dev_data || !dev_data->volts_supported ||
-			!dev_data->efuse_sr_control ||
+			!dev_data->volt_data || !dev_data->efuse_sr_control ||
 			!dev_data->efuse_nvalues_offs))
 		return;
 
-	if (WARN_ON(!sr_data->sr_volt_data))
-		return;
-
 	sr_data->senn_mod = (omap_ctrl_readl(dev_data->efuse_sr_control) &
 				(0x3 << dev_data->sennenable_shift) >>
 				dev_data->sennenable_shift);
@@ -61,7 +59,7 @@ static void __init sr_read_efuse(
 				(0x3 << dev_data->senpenable_shift) >>
 				dev_data->senpenable_shift);
 	for (i = 0; i < dev_data->volts_supported; i++)
-		sr_data->sr_volt_data[i].sr_nvalue = omap_ctrl_readl(
+		dev_data->volt_data[i].sr_nvalue = omap_ctrl_readl(
 				dev_data->efuse_nvalues_offs[i]);
 }
 
@@ -76,16 +74,13 @@ static void __init sr_set_testing_nvalues(
 	int i;
 
 	if (WARN_ON(!dev_data || !dev_data->volts_supported ||
-			!dev_data->test_nvalues))
-		return;
-
-	if (WARN_ON(!sr_data->sr_volt_data))
+			!dev_data->volt_data || !dev_data->test_nvalues))
 		return;
 
 	sr_data->senn_mod = dev_data->test_sennenable;
 	sr_data->senp_mod = dev_data->test_senpenable;
 	for (i = 0; i < dev_data->volts_supported; i++)
-		sr_data->sr_volt_data[i].sr_nvalue = dev_data->test_nvalues[i];
+		dev_data->volt_data[i].sr_nvalue = dev_data->test_nvalues[i];
 }
 
 static void __init sr_set_nvalues(struct omap_smartreflex_dev_data *dev_data,
@@ -99,28 +94,6 @@ static void __init sr_set_nvalues(struct omap_smartreflex_dev_data *dev_data,
 	}
 }
 
-static void __init omap34xx_sr_volt_details(struct omap_smartreflex_data
-						*sr_data, int srid,
-						int volt_count)
-{
-	sr_data->sr_volt_data = kzalloc(sizeof(sr_data->sr_volt_data) *
-				volt_count , GFP_KERNEL);
-	if (WARN_ON(!sr_data->sr_volt_data))
-		return;
-
-	if (srid == SR1) {
-		sr_data->sr_volt_data[0].voltage = 975000;
-		sr_data->sr_volt_data[1].voltage = 1075000;
-		sr_data->sr_volt_data[2].voltage = 1200000;
-		sr_data->sr_volt_data[3].voltage = 1270000;
-		sr_data->sr_volt_data[4].voltage = 1350000;
-	} else if (srid == SR2) {
-		sr_data->sr_volt_data[0].voltage = 975000;
-		sr_data->sr_volt_data[1].voltage = 1050000;
-		sr_data->sr_volt_data[2].voltage = 1150000;
-	}
-}
-
 static int __init omap_devinit_smartreflex(void)
 {
 	int i = 0;
@@ -148,9 +121,8 @@ static int __init omap_devinit_smartreflex(void)
 		sr_data->device_enable = omap_device_enable;
 		sr_data->device_shutdown = omap_device_shutdown;
 		sr_data->device_idle = omap_device_idle;
-		if (cpu_is_omap34xx())
-			omap34xx_sr_volt_details(sr_data, i + 1,
-					sr_dev_data->volts_supported);
+		omap_get_voltage_table(i, &sr_dev_data->volt_data,
+					&sr_dev_data->volts_supported);
 		sr_set_nvalues(sr_dev_data, sr_data);
 
 		od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index f84d02c..dd9618c 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -57,12 +57,15 @@ struct vp_reg_offs {
 };
 
 /*
- * Voltage processor structure conttaining info about
- * the various register offsets and the bit field values
- * for a particular instance of voltage processor.
+ * Voltage processor structure containing info about
+ * the various register offsets, the bit field values
+ * and the info on various supported volatges and dependent
+ * data for a particular instance of voltage processor.
  */
 struct vp_info {
+	struct omap_volt_data *volt_data;
 	struct vp_reg_offs vp_offs;
+	int volt_data_count;
 	/* Bit fields for VPx_VPCONFIG */
 	u32 vp_erroroffset;
 	u32 vp_errorgain;
@@ -139,6 +142,29 @@ static struct prm_setup_vc vc_config = {
 	.vdd1_off = 0x00,       /* 0.6v */
 };
 
+/*
+ * Structures containing OMAP3430 voltage supported and various data
+ * associated with it per voltage domain basis. Smartreflex Ntarget
+ * vales are left as 0 as they have to be populated by smartreflex
+ * driver after reading the efuse.
+ */
+
+/* VDD1 */
+static struct omap_volt_data omap34xx_vdd1_volt_data[] = {
+	{975000, 0},
+	{1075000, 0},
+	{1200000, 0},
+	{1270000, 0},
+	{1350000, 0},
+};
+
+/* VDD2 */
+static struct omap_volt_data omap34xx_vdd2_volt_data[] = {
+	{975000, 0},
+	{1050000, 0},
+	{1150000, 0},
+};
+
 static inline u32 voltage_read_reg(u8 offset)
 {
 	return prm_read_mod_reg(volt_mod, offset);
@@ -285,11 +311,17 @@ static void __init vp_data_configure(int vp_id)
 	if (cpu_is_omap34xx()) {
 		vp_reg[vp_id].vp_offs = omap3_vp_offs[vp_id];
 		if (vp_id == VP1) {
+			vp_reg[vp_id].volt_data = omap34xx_vdd1_volt_data;
+			vp_reg[vp_id].volt_data_count =
+					ARRAY_SIZE(omap34xx_vdd1_volt_data);
 			vp_reg[vp_id].vp_vddmin = (OMAP3_VP1_VLIMITTO_VDDMIN <<
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP1_VLIMITTO_VDDMAX <<
 					OMAP3430_VDDMAX_SHIFT);
 		} else if (vp_id == VP2) {
+			vp_reg[vp_id].volt_data = omap34xx_vdd2_volt_data;
+			vp_reg[vp_id].volt_data_count =
+					ARRAY_SIZE(omap34xx_vdd2_volt_data);
 			vp_reg[vp_id].vp_vddmin = (OMAP3_VP2_VLIMITTO_VDDMIN <<
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP2_VLIMITTO_VDDMAX <<
@@ -613,6 +645,61 @@ void __init omap_voltage_init_vc(struct prm_setup_vc *setup_vc)
 }
 
 /**
+ * omap_get_voltage_table : API to get the voltage table associated with a
+ *			    particular voltage domain.
+ *
+ * @vdd : the voltage domain id for which the voltage table is required
+ * @volt_data : the voltage table for the particular vdd which is to be
+ *		populated by this API
+ * @volt_count : number of distinct voltages supported by this vdd which
+ *		is to be populated by this API.
+ *
+ * This API populates the voltage table associated with a VDD and the count
+ * of number of voltages supported into the passed parameter pointers.
+ */
+void omap_get_voltage_table(int vdd, struct omap_volt_data **volt_data,
+						int *volt_count)
+{
+	*volt_data = vp_reg[vdd].volt_data;
+	*volt_count = vp_reg[vdd].volt_data_count;
+}
+
+/**
+ * omap_match_volt : API to get the voltage table entry for a particular
+ *		     voltage
+ * @vdd : the voltage domain id for whose voltage table has to be searched
+ * @volt : the voltage to be searched in the voltage table
+ * @volt_data : the matching voltage table entry which has to be populate
+ *		by this API.
+ *
+ * This API searches through the voltage table for the required voltage
+ * domain and tries to find a matching entry for the passed voltage volt.
+ * If a matching entry is found volt_data is populated with that entry.
+ * Returns -ENXIO if not voltage table exisits for the passed voltage
+ * domain or if there is no matching entry. On success returns true.
+ */
+int omap_match_volt(int vdd, unsigned long volt,
+				struct omap_volt_data *volt_data)
+{
+	int i;
+
+	if (!vp_reg[vdd].volt_data) {
+		pr_notice("voltage table does not exist for VDD %d\n", vdd + 1);
+		return -ENXIO;
+	}
+
+	for (i = 0; i < vp_reg[vdd].volt_data_count; i++) {
+		if (vp_reg[vdd].volt_data[i].voltage == volt) {
+			*volt_data = vp_reg[vdd].volt_data[i];
+			return 0;
+		}
+	}
+	pr_notice("Unable to match the current voltage with \
+				the voltage table for VDD %d\n", vdd + 1);
+	return -ENXIO;
+}
+
+/**
  * omap_voltage_init : Volatage init API which does VP and VC init.
  */
 void __init omap_voltage_init(void)
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 663c6fe..cc3308e 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -63,6 +63,17 @@
 
 /* TODO OMAP4 VP register values if the same file is used for OMAP4*/
 
+/**
+ * omap_volt_data - Omap voltage specific data.
+ *
+ * @voltage	: The possible voltage value
+ * @sr_nvalue	: Smartreflex N target value at voltage <voltage>
+ */
+struct omap_volt_data {
+	unsigned long	voltage;
+	u32		sr_nvalue;
+};
+
 void omap_voltageprocessor_enable(int vp_id);
 void omap_voltageprocessor_disable(int vp_id);
 void omap_voltage_init_vc(struct prm_setup_vc *setup_vc);
@@ -70,5 +81,9 @@ void omap_voltage_init(void);
 int omap_voltage_scale(int vdd, unsigned long target_volt,
 					unsigned long current_volt);
 void omap_reset_voltage(int vdd);
+void omap_get_voltage_table(int vdd, struct omap_volt_data **volt_data,
+						int *volt_count);
+int omap_match_volt(int vdd, unsigned long volt,
+				struct omap_volt_data *volt_data);
 unsigned long get_curr_vdd1_voltage(void);
 unsigned long get_curr_vdd2_voltage(void);
-- 
1.7.0.rc1.33.g07cf0f

