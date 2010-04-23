From: Thara Gopinath <thara@ti.com>
Subject: [PM-WIP-SR][PATCH] OMAP3: PM: Separating PMIC specific part out of smartreflex driver
Date: Fri, 23 Apr 2010 19:18:07 +0530
Message-ID: <1272030487-31118-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60774 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757423Ab0DWNs1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Apr 2010 09:48:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds a hook to register pmic specific data with
the smartreflex driver. Currently with this the only info required
to be registered is the API to enable smartreflex on PMIC side.
Later any other pmic specific data can be added.

This patch also modifies the pmic file twl4030.c meant for
OMAP3430 and OMAP3630 chips to register the required
data with the smartreflex driver.

This patch is created on the pm-wip-sr branch off Kevin's
pm tree and is dependent on Lesly's Triton power scripts
patch series the link to which is given below
	http://marc.info/?l=linux-omap&m=127167610420379&w=2

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   34 +++++++++++++++++++++++-----------
 arch/arm/mach-omap2/smartreflex.h |   22 ++++++++++++++++------
 arch/arm/mach-omap2/twl4030.c     |   26 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030.h     |    6 ++++++
 4 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index a6a29d1..7134529 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -23,7 +23,6 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/kobject.h>
-#include <linux/i2c/twl.h>
 #include <linux/io.h>
 #include <linux/list.h>
 #include <linux/debugfs.h>
