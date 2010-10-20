From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/3 v2] OMAP3: remove OPP interfaces from OMAP PM layer
Date: Tue, 19 Oct 2010 20:02:23 -0500
Message-ID: <1287536543-9729-4-git-send-email-nm@ti.com>
References: <1287536543-9729-1-git-send-email-nm@ti.com>
 <1287536543-9729-2-git-send-email-nm@ti.com>
 <1287536543-9729-3-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46006 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab0JTBC1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 21:02:27 -0400
In-Reply-To: <1287536543-9729-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@deeprootsystems.com>, Tony <tony@atomide.com>, Nishanth Menon <nm@ti.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

With new OPP layer, OPP users will access OPP API directly instead of
using OMAP PM layer, so remove all notions of OPPs from the OMAP PM
layer.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Retaining Kevin's original attribution

 arch/arm/mach-omap2/io.c                  |    3 +-
 arch/arm/mach-omap2/pm.c                  |    6 +++++
 arch/arm/plat-omap/include/plat/omap-pm.h |   31 +++++++++-------------------
 arch/arm/plat-omap/omap-pm-noop.c         |   11 +---------
 4 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b9ea70b..c09bf10 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -323,8 +323,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		omap2430_hwmod_init();
 	else if (cpu_is_omap34xx())
 		omap3xxx_hwmod_init();
-	/* The OPP tables have to be registered before a clk init */
-	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
+	omap_pm_if_early_init();
 
 	if (cpu_is_omap2420())
 		omap2420_clk_init();
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 68f9f2e..c5ada1c 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -18,6 +18,8 @@
 #include <plat/omap_device.h>
 #include <plat/common.h>
 
+#include "pm.h"
+
 static struct omap_device_pm_latency *pm_lats;
 
 static struct device *mpu_dev;
@@ -76,6 +78,10 @@ static void omap2_init_processor_devices(void)
 static int __init omap2_common_pm_init(void)
 {
 	omap2_init_processor_devices();
+
+	if (cpu_is_omap34xx() || cpu_is_omap44xx())
+		omap_init_opp_table();
+
 	omap_pm_if_init();
 
 	return 0;
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 728fbb9..62c3fe9 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -17,27 +17,10 @@
 #include <linux/device.h>
 #include <linux/cpufreq.h>
 #include <linux/clk.h>
+#include <linux/opp.h>
 
 #include "powerdomain.h"
 
-/**
- * struct omap_opp - clock frequency-to-OPP ID table for DSP, MPU
- * @rate: target clock rate
- * @opp_id: OPP ID
- * @min_vdd: minimum VDD1 voltage (in millivolts) for this OPP
- *
- * Operating performance point data.  Can vary by OMAP chip and board.
- */
-struct omap_opp {
-	unsigned long rate;
-	u8 opp_id;
-	u16 min_vdd;
-};
-
-extern struct omap_opp *mpu_opps;
-extern struct omap_opp *dsp_opps;
-extern struct omap_opp *l3_opps;
-
 /*
  * agent_id values for use with omap_pm_set_min_bus_tput():
  *
@@ -59,9 +42,11 @@ extern struct omap_opp *l3_opps;
  * framework starts.  The "_if_" is to avoid name collisions with the
  * PM idle-loop code.
  */
-int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
-				 struct omap_opp *dsp_opp_table,
-				 struct omap_opp *l3_opp_table);
+#ifdef CONFIG_OMAP_PM_NONE
+#define omap_pm_if_early_init() 0
+#else
+int __init omap_pm_if_early_init(void);
+#endif
 
 /**
  * omap_pm_if_init - OMAP PM init code called after clock fw init
@@ -69,7 +54,11 @@ int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
  * The main initialization code.  OPP tables are passed in here.  The
  * "_if_" is to avoid name collisions with the PM idle-loop code.
  */
+#ifdef CONFIG_OMAP_PM_NONE
+#define omap_pm_if_init() 0
+#else
 int __init omap_pm_if_init(void);
+#endif
 
 /**
  * omap_pm_if_exit - OMAP PM exit code
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index e129ce8..ca75abb 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -26,10 +26,6 @@
 
 #include <plat/powerdomain.h>
 
-struct omap_opp *dsp_opps;
-struct omap_opp *mpu_opps;
-struct omap_opp *l3_opps;
-
 /*
  * Device-driver-originated constraints (via board-*.c files)
  */
@@ -308,13 +304,8 @@ int omap_pm_get_dev_context_loss_count(struct device *dev)
 
 
 /* Should be called before clk framework init */
-int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
-				 struct omap_opp *dsp_opp_table,
-				 struct omap_opp *l3_opp_table)
+int __init omap_pm_if_early_init(void)
 {
-	mpu_opps = mpu_opp_table;
-	dsp_opps = dsp_opp_table;
-	l3_opps = l3_opp_table;
 	return 0;
 }
 
-- 
1.6.3.3

