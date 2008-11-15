From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] BRIDGE: Fix memory leak in PROC_Init()
Date: Sat, 15 Nov 2008 11:02:51 +0200
Message-ID: <1226739771-31426-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25425 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbYKOJDA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Nov 2008 04:03:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x00omar@ti.com, h-kanigeri2@ti.com, grgupta77@gmail.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Since "SYNC_InitializeCS()" allocates "struct SYNC_CSOBJECT" for
"hProcLock", "MEM_AllocObject()" shouldn't be called for
"hProcLock". This was double allocation for the same pointer.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 3f9a371..082bea3 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1006,7 +1006,6 @@ bool PROC_Init(void)
 		DBC_Assert(!PROC_DebugMask.flags);
 		GT_create(&PROC_DebugMask, "PR");  /* "PR" for Processor */
 
-		MEM_AllocObject(hProcLock, struct SYNC_CSOBJECT, SIGNATURECS);
 		(void)SYNC_InitializeCS(&hProcLock);
 	}
 
-- 
1.6.0.3.613.g9f8f13

