From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 5/7] DSPBRIDGE: remove mem_flush_cache
Date: Thu, 27 May 2010 19:02:12 +0300
Message-ID: <1274976134-22769-6-git-send-email-ohad@wizery.com>
References: <1274976134-22769-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14152 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759186Ab0E0QCm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 12:02:42 -0400
Received: by fg-out-1718.google.com with SMTP id d23so83476fga.1
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 09:02:42 -0700 (PDT)
In-Reply-To: <1274976134-22769-1-git-send-email-ohad@wizery.com>
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

