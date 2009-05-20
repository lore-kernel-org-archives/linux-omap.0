From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 04/14] DSPBRIDGE: Fixed typo in debug traces
Date: Wed, 20 May 2009 00:02:10 -0500
Message-ID: <1242795740-21535-4-git-send-email-x00omar@ti.com>
References: <1242795740-21535-1-git-send-email-x00omar@ti.com>
 <1242795740-21535-2-git-send-email-x00omar@ti.com>
 <1242795740-21535-3-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59987 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbZETE6e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 00:58:34 -0400
In-Reply-To: <1242795740-21535-3-git-send-email-x00omar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Omar Ramirez Luna <omar.ramirez@ti.com>

Fixed typo in Bridge traces for Msg and Nldr.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Acked-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/pmgr/msg.c  |    2 +-
 drivers/dsp/bridge/rmgr/nldr.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index bbf5174..be4acdb 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -158,7 +158,7 @@ bool MSG_Init(void)
 
 	if (cRefs == 0) {
 		DBC_Assert(!MSG_debugMask.flags);
-		GT_create(&MSG_debugMask, "MG");	/* "MG" for MsG */
+		GT_create(&MSG_debugMask, "MS");	/* "MS" for MSg */
 	}
 
 	cRefs++;
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index f3c429c..79f7505 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -893,7 +893,7 @@ bool NLDR_Init(void)
 
 	if (cRefs == 0) {
 		DBC_Assert(!NLDR_debugMask.flags);
-		GT_create(&NLDR_debugMask, "DL");	/* "DL" for DLdr */
+		GT_create(&NLDR_debugMask, "NL");	/* "NL" for NLdr */
 
 		RMM_init();
 	}
-- 
1.6.2.4

