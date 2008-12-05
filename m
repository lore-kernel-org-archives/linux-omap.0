From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: Freeing allocated resources on
 rmmod
Date: Fri, 5 Dec 2008 00:55:01 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F1E9A961@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60810 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbYLEGzM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 01:55:12 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

From: Omar Ramirez Luna <x00omar@ti.com>
Date: Thu, 27 Nov 2008 02:40:50 -0600
Subject: [PATCH] DSPBRIDGE: Freeing allocated resources on rmmod

This patch implements the cleanup of allocated resources
whenever the module is removed from the kernel.

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   40 +++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 drivers/dsp/bridge/rmgr/drv_interface.c

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
old mode 100644
new mode 100755
index 7e81f6f..b7a999f
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -496,8 +496,48 @@ static void __exit bridge_exit(void)
 {
 	dev_t devno;
 	bool ret;
+	DSP_STATUS dsp_status = DSP_SOK;
+	HANDLE	     hDrvObject = NULL;
+	struct PROCESS_CONTEXT	*pTmp = NULL;
+	struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
+	struct PROCESS_CONTEXT    *pCtxttraverse = NULL;
+
 	GT_0trace(driverTrace, GT_ENTER, "-> driver_exit\n");
 
+	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
+	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
+	while (pCtxtclosed != NULL) {
+		DRV_RemoveAllResources(pCtxtclosed);
+		if (pCtxtclosed->hProcessor != NULL) {
+			DRV_GetProcCtxtList(&pCtxttraverse,
+					    (struct DRV_OBJECT *)hDrvObject);
+			if (pCtxttraverse->next == NULL) {
+				PROC_Detach(pCtxtclosed->hProcessor);
+				goto func_cont;
+			}
+			if ((pCtxtclosed->pid == pCtxttraverse->pid) &&
+			   (pCtxttraverse->next != NULL)) {
+				pCtxttraverse =	pCtxttraverse->next;
+			}
+			while ((pCtxttraverse != NULL) &&
+			      (pCtxtclosed->hProcessor
+			      != pCtxttraverse->hProcessor)) {
+				pCtxttraverse =	pCtxttraverse->next;
+				if ((pCtxttraverse != NULL) &&
+				   (pCtxtclosed->pid == pCtxttraverse->pid)) {
+					pCtxttraverse = pCtxttraverse->next;
+				}
+			}
+			if (pCtxttraverse == NULL)
+				PROC_Detach(pCtxtclosed->hProcessor);
+		}
+func_cont:
+		pTmp = pCtxtclosed->next;
+		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
+				     pCtxtclosed, (void *)pCtxtclosed->pid);
+		pCtxtclosed = pTmp;
+	}
+
 	/* unregister the clock notifier */
 #ifdef CONFIG_BRIDGE_DVFS
 	if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
-- 
1.6.0
