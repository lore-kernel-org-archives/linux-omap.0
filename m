From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: Remove GT_TRACE conditional macro
Date: Tue, 23 Feb 2010 11:05:43 -0600
Message-ID: <1266944743-989-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58376 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130Ab0BWQ5q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 11:57:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove GT_TRACE conditional macro

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbc.h |   14 --------------
 drivers/dsp/bridge/Makefile                |    5 -----
 drivers/dsp/bridge/rmgr/drv.c              |    2 --
 drivers/dsp/bridge/rmgr/drv_interface.c    |    2 --
 4 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
index c4bf803..4ed8f72 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
@@ -25,13 +25,7 @@
 #ifndef DBC_
 #define DBC_
 
-#ifndef GT_TRACE
-#define GT_TRACE 0	    /* 0 = "trace compiled out"; 1 = "trace active" */
-#endif
-
 /* Assertion Macros: */
-#if GT_TRACE
-
 #define DBC_Assert(exp) \
     if (!(exp)) \
 	pr_err("%s, line %d: Assertion (" #exp ") failed.\n", \
@@ -39,12 +33,4 @@
 #define DBC_Require DBC_Assert	/* Function Precondition.  */
 #define DBC_Ensure  DBC_Assert	/* Function Postcondition. */
 
-#else
-
-#define DBC_Assert(exp) {}
-#define DBC_Require(exp) {}
-#define DBC_Ensure(exp) {}
-
-#endif				/* DEBUG */
-
 #endif				/* DBC_ */
diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index 11d92cd..11f48cb 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -20,11 +20,6 @@ libhw = hw/hw_prcm.o hw/hw_dspssC64P.o hw/hw_mmu.o hw/hw_mbox.o
 bridgedriver-objs = $(libgen) $(libservices) $(libwmd) $(libpmgr) $(librmgr) \
 			$(libdload) $(libhw)
 
-# Debug
-ifeq ($(CONFIG_BRIDGE_DEBUG),y)
-ccflags-y += -DGT_TRACE
-endif
-
 #Machine dependent
 ccflags-y += -D_TI_ -D_DB_TIOMAP -DTMS32060 \
 		-DTICFG_PROC_VER -DTICFG_EVM_TYPE -DCHNL_SMCLASS \
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index ecd5905..47ca742 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -513,9 +513,7 @@ DSP_STATUS DRV_GetDevObject(u32 uIndex, struct DRV_OBJECT *hDrvObject,
 			   struct DEV_OBJECT **phDevObject)
 {
 	DSP_STATUS status = DSP_SOK;
-#if GT_TRACE	/* pDrvObject is used only for Assertions and debug messages.*/
 	struct DRV_OBJECT *pDrvObject = (struct DRV_OBJECT *)hDrvObject;
-#endif
 	struct DEV_OBJECT *pDevObject;
 	u32 i;
 	DBC_Require(MEM_IsValidHandle(pDrvObject, SIGNATURE));
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 3d3f02d..fa97caa 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -533,9 +533,7 @@ err:
 /* This function maps kernel space memory to user space memory. */
 static int bridge_mmap(struct file *filp, struct vm_area_struct *vma)
 {
-#if GT_TRACE
 	u32 offset = vma->vm_pgoff << PAGE_SHIFT;
-#endif
 	u32 status;
 
 	DBC_Assert(vma->vm_start < vma->vm_end);
-- 
1.6.2.4

