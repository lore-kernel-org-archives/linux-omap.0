From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: Reset IVA2 Video sequencer
Date: Wed, 16 Dec 2009 21:50:26 -0600
Message-ID: <1261021826-19205-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33389 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757353AbZLQDnI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 22:43:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch will reset IVA2 video sequencer as part of
initialization or uninstall process.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index f41763c..b7447e1 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -879,6 +879,7 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Stop - End ****** \n");
 	HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
 	HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
+	HW_RST_Reset(resources.dwPrmBase, HW_RST3_IVA2);
 
 	return status;
 }
@@ -945,6 +946,7 @@ static DSP_STATUS WMD_BRD_Delete(struct WMD_DEV_CONTEXT *hDevContext)
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Delete - End ****** \n");
 	HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
 	HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
+	HW_RST_Reset(resources.dwPrmBase, HW_RST3_IVA2);
 
 	return status;
 }
-- 
1.6.2.4

