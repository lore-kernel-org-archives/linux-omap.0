From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 14/14] DSPBRIDGE: Remove run_IdleBoot support
Date: Wed, 20 May 2009 00:02:20 -0500
Message-ID: <1242795740-21535-14-git-send-email-x00omar@ti.com>
References: <1242795740-21535-1-git-send-email-x00omar@ti.com>
 <1242795740-21535-2-git-send-email-x00omar@ti.com>
 <1242795740-21535-3-git-send-email-x00omar@ti.com>
 <1242795740-21535-4-git-send-email-x00omar@ti.com>
 <1242795740-21535-5-git-send-email-x00omar@ti.com>
 <1242795740-21535-6-git-send-email-x00omar@ti.com>
 <1242795740-21535-7-git-send-email-x00omar@ti.com>
 <1242795740-21535-8-git-send-email-x00omar@ti.com>
 <1242795740-21535-9-git-send-email-x00omar@ti.com>
 <1242795740-21535-10-git-send-email-x00omar@ti.com>
 <1242795740-21535-11-git-send-email-x00omar@ti.com>
 <1242795740-21535-12-git-send-email-x00omar@ti.com>
 <1242795740-21535-13-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57563 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbZETE6d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 00:58:33 -0400
In-Reply-To: <1242795740-21535-13-git-send-email-x00omar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Hari Kanigeri <h-kanigeri2@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

From: Hari Kanigeri <h-kanigeri2@ti.com>

Changed the Bridge boot process in order to avoid the
usage of the IDLE boot mode and the DSP ROM.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |   60 +++-------------------------------
 1 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index afeeb2c..7a9603d 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -141,8 +141,6 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
 			u32 ulMpuAddr, u32 ulVirtAddr,
 			u32 ulNumBytes, struct HW_MMUMapAttrs_t *hwAttrs);
-static DSP_STATUS run_IdleBoot(void __iomem *prcm_base, void __iomem *cm_base,
-			void __iomem *sysctrl_base);
 static void GetHWRegs(void __iomem *prcm_base, void __iomem *cm_base);
 
 /*  ----------------------------------- Globals */
@@ -341,8 +339,9 @@ static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *hDevContext)
 	}
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Monitor - Middle ****** \n");
 	GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
-	status = run_IdleBoot(resources.dwPrmBase, resources.dwCmBase,
-			      resources.dwSysCtrlBase);
+	HW_RST_UnReset(resources.dwPrmBase, HW_RST2_IVA2);
+	CLK_Enable(SERVICESCLK_iva2_ck);
+
 	if (DSP_SUCCEEDED(status)) {
 		/* set the device state to IDLE */
 		pDevContext->dwBrdState = BRD_IDLE;
@@ -811,8 +810,6 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 		CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);
 		mdelay(10);
 		GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
-		run_IdleBoot(resources.dwPrmBase, resources.dwCmBase,
-				resources.dwSysCtrlBase);
 		udelay(50);
 
 		clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
@@ -916,6 +913,9 @@ static DSP_STATUS WMD_BRD_Delete(struct WMD_DEV_CONTEXT *hDevContext)
 			(pPtAttrs->L2NumPages * sizeof(struct PageInfo)));
 	}
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Stop - End ****** \n");
+	HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
+	HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
+
 	return status;
 }
 
@@ -2018,54 +2018,6 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *pDevContext,
 	return status;
 }
 
-static DSP_STATUS run_IdleBoot(void __iomem *prm_base, void __iomem *cm_base,
-			       void __iomem *sysctrl_base)
-{
-	u32 temp;
-	DSP_STATUS status = DSP_SOK;
-	enum HW_PwrState_t    pwrState;
-
-	/* Read PM_PWSTST_IVA2 */
-	HW_PWRST_IVA2RegGet(prm_base, &temp);
-	if ((temp & 0x03) != 0x03 || (temp & 0x03) != 0x02) {
-		/* IVA2 is not in ON state */
-		/* Set PM_PWSTCTRL_IVA2  to ON */
-		HW_PWR_IVA2PowerStateSet(prm_base, HW_PWR_DOMAIN_DSP,
-					  HW_PWR_STATE_ON);
-		/* Set the SW supervised state transition */
-		HW_PWR_CLKCTRL_IVA2RegSet(cm_base, HW_SW_SUP_WAKEUP);
-		/* Wait until the state has moved to ON */
-		HW_PWR_IVA2StateGet(prm_base, HW_PWR_DOMAIN_DSP, &pwrState);
-	}
-	CLK_Disable(SERVICESCLK_iva2_ck);
-	udelay(10);
-	/* Assert IVA2-RST1 and IVA2-RST2  */
-	__raw_writel((u32)0x07, (prm_base) + 0x50);
-	udelay(30);
-	/* set the SYSC for Idle Boot */
-	__raw_writel((u32)0x01, (sysctrl_base) + 0x404);
-	       temp = (u32) *((REG_UWORD32 *)
-			       ((u32) (cm_base) + 0x34));
-	       temp = (temp & 0xFFFFFFFE) | 0x1;
-	       *((REG_UWORD32 *) ((u32) (cm_base) + 0x34)) =
-		       (u32) temp;
-	       temp = (u32) *((REG_UWORD32 *)
-		       ((u32) (cm_base) + 0x4));
-	       temp =  (temp & 0xFFFFFC8) | 0x37;
-	       *((REG_UWORD32 *) ((u32) (cm_base) + 0x4)) =
-		       (u32) temp;
-	CLK_Enable(SERVICESCLK_iva2_ck);
-	udelay(20);
-	GetHWRegs(prm_base, cm_base);
-	/* Release Reset1 and Reset2 */
-	__raw_writel((u32)0x05, (prm_base) + 0x50);
-	udelay(20);
-	__raw_writel((u32)0x04, (prm_base) + 0x50);
-	udelay(30);
-	return status;
-}
-
-
 static void GetHWRegs(void __iomem *prm_base, void __iomem *cm_base)
 {
 	u32 temp;
-- 
1.6.2.4

