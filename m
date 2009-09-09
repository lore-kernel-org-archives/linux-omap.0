From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] OMAP3 : PM : Functions to get freq from opp and vice-versa
Date: Wed,  9 Sep 2009 16:54:59 +0530
Message-ID: <1252495499-8455-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60619 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbZIILZF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Sep 2009 07:25:05 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n89BP1n8015009
	for <linux-omap@vger.kernel.org>; Wed, 9 Sep 2009 06:25:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

There is no generic function to get OPP corresponding to frequency
and vice versa.

Function get_opp() - in resource34xx.c - is included only when
CONFIG_OMAP_PM_SRF is enabled. Moreover, it is always called with
an explicit addition of MAX_VDDn_OPP e.g.
  opp = get_opp(mpu_opps + MAX_VDD1_OPP, clk->rate);
  opp = get_opp(l3_opps + MAX_VDD2_OPP, clk->rate);

This is 'addition' is required as there is no encapsulation of
MIN and MAX VDDs associated to the table.

This patch fixes the issue by creating a 'table' object that
encapsulates the MIN and MAX values and the existing rate table.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/omap3-opp.h           |   42 +++------------------
 arch/arm/mach-omap2/pm.c                  |   49 +++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c              |   57 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/omap-pm.h |   25 +++++++++++++
 4 files changed, 137 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
index 3c9a582..52deb4a 100644
--- a/arch/arm/mach-omap2/omap3-opp.h
+++ b/arch/arm/mach-omap2/omap3-opp.h
@@ -21,42 +21,12 @@
 #define S83M    83000000
 #define S166M   166000000
 
-static struct omap_opp omap3_mpu_rate_table[] = {
-	{0, 0, 0},
-	/*OPP1*/
-	{S125M, VDD1_OPP1, 0x1E},
-	/*OPP2*/
-	{S250M, VDD1_OPP2, 0x26},
-	/*OPP3*/
-	{S500M, VDD1_OPP3, 0x30},
-	/*OPP4*/
-	{S550M, VDD1_OPP4, 0x36},
-	/*OPP5*/
-	{S600M, VDD1_OPP5, 0x3C},
-};
+extern struct omap_opp omap3_mpu_rate_table[];
+extern struct omap_opp omap3_dsp_rate_table[];
+extern struct omap_opp omap3_l3_rate_table[];
 
-static struct omap_opp omap3_l3_rate_table[] = {
-	{0, 0, 0},
-	/*OPP1*/
-	{0, VDD2_OPP1, 0x1E},
-	/*OPP2*/
-	{S83M, VDD2_OPP2, 0x24},
-	/*OPP3*/
-	{S166M, VDD2_OPP3, 0x2C},
-};
-
-static struct omap_opp omap3_dsp_rate_table[] = {
-	{0, 0, 0},
-	/*OPP1*/
-	{S90M, VDD1_OPP1, 0x1E},
-	/*OPP2*/
-	{S180M, VDD1_OPP2, 0x26},
-	/*OPP3*/
-	{S360M, VDD1_OPP3, 0x30},
-	/*OPP4*/
-	{S400M, VDD1_OPP4, 0x36},
-	/*OPP5*/
-	{S430M, VDD1_OPP5, 0x3C},
-};
+extern const struct omap_opp_table omap3_mpu_opp_table;
+extern const struct omap_opp_table omap3_dsp_opp_table;
+extern const struct omap_opp_table omap3_l3_opp_table;
 
 #endif
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index fec7d00..2bbe63f 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -33,6 +33,7 @@
 #include <mach/powerdomain.h>
 #include <mach/resource.h>
 #include <mach/omap34xx.h>
+#include <mach/omap-pm.h>
 
 #include "prm-regbits-34xx.h"
 #include "pm.h"
@@ -281,3 +282,51 @@ static int __init omap_pm_init(void)
 	return error;
 }
 late_initcall(omap_pm_init);
+
+/*
+ * Get frequency corresponding to an OPP
+ */
+int opp_to_freq(unsigned long* freq, const struct omap_opp_table* table, u8 opp)
+{
+        int i, found=0;
+
+        if (table && table->opps) {
+		for (i = table->min; i <= table->max; i++) {
+			if (table->opps[i].opp_id == opp) {
+				found = 1;
+				break;
+			}
+		}
+
+		if (found) {
+			*freq = table->opps[i].rate;
+			return 1;
+		}
+	}
+
+        return 0;
+}
+
+/*
+ * Get OPP corresponding to a frequency
+ */
+int freq_to_opp(u8* opp, const struct omap_opp_table* table, unsigned long freq)
+{
+        int i, found=0;
+
+        if (table && table->opps) {
+		for (i = table->min; i <= table->max; i++) {
+			if (table->opps[i].rate == freq) {
+				found = 1;
+				break;
+			}
+		}
+
+		if (found) {
+			*opp = table->opps[i].opp_id;
+			return 1;
+		}
+	}
+
+        return 0;
+}
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3d62b06..60b0441 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -50,6 +50,7 @@
 #include "prm.h"
 #include "pm.h"
 #include "sdrc.h"
