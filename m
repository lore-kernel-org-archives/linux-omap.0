From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: Revert removing all resources on proc detach
Date: Wed,  3 Jun 2009 10:37:34 -0500
Message-ID: <1244043454-31662-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35404 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbZFCPdX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2009 11:33:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Nishant Menon <nm@ti.com>, Fernando Guzman <x0095840@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch changes removing all resources for the process
context on processor detach, it only frees the dmm resources
and let resource cleanup take care of the rest.

This regression was introduced with the following patch:
    DSPBRIDGE: base image reload support after DSP error

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Acked-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index d4d20ae..43f2d29 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -659,7 +659,7 @@ DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor)
 				(struct DRV_OBJECT *)hDRVObject, &pPctxt,
 					 NULL, 0);
 			if (pPctxt != NULL) {
-				DRV_RemoveAllResources(pPctxt);
+				DRV_ProcFreeDMMRes(pPctxt);
 				pPctxt->hProcessor = NULL;
 			}
 		}
-- 
1.6.2.4

