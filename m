From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] dsp-bridge: improve PM conditional code
Date: Fri, 18 Dec 2009 19:44:36 +0200
Message-ID: <1261158277-26402-2-git-send-email-felipe.contreras@gmail.com>
References: <1261016163-11091-19-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:37016 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932325AbZLRRpA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 12:45:00 -0500
Received: by ewy19 with SMTP id 19so1736234ewy.21
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 09:44:59 -0800 (PST)
In-Reply-To: <1261016163-11091-19-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/dspbridge.c         |    2 ++
 drivers/dsp/bridge/rmgr/drv_interface.c |    5 ++++-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

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
index 6415955..90d4bad 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -96,8 +96,10 @@
 #include <dspbridge/drv.h>
 #endif
 
+#ifdef CONFIG_BRIDGE_DVFS
 #include <mach/omap-pm.h>
 #include <mach-omap2/omap3-opp.h>
+#endif
 
 #define BRIDGE_NAME "C6410"
 /*  ----------------------------------- Globals */
@@ -147,7 +149,6 @@ static int omap34xxbridge_suspend_lockout(
 	}
 	return 0;
 }
-
 #endif
 
 #ifdef DEBUG
@@ -459,8 +460,10 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 		DBC_Assert(ret == true);
 	}
 
+#ifdef CONFIG_BRIDGE_DVFS
 	clk_put(clk_handle);
 	clk_handle = NULL;
+#endif /* #ifdef CONFIG_BRIDGE_DVFS */
 
 func_cont:
 	MEM_ExtPhysPoolRelease();
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index ea299a0..8a0cb02 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -68,8 +68,8 @@
 
 #ifdef CONFIG_PM
 #include <mach/board-3430sdp.h>
-#endif
 extern s32 dsp_test_sleepstate;
+#endif
 extern struct MAILBOX_CONTEXT mboxsetting;
 
 /*
-- 
1.6.6.rc2.5.g49666

