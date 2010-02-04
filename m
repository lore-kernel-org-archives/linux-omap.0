From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: check pointer before calling Proc_Detach
Date: Thu,  4 Feb 2010 15:17:33 -0600
Message-ID: <1265318253-20308-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48056 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560Ab0BDVGG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 16:06:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Ernest Ramos Falcon <ernesto@ti.com>

From: Ernest Ramos Falcon <ernesto@ti.com>

This patch adds a check before calling Proc_Detach, otherwise
in case a failure occurs on PROC_Attach and hProcessor is
invalid when the userspace task closes its handle, unexpected
behavior might be seen as this pointer is dereferenced in
PROC_Detach.

Signed-off-by: Ernest Ramos Falcon <ernesto@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 32aff66..b0f0d93 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -539,7 +539,8 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	pr_ctxt = filp->private_data;
 	flush_signals(current);
 	DRV_RemoveAllResources(pr_ctxt);
-	PROC_Detach(pr_ctxt);
+	if (pr_ctxt->hProcessor)
+		PROC_Detach(pr_ctxt);
 	MEM_Free(pr_ctxt);
 
 	filp->private_data = NULL;
-- 
1.6.2.4

