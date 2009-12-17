From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCHv2 14/18] DSPBRIDGE: check pointer before calling Proc_Detach
Date: Wed, 16 Dec 2009 20:15:59 -0600
Message-ID: <1261016163-11091-15-git-send-email-omar.ramirez@ti.com>
References: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-2-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-3-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-4-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-5-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-6-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-7-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-8-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-9-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-10-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-11-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-12-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-13-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-14-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36709 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763917AbZLQCIt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 21:08:49 -0500
In-Reply-To: <1261016163-11091-14-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

From: Ernest Ramos Falcon <ernesto@ti.com>

This patch adds a check before calling Proc_Detach, otherwise
we will see an error.

Signed-off-by: Ernest Ramos Falcon <ernesto@ti.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index a2df832..6415955 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -592,7 +592,8 @@ static int bridge_release(struct inode *ip, struct file *filp)
 		if (DSP_SUCCEEDED(dsp_status)) {
 			flush_signals(current);
 			DRV_RemoveAllResources(pr_ctxt);
-			PROC_Detach(pr_ctxt->hProcessor);
+			if (pr_ctxt->hProcessor)
+				PROC_Detach(pr_ctxt->hProcessor);
 			DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
 					pr_ctxt, (void *)pr_ctxt->pid);
 		} else {
-- 
1.6.2.4