@@ -59,6 +58,7 @@ struct omap_sr {
 /* sr_list contains all the instances of smartreflex module */
 static LIST_HEAD(sr_list);
 static struct omap_smartreflex_class_data *sr_class;
+static struct omap_smartreflex_pmic_data *sr_pmic_data;
 
 static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
 {
@@ -670,6 +670,24 @@ void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
 		sr_late_init(sr_info);
 }
 
+/**
+ * omap_sr_register_pmic : API to register pmic specific info.
+ * @pmic_data - The structure containing pmic specific data.
+ *
+ * This API is to be called from the PMIC specific code to register with
+ * smartreflex driver pmic specific info. Currently the only info required
+ * is the smartreflex init on the PMIC side.
+ */
+void omap_sr_register_pmic(struct omap_smartreflex_pmic_data *pmic_data)
+{
+	if (!pmic_data) {
+		pr_warning("Trying to register NULL PMIC data structure with \
+				smartreflex\n");
+		return;
+	}
+	sr_pmic_data = pmic_data;
+}
+
 /* PM Debug Fs enteries to enable disable smartreflex.*/
 
 static int omap_sr_autocomp_show(void *data, u64 *val)
@@ -770,16 +788,10 @@ static struct platform_driver smartreflex_driver = {
 
 static int __init sr_init(void)
 {
-	int ret = 0;
-	u8 RdReg;
-
-	/* TODO: Find an appropriate place for this */
-	/* Enable SR on T2 */
-	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
-			      R_DCDC_GLOBAL_CFG);
-	RdReg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
-	ret |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, RdReg,
-				R_DCDC_GLOBAL_CFG);
+	int ret;
+
+	if (sr_pmic_data && sr_pmic_data->sr_pmic_init)
+		sr_pmic_data->sr_pmic_init();
 
 	ret = platform_driver_probe(&smartreflex_driver,
 				omap_smartreflex_probe);
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index d12c093..46bc1f1 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -138,12 +138,6 @@ extern struct dentry *pm_dbg_main_dir;
 
 /* TODO:3630/OMAP4 values if it has to come from this file */
 
-/* Info for enabling SR in T2/gaia. ToDo: Move it to twl4030_power.c */
-#define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
-#define R_DCDC_GLOBAL_CFG	PHY_TO_OFF_PM_RECIEVER(0x61)
-/* R_DCDC_GLOBAL_CFG register, SMARTREFLEX_ENABLE values */
-#define DCDC_GLOBAL_CFG_ENABLE_SRFLX	0x08
-
 #ifdef CONFIG_OMAP_SMARTREFLEX_TESTING
 #define SR_TESTING_NVALUES 	1
 #else
@@ -196,6 +190,16 @@ struct omap_smartreflex_dev_data {
 #define SR_CLASS3	0x3
 
 /**
+ * omap_smartreflex_pmic_data : Strucutre to be populated by pmic code to pass
+ * pmic specific info to smartreflex driver
+ *
+ * @sr_pmic_init - API to initialize smartreflex on the PMIC side.
+ */
+struct omap_smartreflex_pmic_data {
+	void (*sr_pmic_init) (void);
+};
+
+/**
  * omap_smartreflex_class_data : Structure to be populated by
  * Smartreflex class driver with corresponding class enable disable API's
  *
@@ -260,9 +264,15 @@ void sr_configure_minmax(int srid);
  * API to register the smartreflex class driver with the smartreflex driver
  */
 void omap_sr_register_class(struct omap_smartreflex_class_data *class_data);
+
+
+/* API to register the pmic specific data with the smartreflex driver */
+void omap_sr_register_pmic(struct omap_smartreflex_pmic_data *pmic_data);
 #else
 static inline void omap_smartreflex_enable(int srid) {}
 static inline void omap_smartreflex_disable(int srid) {}
+static inline void omap_sr_register_pmic
+		(struct omap_smartreflex_pmic_data *pmic_data) {}
 #endif
 
 #endif
diff --git a/arch/arm/mach-omap2/twl4030.c b/arch/arm/mach-omap2/twl4030.c
index 6647156..360e4ba 100644
--- a/arch/arm/mach-omap2/twl4030.c
+++ b/arch/arm/mach-omap2/twl4030.c
@@ -9,7 +9,10 @@
 
 #ifdef CONFIG_TWL4030_POWER
 
+#include <linux/i2c/twl.h>
+
 #include "twl4030.h"
+#include "smartreflex.h"
 
 static struct prm_setup_vc twl4030_voltsetup_time = {
 	/* VOLT SETUPTIME for RET */
@@ -151,4 +154,27 @@ void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc)
 	setup_vc->off.voltsetup2 = twl4030_voltsetup_time.off.voltsetup2;
 	setup_vc->off.voltoffset = twl4030_voltsetup_time.off.voltoffset;
 }
+
+static void twl4030_smartreflex_init(void)
+{
+	int ret = 0;
+	u8 read_val;
+
+	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &read_val,
+			      R_DCDC_GLOBAL_CFG);
+	read_val |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
+	ret |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, read_val,
+				R_DCDC_GLOBAL_CFG);
+}
+
+struct omap_smartreflex_pmic_data twl4030_sr_data = {
+	.sr_pmic_init	= twl4030_smartreflex_init,
+};
+
+static int __init twl4030_init(void)
+{
+	omap_sr_register_pmic(&twl4030_sr_data);
+	return 0;
+}
+arch_initcall(twl4030_init);
 #endif
diff --git a/arch/arm/mach-omap2/twl4030.h b/arch/arm/mach-omap2/twl4030.h
index 3a7da2d..52218b2 100644
--- a/arch/arm/mach-omap2/twl4030.h
+++ b/arch/arm/mach-omap2/twl4030.h
@@ -5,6 +5,12 @@
 #include "voltage.h"
 
 #ifdef CONFIG_TWL4030_POWER
+/* Info for enabling SR in T2/gaia. */
+#define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
+#define R_DCDC_GLOBAL_CFG	PHY_TO_OFF_PM_RECIEVER(0x61)
+/* R_DCDC_GLOBAL_CFG register, SMARTREFLEX_ENABLE values */
+#define DCDC_GLOBAL_CFG_ENABLE_SRFLX	0x08
+
 extern void twl4030_get_scripts(struct twl4030_power_data *t2scripts_data);
 extern void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc);
 #else
-- 
1.7.0.rc1.33.g07cf0f

