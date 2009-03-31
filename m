From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Logical code cleanup in bridge_open()
Date: Tue, 31 Mar 2009 18:01:51 +0300
Message-ID: <1238511711-6472-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36975 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555AbZCaPCA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 11:02:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index d9504cc..350e1b5 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -585,7 +585,7 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	DSP_STATUS dsp_status = DSP_SOK;
 	HANDLE	     hDrvObject = NULL;
 	struct PROCESS_CONTEXT    *pPctxt = NULL;
-	struct PROCESS_CONTEXT	*pTmp = NULL;
+	struct PROCESS_CONTEXT	*next_node = NULL;
 	struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
 	struct PROCESS_CONTEXT    *pCtxttraverse = NULL;
 	struct task_struct *tsk = NULL;
@@ -600,6 +600,7 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
 	while (pCtxtclosed != NULL) {
 		tsk = find_task_by_vpid(pCtxtclosed->pid);
+		next_node = pCtxtclosed->next;
 
 		if ((tsk == NULL) || (tsk->exit_state == EXIT_ZOMBIE)) {
 
@@ -637,14 +638,11 @@ static int bridge_open(struct inode *ip, struct file *filp)
 					}
 				}
 			}
-			pTmp = pCtxtclosed->next;
 			DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
 					     pCtxtclosed,
 					     (void *)pCtxtclosed->pid);
-		} else {
-			pTmp = pCtxtclosed->next;
 		}
-		pCtxtclosed = pTmp;
+		pCtxtclosed = next_node;
 	}
 func_cont:
 	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-- 
1.6.2.1

