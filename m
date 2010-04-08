From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 04/13] DSPBRIDGE: Moving macros from mem.h to drv.h
Date: Thu, 8 Apr 2010 18:54:05 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB09548F6481D6@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43593 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933823Ab0DHXyM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 19:54:12 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From c1d6a6f9f372853943c94cf5471f0d2ca7a6b384 Mon Sep 17 00:00:00 2001
From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Date: Thu, 25 Mar 2010 18:39:55 -0600
Subject: [PATCH 04/13] DSPBRIDGE: Moving macros from mem.h to drv.h

Since mem.h file is going to be deleted, the following
macros are moved to drv.h:

MEM_LINEAR_ADDRESS
MEM_UNMAP_LINEAR_ADDRESS

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h |   33 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/dspbridge/mem.h |   33 ----------------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index eeb5e23..b4bea17 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -468,4 +468,37 @@ extern void mem_flush_cache(void *pMemBuf, u32 byte_size, s32 FlushType);
 extern void mem_free_phys_mem(void *pVirtualAddress,
 			      u32 pPhysicalAddress, u32 byte_size);
 
+/*
+ *  ======== MEM_LINEAR_ADDRESS ========
+ *  Purpose:
+ *      Get the linear address corresponding to the given physical address.
+ *  Parameters:
+ *      pPhysAddr:  Physical address to be mapped.
+ *      byte_size:     Number of bytes in physical range to map.
+ *  Returns:
+ *      The corresponding linear address, or NULL if unsuccessful.
+ *  Requires:
+ *      MEM initialized.
+ *  Ensures:
+ *  Notes:
+ *      If valid linear address is returned, be sure to call
+ *      MEM_UNMAP_LINEAR_ADDRESS().
+ */
+#define MEM_LINEAR_ADDRESS(pPhyAddr, byte_size) pPhyAddr
+
+/*
+ *  ======== MEM_UNMAP_LINEAR_ADDRESS ========
+ *  Purpose:
+ *      Unmap the linear address mapped in MEM_LINEAR_ADDRESS.
+ *  Parameters:
+ *      pBaseAddr: Ptr to mapped memory (as returned by MEM_LINEAR_ADDRESS()).
+ *  Returns:
+ *  Requires:
+ *      - MEM initialized.
+ *      - pBaseAddr is a valid linear address mapped in MEM_LINEAR_ADDRESS.
+ *  Ensures:
+ *      - pBaseAddr no longer points to a valid linear address.
+ */
+#define MEM_UNMAP_LINEAR_ADDRESS(pBaseAddr) {}
+
 #endif /* DRV_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 374b971..9f713b9 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -166,37 +166,4 @@ extern bool services_mem_init(void);
 #define MEM_IS_VALID_HANDLE(hObj, Sig)                \
      ((hObj != NULL) && (hObj->dw_signature == Sig))
 
-/*
- *  ======== MEM_LINEAR_ADDRESS ========
- *  Purpose:
- *      Get the linear address corresponding to the given physical address.
- *  Parameters:
- *      pPhysAddr:  Physical address to be mapped.
- *      byte_size:     Number of bytes in physical range to map.
- *  Returns:
- *      The corresponding linear address, or NULL if unsuccessful.
- *  Requires:
- *      MEM initialized.
- *  Ensures:
- *  Notes:
- *      If valid linear address is returned, be sure to call
- *      MEM_UNMAP_LINEAR_ADDRESS().
- */
-#define MEM_LINEAR_ADDRESS(pPhyAddr, byte_size) pPhyAddr
-
-/*
- *  ======== MEM_UNMAP_LINEAR_ADDRESS ========
- *  Purpose:
- *      Unmap the linear address mapped in MEM_LINEAR_ADDRESS.
- *  Parameters:
- *      pBaseAddr: Ptr to mapped memory (as returned by MEM_LINEAR_ADDRESS()).
- *  Returns:
- *  Requires:
- *      - MEM initialized.
- *      - pBaseAddr is a valid linear address mapped in MEM_LINEAR_ADDRESS.
- *  Ensures:
- *      - pBaseAddr no longer points to a valid linear address.
- */
-#define MEM_UNMAP_LINEAR_ADDRESS(pBaseAddr) {}
-
 #endif /* MEM_ */
-- 
1.7.0.3

