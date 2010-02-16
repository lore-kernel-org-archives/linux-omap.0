From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 18/18] DSPBRIDGE: change critical error statements to pr_err in services
Date: Tue, 16 Feb 2010 02:42:28 -0600
Message-ID: <1266309748-11714-19-git-send-email-omar.ramirez@ti.com>
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
 <1266309748-11714-14-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-15-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-16-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-17-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-18-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60004 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078Ab0BPIaH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:30:07 -0500
In-Reply-To: <1266309748-11714-18-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Print to console:
    - If extern phys_mem_pool map fails.
    - Clk bridge module failures.
    - Cfg bridge module failures.

This will help to quick diagnose most common bridge errors.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/cfg.c |   21 ++++++++-------------
 drivers/dsp/bridge/services/clk.c |   23 +++++++++--------------
 drivers/dsp/bridge/services/mem.c |    4 +---
 3 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index f8c958a..d26f8b9 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -107,8 +107,7 @@ DSP_STATUS CFG_GetDevObject(struct CFG_DEVNODE *hDevNode, OUT u32 *pdwValue)
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
-		GT_0trace(CFG_debugMask, GT_6CLASS,
-			  "CFG_GetDevObject Failed \n");
+		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 #endif
 	return status;
 }
@@ -134,8 +133,7 @@ DSP_STATUS CFG_GetDSPResources(struct CFG_DEVNODE *hDevNode,
 	}
 	if (DSP_FAILED(status)) {
 		status = CFG_E_RESOURCENOTAVAIL;
-		GT_0trace(CFG_debugMask, GT_6CLASS,
-			  "CFG_GetDSPResources Failed \n");
+		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
 	/* assert that resource values are reasonable */
@@ -174,8 +172,7 @@ DSP_STATUS CFG_GetExecFile(struct CFG_DEVNODE *hDevNode, u32 ulBufSize,
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
-		GT_0trace(CFG_debugMask, GT_6CLASS,
-			  "CFG_GetExecFile Failed \n");
+		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 #endif
 	DBC_Ensure(((status == DSP_SOK) &&
 		(strlen(pstrExecFile) <= ulBufSize)) || (status != DSP_SOK));
@@ -242,7 +239,7 @@ DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, u32 dwType)
 	}
 	if (DSP_FAILED(status)) {
 		*pdwValue = 0;
-		GT_0trace(CFG_debugMask, GT_6CLASS, "CFG_GetObject Failed \n");
+		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 	}
 	DBC_Ensure((DSP_SUCCEEDED(status) && *pdwValue != 0) ||
 		   (DSP_FAILED(status) && *pdwValue == 0));
@@ -268,9 +265,8 @@ bool CFG_Init(void)
 	dspResources.aMemDesc[0].ulMax = 0;
 	if (DSP_FAILED(REG_SetValue(DSPRESOURCES, (u8 *)&dspResources,
 				       sizeof(struct CFG_DSPRES))))
-		GT_0trace(CFG_debugMask, GT_5CLASS,
-			  "Failed to Initialize DSP resources"
-			  " in Registry \n");
+		pr_err("Failed to initialize DSP resources in registry\n");
+
 	return true;
 }
 
@@ -298,8 +294,7 @@ DSP_STATUS CFG_SetDevObject(struct CFG_DEVNODE *hDevNode, u32 dwValue)
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
-		GT_0trace(CFG_debugMask, GT_6CLASS,
-			  "CFG_SetDevObject Failed \n");
+		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 #endif
 	return status;
 }
@@ -327,7 +322,7 @@ DSP_STATUS CFG_SetObject(u32 dwValue, u32 dwType)
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
-		GT_0trace(CFG_debugMask, GT_6CLASS, "CFG_SetObject Failed \n");
+		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 #endif
 	return status;
 }
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 1e8fe45..f8c417a 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -138,10 +138,8 @@ bool CLK_Init(void)
 			     SERVICES_Clks[i].clk_name);
 
 		if (!clk_handle) {
-			GT_2trace(CLK_debugMask, GT_7CLASS,
-				  "CLK_Init: failed to get Clk handle %s, "
-				  "CLK dev id = %d\n",
-				  SERVICES_Clks[i].clk_name,
+			pr_err("%s: failed to get clk handle %s, dev id = %d\n",
+				  __func__, SERVICES_Clks[i].clk_name,
 				  SERVICES_Clks[i].id);
 			/* should we fail here?? */
 		}
@@ -208,8 +206,7 @@ DSP_STATUS CLK_Set_32KHz(IN enum SERVICES_ClkId clk_id)
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
 		if (!(clk_set_parent(pClk, pClkParent) == 0x0)) {
-			GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Set_32KHz: "
-				"Failed to set to 32KHz %s, CLK dev id = %s\n",
+			pr_err("%s: failed for %s, dev id = %d\n", __func__,
 				SERVICES_Clks[clk_id].clk_name,
 				SERVICES_Clks[clk_id].id);
 			status = DSP_EFAIL;
@@ -282,10 +279,9 @@ DSP_STATUS CLK_GetRate(IN enum SERVICES_ClkId clk_id, u32 *speedKhz)
 			  "CLK_GetRate: clkSpeedHz = %d , "
 			 "speedinKhz=%d\n", clkSpeedHz, *speedKhz);
 	} else {
-		GT_2trace(CLK_debugMask, GT_7CLASS,
-			 "CLK_GetRate: failed to get CLK %s, "
-			 "CLK dev Id = %d\n", SERVICES_Clks[clk_id].clk_name,
-			 SERVICES_Clks[clk_id].id);
+		pr_err("%s: failed to get %s, dev Id = %d\n", __func__,
+						SERVICES_Clks[clk_id].clk_name,
+						SERVICES_Clks[clk_id].id);
 		status = DSP_EFAIL;
 	}
 	return status;
@@ -304,10 +300,9 @@ s32 CLK_Get_UseCnt(IN enum SERVICES_ClkId clk_id)
 		/* FIXME: usecount shouldn't be used */
 		useCount = pClk->usecount;
 	} else {
-		GT_2trace(CLK_debugMask, GT_7CLASS,
-			 "CLK_GetRate: failed to get CLK %s, "
-			 "CLK dev Id = %d\n", SERVICES_Clks[clk_id].clk_name,
-			 SERVICES_Clks[clk_id].id);
+		pr_err("%s: failed to get %s, dev Id = %d\n", __func__,
+						SERVICES_Clks[clk_id].clk_name,
+						SERVICES_Clks[clk_id].id);
 		status = DSP_EFAIL;
 	}
 	return useCount;
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 65d268a..092b532 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -59,9 +59,7 @@ void MEM_ExtPhysPoolInit(u32 poolPhysBase, u32 poolSize)
 	poolVirtBase = (u32)ioremap(poolPhysBase, poolSize);
 
 	if ((void **)poolVirtBase == NULL) {
-		GT_0trace(MEM_debugMask, GT_7CLASS,
-			  "[PHYS_POOL]Mapping External "
-			  "physical memory to virt failed \n");
+		pr_err("%s: external physical memory map failed\n", __func__);
 		extPhysMemPoolEnabled = false;
 	} else {
 		extMemPool.physMemBase = poolPhysBase;
-- 
1.6.2.4

