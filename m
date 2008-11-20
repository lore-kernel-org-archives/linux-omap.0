From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [omapzoom][PATCH 4/4] DSPBRIDGE Deleting unneeded mem alloc
Date: Thu, 20 Nov 2008 03:12:07 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F1A398EF@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47346 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbYKTJMT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 04:12:19 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Mon, 17 Nov 2008 17:13:58 -0600
Subject: [PATCH] DSPBRIDGE Deleting unneeded mem alloc

Since "SYNC_InitializeCS()" allocates "struct SYNC_CSOBJECT"
for "hProcLock", "MEM_AllocObject()" shouldn't be called
for "hProcLock". This was double allocation for the
same pointer.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index d7798e7..9afaaad 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1009,7 +1009,6 @@ bool PROC_Init(void)
 		DBC_Assert(!PROC_DebugMask.flags);
 		GT_create(&PROC_DebugMask, "PR");  /* "PR" for Processor */
 
-		MEM_AllocObject(hProcLock, struct SYNC_CSOBJECT, SIGNATURECS);
 		(void)SYNC_InitializeCS(&hProcLock);
 	}
 
-- 
1.6.0
