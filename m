From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: cache operation against kernel address instead of user's
Date: Fri, 22 Jan 2010 22:26:12 -0600
Message-ID: <1264220772-11097-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51113 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697Ab0AWEPt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jan 2010 23:15:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Based on the discussion:
  http://www.spinics.net/lists/arm-kernel/msg72810.html

HACK: export "follow_page()" for dspbridge cache operation

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |   68 ++++++++++++++++++++++++++++++---------
 mm/memory.c                    |    1 +
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 491661f..eb4752d 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -574,8 +574,43 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
 	return status;
 }
 
+/* Cache operation against kernel address instead of users */
+static int memory_sync_page(struct vm_area_struct *vma, unsigned long start,
+			    ssize_t len, enum DSP_FLUSHTYPE ftype)
+{
+	struct page *page;
+	void *kaddr;
+	unsigned long offset;
+	ssize_t rest;
+
+	while (len) {
+		page = follow_page(vma, start, FOLL_GET);
+		if (!page) {
+			pr_err("%s: no page for %08lx\n", __func__, start);
+			return -EINVAL;
+		} else if (IS_ERR(page)) {
+			pr_err("%s: err page for %08lx(%lu)\n", __func__, start,
+			       IS_ERR(page));
+			return IS_ERR(page);
+		}
+
+		offset = start & ~PAGE_MASK;
+		kaddr = page_address(page) + offset;
+		rest = min_t(ssize_t, PAGE_SIZE - offset, len);
+
+		MEM_FlushCache(kaddr, rest, ftype);
+
+		put_page(page);
+		len -= rest;
+		start += rest;
+	}
+
+	return 0;
+}
+
 /* Check if the given area blongs to process virtul memory address space */
-static int memory_check_vma(unsigned long start, u32 len)
+static int memory_sync_vma(unsigned long start, u32 len,
+			   enum DSP_FLUSHTYPE ftype)
 {
 	int err = 0;
 	unsigned long end;
@@ -585,14 +620,19 @@ static int memory_check_vma(unsigned long start, u32 len)
 	if (end <= start)
 		return -EINVAL;
 
-	down_read(&current->mm->mmap_sem);
-
 	while ((vma = find_vma(current->mm, start)) != NULL) {
+		ssize_t size;
 
-		if (vma->vm_start > start) {
-			err = -EINVAL;
+		if (vma->vm_flags & (VM_IO | VM_PFNMAP))
+			return -EINVAL;
+
+		if (vma->vm_start > start)
+			return -EINVAL;
+
+		size = min_t(ssize_t, vma->vm_end - start, len);
+		err = memory_sync_page(vma, start, size, ftype);
+		if (err)
 			break;
-		}
 
 		if (end <= vma->vm_end)
 			break;
@@ -603,8 +643,6 @@ static int memory_check_vma(unsigned long start, u32 len)
 	if (!vma)
 		err = -EINVAL;
 
-	up_read(&current->mm->mmap_sem);
-
 	return err;
 }
 
@@ -629,17 +667,15 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 		goto err_out;
 	}
 
-	if (memory_check_vma((u32)pMpuAddr, ulSize)) {
-		GT_3trace(PROC_DebugMask, GT_7CLASS,
-			  "%s: InValid address parameters\n",
-			  __func__, pMpuAddr, ulSize);
+	down_read(&current->mm->mmap_sem);
+
+	if (memory_sync_vma((u32)pMpuAddr, ulSize, ulFlags)) {
+		pr_err("%s: InValid address parameters %p %x\n",
+		       __func__, pMpuAddr, ulSize);
 		status = DSP_EHANDLE;
-		goto err_out;
 	}
 
-	(void)SYNC_EnterCS(hProcLock);
-	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
-	(void)SYNC_LeaveCS(hProcLock);
+	up_read(&current->mm->mmap_sem);
 
 err_out:
 	GT_2trace(PROC_DebugMask, GT_ENTER,
diff --git a/mm/memory.c b/mm/memory.c
index 6ab19dd..377be88 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1228,6 +1228,7 @@ no_page_table:
 		return ERR_PTR(-EFAULT);
 	return page;
 }
+EXPORT_SYMBOL_GPL(follow_page);
 
 int __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		     unsigned long start, int nr_pages, unsigned int gup_flags,
-- 
1.6.2.4

