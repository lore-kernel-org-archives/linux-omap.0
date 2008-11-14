From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 4/5][omapzoom] BRIDGE Memory leak fix
Date: Thu, 13 Nov 2008 20:13:49 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303E11EBF3F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40191 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbYKNCNz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 21:13:55 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAE2Dn4n002604
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 20:13:54 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAE2Dn5q002313
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 20:13:49 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Fri, 31 Oct 2008 21:32:07 -0500
Subject: [PATCH] BRIDGE Memory leak fix

There is a memory leak when loading a new base image.

Installing and uninstalling the bridge driver on ARM side for over
10^5 number of times, resulted in the system becoming unstable
after that.

The PROC_OBJECT structure is being freed without freeing
the memory held by the internal pointer g_pszLastCoff.

Bug details reported by Lam SuiLun.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 5bc87a7..eb7781d 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -641,6 +641,11 @@ DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor)
 		if (pProcObject->hNtfy)
 			NTFY_Delete(pProcObject->hNtfy);
 
+		if (pProcObject->g_pszLastCoff) {
+			MEM_Free(pProcObject->g_pszLastCoff);
+			pProcObject->g_pszLastCoff = NULL;
+		}
+
 		/* Remove the Proc from the DEV List */
 		(void)DEV_RemoveProcObject(pProcObject->hDevObject,
 			(u32)pProcObject);
-- 
1.6.0
