From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 1/2][OMAPZOOM] DSPBRIDGE: Removes wrappers funtions of readl
 and writel
Date: Tue, 24 Feb 2009 15:50:03 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602877515DA@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54065 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760628AbZBXVuL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 16:50:11 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1OLo4i1020954
	for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2009 15:50:09 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1OLo4im028107
	for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2009 15:50:04 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 23 Feb 2009 17:38:15 -0600
Subject: [PATCH] DSPBRIDGE: Removes wrappers funtions of readl and writel

This patch change the call to RD_MEM_32_VOLATILE and
WR_MEM_32_VOLATILE with __raw_readl and __raw_writel
Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
---
 drivers/dsp/bridge/hw/MLBRegAcM.h    |   41 ++++----
 drivers/dsp/bridge/hw/MMURegAcM.h    |   66 ++++++------
 drivers/dsp/bridge/hw/PRCMRegAcM.h   |  181 +++++++++++++++++-----------------
 drivers/dsp/bridge/hw/hw_dspssC64P.c |    5 +-
 4 files changed, 148 insertions(+), 145 deletions(-)

diff --git a/drivers/dsp/bridge/hw/MLBRegAcM.h b/drivers/dsp/bridge/hw/MLBRegAcM.h
index 747a2e1..d215ec5
--- a/drivers/dsp/bridge/hw/MLBRegAcM.h
+++ b/drivers/dsp/bridge/hw/MLBRegAcM.h
@@ -18,6 +18,7 @@
 #define _MLB_REG_ACM_H

 #include <GlobalTypes.h>
+#include <linux/io.h>
 #include <EasiGlobal.h>
 #include "MLBAccInt.h"

@@ -25,7 +26,7 @@

 #define MLBMAILBOX_SYSCONFIGReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+ \
+      __raw_readl(((baseAddress))+ \
       MLB_MAILBOX_SYSCONFIG_OFFSET))


@@ -34,13 +35,13 @@
     const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGWriteRegister32);\
-    WR_MEM_32_VOLATILE(((u32)(baseAddress))+offset, newValue);\
+    __raw_writel(newValue, ((baseAddress))+offset);\
 }


 #define MLBMAILBOX_SYSCONFIGSIdleModeRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGSIdleModeRead32),\
