From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address
 instead of user's
Date: Tue, 17 Nov 2009 08:41:08 +0200 (EET)
Message-ID: <20091117.084108.193702761.Hiroshi.DOYU@nokia.com>
References: <1257510861-18627-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<20091113.121212.189727725.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44173 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbZKQGlf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 01:41:35 -0500
In-Reply-To: <20091113.121212.189727725.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, omar.ramirez@ti.com
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, nm@ti.com, Miguel.Verdu@nokia.com, bshah@ti.com, rmk@arm.linux.org.uk, imre.deak@nokia.com

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address instead of user's
Date: Fri, 13 Nov 2009 12:12:12 +0200 (EET)

> From: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
> Subject: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address instead of user's
> Date: Fri, 6 Nov 2009 13:34:21 +0100
> 
> > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > 
> > Based on the discussion:
> >   http://www.spinics.net/lists/arm-kernel/msg72810.html
> > 
> > HACK: export "follow_page()" for dspbridge cache operation
> > 
> > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > ---

Now there's no need for homebrewed cache function because we use
kernel address and can pass "virt_addr_valid()" check in
"dma_cache_maint()".

"dma_cache_maint()" shouldn't be used directly because of DMABOUNCE
support but this can be fixed later.

>From 949a76946359bb5dbf2b488dfe30315780b53183 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Mon, 16 Nov 2009 19:00:29 +0200
Subject: [PATCH 1/1] DSPBRIDGE: replace homebrewed cache func with kernel API

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Use "dma_cache_maint()" instead of "MEM_FlushCache()"

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    1 +
 arch/arm/plat-omap/include/dspbridge/mem.h    |   16 -----------
 drivers/dsp/bridge/rmgr/proc.c                |   23 +++++++++++----
 drivers/dsp/bridge/services/mem.c             |   37 -------------------------
 4 files changed, 18 insertions(+), 59 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 78be880..d4035b3 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -305,6 +305,7 @@
 		PROC_INVALIDATE_MEM = 0,
 		PROC_WRITEBACK_MEM,
 		PROC_WRITEBACK_INVALIDATE_MEM,
+		PROC_FLUSHTYPE_MAX = PROC_WRITEBACK_INVALIDATE_MEM
 	} ;
 
 /* Memory Segment Status Values */
diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 4e43f21..0f0beca 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -27,7 +27,6 @@
  *      MEM_AllocPhysMem
  *      MEM_Calloc
  *      MEM_Exit
- *      MEM_FlushCache
  *      MEM_Free
  *      MEM_FreeObject
  *      MEM_FreePhysMem