+#include "omap3-opp.h"
 
 static int regset_save_on_suspend;
 
@@ -93,6 +94,62 @@ static struct prm_setup_vc prm_setup = {
 	.vdd1_off = 0x00,	/* 0.6v */
 };
 
+struct omap_opp omap3_mpu_rate_table[] = {
+	{0, 0, 0},
+	/*OPP1*/
+	{S125M, VDD1_OPP1, 0x1E},
+	/*OPP2*/
+	{S250M, VDD1_OPP2, 0x26},
+	/*OPP3*/
+	{S500M, VDD1_OPP3, 0x30},
+	/*OPP4*/
+	{S550M, VDD1_OPP4, 0x36},
+	/*OPP5*/
+	{S600M, VDD1_OPP5, 0x3C},
+};
+
+struct omap_opp omap3_l3_rate_table[] = {
+	{0, 0, 0},
+	/*OPP1*/
+	{0, VDD2_OPP1, 0x1E},
+	/*OPP2*/
+	{S83M, VDD2_OPP2, 0x24},
+	/*OPP3*/
+	{S166M, VDD2_OPP3, 0x2C},
+};
+
+struct omap_opp omap3_dsp_rate_table[] = {
+	{0, 0, 0},
+	/*OPP1*/
+	{S90M, VDD1_OPP1, 0x1E},
+	/*OPP2*/
+	{S180M, VDD1_OPP2, 0x26},
+	/*OPP3*/
+	{S360M, VDD1_OPP3, 0x30},
+	/*OPP4*/
+	{S400M, VDD1_OPP4, 0x36},
+	/*OPP5*/
+	{S430M, VDD1_OPP5, 0x3C},
+};
+
+const struct omap_opp_table omap3_mpu_opp_table = {
+	VDD1_OPP1,
+	VDD1_OPP5,
+	omap3_mpu_rate_table
+};
+
+const struct omap_opp_table omap3_dsp_opp_table = {
+        VDD1_OPP1,
+        VDD1_OPP5,
+        omap3_dsp_rate_table
+};
+
+const struct omap_opp_table omap3_l3_opp_table = {
+        VDD1_OPP1,
+        VDD1_OPP3,
+        omap3_l3_rate_table
+};
+
 static inline void omap3_per_save_context(void)
 {
 	omap3_gpio_save_context();
diff --git a/arch/arm/plat-omap/include/mach/omap-pm.h b/arch/arm/plat-omap/include/mach/omap-pm.h
index 583e540..cf910ef 100644
--- a/arch/arm/plat-omap/include/mach/omap-pm.h
+++ b/arch/arm/plat-omap/include/mach/omap-pm.h
@@ -33,6 +33,20 @@ struct omap_opp {
 	u16 vsel;
 };
 
+/* struct omap_opp_table - View OPP table as an object
+ * @min: Minimum OPP id
+ * @max: Maximim OPP id
+ * @opps: Pointer to array defining the OPPs.
+ *
+ * An OPP table has varied length. Knowing minimum and maximum
+ * OPP ids allow easy traversal.
+ */
+struct omap_opp_table {
+	u8	min;
+	u8	max;
+	struct omap_opp* opps;
+};
+
 extern struct omap_opp *mpu_opps;
 extern struct omap_opp *dsp_opps;
 extern struct omap_opp *l3_opps;
@@ -49,6 +63,17 @@ extern struct omap_opp *l3_opps;
 #define OCP_INITIATOR_AGENT		2
 
 /**
+ *
+ */
+int opp_to_freq(unsigned long* freq, const struct omap_opp_table* table, u8 opp);
+
+/**
+ *
+ */
+int freq_to_opp(u8* opp, const struct omap_opp_table* table, unsigned long freq);
+
+
+/**
  * omap_pm_if_early_init - OMAP PM init code called before clock fw init
  * @mpu_opp_table: array ptr to struct omap_opp for MPU
  * @dsp_opp_table: array ptr to struct omap_opp for DSP
-- 
1.6.2.2

