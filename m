From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 3/3] DSPBRIDGE: Get rid of MEM_VFree()
Date: Thu,  4 Feb 2010 01:32:26 +0200
Message-ID: <3240b3d882542163a213b63e345f71a9d2308806.1265239075.git.ameya.palande@nokia.com>
References: <cover.1265239075.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23029 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757886Ab0BCXck (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 18:32:40 -0500
In-Reply-To: <cover.1265239075.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1265239075.git.ameya.palande@nokia.com>
References: <cover.1265239075.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, nm@ti.com, deepak.chitriki@ti.com

vfree() is NULL safe so MEM_VFree() doesn't provide any significant
advantage. By getting rid of MEM_VFree() and the NULL pointer check
associated with it, we can save on:
1. One level of indirection which translates to a function call cost.
2. NULL pointer checking cost.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/mem.h |   17 -----------------
 drivers/dsp/bridge/pmgr/dmm.c              |    3 +--
 drivers/dsp/bridge/services/mem.c          |   17 -----------------
 3 files changed, 1 insertions(+), 36 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 3b94c02..afc15a9 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -140,23 +140,6 @@
 	extern void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 FlushType);
 
 /*
- *  ======== MEM_VFree ========
- *  Purpose:
- *      Free the given block of system memory in virtual space.
- *  Parameters:
- *      pMemBuf:    Pointer to memory allocated by MEM_Calloc/Alloc()
- *		    using vmalloc.
- *  Returns:
- *  Requires:
- *      MEM initialized.
- *      pMemBuf is a valid memory address returned by MEM_Calloc/Alloc()
- *	using vmalloc.
- *  Ensures:
- *      pMemBuf is no longer a valid pointer to memory.
- */
-	extern void MEM_VFree(IN void *pMemBuf);
-
-/*
  *  ======== MEM_FreePhysMem ========
  *  Purpose:
  *      Free the given block of physically contiguous memory.
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index d5a7275..2425f0f 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -220,8 +220,7 @@ DSP_STATUS DMM_DeleteTables(struct DMM_OBJECT *hDmmMgr)
 		/* Delete all DMM tables */
 		SYNC_EnterCS(pDmmObj->hDmmLock);
 
-		if (pVirtualMappingTable != NULL)
-			MEM_VFree(pVirtualMappingTable);
+		vfree(pVirtualMappingTable);
 
 		SYNC_LeaveCS(pDmmObj->hDmmLock);
 	} else
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 614396e..57f1794 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -292,23 +292,6 @@ void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 FlushType)
 }
 
 /*
- *  ======== MEM_VFree ========
- *  Purpose:
- *      Free the given block of system memory in virtual space.
- */
-void MEM_VFree(IN void *pMemBuf)
-{
-	DBC_Require(pMemBuf != NULL);
-
-	GT_1trace(MEM_debugMask, GT_ENTER, "MEM_VFree: pMemBufs 0x%x\n",
-		  pMemBuf);
-
-	if (pMemBuf) {
-		vfree(pMemBuf);
-	}
-}
-
-/*
  *  ======== MEM_FreePhysMem ========
  *  Purpose:
  *      Free the given block of physically contiguous memory.
-- 
1.6.3.3

