From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address instead of user's
Date: Fri,  6 Nov 2009 14:34:21 +0200
Message-ID: <1257510861-18627-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63691 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237AbZKFMfU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 07:35:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, nm@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Based on the discussion:
  http://www.spinics.net/lists/arm-kernel/msg72810.html

HACK: export "follow_page()" for dspbridge cache operation

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |   76 +++++++++++++++++++++++++++++++---------
 mm/memory.c                    |    1 +
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index a75b64a..dc37beb 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -159,6 +159,8 @@
 #define PWR_TIMEOUT	 500	/* Sleep/wake timout in msec */
 #define EXTEND	      "_EXT_END"	/* Extmem end addr in DSP binary */
 
+#define DSP_CACHE_LINE 128
+
 extern char *iva_img;
 
 /*  ----------------------------------- Globals */
@@ -679,8 +681,48 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
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
+#ifdef CHECK_DSP_CACHE_LINE
+	if ((start & DSP_CACHE_LINE) || (len & DSP_CACHE_LINE))
+		pr_warning("%s: not aligned: %08lx(%d)\n", __func__,
+			   start, len);
+#endif
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
+		offset = start & ~PAGE_SIZE;
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
@@ -690,14 +732,19 @@ static int memory_check_vma(unsigned long start, u32 len)
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
@@ -708,8 +755,6 @@ static int memory_check_vma(unsigned long start, u32 len)
 	if (!vma)
 		err = -EINVAL;
 
-	up_read(&current->mm->mmap_sem);
-
 	return err;
 }
 
@@ -734,18 +779,15 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 		goto err_out;
 	}
 
-	if (memory_check_vma((u32)pMpuAddr, ulSize)) {
-		GT_3trace(PROC_DebugMask, GT_7CLASS,
-			  "%s: InValid address parameters\n",
-			  __func__, pMpuAddr, ulSize);
+	down_read(&current->mm->mmap_sem);
+
+	if (memory_sync_vma((u32)pMpuAddr, ulSize, FlushMemType)) {
+		pr_err("%s: InValid address parameters %p %x\n",
+		       __func__, pMpuAddr, ulSize);
 		status = DSP_EHANDLE;
-		goto err_out;
 	}
 
-	(void)SYNC_EnterCS(hProcLock);
-	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
-	(void)SYNC_LeaveCS(hProcLock);
-
+	up_read(&current->mm->mmap_sem);
 err_out:
 	GT_2trace(PROC_DebugMask, GT_ENTER,
 		  "Leaving %s [0x%x]", __func__, status);
diff --git a/mm/memory.c b/mm/memory.c
index 164951c..e9dc657 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1110,6 +1110,7 @@ no_page_table:
 	}
 	return page;
 }
+EXPORT_SYMBOL_GPL(follow_page);
 
 /* Can we do the FOLL_ANON optimization? */
 static inline int use_zero_page(struct vm_area_struct *vma)
-- 
1.6.0.4

