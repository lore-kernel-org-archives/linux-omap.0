From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 7/7] DSPBRIDGE: Reset MMU and DSP on board stop
Date: Wed, 17 Jun 2009 12:36:12 -0500
Message-ID: <1245260172-23008-8-git-send-email-omar.ramirez@ti.com>
References: <1245260172-23008-1-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-2-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-3-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-4-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-5-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-6-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-7-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58458 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758949AbZFQRbh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2009 13:31:37 -0400
In-Reply-To: <1245260172-23008-7-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Fernando Guzman Lugo <x0095840@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

This patch resets MMU and DSP by writintg into those registers,
this will solve MMU faults occured when the processor is stopped.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Signed-off-by: Fernando Guzman <x0095840@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 4919314..b317015 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -849,6 +849,9 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 		       (pPtAttrs->L2NumPages * sizeof(struct PageInfo)));
 	}
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Stop - End ****** \n");
+	HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
+	HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
+
 	return status;
 }
 
@@ -911,7 +914,7 @@ static DSP_STATUS WMD_BRD_Delete(struct WMD_DEV_CONTEXT *hDevContext)
 		memset((u8 *)pPtAttrs->pgInfo, 0x00,
 			(pPtAttrs->L2NumPages * sizeof(struct PageInfo)));
 	}
-	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Stop - End ****** \n");
+	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Delete - End ****** \n");
 	HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
 	HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
 
-- 
1.6.2.4

