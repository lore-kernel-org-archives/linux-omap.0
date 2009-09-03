From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] dspbridge: relocate MEM_ExtPhysPoolRelease() call
Date: Thu,  3 Sep 2009 14:38:27 +0300
Message-ID: <1251977907-26533-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20193 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbZICLi4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 07:38:56 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n83BckDd023834
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 14:38:49 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

It's more logical to have calls of symmetric functions at single place.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/mem.h |    5 +++++
 drivers/dsp/bridge/rmgr/drv_interface.c    |    2 ++
 drivers/dsp/bridge/services/mem.c          |    4 ++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 4e43f21..b47a6d4 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -354,4 +354,9 @@
 	extern void MEM_ExtPhysPoolInit(IN u32 poolPhysBase,
 					IN u32 poolSize);
 
+/*
+ *  ======== MEM_ExtPhysPoolRelease ========
+ */
+	extern void MEM_ExtPhysPoolRelease(void);
+
 #endif				/* MEM_ */
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 08b5cde..e83ba3b 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -503,6 +503,8 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 	clk_handle = NULL;
 
 func_cont:
+	MEM_ExtPhysPoolRelease();
+
 	SERVICES_Exit();
 	GT_exit();
 
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 22f382b..5836bae 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -30,6 +30,7 @@
  *      MEM_FreePhysMem
  *      MEM_Init
  *      MEM_ExtPhysPoolInit
+ *      MEM_ExtPhysPoolRelease
  *
  *! Revision History:
  *! =================
@@ -199,7 +200,7 @@ void MEM_ExtPhysPoolInit(u32 poolPhysBase, u32 poolSize)
 	}
 }
 
-static void MEM_ExtPhysPoolRelease(void)
+void MEM_ExtPhysPoolRelease(void)
 {
 	GT_0trace(MEM_debugMask, GT_1CLASS,
 		  "Releasing External memory pool \n");
@@ -460,7 +461,6 @@ void MEM_Exit(void)
 		MEM_Check();
 
 #endif
-	MEM_ExtPhysPoolRelease();
 	DBC_Ensure(cRefs >= 0);
 }
 
-- 
1.5.6.5

