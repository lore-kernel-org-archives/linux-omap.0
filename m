From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/2] DSPBRIDGE: introduce VMA checking for cache operation
Date: Wed, 22 Jul 2009 11:22:50 +0300
Message-ID: <1248250970-417-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1248250970-417-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21785 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbZGVIXL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 04:23:11 -0400
In-Reply-To: <1248250970-417-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, ameya.palande@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, h-kanigeri2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Check if the given area blongs to process virtul memory address space.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 3a2879f..fe9dabf 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -735,6 +735,30 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
 	return status;
 }
 
+/* Check if the given area blongs to process virtul memory address space */
+static int memory_check_vma(unsigned long start, u32 len)
+{
+	int err = 0;
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	len = PAGE_ALIGN(len);
+	end = start + len;
+	if (end <= start)
+		return -EINVAL;
+
+	down_read(&current->mm->mmap_sem);
+
+	vma = find_vma(current->mm, start);
+	if (!vma || start < vma->vm_start) {
+		pr_err("%s: no vma for %08lx %08lx\n", __func__, start, end);
+		err = -EINVAL;
+	}
+
+	up_read(&current->mm->mmap_sem);
+
+	return err;
+}
 
 static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 				   u32 ulSize, u32 ulFlags,
@@ -757,6 +781,14 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 		goto err_out;
 	}
 
+	if (memory_check_vma((u32)pMpuAddr, ulSize)) {
+		GT_3trace(PROC_DebugMask, GT_7CLASS,
+			  "%s: InValid address parameters\n",
+			  __func__, pMpuAddr, ulSize);
+		status = DSP_EHANDLE;
+		goto err_out;
+	}
+
 	(void)SYNC_EnterCS(hProcLock);
 	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
 	(void)SYNC_LeaveCS(hProcLock);
-- 
1.6.0.4

