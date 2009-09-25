From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] DSPBRIDGE: protect cache operation with mmap read semaphore
Date: Fri, 25 Sep 2009 10:09:41 +0300
Message-ID: <1253862581-22173-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49785 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbZIYHKI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 03:10:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

There was potential risk that VMA mapping can be changed before cache
operation. To prevent this, we'll hold mmap read semaphore until cache
operation finishes.

This case assumes that pages in this ranges have been populated by
get_user_pages() and also marked as MLOCKED, which has to be ensured
by userland application(dsp client), unfortunately.

This patch may solve some kernel crashes at "v7_dma_cache_*()"
functions.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index a75b64a..45cd04b 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -690,8 +690,6 @@ static int memory_check_vma(unsigned long start, u32 len)
 	if (end <= start)
 		return -EINVAL;
 
-	down_read(&current->mm->mmap_sem);
-
 	while ((vma = find_vma(current->mm, start)) != NULL) {
 
 		if (vma->vm_start > start) {
@@ -708,8 +706,6 @@ static int memory_check_vma(unsigned long start, u32 len)
 	if (!vma)
 		err = -EINVAL;
 
-	up_read(&current->mm->mmap_sem);
-
 	return err;
 }
 
@@ -734,18 +730,22 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 		goto err_out;
 	}
 
+	down_read(&current->mm->mmap_sem);
+
 	if (memory_check_vma((u32)pMpuAddr, ulSize)) {
 		GT_3trace(PROC_DebugMask, GT_7CLASS,
 			  "%s: InValid address parameters\n",
 			  __func__, pMpuAddr, ulSize);
 		status = DSP_EHANDLE;
-		goto err_out;
+		goto err_mem_check;
 	}
 
 	(void)SYNC_EnterCS(hProcLock);
 	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
 	(void)SYNC_LeaveCS(hProcLock);
 
+err_mem_check:
+	up_read(&current->mm->mmap_sem);
 err_out:
 	GT_2trace(PROC_DebugMask, GT_ENTER,
 		  "Leaving %s [0x%x]", __func__, status);
-- 
1.6.0.4

