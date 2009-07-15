From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 06/13] DSPBRIDGE: avoid to dump unnecessary registers without debug
Date: Wed, 15 Jul 2009 17:56:29 +0300
Message-ID: <1247669795-23895-7-git-send-email-ameya.palande@nokia.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35439 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbZGOO4n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 10:56:43 -0400
In-Reply-To: <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com, nm@ti.com, hiroshi.doyu@nokia.com

Make "GetHWRegs()" available only with CONFIG_BRIDGE_DEBUG.

[Hiroshi DOYU: split the original to logical ones]

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |   57 +++++++++++++++++++----------------
 1 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 204ddd5..fd4c11c 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -141,7 +141,37 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
 			u32 ulMpuAddr, u32 ulVirtAddr,
 			u32 ulNumBytes, struct HW_MMUMapAttrs_t *hwAttrs);
-static void GetHWRegs(void __iomem *prcm_base, void __iomem *cm_base);
+
+#ifdef CONFIG_BRIDGE_DEBUG
+static void GetHWRegs(void __iomem *prm_base, void __iomem *cm_base)
+{
+	u32 temp;
+	temp = __raw_readl((cm_base) + 0x00);
+	DBG_Trace(DBG_LEVEL6, "CM_FCLKEN_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((cm_base) + 0x10);
+	DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((cm_base) + 0x20);
+	DBG_Trace(DBG_LEVEL6, "CM_IDLEST_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((cm_base) + 0x48);
+	DBG_Trace(DBG_LEVEL6, "CM_CLKSTCTRL_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((cm_base) + 0x4c);
+	DBG_Trace(DBG_LEVEL6, "CM_CLKSTST_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((prm_base) + 0x50);
+	DBG_Trace(DBG_LEVEL6, "RM_RSTCTRL_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((prm_base) + 0x58);
+	DBG_Trace(DBG_LEVEL6, "RM_RSTST_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((prm_base) + 0xE0);
+	DBG_Trace(DBG_LEVEL6, "PM_PWSTCTRL_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((prm_base) + 0xE4);
+	DBG_Trace(DBG_LEVEL6, "PM_PWSTST_IVA2 = 0x%x \n", temp);
+	temp = __raw_readl((cm_base) + 0xA10);
+	DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_CORE = 0x%x \n", temp);
+}
+#else
+static inline void GetHWRegs(void __iomem *prm_base, void __iomem *cm_base)
+{
+}
+#endif
 
 /*  ----------------------------------- Globals */
 
@@ -2021,31 +2051,6 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *pDevContext,
 	return status;
 }
 
-static void GetHWRegs(void __iomem *prm_base, void __iomem *cm_base)
-{
-	u32 temp;
-	temp = __raw_readl((cm_base) + 0x00);
-	DBG_Trace(DBG_LEVEL6, "CM_FCLKEN_IVA2 = 0x%x \n", temp);
-	temp = __raw_readl((cm_base) + 0x10);
-	DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_IVA2 = 0x%x \n", temp);
-	temp = __raw_readl((cm_base) + 0x20);
-	DBG_Trace(DBG_LEVEL6, "CM_IDLEST_IVA2 = 0x%x \n", temp);
-	temp = __raw_readl((cm_base) + 0x48);
-	DBG_Trace(DBG_LEVEL6, "CM_CLKSTCTRL_IVA2 = 0x%x \n", temp);
-	temp = __raw_readl((cm_base) + 0x4c);
-	DBG_Trace(DBG_LEVEL6, "CM_CLKSTST_IVA2 = 0x%x \n", temp);
-	temp = __raw_readl((prm_base) + 0x50);
-	DBG_Trace(DBG_LEVEL6, "RM_RSTCTRL_IVA2 = 0x%x \n", temp);
-	temp = __raw_readl((prm_base) + 0x58);
-	DBG_Trace(DBG_LEVEL6, "RM_RSTST_IVA2 = 0x%x \n", temp);
-	temp = __raw_readl((prm_base) + 0xE0);
-	DBG_Trace(DBG_LEVEL6, "PM_PWSTCTRL_IVA2 = 0x%x \n", temp);
-	temp = __raw_readl((prm_base) + 0xE4);
-	DBG_Trace(DBG_LEVEL6, "PM_PWSTST_IVA2 = 0x%x \n", temp);
-	temp = __raw_readl((cm_base) + 0xA10);
-	DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_CORE = 0x%x \n", temp);
-}
-
 /*
  *  ======== configureDspMmu ========
  *      Make DSP MMU page table entries.
-- 
1.6.2.4

