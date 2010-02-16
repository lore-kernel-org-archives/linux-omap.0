From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 13/18] DSPBRIDGE: change init statements to pr_info in rmgr
Date: Tue, 16 Feb 2010 02:42:23 -0600
Message-ID: <1266309748-11714-14-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-8-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-9-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-10-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-11-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-12-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-13-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60019 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755703Ab0BPIaK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:30:10 -0500
In-Reply-To: <1266309748-11714-13-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Print to console if:
- Driver is succesfully installed.
- Baseimage is correctly loaded.
- Processor is started.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    3 +--
 drivers/dsp/bridge/rmgr/proc.c          |    6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 8f9e626..a002e01 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -346,8 +346,7 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 			GT_0trace(driverTrace, GT_7CLASS,
 				 "DSP/BIOS Bridge initialization Failed\n");
 		} else {
-			GT_0trace(driverTrace, GT_5CLASS,
-					"DSP/BIOS Bridge driver loaded\n");
+			pr_info("DSP Bridge driver loaded\n");
 		}
 	}
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index ed42a47..b6ed886 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1030,8 +1030,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 	if (DSP_SUCCEEDED(status)) {
 		if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
 		   (pProcObject->hWmdContext, &uBrdState))) {
-			GT_0trace(PROC_DebugMask, GT_1CLASS,
-				 "PROC_Load: Processor Loaded\n");
+			pr_info("%s: Processor Loaded %s\n", __func__, pargv0);
 			DBC_Assert(uBrdState == BRD_LOADED);
 		}
 	}
@@ -1289,8 +1288,7 @@ func_cont:
 	if (DSP_SUCCEEDED(status)) {
 		if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
 		   (pProcObject->hWmdContext, &uBrdState))) {
-			GT_0trace(PROC_DebugMask, GT_1CLASS,
-				 "PROC_Start: Processor State is RUNNING \n");
+			pr_info("%s: dsp in running state\n", __func__);
 			DBC_Assert(uBrdState != BRD_HIBERNATION);
 		}
 	}
-- 
1.6.2.4

