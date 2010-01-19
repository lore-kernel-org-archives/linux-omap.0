From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 6/6] DSPBRIDGE: Always print DSP traces
Date: Tue, 19 Jan 2010 14:54:09 -0600
Message-ID: <1263934449-16891-7-git-send-email-omar.ramirez@ti.com>
References: <1263934449-16891-1-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-2-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-3-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-4-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-5-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-6-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47096 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512Ab0ASUoG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 15:44:06 -0500
In-Reply-To: <1263934449-16891-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

This patches prints DSP traces always removing the need to
compile debug version and enable DSP traces.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index d267cab..e35ce57 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1905,7 +1905,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 			 */
 			hIOMgr->ulGPPReadPointer += ulNewMessageLength;
 			/* Print the trace messages */
-			GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
+			pr_info("DSPTrace: %s\n", hIOMgr->pMsg);
 		} else if (ulGPPCurPointer < hIOMgr->ulGPPReadPointer) {
 			/* Handle trace buffer wraparound */
 			memcpy(hIOMgr->pMsg, (char *)hIOMgr->ulGPPReadPointer,
@@ -1927,7 +1927,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 			hIOMgr->ulGPPReadPointer = hIOMgr->ulTraceBufferBegin +
 						   ulNewMessageLength;
 			/* Print the trace messages */
-			GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
+			pr_info("DSPTrace: %s\n", hIOMgr->pMsg);
 		}
 	}
 }
-- 
1.6.2.4

