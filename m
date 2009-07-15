From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 07/13] DSPBRIDGE: flush_all() bumps VDD1_OPP to 2 if it is at 1
Date: Wed, 15 Jul 2009 17:56:30 +0300
Message-ID: <1247669795-23895-8-git-send-email-ameya.palande@nokia.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-7-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35485 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221AbZGOO5k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 10:57:40 -0400
In-Reply-To: <1247669795-23895-7-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com, nm@ti.com, hiroshi.doyu@nokia.com

[Hiroshi DOYU: split the original to logical ones]

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index fd4c11c..54c53b6 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -291,8 +291,20 @@ static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
 		WakeDSP(pDevContext, NULL);
 		tlb_flush_all(pDevContext->dwDSPMmuBase);
 		CLK_Disable(SERVICESCLK_iva2_ck);
-	} else
+	} else {
+#ifdef CONFIG_BRIDGE_DVFS
+		struct dspbridge_platform_data *pdata =
+			omap_dspbridge_dev->dev.platform_data;
+		u32 opplevel = 0;
+		if (pdata->dsp_get_opp)
+			opplevel = (*pdata->dsp_get_opp)();
+		if (opplevel == VDD1_OPP1) {
+			if (pdata->dsp_set_min_opp)
+				(*pdata->dsp_set_min_opp)(VDD1_OPP2);
+		}
+#endif
 		tlb_flush_all(pDevContext->dwDSPMmuBase);
+	}
 }
 
 static void bad_page_dump(u32 pa, struct page *pg)
-- 
1.6.2.4