@@ -173,21 +172,6 @@
 	extern void MEM_Exit(void);
 
 /*
- *  ======== MEM_FlushCache ========
- *  Purpose:
- *      Performs system cache sync with discard
- *  Parameters:
- *      pMemBuf:    Pointer to memory region to be flushed.
- *      pMemBuf:    Size of the memory region to be flushed.
- *  Returns:
- *  Requires:
- *      MEM is initialized.
- *  Ensures:
- *      Cache is synchronized
- */
-	extern void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 FlushType);
-
-/*
  *  ======== MEM_Free ========
  *  Purpose:
  *      Free the given block of system memory.
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index c195b6f..9345a7a 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -683,7 +683,7 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
 
 /* Cache operation against kernel address instead of users */
 static int memory_sync_page(struct vm_area_struct *vma, unsigned long start,
-			    ssize_t len, enum DSP_FLUSHTYPE ftype)
+			    ssize_t len, int dir)
 {
 	struct page *page;
 	void *kaddr;
@@ -710,7 +710,7 @@ static int memory_sync_page(struct vm_area_struct *vma, unsigned long start,
 		kaddr = page_address(page) + offset;
 		rest = min_t(ssize_t, PAGE_SIZE - offset, len);
 
-		MEM_FlushCache(kaddr, rest, ftype);
+		dma_cache_maint(kaddr, rest, dir);
 
 		put_page(page);
 		len -= rest;
@@ -721,8 +721,7 @@ static int memory_sync_page(struct vm_area_struct *vma, unsigned long start,
 }
 
 /* Check if the given area blongs to process virtul memory address space */
-static int memory_sync_vma(unsigned long start, u32 len,
-			   enum DSP_FLUSHTYPE ftype)
+static int memory_sync_vma(unsigned long start, u32 len, int dir)
 {
 	int err = 0;
 	unsigned long end;
@@ -742,7 +741,7 @@ static int memory_sync_vma(unsigned long start, u32 len,
 			return -EINVAL;
 
 		size = min_t(ssize_t, vma->vm_end - start, len);
-		err = memory_sync_page(vma, start, size, ftype);
+		err = memory_sync_page(vma, start, size, dir);
 		if (err)
 			break;
 
@@ -765,6 +764,7 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 	/* Keep STATUS here for future additions to this function */
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
+	int dir;
 
 	DBC_Require(cRefs > 0);
 	GT_5trace(PROC_DebugMask, GT_ENTER,
@@ -779,9 +779,20 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 		goto err_out;
 	}
 
+	/*
+	 * PROC_INVALIDATE_MEM		(0) : DMA_FROM_DEVICE  (2)
+	 * PROC_WRITEBACK_MEM		(1) : DMA_TO_DEVICE    (1)
+	 * PROC_WRITEBACK_INVALIDATE_MEM(2) : DMA_BIDIRECTIONAL(0)
+	 */
+	if (FlushMemType > PROC_FLUSHTYPE_MAX) {
+		status = DSP_EHANDLE;
+		goto err_out;
+	}
+	dir = (FlushMemType & 1) ? 1 : (~FlushMemType & 2);
+
 	down_read(&current->mm->mmap_sem);
 
-	if (memory_sync_vma((u32)pMpuAddr, ulSize, FlushMemType)) {
+	if (memory_sync_vma((u32)pMpuAddr, ulSize, dir)) {
 		pr_err("%s: InValid address parameters %p %x\n",
 		       __func__, pMpuAddr, ulSize);
 		status = DSP_EHANDLE;
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 22f382b..fba14ab 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -25,7 +25,6 @@
  *      MEM_AllocPhysMem
  *      MEM_Calloc
  *      MEM_Exit
- *      MEM_FlushCache
  *      MEM_Free
  *      MEM_FreePhysMem
  *      MEM_Init
@@ -465,42 +464,6 @@ void MEM_Exit(void)
 }
 
 /*
- *  ======== MEM_FlushCache ========
- *  Purpose:
- *      Flush cache
- */
-void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 FlushType)
-{
-	DBC_Require(cRefs > 0);
-
-	switch (FlushType) {
-	/* invalidate only */
-	case PROC_INVALIDATE_MEM:
-		dmac_inv_range(pMemBuf, pMemBuf + cBytes);
-		outer_inv_range(__pa((u32)pMemBuf), __pa((u32)pMemBuf +
-				cBytes));
-	break;
-	/* writeback only */
-	case PROC_WRITEBACK_MEM:
-		dmac_clean_range(pMemBuf, pMemBuf + cBytes);
-		outer_clean_range(__pa((u32)pMemBuf), __pa((u32)pMemBuf +
-				  cBytes));
-	break;
-	/* writeback and invalidate */
-	case PROC_WRITEBACK_INVALIDATE_MEM:
-		dmac_flush_range(pMemBuf, pMemBuf + cBytes);
-		outer_flush_range(__pa((u32)pMemBuf), __pa((u32)pMemBuf +
-				  cBytes));
-	break;
-	default:
-		GT_1trace(MEM_debugMask, GT_6CLASS, "MEM_FlushCache: invalid "
-			  "FlushMemType 0x%x\n", FlushType);
-	break;
-	}
-
-}
-
-/*
  *  ======== MEM_VFree ========
  *  Purpose:
  *      Free the given block of system memory in virtual space.
-- 
1.6.0.4

