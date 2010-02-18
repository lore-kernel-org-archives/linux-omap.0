From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: check pointer before dereference
Date: Thu, 18 Feb 2010 15:55:34 -0600
Message-ID: <1266530134-8186-3-git-send-email-omar.ramirez@ti.com>
References: <1266530134-8186-1-git-send-email-omar.ramirez@ti.com>
 <1266530134-8186-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55630 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab0BRVm4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:42:56 -0500
In-Reply-To: <1266530134-8186-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Change the check for valid handle to detect a possible
error, and now use it before dereferencing the pointer.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/msg.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 5cfeb5b..9e4b202 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -104,19 +104,19 @@ void MSG_Delete(struct MSG_MGR *hMsgMgr)
 	struct WMD_DRV_INTERFACE *pIntfFxns;
 
 	DBC_Require(cRefs > 0);
-	DBC_Require(MEM_IsValidHandle(pMsgMgr, MSGMGR_SIGNATURE));
 
 	GT_1trace(MSG_debugMask, GT_ENTER, "MSG_Delete: hMsgMgr: 0x%x\n",
 		 hMsgMgr);
 
-	pIntfFxns = pMsgMgr->pIntfFxns;
+	if (MEM_IsValidHandle(pMsgMgr, MSGMGR_SIGNATURE)) {
+		pIntfFxns = pMsgMgr->pIntfFxns;
 
-	/* Let WMD message module destroy the MSG_MGR: */
-	(*pIntfFxns->pfnMsgDelete)(hMsgMgr);
-
-	if (MEM_IsValidHandle(pMsgMgr, MSGMGR_SIGNATURE))
-		GT_1trace(MSG_debugMask, GT_7CLASS, "MSG_Delete: Error hMsgMgr "
-					"Valid Handle: 0x%x\n", hMsgMgr);
+		/* Let WMD message module destroy the MSG_MGR: */
+		(*pIntfFxns->pfnMsgDelete)(hMsgMgr);
+	} else {
+		GT_1trace(MSG_debugMask, GT_7CLASS, "MSG_Delete: Error hMsgMgr"
+					"invalid Handle: 0x%x\n", hMsgMgr);
+	}
 }
 
 /*
-- 
1.6.2.4

