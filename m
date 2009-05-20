From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 08/14] DSPBRIDGE: trivial spacing cleanup for memory module
Date: Wed, 20 May 2009 00:02:14 -0500
Message-ID: <1242795740-21535-8-git-send-email-x00omar@ti.com>
References: <1242795740-21535-1-git-send-email-x00omar@ti.com>
 <1242795740-21535-2-git-send-email-x00omar@ti.com>
 <1242795740-21535-3-git-send-email-x00omar@ti.com>
 <1242795740-21535-4-git-send-email-x00omar@ti.com>
 <1242795740-21535-5-git-send-email-x00omar@ti.com>
 <1242795740-21535-6-git-send-email-x00omar@ti.com>
 <1242795740-21535-7-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57567 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312AbZETE6e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 00:58:34 -0400
In-Reply-To: <1242795740-21535-7-git-send-email-x00omar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Omar Ramirez Luna <omar.ramirez@ti.com>, Omar Ramirez Luna <x00omar@ti.com>

From: Omar Ramirez Luna <omar.ramirez@ti.com>

trivial spacing cleanup for memory module

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---
 drivers/dsp/bridge/services/mem.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 0a10304..47ec09b 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -281,11 +281,11 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
 		/* If non-paged memory required, see note at top of file. */
 		case MEM_PAGED:
 #ifndef MEM_CHECK
-                                  pMem = kmalloc(cBytes,
-                                              (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
+			pMem = kmalloc(cBytes,
+				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
 #else
 			pMem = kmalloc(cBytes + sizeof(struct memInfo),
-                                              (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
+				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
 			if (pMem) {
 				pMem->size = cBytes;
 				pMem->caller = __builtin_return_address(0);
@@ -304,12 +304,12 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
 		case MEM_LARGEVIRTMEM:
 #ifndef MEM_CHECK
 			/* FIXME - Replace with 'vmalloc' after BP fix */
-                                  pMem = __vmalloc(cBytes,
-                                  (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
+			pMem = __vmalloc(cBytes,
+				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
 #else
 			/* FIXME - Replace with 'vmalloc' after BP fix */
 			pMem = __vmalloc((cBytes + sizeof(struct memInfo)),
-                                  (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
+				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
 			if (pMem) {
 				pMem->size = cBytes;
 				pMem->caller = __builtin_return_address(0);
@@ -359,7 +359,7 @@ void *MEM_AllocPhysMem(u32 cBytes, u32 ulAlign, OUT u32 *pPhysicalAddress)
 						    (u32 *)&paMem);
 		} else
 			pVaMem = dma_alloc_coherent(NULL, cBytes, &paMem,
-                                              (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
+				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
 		if (pVaMem == NULL) {
 			*pPhysicalAddress = 0;
 			GT_1trace(MEM_debugMask, GT_6CLASS,
@@ -391,14 +391,14 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
 		/* If non-paged memory required, see note at top of file. */
 		case MEM_PAGED:
 #ifndef MEM_CHECK
-                                  pMem = kmalloc(cBytes,
-                                              (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
+			pMem = kmalloc(cBytes,
+				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
 			if (pMem)
 				memset(pMem, 0, cBytes);
 
 #else
 			pMem = kmalloc(cBytes + sizeof(struct memInfo),
-                                              (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
+				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
 			if (pMem) {
 				memset((void *)((u32)pMem +
 					sizeof(struct memInfo)), 0, cBytes);
@@ -417,15 +417,15 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
 		case MEM_LARGEVIRTMEM:
 #ifndef MEM_CHECK
 			/* FIXME - Replace with 'vmalloc' after BP fix */
-                                  pMem = __vmalloc(cBytes,
-                                  (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
+			pMem = __vmalloc(cBytes,
+				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
 			if (pMem)
 				memset(pMem, 0, cBytes);
 
 #else
 			/* FIXME - Replace with 'vmalloc' after BP fix */
 			pMem = __vmalloc(cBytes + sizeof(struct memInfo),
-                                  (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
+				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
 			if (pMem) {
 				memset((void *)((u32)pMem +
 					sizeof(struct memInfo)), 0, cBytes);
-- 
1.6.2.4

