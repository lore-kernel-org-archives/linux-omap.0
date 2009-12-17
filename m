From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: Improve flush_all() performance
Date: Wed, 16 Dec 2009 21:50:56 -0600
Message-ID: <1261021856-19234-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45724 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758194AbZLQDni (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 22:43:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Ameya Palande <ameya.palande@nokia.com>

This patch improves performance of flush_all operation by:

1. Instead of checking IVA state by reading a register, use
   pDevContext->dwBrdState variable.

2. Only call WakeDSP() when IVA is in OFF state.

Ported from:
http://gitorious.org/tidspbridge/mainline/commit/f0cc4ab4e4c40043a423f178a970ad9c8ab8fa06

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
[ orl: ported ]
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index b7447e1..7138396 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -275,21 +275,11 @@ static inline void tlb_flush_all(const void __iomem *base)
 
 static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
 {
-	struct CFG_HOSTRES resources;
-	u32 temp = 0;
-
-	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-				&resources);
-	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
-
-	if ((temp & HW_PWR_STATE_ON) == HW_PWR_STATE_OFF ||
-	    (temp & HW_PWR_STATE_ON) == HW_PWR_STATE_RET) {
-		CLK_Enable(SERVICESCLK_iva2_ck);
+	if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
+				pDevContext->dwBrdState == BRD_HIBERNATION)
 		WakeDSP(pDevContext, NULL);
-		tlb_flush_all(pDevContext->dwDSPMmuBase);
-		CLK_Disable(SERVICESCLK_iva2_ck);
-	} else
-		tlb_flush_all(pDevContext->dwDSPMmuBase);
+
+	tlb_flush_all(pDevContext->dwDSPMmuBase);
 }
 
 static void bad_page_dump(u32 pa, struct page *pg)
-- 
1.6.2.4

