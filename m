From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RESEND][PATCH] DSPBRIDGE: Remove GT_TRACE conditional macro
Date: Tue, 23 Feb 2010 11:26:27 -0600
Message-ID: <1266945987-24216-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60624 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab0BWROm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 12:14:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Please discard previous patch, I think it is best to place
DBC* under CONFIG_BRIDGE_DEBUG instead of printing by default.
---

Remove GT_TRACE conditional macro, replace in needed places
for CONFIG_BRIDGE_DEBUG

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbc.h |    6 +-----
 drivers/dsp/bridge/Makefile                |    5 -----
 drivers/dsp/bridge/rmgr/drv.c              |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c    |    2 --
 4 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
index c4bf803..90cad03 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
@@ -25,12 +25,8 @@
 #ifndef DBC_
 #define DBC_
 
-#ifndef GT_TRACE
-#define GT_TRACE 0	    /* 0 = "trace compiled out"; 1 = "trace active" */
-#endif
-
 /* Assertion Macros: */
-#if GT_TRACE
+#ifdef CONFIG_BRIDGE_DEBUG
 
 #define DBC_Assert(exp) \
     if (!(exp)) \
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
index ecd5905..a2737fd 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -513,7 +513,7 @@ DSP_STATUS DRV_GetDevObject(u32 uIndex, struct DRV_OBJECT *hDrvObject,
 			   struct DEV_OBJECT **phDevObject)
 {
 	DSP_STATUS status = DSP_SOK;
-#if GT_TRACE	/* pDrvObject is used only for Assertions and debug messages.*/
+#ifdef CONFIG_BRIDGE_DEBUG	/* used only for Assertions and debug messages.*/
 	struct DRV_OBJECT *pDrvObject = (struct DRV_OBJECT *)hDrvObject;
 #endif
 	struct DEV_OBJECT *pDevObject;
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

