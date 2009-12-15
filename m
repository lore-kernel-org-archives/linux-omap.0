From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 17/17] DSPBRIDGE: Compilation fixes 2.6.31
Date: Tue, 15 Dec 2009 00:19:58 -0600
Message-ID: <1260857998-19349-18-git-send-email-omar.ramirez@ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44514 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953AbZLOGMw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 01:12:52 -0500
In-Reply-To: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Compilation fixes 2.6.31

	board-sdp3430.h not found
	clk_handle undefined because of DVFS flag

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/dspbridge.c         |    2 ++
 drivers/dsp/bridge/rmgr/drv_interface.c |    8 ++++----
 drivers/dsp/bridge/rmgr/proc.c          |    3 +++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    3 ---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index 9724a95..ea109a3 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -13,7 +13,9 @@
 
 #include <linux/platform_device.h>
 
+#ifdef CONFIG_BRIDGE_DVFS
 #include <mach/omap-pm.h>
+#endif
 
 #include <dspbridge/host_os.h>
 
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 6415955..16529d8 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -59,8 +59,6 @@
 #include <linux/moduleparam.h>
 #include <linux/cdev.h>
 
-#include <mach/board-3430sdp.h>
-
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
@@ -96,8 +94,10 @@
 #include <dspbridge/drv.h>
 #endif
 
+#ifdef CONFIG_BRIDGE_DVFS
 #include <mach/omap-pm.h>
 #include <mach-omap2/omap3-opp.h>
+#endif
 
 #define BRIDGE_NAME "C6410"
 /*  ----------------------------------- Globals */
@@ -458,10 +458,10 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 		driverContext = 0;
 		DBC_Assert(ret == true);
 	}
-
+#ifdef CONFIG_BRIDGE_DVFS
 	clk_put(clk_handle);
 	clk_handle = NULL;
-
+#endif
 func_cont:
 	MEM_ExtPhysPoolRelease();
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 89b1ff3..76e39ca 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -142,7 +142,10 @@
 /*  ----------------------------------- This */
 #include <dspbridge/proc.h>
 #include <dspbridge/pwr.h>
+
+#ifdef CONFIG_BRIDGE_DVFS
 #include <mach-omap2/omap3-opp.h>
+#endif
 
 #ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/resourcecleanup.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 1c3bec3..d52fdb8 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -66,9 +66,6 @@
 #include <mach-omap2/prm-regbits-34xx.h>
 #include <mach-omap2/cm-regbits-34xx.h>
 
-#ifdef CONFIG_PM
-#include <mach/board-3430sdp.h>
-#endif
 extern s32 dsp_test_sleepstate;
 extern struct MAILBOX_CONTEXT mboxsetting;
 
-- 
1.6.2.4