-      (((RD_MEM_32_VOLATILE((((u32)(baseAddress))+\
+      (((__raw_readl((((u32)(baseAddress))+\
       (MLB_MAILBOX_SYSCONFIG_OFFSET)))) &\
       MLB_MAILBOX_SYSCONFIG_SIdleMode_MASK) >>\
       MLB_MAILBOX_SYSCONFIG_SIdleMode_OFFSET))
@@ -49,7 +50,7 @@
 #define MLBMAILBOX_SYSCONFIGSIdleModeWrite32(baseAddress, value)\
 {\
     const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE(((u32)(baseAddress)) +\
+    register u32 data = __raw_readl(((u32)(baseAddress)) +\
                            offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGSIdleModeWrite32);\
@@ -57,7 +58,7 @@
     newValue <<= MLB_MAILBOX_SYSCONFIG_SIdleMode_OFFSET;\
     newValue &= MLB_MAILBOX_SYSCONFIG_SIdleMode_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


@@ -65,20 +66,20 @@
 {\
     const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;\
     register u32 data =\
-    RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+    __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGSoftResetWrite32);\
     data &= ~(MLB_MAILBOX_SYSCONFIG_SoftReset_MASK);\
     newValue <<= MLB_MAILBOX_SYSCONFIG_SoftReset_OFFSET;\
     newValue &= MLB_MAILBOX_SYSCONFIG_SoftReset_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


 #define MLBMAILBOX_SYSCONFIGAutoIdleRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGAutoIdleRead32),\
-      (((RD_MEM_32_VOLATILE((((u32)(baseAddress))+\
+      (((__raw_readl((((u32)(baseAddress))+\
       (MLB_MAILBOX_SYSCONFIG_OFFSET)))) &\
       MLB_MAILBOX_SYSCONFIG_AutoIdle_MASK) >>\
       MLB_MAILBOX_SYSCONFIG_AutoIdle_OFFSET))
@@ -88,20 +89,20 @@
 {\
     const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;\
     register u32 data =\
-    RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+    __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGAutoIdleWrite32);\
     data &= ~(MLB_MAILBOX_SYSCONFIG_AutoIdle_MASK);\
     newValue <<= MLB_MAILBOX_SYSCONFIG_AutoIdle_OFFSET;\
     newValue &= MLB_MAILBOX_SYSCONFIG_AutoIdle_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


 #define MLBMAILBOX_SYSSTATUSResetDoneRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSSTATUSResetDoneRead32),\
-      (((RD_MEM_32_VOLATILE((((u32)(baseAddress))+\
+      (((__raw_readl((((u32)(baseAddress))+\
       (MLB_MAILBOX_SYSSTATUS_OFFSET)))) &\
       MLB_MAILBOX_SYSSTATUS_ResetDone_MASK) >>\
       MLB_MAILBOX_SYSSTATUS_ResetDone_OFFSET))
@@ -109,7 +110,7 @@

 #define MLBMAILBOX_MESSAGE___0_15ReadRegister32(baseAddress, bank)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_MESSAGE___0_15ReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+\
+      __raw_readl(((baseAddress))+\
       (MLB_MAILBOX_MESSAGE___REGSET_0_15_OFFSET +\
       MLB_MAILBOX_MESSAGE___0_15_OFFSET+(\
       (bank)*MLB_MAILBOX_MESSAGE___REGSET_0_15_STEP))))
@@ -122,14 +123,14 @@
     ((bank)*MLB_MAILBOX_MESSAGE___REGSET_0_15_STEP);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_MESSAGE___0_15WriteRegister32);\
-    WR_MEM_32_VOLATILE(((u32)(baseAddress))+offset, newValue);\
+    __raw_writel(newValue, ((baseAddress))+offset);\
 }


 #define MLBMAILBOX_FIFOSTATUS___0_15ReadRegister32(baseAddress, bank)\
     (_DEBUG_LEVEL_1_EASI(\
       EASIL1_MLBMAILBOX_FIFOSTATUS___0_15ReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+\
+      __raw_readl(((u32)(baseAddress))+\
       (MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_OFFSET +\
       MLB_MAILBOX_FIFOSTATUS___0_15_OFFSET+\
       ((bank)*MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_STEP))))
@@ -138,7 +139,7 @@
 #define MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32(baseAddress, bank)\
     (_DEBUG_LEVEL_1_EASI(\
       EASIL1_MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32),\
-      (((RD_MEM_32_VOLATILE(((u32)(baseAddress))+\
+      (((__raw_readl(((baseAddress))+\
       (MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_OFFSET +\
       MLB_MAILBOX_FIFOSTATUS___0_15_OFFSET+\
       ((bank)*MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_STEP)))) &\
@@ -149,7 +150,7 @@
 #define MLBMAILBOX_MSGSTATUS___0_15NbOfMsgMBmRead32(baseAddress, bank)\
     (_DEBUG_LEVEL_1_EASI(\
       EASIL1_MLBMAILBOX_MSGSTATUS___0_15NbOfMsgMBmRead32),\
-      (((RD_MEM_32_VOLATILE(((u32)(baseAddress))+\
+      (((__raw_readl(((baseAddress))+\
       (MLB_MAILBOX_MSGSTATUS___REGSET_0_15_OFFSET +\
       MLB_MAILBOX_MSGSTATUS___0_15_OFFSET+\
       ((bank)*MLB_MAILBOX_MSGSTATUS___REGSET_0_15_STEP)))) &\
@@ -159,7 +160,7 @@

 #define MLBMAILBOX_IRQSTATUS___0_3ReadRegister32(baseAddress, bank)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQSTATUS___0_3ReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+\
+      __raw_readl(((baseAddress))+\
       (MLB_MAILBOX_IRQSTATUS___REGSET_0_3_OFFSET +\
       MLB_MAILBOX_IRQSTATUS___0_3_OFFSET+\
       ((bank)*MLB_MAILBOX_IRQSTATUS___REGSET_0_3_STEP))))
@@ -172,13 +173,13 @@
     ((bank)*MLB_MAILBOX_IRQSTATUS___REGSET_0_3_STEP);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQSTATUS___0_3WriteRegister32);\
-    WR_MEM_32_VOLATILE(((u32)(baseAddress))+offset, newValue);\
+    __raw_writel(newValue, ((baseAddress))+offset);\
 }


 #define MLBMAILBOX_IRQENABLE___0_3ReadRegister32(baseAddress, bank)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQENABLE___0_3ReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+\
+      __raw_readl(((baseAddress))+\
       (MLB_MAILBOX_IRQENABLE___REGSET_0_3_OFFSET +\
       MLB_MAILBOX_IRQENABLE___0_3_OFFSET+\
        ((bank)*MLB_MAILBOX_IRQENABLE___REGSET_0_3_STEP))))
@@ -191,7 +192,7 @@
       ((bank)*MLB_MAILBOX_IRQENABLE___REGSET_0_3_STEP);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQENABLE___0_3WriteRegister32);\
-    WR_MEM_32_VOLATILE(((u32)(baseAddress))+offset, newValue);\
+    __raw_writel(newValue, ((baseAddress))+offset);\
 }


diff --git a/drivers/dsp/bridge/hw/MMURegAcM.h b/drivers/dsp/bridge/hw/MMURegAcM.h
index a130b1a..34b0c49
--- a/drivers/dsp/bridge/hw/MMURegAcM.h
+++ b/drivers/dsp/bridge/hw/MMURegAcM.h
@@ -19,7 +19,7 @@
 #define _MMU_REG_ACM_H

 #include <GlobalTypes.h>
-
+#include <linux/io.h>
 #include <EasiGlobal.h>

 #include "MMUAccInt.h"
@@ -29,40 +29,40 @@

 #define MMUMMU_SYSCONFIGReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_SYSCONFIGReadRegister32),\
-      RD_MEM_32_VOLATILE((baseAddress)+MMU_MMU_SYSCONFIG_OFFSET))
+      __raw_readl((baseAddress)+MMU_MMU_SYSCONFIG_OFFSET))


 #define MMUMMU_SYSCONFIGIdleModeWrite32(baseAddress, value)\
 {\
     const u32 offset = MMU_MMU_SYSCONFIG_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((baseAddress)+offset);\
+    register u32 data = __raw_readl((baseAddress)+offset);\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_SYSCONFIGIdleModeWrite32);\
     data &= ~(MMU_MMU_SYSCONFIG_IdleMode_MASK);\
     newValue <<= MMU_MMU_SYSCONFIG_IdleMode_OFFSET;\
     newValue &= MMU_MMU_SYSCONFIG_IdleMode_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE(baseAddress+offset, newValue);\
+    __raw_writel(newValue, baseAddress+offset);\
 }


 #define MMUMMU_SYSCONFIGAutoIdleWrite32(baseAddress, value)\
 {\
     const u32 offset = MMU_MMU_SYSCONFIG_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((baseAddress)+offset);\
+    register u32 data = __raw_readl((baseAddress)+offset);\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_SYSCONFIGAutoIdleWrite32);\
     data &= ~(MMU_MMU_SYSCONFIG_AutoIdle_MASK);\
     newValue <<= MMU_MMU_SYSCONFIG_AutoIdle_OFFSET;\
     newValue &= MMU_MMU_SYSCONFIG_AutoIdle_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE(baseAddress+offset, newValue);\
+    __raw_writel(newValue, baseAddress+offset);\
 }


 #define MMUMMU_IRQSTATUSReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQSTATUSReadRegister32),\
-      RD_MEM_32_VOLATILE((baseAddress)+MMU_MMU_IRQSTATUS_OFFSET))
+      __raw_readl((baseAddress)+MMU_MMU_IRQSTATUS_OFFSET))


 #define MMUMMU_IRQSTATUSWriteRegister32(baseAddress, value)\
@@ -70,13 +70,13 @@
     const u32 offset = MMU_MMU_IRQSTATUS_OFFSET;\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQSTATUSWriteRegister32);\
-    WR_MEM_32_VOLATILE((baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


 #define MMUMMU_IRQENABLEReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQENABLEReadRegister32),\
-      RD_MEM_32_VOLATILE((baseAddress)+MMU_MMU_IRQENABLE_OFFSET))
+      __raw_readl((baseAddress)+MMU_MMU_IRQENABLE_OFFSET))


 #define MMUMMU_IRQENABLEWriteRegister32(baseAddress, value)\
@@ -84,20 +84,20 @@
     const u32 offset = MMU_MMU_IRQENABLE_OFFSET;\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQENABLEWriteRegister32);\
-    WR_MEM_32_VOLATILE((baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


 #define MMUMMU_WALKING_STTWLRunningRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_WALKING_STTWLRunningRead32),\
-      (((RD_MEM_32_VOLATILE(((baseAddress)+(MMU_MMU_WALKING_ST_OFFSET))))\
+      (((__raw_readl(((baseAddress)+(MMU_MMU_WALKING_ST_OFFSET))))\
       & MMU_MMU_WALKING_ST_TWLRunning_MASK) >>\
       MMU_MMU_WALKING_ST_TWLRunning_OFFSET))


 #define MMUMMU_CNTLTWLEnableRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CNTLTWLEnableRead32),\
-      (((RD_MEM_32_VOLATILE(((baseAddress)+(MMU_MMU_CNTL_OFFSET)))) &\
+      (((__raw_readl(((baseAddress)+(MMU_MMU_CNTL_OFFSET)))) &\
       MMU_MMU_CNTL_TWLEnable_MASK) >>\
       MMU_MMU_CNTL_TWLEnable_OFFSET))

@@ -105,34 +105,34 @@
 #define MMUMMU_CNTLTWLEnableWrite32(baseAddress, value)\
 {\
     const u32 offset = MMU_MMU_CNTL_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((baseAddress)+offset);\
+    register u32 data = __raw_readl((baseAddress)+offset);\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CNTLTWLEnableWrite32);\
     data &= ~(MMU_MMU_CNTL_TWLEnable_MASK);\
     newValue <<= MMU_MMU_CNTL_TWLEnable_OFFSET;\
     newValue &= MMU_MMU_CNTL_TWLEnable_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE(baseAddress+offset, newValue);\
+    __raw_writel(newValue, baseAddress+offset);\
 }


 #define MMUMMU_CNTLMMUEnableWrite32(baseAddress, value)\
 {\
     const u32 offset = MMU_MMU_CNTL_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((baseAddress)+offset);\
+    register u32 data = __raw_readl((baseAddress)+offset);\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CNTLMMUEnableWrite32);\
     data &= ~(MMU_MMU_CNTL_MMUEnable_MASK);\
     newValue <<= MMU_MMU_CNTL_MMUEnable_OFFSET;\
     newValue &= MMU_MMU_CNTL_MMUEnable_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE(baseAddress+offset, newValue);\
+    __raw_writel(newValue, baseAddress+offset);\
 }


 #define MMUMMU_FAULT_ADReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_FAULT_ADReadRegister32),\
-      RD_MEM_32_VOLATILE((baseAddress)+MMU_MMU_FAULT_AD_OFFSET))
+      __raw_readl((baseAddress)+MMU_MMU_FAULT_AD_OFFSET))


 #define MMUMMU_TTBWriteRegister32(baseAddress, value)\
@@ -140,13 +140,13 @@
     const u32 offset = MMU_MMU_TTB_OFFSET;\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_TTBWriteRegister32);\
-    WR_MEM_32_VOLATILE((baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


 #define MMUMMU_LOCKReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKReadRegister32),\
-      RD_MEM_32_VOLATILE((baseAddress)+MMU_MMU_LOCK_OFFSET))
+      __raw_readl((baseAddress)+MMU_MMU_LOCK_OFFSET))


 #define MMUMMU_LOCKWriteRegister32(baseAddress, value)\
@@ -154,13 +154,13 @@
     const u32 offset = MMU_MMU_LOCK_OFFSET;\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKWriteRegister32);\
-    WR_MEM_32_VOLATILE((baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


 #define MMUMMU_LOCKBaseValueRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKBaseValueRead32),\
-      (((RD_MEM_32_VOLATILE(((baseAddress)+(MMU_MMU_LOCK_OFFSET)))) &\
+      (((__raw_readl(((baseAddress)+(MMU_MMU_LOCK_OFFSET)))) &\
       MMU_MMU_LOCK_BaseValue_MASK) >>\
       MMU_MMU_LOCK_BaseValue_OFFSET))

@@ -168,20 +168,20 @@
 #define MMUMMU_LOCKBaseValueWrite32(baseAddress, value)\
 {\
     const u32 offset = MMU_MMU_LOCK_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((baseAddress)+offset);\
+    register u32 data = __raw_readl((baseAddress)+offset);\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKBaseValueWrite32);\
     data &= ~(MMU_MMU_LOCK_BaseValue_MASK);\
     newValue <<= MMU_MMU_LOCK_BaseValue_OFFSET;\
     newValue &= MMU_MMU_LOCK_BaseValue_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE(baseAddress+offset, newValue);\
+    __raw_writel(newValue, baseAddress+offset);\
 }


 #define MMUMMU_LOCKCurrentVictimRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKCurrentVictimRead32),\
-      (((RD_MEM_32_VOLATILE(((baseAddress)+(MMU_MMU_LOCK_OFFSET)))) &\
+      (((__raw_readl(((baseAddress)+(MMU_MMU_LOCK_OFFSET)))) &\
       MMU_MMU_LOCK_CurrentVictim_MASK) >>\
       MMU_MMU_LOCK_CurrentVictim_OFFSET))

@@ -189,14 +189,14 @@
 #define MMUMMU_LOCKCurrentVictimWrite32(baseAddress, value)\
 {\
     const u32 offset = MMU_MMU_LOCK_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((baseAddress)+offset);\
+    register u32 data = __raw_readl((baseAddress)+offset);\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKCurrentVictimWrite32);\
     data &= ~(MMU_MMU_LOCK_CurrentVictim_MASK);\
     newValue <<= MMU_MMU_LOCK_CurrentVictim_OFFSET;\
     newValue &= MMU_MMU_LOCK_CurrentVictim_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE(baseAddress+offset, newValue);\
+    __raw_writel(newValue, baseAddress+offset);\
 }


@@ -209,7 +209,7 @@

 #define MMUMMU_LD_TLBReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LD_TLBReadRegister32),\
-      RD_MEM_32_VOLATILE((baseAddress)+MMU_MMU_LD_TLB_OFFSET))
+      __raw_readl((baseAddress)+MMU_MMU_LD_TLB_OFFSET))


 #define MMUMMU_LD_TLBWriteRegister32(baseAddress, value)\
@@ -217,7 +217,7 @@
     const u32 offset = MMU_MMU_LD_TLB_OFFSET;\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LD_TLBWriteRegister32);\
-    WR_MEM_32_VOLATILE((baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


@@ -226,7 +226,7 @@
     const u32 offset = MMU_MMU_CAM_OFFSET;\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CAMWriteRegister32);\
-    WR_MEM_32_VOLATILE((baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


@@ -235,21 +235,21 @@
     const u32 offset = MMU_MMU_RAM_OFFSET;\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_RAMWriteRegister32);\
-    WR_MEM_32_VOLATILE((baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


 #define MMUMMU_GFLUSHGlobalFlushWrite32(baseAddress, value)\
 {\
     const u32 offset = MMU_MMU_GFLUSH_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((baseAddress)+offset);\
+    register u32 data = __raw_readl((baseAddress)+offset);\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_GFLUSHGlobalFlushWrite32);\
     data &= ~(MMU_MMU_GFLUSH_GlobalFlush_MASK);\
     newValue <<= MMU_MMU_GFLUSH_GlobalFlush_OFFSET;\
     newValue &= MMU_MMU_GFLUSH_GlobalFlush_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE(baseAddress+offset, newValue);\
+    __raw_writel(newValue, baseAddress+offset);\
 }


@@ -258,7 +258,7 @@
     const u32 offset = MMU_MMU_FLUSH_ENTRY_OFFSET;\
     register u32 newValue = (value);\
     _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_FLUSH_ENTRYWriteRegister32);\
-    WR_MEM_32_VOLATILE((baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


diff --git a/drivers/dsp/bridge/hw/PRCMRegAcM.h b/drivers/dsp/bridge/hw/PRCMRegAcM.h
index 91cb33c..c0db1fe
--- a/drivers/dsp/bridge/hw/PRCMRegAcM.h
+++ b/drivers/dsp/bridge/hw/PRCMRegAcM.h
@@ -18,6 +18,7 @@
 #define _PRCM_REG_ACM_H

 #include <GlobalTypes.h>
+#include <linux/io.h>

 #include <EasiGlobal.h>

@@ -31,37 +32,37 @@
     const u32 newValue = \
        (u32)PRCMPRCM_CLKCFG_CTRLValid_configClk_valid <<\
       PRCM_PRCM_CLKCFG_CTRL_Valid_config_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(\
       EASIL1_PRCMPRCM_CLKCFG_CTRLValid_configWriteClk_valid32);\
     data &= ~(PRCM_PRCM_CLKCFG_CTRL_Valid_config_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


 #define CM_FCLKEN_PERReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+CM_FCLKEN_PER_OFFSET))
+      __raw_readl(((u32)(baseAddress))+CM_FCLKEN_PER_OFFSET))


 #define CM_ICLKEN_PERReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+CM_ICLKEN_PER_OFFSET))
+      __raw_readl(((u32)(baseAddress))+CM_ICLKEN_PER_OFFSET))


 #define CM_FCLKEN_PER_GPT5WriteRegister32(baseAddress,value)\
 {\
     const u32 offset = CM_FCLKEN_PER_OFFSET;\
     register u32 data = \
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_CM_FCLKEN_PER_GPT5WriteRegister32);\
    data &= ~(CM_FCLKEN_PER_GPT5_MASK);\
    newValue <<= CM_FCLKEN_PER_GPT5_OFFSET;\
    newValue &= CM_FCLKEN_PER_GPT5_MASK;\
    newValue |= data;\
-    WR_MEM_32_VOLATILE(((u32)(baseAddress))+offset, newValue);\
+    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
 }


@@ -69,14 +70,14 @@
 {\
     const u32 offset = CM_FCLKEN_PER_OFFSET;\
     register u32 data =\
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_CM_FCLKEN_PER_GPT5WriteRegister32);\
    data &= ~(CM_FCLKEN_PER_GPT6_MASK);\
    newValue <<= CM_FCLKEN_PER_GPT6_OFFSET;\
    newValue &= CM_FCLKEN_PER_GPT6_MASK;\
    newValue |= data;\
-    WR_MEM_32_VOLATILE(((u32)(baseAddress))+offset, newValue);\
+    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
 }


@@ -84,14 +85,14 @@
 {\
     const u32 offset = CM_ICLKEN_PER_OFFSET;\
     register u32 data = \
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_CM_ICLKEN_PER_GPT5WriteRegister32);\
    data &= ~(CM_ICLKEN_PER_GPT5_MASK);\
    newValue <<= CM_ICLKEN_PER_GPT5_OFFSET;\
    newValue &= CM_ICLKEN_PER_GPT5_MASK;\
    newValue |= data;\
-    WR_MEM_32_VOLATILE(((u32)(baseAddress))+offset, newValue);\
+    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
 }


@@ -99,34 +100,34 @@
 {\
     const u32 offset = CM_ICLKEN_PER_OFFSET;\
     register u32 data = \
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_CM_ICLKEN_PER_GPT5WriteRegister32);\
    data &= ~(CM_ICLKEN_PER_GPT6_MASK);\
    newValue <<= CM_ICLKEN_PER_GPT6_OFFSET;\
    newValue &= CM_ICLKEN_PER_GPT6_MASK;\
    newValue |= data;\
-    WR_MEM_32_VOLATILE(((u32)(baseAddress))+offset, newValue);\
+    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
 }


 #define CM_FCLKEN1_COREReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+CM_FCLKEN1_CORE_OFFSET))
+      __raw_readl(((u32)(baseAddress))+CM_FCLKEN1_CORE_OFFSET))


 #define PRCMCM_FCLKEN1_COREEN_GPT8Write32(baseAddress,value)\
 {\
     const u32 offset = PRCM_CM_FCLKEN1_CORE_OFFSET;\
     register u32 data = \
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREEN_GPT8Write32);\
     data &= ~(PRCM_CM_FCLKEN1_CORE_EN_GPT8_MASK);\
     newValue <<= PRCM_CM_FCLKEN1_CORE_EN_GPT8_OFFSET;\
     newValue &= PRCM_CM_FCLKEN1_CORE_EN_GPT8_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


@@ -134,34 +135,34 @@
 {\
     const u32 offset = PRCM_CM_FCLKEN1_CORE_OFFSET;\
     register u32 data = \
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREEN_GPT7Write32);\
     data &= ~(PRCM_CM_FCLKEN1_CORE_EN_GPT7_MASK);\
     newValue <<= PRCM_CM_FCLKEN1_CORE_EN_GPT7_OFFSET;\
     newValue &= PRCM_CM_FCLKEN1_CORE_EN_GPT7_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


 #define CM_ICLKEN1_COREReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+CM_ICLKEN1_CORE_OFFSET))
+      __raw_readl(((u32)(baseAddress))+CM_ICLKEN1_CORE_OFFSET))


 #define  CM_ICLKEN1_COREEN_MAILBOXESWrite32(baseAddress, value)\
 {\
     const u32 offset = CM_ICLKEN1_CORE_OFFSET;\
     register u32 data = \
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREEN_MAILBOXESWrite32);\
     data &= ~(CM_ICLKEN1_CORE_EN_MAILBOXES_MASK);\
     newValue <<= CM_ICLKEN1_CORE_EN_MAILBOXES_OFFSET;\
     newValue &= CM_ICLKEN1_CORE_EN_MAILBOXES_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


@@ -169,14 +170,14 @@
 {\
     const u32 offset = PRCM_CM_ICLKEN1_CORE_OFFSET;\
     register u32 data = \
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREEN_GPT8Write32);\
     data &= ~(PRCM_CM_ICLKEN1_CORE_EN_GPT8_MASK);\
     newValue <<= PRCM_CM_ICLKEN1_CORE_EN_GPT8_OFFSET;\
     newValue &= PRCM_CM_ICLKEN1_CORE_EN_GPT8_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


@@ -184,14 +185,14 @@
 {\
     const u32 offset = PRCM_CM_ICLKEN1_CORE_OFFSET;\
     register u32 data =\
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREEN_GPT7Write32);\
     data &= ~(PRCM_CM_ICLKEN1_CORE_EN_GPT7_MASK);\
     newValue <<= PRCM_CM_ICLKEN1_CORE_EN_GPT7_OFFSET;\
     newValue &= PRCM_CM_ICLKEN1_CORE_EN_GPT7_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


@@ -200,11 +201,11 @@
     const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT832k <<\
       PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT8Write32k32);\
     data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


@@ -213,11 +214,11 @@
     const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT8Sys <<\
       PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT8WriteSys32);\
     data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


@@ -226,11 +227,11 @@
     const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT8Ext <<\
       PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT8WriteExt32);\
     data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


@@ -239,11 +240,11 @@
     const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT732k <<\
       PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT7Write32k32);\
     data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


@@ -252,11 +253,11 @@
     const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT7Sys <<\
       PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT7WriteSys32);\
     data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


@@ -265,11 +266,11 @@
     const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT7Ext <<\
       PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT7WriteExt32);\
     data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


