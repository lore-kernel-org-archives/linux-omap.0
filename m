From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/4] omap3: pm: remove OPP interfaces from OMAP PM layer
Date: Tue, 10 Aug 2010 17:09:16 -0700
Message-ID: <1281485357-20791-4-git-send-email-khilman@deeprootsystems.com>
References: <1281485357-20791-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55614 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab0HKAJ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 20:09:26 -0400
Received: by pxi10 with SMTP id 10so277275pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 17:09:26 -0700 (PDT)
In-Reply-To: <1281485357-20791-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Romit Dasgupta <romit@ti.com>

With new OPP layer, OPP users will access OPP API directly instead of
using OMAP PM layer, so remove all notions of OPPs from the OMAP PM
layer.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
Signed-off-by: Romit Dasgupta <romit@ti.com>
---
 arch/arm/mach-omap2/io.c                  |    3 +-
 arch/arm/plat-omap/include/plat/omap-pm.h |   31 +++++++++-------------------
 arch/arm/plat-omap/omap-pm-noop.c         |   11 +---------
 3 files changed, 12 insertions(+), 33 deletions(-)

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
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 728fbb9..c5b533d 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -19,24 +19,7 @@
 #include <linux/clk.h>
 
 #include "powerdomain.h"
-
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
+#include <plat/opp.h>
 
 /*
  * agent_id values for use with omap_pm_set_min_bus_tput():
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
1.7.2.1

