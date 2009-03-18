From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH B 2/3] tidspbridge: cleanup and remove HW_MMU_TLBFlushAll
Date: Wed, 18 Mar 2009 03:26:44 +0200
Message-ID: <1237339605-20697-3-git-send-email-felipe.contreras@gmail.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:55535 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbZCRB06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:26:58 -0400
Received: by bwz17 with SMTP id 17so322072bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:26:55 -0700 (PDT)
In-Reply-To: <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

It doesn't make sense to have layers and layers of constants and defines
to turn one bit on.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/hw/MMUAccInt.h   |    3 ---
 drivers/dsp/bridge/hw/MMURegAcM.h   |   14 --------------
 drivers/dsp/bridge/hw/hw_mmu.c      |    9 ---------
 drivers/dsp/bridge/hw/hw_mmu.h      |    2 --
 drivers/dsp/bridge/wmd/tiomap3430.c |   12 ++++++++++--
 5 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/dsp/bridge/hw/MMUAccInt.h b/drivers/dsp/bridge/hw/MMUAccInt.h
index 78e1d15..6ca1573 100644
--- a/drivers/dsp/bridge/hw/MMUAccInt.h
+++ b/drivers/dsp/bridge/hw/MMUAccInt.h
@@ -41,7 +41,6 @@
 #define EASIL1_MMUMMU_LD_TLBWriteRegister32   (MMU_BASE_EASIL1 + 214)
 #define EASIL1_MMUMMU_CAMWriteRegister32   (MMU_BASE_EASIL1 + 226)
 #define EASIL1_MMUMMU_RAMWriteRegister32 (MMU_BASE_EASIL1 + 268)
-#define EASIL1_MMUMMU_GFLUSHGlobalFlushWrite32 (MMU_BASE_EASIL1 + 317)
 #define EASIL1_MMUMMU_FLUSH_ENTRYWriteRegister32  (MMU_BASE_EASIL1 + 322)
 
 /* Register offset address definitions */
@@ -73,7 +72,5 @@
 #define MMU_MMU_LOCK_BaseValue_OFFSET   10
 #define MMU_MMU_LOCK_CurrentVictim_MASK   0x3f0
 #define MMU_MMU_LOCK_CurrentVictim_OFFSET    4
-#define MMU_MMU_GFLUSH_GlobalFlush_MASK 0x1
-#define MMU_MMU_GFLUSH_GlobalFlush_OFFSET   0
 
 #endif /* _MMU_ACC_INT_H */
diff --git a/drivers/dsp/bridge/hw/MMURegAcM.h b/drivers/dsp/bridge/hw/MMURegAcM.h
index a130b1a..e46fdcb 100644
--- a/drivers/dsp/bridge/hw/MMURegAcM.h
+++ b/drivers/dsp/bridge/hw/MMURegAcM.h
@@ -239,20 +239,6 @@
 }
 
 
-#define MMUMMU_GFLUSHGlobalFlushWrite32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_GFLUSH_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((baseAddress)+offset);\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_GFLUSHGlobalFlushWrite32);\
-    data &= ~(MMU_MMU_GFLUSH_GlobalFlush_MASK);\
-    newValue <<= MMU_MMU_GFLUSH_GlobalFlush_OFFSET;\
-    newValue &= MMU_MMU_GFLUSH_GlobalFlush_MASK;\
-    newValue |= data;\
-    WR_MEM_32_VOLATILE(baseAddress+offset, newValue);\
-}
-
-
 #define MMUMMU_FLUSH_ENTRYWriteRegister32(baseAddress, value)\
 {\
     const u32 offset = MMU_MMU_FLUSH_ENTRY_OFFSET;\
diff --git a/drivers/dsp/bridge/hw/hw_mmu.c b/drivers/dsp/bridge/hw/hw_mmu.c
index da7e092..ab65de0 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.c
+++ b/drivers/dsp/bridge/hw/hw_mmu.c
@@ -212,15 +212,6 @@ HW_STATUS HW_MMU_VictimNumSet(const u32 baseAddress,
     return status;
 }
 
-HW_STATUS HW_MMU_TLBFlushAll(const u32 baseAddress)
-{
-    HW_STATUS status = RET_OK;
-
-    MMUMMU_GFLUSHGlobalFlushWrite32(baseAddress, HW_SET);
-
-    return status;
-}
-
 HW_STATUS HW_MMU_EventAck(const u32 baseAddress, u32 irqMask)
 {
     HW_STATUS status = RET_OK;
diff --git a/drivers/dsp/bridge/hw/hw_mmu.h b/drivers/dsp/bridge/hw/hw_mmu.h
index 924f32b..4783276 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.h
+++ b/drivers/dsp/bridge/hw/hw_mmu.h
@@ -91,8 +91,6 @@ extern HW_STATUS HW_MMU_TLBFlush(const u32 baseAddress,
 				    u32 virtualAddr,
 				    u32 pageSize);
 
-extern HW_STATUS HW_MMU_TLBFlushAll(const u32 baseAddress);
-
 extern HW_STATUS HW_MMU_TLBAdd(const u32     baseAddress,
 				  u32	   physicalAddr,
 				  u32	   virtualAddr,
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index b538ef7..30e0cb3 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -88,6 +88,9 @@
 #define MMU_LARGE_PAGE_MASK      0xFFFF0000
 #define MMU_SMALL_PAGE_MASK      0xFFFFF000
 #define PAGES_II_LVL_TABLE   512
+
+#define MMU_GFLUSH 0x60
+
 /* Forward Declarations: */
 static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *pDevContext);
 static DSP_STATUS WMD_BRD_Read(struct WMD_DEV_CONTEXT *pDevContext,
@@ -235,6 +238,11 @@ static struct WMD_DRV_INTERFACE drvInterfaceFxns = {
 	WMD_MSG_SetQueueId,
 };
 
+static inline void tlb_flush_all(const u32 base)
+{
+    __raw_writeb(__raw_readb(base + MMU_GFLUSH) | 1, base + MMU_GFLUSH);
+}
+
 static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
 {
 	struct CFG_HOSTRES resources;
@@ -248,10 +256,10 @@ static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
 		DBG_Trace(DBG_LEVEL7, "temp value is 0x%x\n", temp);
 		CLK_Enable(SERVICESCLK_iva2_ck);
 		WakeDSP(pDevContext, NULL);
-		HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
+		tlb_flush_all(pDevContext->dwDSPMmuBase);
 		CLK_Disable(SERVICESCLK_iva2_ck);
 	} else
-		HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
+		tlb_flush_all(pDevContext->dwDSPMmuBase);
 }
 
 /*
-- 
1.6.2.1.287.g9a8be

