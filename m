From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 08/10] DSPBRIDGE: Checkpatch - line over 80 characters
Date: Fri, 15 Jan 2010 15:28:39 -0600
Message-ID: <1263590921-24357-9-git-send-email-omar.ramirez@ti.com>
References: <1263590921-24357-1-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-2-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-3-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-4-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-5-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-6-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-7-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-8-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41930 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758284Ab0AOVS5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 16:18:57 -0500
In-Reply-To: <1263590921-24357-8-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

WARNING: line over 80 characters

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c                |    3 ++-
 drivers/dsp/bridge/wmd/tiomap3430.c           |   11 +++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index fe68cab..fc9fdc8 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -556,7 +556,7 @@ bit 6 - MMU element size = 64bit (valid only for non mixed page entries)
 #define AUTOSTART	"AutoStart"		/* Statically load flag */
 #define CURRENTCONFIG	"CurrentConfig"		/* Current resources */
 #define SHMSIZE		"SHMSize"		/* Size of SHM reservd on MPU */
-#define TCWORDSWAP	"TCWordSwap"		/* Traffic Contoller Word Swap */
+#define TCWORDSWAP	"TCWordSwap"		/* Traffic Controller WordSwp */
 #define DSPRESOURCES	"DspTMSResources"	/* C55 DSP resurces on OMAP */
 
 #endif				/* DBDEFS_ */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 8b7d221..e37d447 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1566,7 +1566,8 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 			IO_SetValue(pIOMgr->hWmdContext, struct MSG, pCtrl,
 				   postSWI, true);
 			/* Tell the DSP we have written the output. */
-			CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+			CHNLSM_InterruptDSP2(pIOMgr->hWmdContext,
+						MBX_PCPY_CLASS);
 		}
 	}
 func_end:
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 2c1ec2f..4729ae5 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -564,12 +564,11 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 
 		/* Enable the BIOS clock  */
 		(void)DEV_GetSymbol(pDevContext->hDevObject,
-					BRIDGEINIT_BIOSGPTIMER,
-				     &ulBiosGpTimer);
+				BRIDGEINIT_BIOSGPTIMER, &ulBiosGpTimer);
 		DBG_Trace(DBG_LEVEL7, "BIOS GPTimer : 0x%x\n", ulBiosGpTimer);
 		(void)DEV_GetSymbol(pDevContext->hDevObject,
 				BRIDGEINIT_LOADMON_GPTIMER,
-				     &ulLoadMonitorTimer);
+				&ulLoadMonitorTimer);
 		DBG_Trace(DBG_LEVEL7, "Load Monitor Timer : 0x%x\n",
 			  ulLoadMonitorTimer);
 	}
@@ -585,7 +584,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 
 			extClkId = uClkCmd & MBX_PM_CLK_IDMASK;
 			for (tmpIndex = 0; tmpIndex < MBX_PM_MAX_RESOURCES;
-				       tmpIndex++) {
+			     tmpIndex++) {
 				if (extClkId == BPWR_CLKID[tmpIndex]) {
 					clkIdIndex = tmpIndex;
 					break;
@@ -593,8 +592,8 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			}
 
 			if (clkIdIndex < MBX_PM_MAX_RESOURCES)
-				status = CLK_Set_32KHz(
-						BPWR_Clks[clkIdIndex].funClk);
+				status =
+				    CLK_Set_32KHz(BPWR_Clks[clkIdIndex].funClk);
 			else
 				status = DSP_EFAIL;
 
-- 
1.6.2.4