@@ -278,11 +279,11 @@
     const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT6Sys <<\
       PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT6WriteSys32);\
     data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


@@ -291,11 +292,11 @@
     const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT6Ext <<\
       PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT6WriteExt32);\
     data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


@@ -304,11 +305,11 @@
     const u32 offset = CM_CLKSEL_PER_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT532k <<\
       CM_CLKSEL_PER_GPT5_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_CM_CLKSEL_PER_GPT5Write32k32);\
     data &= ~(CM_CLKSEL_PER_GPT5_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


@@ -317,11 +318,11 @@
     const u32 offset = CM_CLKSEL_PER_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT532k <<\
       CM_CLKSEL_PER_GPT6_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_CM_CLKSEL_PER_GPT6Write32k32);\
     data &= ~(CM_CLKSEL_PER_GPT6_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


@@ -330,11 +331,11 @@
     const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT5Sys <<\
       PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT5WriteSys32);\
     data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


@@ -343,17 +344,17 @@
     const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
     const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT5Ext <<\
       PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT5WriteExt32);\
     data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (u32)(baseAddress)+offset);\
 }


 #define PRCMCM_CLKSEL1_PLLAPLLs_ClkinRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL1_PLLAPLLs_ClkinRead32),\
-      (((RD_MEM_32_VOLATILE((((u32)(baseAddress))+\
+      (((__raw_readl((((u32)(baseAddress))+\
        (PRCM_CM_CLKSEL1_PLL_OFFSET)))) &\
       PRCM_CM_CLKSEL1_PLL_APLLs_Clkin_MASK) >>\
       PRCM_CM_CLKSEL1_PLL_APLLs_Clkin_OFFSET))
@@ -363,14 +364,14 @@
 {\
     const u32 offset = CM_FCLKEN_IVA2_OFFSET;\
     register u32 data = \
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN_DSPEN_DSPWrite32);\
     data &= ~(CM_FCLKEN_IVA2_EN_MASK);\
     newValue <<= CM_FCLKEN_IVA2_EN_OFFSET;\
     newValue &= CM_FCLKEN_IVA2_EN_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


@@ -378,25 +379,25 @@
 {\
     const u32 offset = PRCM_CM_ICLKEN_DSP_OFFSET;\
     register u32 data = \
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+      __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN_DSPEN_DSP_IPIWrite32);\
     data &= ~(PRCM_CM_ICLKEN_DSP_EN_DSP_IPI_MASK);\
     newValue <<= PRCM_CM_ICLKEN_DSP_EN_DSP_IPI_OFFSET;\
     newValue &= PRCM_CM_ICLKEN_DSP_EN_DSP_IPI_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


 #define PRCMCM_IDLEST_DSPReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_IDLEST_DSPReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+PRCM_CM_IDLEST_DSP_OFFSET))
+      __raw_readl(((u32)(baseAddress))+PRCM_CM_IDLEST_DSP_OFFSET))


 #define PRCMCM_IDLEST_DSPST_IPIRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_IDLEST_DSPST_IPIRead32),\
-      (((RD_MEM_32_VOLATILE((((u32)(baseAddress))+\
+      (((__raw_readl((((u32)(baseAddress))+\
        (PRCM_CM_IDLEST_DSP_OFFSET)))) &\
       PRCM_CM_IDLEST_DSP_ST_IPI_MASK) >>\
       PRCM_CM_IDLEST_DSP_ST_IPI_OFFSET))
@@ -404,7 +405,7 @@

 #define PRM_IDLEST_IVA2ST_IVA2Read32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_IDLEST_DSPST_DSPRead32),\
-      (((RD_MEM_32_VOLATILE((((u32)(baseAddress))+\
+      (((__raw_readl((((u32)(baseAddress))+\
          (CM_IDLEST_IVA2_OFFSET)))) &\
       CM_IDLEST_IVA2_ST_IVA2_MASK) >>\
       CM_IDLEST_IVA2_ST_IVA2_OFFSET))
@@ -414,14 +415,14 @@
 {\
     const u32 offset = PRCM_CM_AUTOIDLE_DSP_OFFSET;\
     register u32 data =\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+      __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_AUTOIDLE_DSPAUTO_DSP_IPIWrite32);\
     data &= ~(PRCM_CM_AUTOIDLE_DSP_AUTO_DSP_IPI_MASK);\
     newValue <<= PRCM_CM_AUTOIDLE_DSP_AUTO_DSP_IPI_OFFSET;\
     newValue &= PRCM_CM_AUTOIDLE_DSP_AUTO_DSP_IPI_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


@@ -429,14 +430,14 @@
 {\
     const u32 offset = PRCM_CM_CLKSEL_DSP_OFFSET;\
     register u32 data = \
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL_DSPSYNC_DSPWrite32);\
     data &= ~(PRCM_CM_CLKSEL_DSP_SYNC_DSP_MASK);\
     newValue <<= PRCM_CM_CLKSEL_DSP_SYNC_DSP_OFFSET;\
     newValue &= PRCM_CM_CLKSEL_DSP_SYNC_DSP_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


@@ -444,14 +445,14 @@
 {\
     const u32 offset = PRCM_CM_CLKSEL_DSP_OFFSET;\
     register u32 data = \
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+      __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL_DSPCLKSEL_DSP_IFWrite32);\
     data &= ~(PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_IF_MASK);\
     newValue <<= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_IF_OFFSET;\
     newValue &= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_IF_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


@@ -459,14 +460,14 @@
 {\
     const u32 offset = PRCM_CM_CLKSEL_DSP_OFFSET;\
     register u32 data = \
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+      __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL_DSPCLKSEL_DSPWrite32);\
     data &= ~(PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_MASK);\
     newValue <<= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_OFFSET;\
     newValue &= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


@@ -474,20 +475,20 @@
 {\
     const u32 offset = PRCM_CM_CLKSTCTRL_IVA2_OFFSET;\
     register u32 data = \
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+      __raw_readl(((baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSTCTRL_IVA2WriteRegister32);\
     data &= ~(CM_CLKSTCTRL_IVA2_MASK);\
     newValue <<= CM_CLKSTCTRL_IVA2_OFFSET;\
     newValue &= CM_CLKSTCTRL_IVA2_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


 #define PRCMCM_CLKSTCTRL_DSPAutostate_DSPRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSTCTRL_DSPAutostate_DSPRead32),\
-      (((RD_MEM_32_VOLATILE((((u32)(baseAddress))+\
+      (((__raw_readl((((u32)(baseAddress))+\
        (PRCM_CM_CLKSTCTRL_DSP_OFFSET)))) &\
       PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_MASK) >>\
       PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_OFFSET))
@@ -497,34 +498,34 @@
 {\
     const u32 offset = PRCM_CM_CLKSTCTRL_DSP_OFFSET;\
     register u32 data = \
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSTCTRL_DSPAutostate_DSPWrite32);\
     data &= ~(PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_MASK);\
     newValue <<= PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_OFFSET;\
     newValue &= PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


 #define PRCMRM_RSTCTRL_DSPReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+PRCM_RM_RSTCTRL_DSP_OFFSET))
+      __raw_readl(((baseAddress))+PRCM_RM_RSTCTRL_DSP_OFFSET))


 #define PRM_RSTCTRL_IVA2RST1_DSPWrite32(baseAddress,value)\
 {\
     const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;\
     register u32 data =\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+    __raw_readl(((baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPRST1_DSPWrite32);\
     data &= ~(PRM_RSTCTRL_IVA2_RST1_MASK);\
     newValue <<= PRM_RSTCTRL_IVA2_RST1_OFFSET;\
     newValue &= PRM_RSTCTRL_IVA2_RST1_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


@@ -532,14 +533,14 @@
 {\
     const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;\
     register u32 data =\
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPRST1_DSPWrite32);\
     data &= ~(PRM_RSTCTRL_IVA2_RST2_MASK);\
     newValue <<= PRM_RSTCTRL_IVA2_RST2_OFFSET;\
     newValue &= PRM_RSTCTRL_IVA2_RST2_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


@@ -547,20 +548,20 @@
 {\
     const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;\
     register u32 data =\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+      __raw_readl(((baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPRST1_DSPWrite32);\
     data &= ~(PRM_RSTCTRL_IVA2_RST3_MASK);\
     newValue <<= PRM_RSTCTRL_IVA2_RST3_OFFSET;\
     newValue &= PRM_RSTCTRL_IVA2_RST3_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (baseAddress)+offset);\
 }


 #define PRCMRM_RSTST_DSPReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTST_DSPReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+PRCM_RM_RSTST_DSP_OFFSET))
+      __raw_readl(((baseAddress))+PRCM_RM_RSTST_DSP_OFFSET))


 #define PRCMRM_RSTST_DSPWriteRegister32(baseAddress,value)\
@@ -568,7 +569,7 @@
     const u32 offset = PRCM_RM_RSTST_DSP_OFFSET;\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTST_DSPWriteRegister32);\
-    WR_MEM_32_VOLATILE(((u32)(baseAddress))+offset, newValue);\
+    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
 }


@@ -576,14 +577,14 @@
 {\
     const u32 offset = PRCM_PM_PWSTCTRL_DSP_OFFSET;\
     register u32 data = \
-       RD_MEM_32_VOLATILE(((u32)(baseAddress))+offset);\
+       __raw_readl(((u32)(baseAddress))+offset);\
     register u32 newValue = ((u32)(value));\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_DSPForceStateWrite32);\
     data &= ~(PRCM_PM_PWSTCTRL_DSP_ForceState_MASK);\
     newValue <<= PRCM_PM_PWSTCTRL_DSP_ForceState_OFFSET;\
     newValue &= PRCM_PM_PWSTCTRL_DSP_ForceState_MASK;\
     newValue |= data;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, newValue);\
+    __raw_writel(newValue, (u32)(baseAddress)+offset);\
 }


@@ -592,11 +593,11 @@
     const u32 offset = PRCM_PM_PWSTCTRL_IVA2_OFFSET;\
     const u32 newValue = (u32)PRCMPM_PWSTCTRL_IVA2PowerStateON <<\
       PRCM_PM_PWSTCTRL_IVA2_PowerState_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_IVA2PowerStateWriteON32);\
     data &= ~(PRCM_PM_PWSTCTRL_IVA2_PowerState_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (baseAddress)+offset);\
 }


@@ -605,11 +606,11 @@
     const u32 offset = PRCM_PM_PWSTCTRL_IVA2_OFFSET;\
     const u32 newValue = (u32)PRCMPM_PWSTCTRL_IVA2PowerStateOFF <<\
       PRCM_PM_PWSTCTRL_IVA2_PowerState_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_IVA2PowerStateWriteOFF32);\
     data &= ~(PRCM_PM_PWSTCTRL_IVA2_PowerState_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (baseAddress)+offset);\
 }


@@ -618,27 +619,27 @@
     const u32 offset = PRCM_PM_PWSTCTRL_DSP_OFFSET;\
     const u32 newValue = (u32)PRCMPM_PWSTCTRL_DSPPowerStateRET <<\
       PRCM_PM_PWSTCTRL_DSP_PowerState_OFFSET;\
-    register u32 data = RD_MEM_32_VOLATILE((u32)(baseAddress)+offset);\
+    register u32 data = __raw_readl((baseAddress)+offset);\
     _DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_DSPPowerStateWriteRET32);\
     data &= ~(PRCM_PM_PWSTCTRL_DSP_PowerState_MASK);\
     data |= newValue;\
-    WR_MEM_32_VOLATILE((u32)(baseAddress)+offset, data);\
+    __raw_writel(data, (baseAddress)+offset);\
 }


 #define PRCMPM_PWSTST_DSPReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_DSPReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+PRCM_PM_PWSTST_DSP_OFFSET))
+      __raw_readl(((u32)(baseAddress))+PRCM_PM_PWSTST_DSP_OFFSET))


 #define PRCMPM_PWSTST_IVA2ReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_IVA2ReadRegister32),\
-      RD_MEM_32_VOLATILE(((u32)(baseAddress))+PRCM_PM_PWSTST_IVA2_OFFSET))
+      __raw_readl((baseAddress) + PRCM_PM_PWSTST_IVA2_OFFSET))


 #define PRCMPM_PWSTST_DSPInTransitionRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_DSPInTransitionRead32),\
-      (((RD_MEM_32_VOLATILE((((u32)(baseAddress))+\
+      (((__raw_readl((((u32)(baseAddress))+\
        (PRCM_PM_PWSTST_DSP_OFFSET)))) &\
       PRCM_PM_PWSTST_DSP_InTransition_MASK) >>\
       PRCM_PM_PWSTST_DSP_InTransition_OFFSET))
@@ -646,7 +647,7 @@

 #define PRCMPM_PWSTST_IVA2InTransitionRead32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_IVA2InTransitionRead32),\
-      (((RD_MEM_32_VOLATILE((((u32)(baseAddress))+\
+      (((__raw_readl((((baseAddress))+\
        (PRCM_PM_PWSTST_IVA2_OFFSET)))) &\
       PRCM_PM_PWSTST_IVA2_InTransition_MASK) >>\
       PRCM_PM_PWSTST_IVA2_InTransition_OFFSET))
diff --git a/drivers/dsp/bridge/hw/hw_dspssC64P.c b/drivers/dsp/bridge/hw/hw_dspssC64P.c
index 029aff5..0d0d45c
--- a/drivers/dsp/bridge/hw/hw_dspssC64P.c
+++ b/drivers/dsp/bridge/hw/hw_dspssC64P.c
@@ -27,6 +27,7 @@

 /* PROJECT SPECIFIC INCLUDE FILES */
 #include <GlobalTypes.h>
+#include <linux/io.h>
 #include <hw_defs.h>
 #include <hw_dspssC64P.h>
 #include <IVA2RegAcM.h>
@@ -43,13 +44,13 @@ HW_STATUS HW_DSPSS_BootModeSet(const u32 baseAddress,

        /* if Boot mode it DIRECT BOOT, check that the bootAddress is
         * aligned to atleast 1K :: TODO */
-       WR_MEM_32_VOLATILE((baseAddress) + offset, bootMode);
+       __raw_writel(bootMode, (baseAddress) + offset);

        offset = SYSC_IVA2BOOTADDR_OFFSET;

        alignedBootAddr = bootAddress & SYSC_IVA2BOOTADDR_MASK;

-       WR_MEM_32_VOLATILE((baseAddress) + offset, alignedBootAddr);
+       __raw_writel(alignedBootAddr, (baseAddress) + offset);

        return status;
 }
--
1.5.6.4

