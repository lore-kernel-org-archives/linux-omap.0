From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] DSPBRIDGE: Always print DSP traces.
Date: Mon, 21 Dec 2009 17:40:12 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A9F8AC1C@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57533 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbZLUXkO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 18:40:14 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBLNeEvo024813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 17:40:14 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBLNeDGs000164
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 17:40:13 -0600 (CST)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBLNeDpd018745
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 17:40:13 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From b2da1eae742842cd8fbc643d2038eedeed5f4d36 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 21 Dec 2009 13:25:24 -0600
Subject: [PATCH] DSPBRIDGE: Always print DSP traces.

This patches prints DSP traces always removing the need to
compile debug version and enable DSP traces.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 208ee29..010928b 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1850,7 +1850,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 			 * pointer */
 			hIOMgr->ulGPPReadPointer += ulNewMessageLength;
 			/* Print the trace messages */
-			GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
+			pr_info("DSPTrace:%s", hIOMgr->pMsg);
 		}
 		/* Handle trace buffer wraparound */
 		else if (ulGPPCurPointer < hIOMgr->ulGPPReadPointer) {
@@ -1871,7 +1871,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 			hIOMgr->ulGPPReadPointer = hIOMgr->ulTraceBufferBegin +
 						   ulNewMessageLength;
 			/* Print the trace messages */
-			GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
+			pr_info("DSPTrace:%s", hIOMgr->pMsg);
 		}
 	}
 }
-- 
1.6.0.4

