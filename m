From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 6/7] DSPBRIDGE: Keep DMM resources for other nodes on PROC_Detach
Date: Wed, 17 Jun 2009 12:36:11 -0500
Message-ID: <1245260172-23008-7-git-send-email-omar.ramirez@ti.com>
References: <1245260172-23008-1-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-2-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-3-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-4-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-5-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-6-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36929 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758796AbZFQRbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 13:31:36 -0400
In-Reply-To: <1245260172-23008-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hari Kanigeri <h-kanigeri2@ti.com>

From: Hari Kanigeri <h-kanigeri2@ti.com>

Removed resource cleanup for DMM on PROC_Detach due to LCML
detaching the processor when it deletes each node, therefore
resource cleanup was freeing DMM resources of other nodes that
might be still in use, this would cause unexpected behavior,
possibly MMU fault.

Signed-of-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 43f2d29..f6045bb 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -658,10 +658,8 @@ DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor)
 			DRV_GetProcContext(hProcess,
 				(struct DRV_OBJECT *)hDRVObject, &pPctxt,
 					 NULL, 0);
-			if (pPctxt != NULL) {
-				DRV_ProcFreeDMMRes(pPctxt);
+			if (pPctxt != NULL)
 				pPctxt->hProcessor = NULL;
-			}
 		}
 #endif
 		/* Notify the Client */
-- 
1.6.2.4

