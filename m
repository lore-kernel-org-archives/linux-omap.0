From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v2 5/7] DSPBRIDGE: remove mem_flush_cache
Date: Mon, 24 May 2010 19:05:16 +0300
Message-ID: <1274717118-15226-6-git-send-email-ohad@wizery.com>
References: <1274717118-15226-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64406 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757714Ab0EXQGR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 12:06:17 -0400
Received: by mail-bw0-f46.google.com with SMTP id 7so1076486bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 09:06:16 -0700 (PDT)
In-Reply-To: <1274717118-15226-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Now that we use standard DMA API instead of low level cache
manipulation API, mem_flush_cache can be removed.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at <  ohadb at ti dot com  >.

 arch/arm/plat-omap/include/dspbridge/drv.h |   15 ------------
 drivers/dsp/bridge/rmgr/drv.c              |   33 ----------------------------
 2 files changed, 0 insertions(+), 48 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 3186935..2eeb47f 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -466,21 +466,6 @@ extern void *mem_alloc_phys_mem(IN u32 byte_size,
 				IN u32 ulAlign, OUT u32 *pPhysicalAddress);
 
 /*
- *  ======== mem_flush_cache ========
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
-extern void mem_flush_cache(void *pMemBuf, u32 byte_size, s32 FlushType);
-
-/*
  *  ======== mem_free_phys_mem ========
  *  Purpose:
  *      Free the given block of physically contiguous memory.
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index a8e711a..6ffae0b 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1039,39 +1039,6 @@ void *mem_alloc_phys_mem(u32 byte_size, u32 ulAlign, OUT u32 * pPhysicalAddress)
 }
 
 /*
- *  ======== mem_flush_cache ========
- *  Purpose:
- *      Flush cache
- */
-void mem_flush_cache(void *pMemBuf, u32 byte_size, s32 FlushType)
-{
-	if (!pMemBuf)
-		return;
-
-	switch (FlushType) {
-		/* invalidate only */
-	case PROC_INVALIDATE_MEM:
-		dmac_inv_range(pMemBuf, pMemBuf + byte_size);
-		outer_inv_range(__pa((u32) pMemBuf), __pa((u32) pMemBuf +
-							  byte_size));
-		break;
-		/* writeback only */
-	case PROC_WRITEBACK_MEM:
-		dmac_clean_range(pMemBuf, pMemBuf + byte_size);
-		outer_clean_range(__pa((u32) pMemBuf), __pa((u32) pMemBuf +
-							    byte_size));
-		break;
-		/* writeback and invalidate */
-	case PROC_WRITEBACK_INVALIDATE_MEM:
-		dmac_flush_range(pMemBuf, pMemBuf + byte_size);
-		outer_flush_range(__pa((u32) pMemBuf), __pa((u32) pMemBuf +
-							    byte_size));
-		break;
-	}
-
-}
-
-/*
  *  ======== mem_free_phys_mem ========
  *  Purpose:
  *      Free the given block of physically contiguous memory.
-- 
1.7.0.4

