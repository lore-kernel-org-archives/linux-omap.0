From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [OMAPZOOM][PATCH 3/5] DSPBRIDGE: Change address resources to void
 __iomem *
Date: Mon, 2 Mar 2009 19:34:06 -0600
Message-ID: <496565EC904933469F292DDA3F1663E60287B84DF9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38140 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062AbZCCBeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 20:34:10 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n231Y46Q029436
	for <linux-omap@vger.kernel.org>; Mon, 2 Mar 2009 19:34:09 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n231Y4H1001146
	for <linux-omap@vger.kernel.org>; Mon, 2 Mar 2009 19:34:04 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Aguilar Pena, Leed" <leed.aguilar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 23 Feb 2009 18:12:27 -0600
Subject: [PATCH] DSPBRIDGE: Change address resources to void __iomem *

This patch changes address resources to void __iomem *
Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h |   16 ++++----
 drivers/dsp/bridge/hw/hw_dspssC64P.c           |    2 +-
 drivers/dsp/bridge/hw/hw_dspssC64P.h           |    2 +-
 drivers/dsp/bridge/hw/hw_mbox.c                |   30 +++++++------
 drivers/dsp/bridge/hw/hw_mbox.h                |   18 ++++----
 drivers/dsp/bridge/hw/hw_mmu.c                 |   43 ++++++++++----------
 drivers/dsp/bridge/hw/hw_mmu.h                 |   30 +++++++-------
 drivers/dsp/bridge/hw/hw_prcm.c                |   26 ++++++------
 drivers/dsp/bridge/hw/hw_prcm.h                |   17 ++++----
 drivers/dsp/bridge/rmgr/drv.c                  |   52 ++++++++++++------------
 drivers/dsp/bridge/rmgr/node.c                 |    2 +-
 drivers/dsp/bridge/wmd/_tiomap.h               |    2 +-
 drivers/dsp/bridge/wmd/tiomap3430.c            |   47 ++++++++++-----------
 13 files changed, 145 insertions(+), 142 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index ca96b3c..e7633b5
--- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -96,14 +96,14 @@
                u32 dwChnlOffset;
                u32 dwChnlBufSize;
                u32 dwNumChnls;
-               u32 dwPrmBase;
-               u32 dwCmBase;
-               u32 dwPerBase;
-               u32 dwWdTimerDspBase;
-               u32 dwMboxBase;
-               u32 dwDmmuBase;
-               u32 dwDipiBase;
-               u32 dwSysCtrlBase;
+               void __iomem *dwPrmBase;
+               void __iomem *dwCmBase;
+               void __iomem *dwPerBase;
+               void __iomem *dwWdTimerDspBase;
+               void __iomem *dwMboxBase;
+               void __iomem *dwDmmuBase;
+               u32 *dwDipiBase;
+               void __iomem *dwSysCtrlBase;
        } ;

        struct CFG_DSPMEMDESC {
diff --git a/drivers/dsp/bridge/hw/hw_dspssC64P.c b/drivers/dsp/bridge/hw/hw_dspssC64P.c
index 0d0d45c..6aac57d
--- a/drivers/dsp/bridge/hw/hw_dspssC64P.c
+++ b/drivers/dsp/bridge/hw/hw_dspssC64P.c
@@ -34,7 +34,7 @@
 #include <IPIAccInt.h>

 /* HW FUNCTIONS */
-HW_STATUS HW_DSPSS_BootModeSet(const u32 baseAddress,
+HW_STATUS HW_DSPSS_BootModeSet(const void __iomem *baseAddress,
                      enum HW_DSPSYSC_BootMode_t bootMode,
                      const u32 bootAddress)
 {
diff --git a/drivers/dsp/bridge/hw/hw_dspssC64P.h b/drivers/dsp/bridge/hw/hw_dspssC64P.h
index 493effd..50f9af4
--- a/drivers/dsp/bridge/hw/hw_dspssC64P.h
+++ b/drivers/dsp/bridge/hw/hw_dspssC64P.h
@@ -41,7 +41,7 @@

 #define HW_DSP_IDLEBOOT_ADDR   0x007E0000

-       extern HW_STATUS HW_DSPSS_BootModeSet(const u32 baseAddress,
+       extern HW_STATUS HW_DSPSS_BootModeSet(const void __iomem *baseAddress,
                                        enum HW_DSPSYSC_BootMode_t bootMode,
                                        const u32 bootAddress);

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index bc61d64..93fa51e
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -36,7 +37,7 @@
 struct MAILBOX_CONTEXT mboxsetting = {0x4, 0x1, 0x1};

 /* Saves the mailbox context */
-HW_STATUS HW_MBOX_saveSettings(u32 baseAddress)
+HW_STATUS HW_MBOX_saveSettings(void __iomem *baseAddress)
 {
        HW_STATUS status = RET_OK;

@@ -50,7 +51,7 @@ HW_STATUS HW_MBOX_saveSettings(u32 baseAddress)
 }

 /* Restores the mailbox context */
-HW_STATUS HW_MBOX_restoreSettings(u32 baseAddress)
+HW_STATUS HW_MBOX_restoreSettings(void __iomem *baseAddress)
 {
         HW_STATUS status = RET_OK;
        /* Restor IRQ enable status */
@@ -65,8 +66,8 @@ HW_STATUS HW_MBOX_restoreSettings(u32 baseAddress)

 /* Reads a u32 from the sub module message box Specified. if there are no
  * messages in the mailbox then and error is returned. */
-HW_STATUS HW_MBOX_MsgRead(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
-                               u32 *const pReadValue)
+HW_STATUS HW_MBOX_MsgRead(const void __iomem *baseAddress,
+       const HW_MBOX_Id_t mailBoxId, u32 *const pReadValue)
 {
        HW_STATUS status = RET_OK;

@@ -86,8 +87,8 @@ HW_STATUS HW_MBOX_MsgRead(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
 }

 /* Writes a u32 from the sub module message box Specified. */
-HW_STATUS HW_MBOX_MsgWrite(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
-                       const u32 writeValue)
+HW_STATUS HW_MBOX_MsgWrite(const void __iomem *baseAddress,
+       const HW_MBOX_Id_t mailBoxId, const u32 writeValue)
 {
        HW_STATUS status = RET_OK;

@@ -105,8 +106,8 @@ HW_STATUS HW_MBOX_MsgWrite(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
 }

 /* Reads the full status register for mailbox. */
-HW_STATUS HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
-                       u32 *const pIsFull)
+HW_STATUS HW_MBOX_IsFull(const void __iomem *baseAddress,
+       const HW_MBOX_Id_t mailBoxId, u32 *const pIsFull)
 {
        HW_STATUS status = RET_OK;
        u32 fullStatus;
@@ -130,8 +131,8 @@ HW_STATUS HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
 }

 /* Gets number of messages in a specified mailbox. */
-HW_STATUS HW_MBOX_NumMsgGet(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
-                               u32 *const pNumMsg)
+HW_STATUS HW_MBOX_NumMsgGet(const void __iomem *baseAddress,
+       const HW_MBOX_Id_t mailBoxId, u32 *const pNumMsg)
 {
        HW_STATUS status = RET_OK;

@@ -152,7 +153,7 @@ HW_STATUS HW_MBOX_NumMsgGet(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
 }

 /* Enables the specified IRQ. */
-HW_STATUS HW_MBOX_EventEnable(const u32        baseAddress,
+HW_STATUS HW_MBOX_EventEnable(const void __iomem *baseAddress,
                                const HW_MBOX_Id_t mailBoxId,
                                const HW_MBOX_UserId_t userId,
                                const u32 events)
@@ -192,7 +193,7 @@ HW_STATUS HW_MBOX_EventEnable(const u32     baseAddress,
 }

 /* Disables the specified IRQ. */
-HW_STATUS HW_MBOX_EventDisable(const u32 baseAddress,
+HW_STATUS HW_MBOX_EventDisable(const void __iomem *baseAddress,
                                const HW_MBOX_Id_t mailBoxId,
                                const HW_MBOX_UserId_t userId,
                                const u32 events)
@@ -226,8 +227,9 @@ HW_STATUS HW_MBOX_EventDisable(const u32 baseAddress,
 }

 /* Sets the status of the specified IRQ. */
-HW_STATUS HW_MBOX_EventAck(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
-                       const HW_MBOX_UserId_t userId, const u32 event)
+HW_STATUS HW_MBOX_EventAck(const void __iomem *baseAddress,
+       const HW_MBOX_Id_t mailBoxId, const HW_MBOX_UserId_t userId,
+       const u32 event)
 {
        HW_STATUS status = RET_OK;
        u32 irqStatusReg;
diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/hw_mbox.h
index 225fb40..5d3d18f
--- a/drivers/dsp/bridge/hw/hw_mbox.h
+++ b/drivers/dsp/bridge/hw/hw_mbox.h
@@ -92,7 +92,7 @@ struct MAILBOX_CONTEXT {
 *               box Specified. if there are no messages in the mailbox
 *               then and error is returned.
 */
-extern HW_STATUS HW_MBOX_MsgRead(const u32 baseAddress,
+extern HW_STATUS HW_MBOX_MsgRead(const void __iomem *baseAddress,
                                const HW_MBOX_Id_t mailBoxId,
                                u32 *const pReadValue);

@@ -124,7 +124,7 @@ extern HW_STATUS HW_MBOX_MsgRead(const u32 baseAddress,
 *               box Specified.
 */
 extern HW_STATUS HW_MBOX_MsgWrite(
-                     const u32  baseAddress,
+                     const void __iomem *baseAddress,
                      const HW_MBOX_Id_t   mailBoxId,
                      const u32  writeValue
                  );
@@ -159,7 +159,7 @@ extern HW_STATUS HW_MBOX_MsgWrite(
 * PURPOSE:      : this function reads the full status register for mailbox.
 */
 extern HW_STATUS HW_MBOX_IsFull(
-                     const u32  baseAddress,
+                     const void __iomem *baseAddress,
                      const HW_MBOX_Id_t   mailBoxId,
                      u32 *const        pIsFull
                  );
@@ -193,7 +193,7 @@ extern HW_STATUS HW_MBOX_IsFull(
 * PURPOSE:      : this function gets number of messages in a specified mailbox.
 */
 extern HW_STATUS HW_MBOX_NumMsgGet(
-                     const u32  baseAddress,
+                     const void         __iomem *baseAddress,
                      const HW_MBOX_Id_t   mailBoxId,
                      u32 *const        pNumMsg
                  );
@@ -229,7 +229,7 @@ extern HW_STATUS HW_MBOX_NumMsgGet(
 * PURPOSE:      : this function enables the specified IRQ.
 */
 extern HW_STATUS HW_MBOX_EventEnable(
-                     const u32      baseAddress,
+                     const void __iomem *baseAddress,
                      const HW_MBOX_Id_t       mailBoxId,
                      const HW_MBOX_UserId_t   userId,
                      const u32      events
@@ -266,7 +266,7 @@ extern HW_STATUS HW_MBOX_EventEnable(
 * PURPOSE:      : this function disables the specified IRQ.
 */
 extern HW_STATUS HW_MBOX_EventDisable(
-                     const u32      baseAddress,
+                     const void __iomem *baseAddress,
                      const HW_MBOX_Id_t       mailBoxId,
                      const HW_MBOX_UserId_t   userId,
                      const u32      events
@@ -305,7 +305,7 @@ extern HW_STATUS HW_MBOX_EventDisable(
 * PURPOSE:      : this function sets the status of the specified IRQ.
 */
 extern HW_STATUS HW_MBOX_EventAck(
-                     const u32       baseAddress,
+                     const void        __iomem *baseAddress,
                      const HW_MBOX_Id_t        mailBoxId,
                      const HW_MBOX_UserId_t    userId,
                      const u32       event
@@ -331,7 +331,7 @@ extern HW_STATUS HW_MBOX_EventAck(
 *
 * PURPOSE:      : this function saves the context of mailbox
 */
-extern HW_STATUS HW_MBOX_saveSettings(u32    baseAddres);
+extern HW_STATUS HW_MBOX_saveSettings(void __iomem *baseAddres);

 /*
 * FUNCTION      : HW_MBOX_restoreSettings
@@ -353,6 +353,6 @@ extern HW_STATUS HW_MBOX_saveSettings(u32    baseAddres);
 *
 * PURPOSE:      : this function restores the context of mailbox
 */
-extern HW_STATUS HW_MBOX_restoreSettings(u32    baseAddres);
+extern HW_STATUS HW_MBOX_restoreSettings(void __iomem *baseAddres);

 #endif  /* __MBOX_H */
diff --git a/drivers/dsp/bridge/hw/hw_mmu.c b/drivers/dsp/bridge/hw/hw_mmu.c
index da7e092..3f2b75c
--- a/drivers/dsp/bridge/hw/hw_mmu.c
+++ b/drivers/dsp/bridge/hw/hw_mmu.c
@@ -30,6 +30,7 @@
  */

 #include <GlobalTypes.h>
+#include <linux/io.h>
 #include "MMURegAcM.h"
 #include <hw_defs.h>
 #include <hw_mmu.h>
@@ -79,7 +80,7 @@ enum HW_MMUPageSize_t {
 * METHOD:             : Check the Input parameter and Flush a
 *                       single entry in the TLB.
 */
-static HW_STATUS MMU_FlushEntry(const u32 baseAddress);
+static HW_STATUS MMU_FlushEntry(const void __iomem *baseAddress);

 /*
 * FUNCTION           : MMU_SetCAMEntry
@@ -121,7 +122,7 @@ static HW_STATUS MMU_FlushEntry(const u32 baseAddress);
 *
 * METHOD:              : Check the Input parameters and set the CAM entry.
 */
-static HW_STATUS MMU_SetCAMEntry(const u32    baseAddress,
+static HW_STATUS MMU_SetCAMEntry(const void __iomem *baseAddress,
                                   const u32    pageSize,
                                   const u32    preservedBit,
                                   const u32    validBit,
@@ -166,7 +167,7 @@ static HW_STATUS MMU_SetCAMEntry(const u32    baseAddress,
 *
 * METHOD:             : Check the Input parameters and set the RAM entry.
 */
-static HW_STATUS MMU_SetRAMEntry(const u32     baseAddress,
+static HW_STATUS MMU_SetRAMEntry(const void __iomem *baseAddress,
                                   const u32    physicalAddr,
                                   enum HW_Endianism_t      endianism,
                                   enum HW_ElementSize_t    elementSize,
@@ -174,7 +175,7 @@ static HW_STATUS MMU_SetRAMEntry(const u32  baseAddress,

 /* HW FUNCTIONS */

-HW_STATUS HW_MMU_Enable(const u32 baseAddress)
+HW_STATUS HW_MMU_Enable(const void __iomem *baseAddress)
 {
     HW_STATUS status = RET_OK;

@@ -183,7 +184,7 @@ HW_STATUS HW_MMU_Enable(const u32 baseAddress)
     return status;
 }

-HW_STATUS HW_MMU_Disable(const u32 baseAddress)
+HW_STATUS HW_MMU_Disable(const void __iomem *baseAddress)
 {
     HW_STATUS status = RET_OK;

@@ -192,7 +193,7 @@ HW_STATUS HW_MMU_Disable(const u32 baseAddress)
     return status;
 }

-HW_STATUS HW_MMU_NumLockedSet(const u32 baseAddress,
+HW_STATUS HW_MMU_NumLockedSet(const void __iomem *baseAddress,
                                u32 numLockedEntries)
 {
     HW_STATUS status = RET_OK;
@@ -202,7 +203,7 @@ HW_STATUS HW_MMU_NumLockedSet(const u32 baseAddress,
     return status;
 }

-HW_STATUS HW_MMU_VictimNumSet(const u32 baseAddress,
+HW_STATUS HW_MMU_VictimNumSet(const void __iomem *baseAddress,
                                u32 victimEntryNum)
 {
     HW_STATUS status = RET_OK;
@@ -212,7 +213,7 @@ HW_STATUS HW_MMU_VictimNumSet(const u32 baseAddress,
     return status;
 }

-HW_STATUS HW_MMU_TLBFlushAll(const u32 baseAddress)
+HW_STATUS HW_MMU_TLBFlushAll(const void __iomem *baseAddress)
 {
     HW_STATUS status = RET_OK;

@@ -221,7 +222,7 @@ HW_STATUS HW_MMU_TLBFlushAll(const u32 baseAddress)
     return status;
 }

-HW_STATUS HW_MMU_EventAck(const u32 baseAddress, u32 irqMask)
+HW_STATUS HW_MMU_EventAck(const void __iomem *baseAddress, u32 irqMask)
 {
     HW_STATUS status = RET_OK;

@@ -230,7 +231,7 @@ HW_STATUS HW_MMU_EventAck(const u32 baseAddress, u32 irqMask)
     return status;
 }

-HW_STATUS HW_MMU_EventDisable(const u32 baseAddress,
+HW_STATUS HW_MMU_EventDisable(const void __iomem *baseAddress,
                                u32 irqMask)
 {
     HW_STATUS status = RET_OK;
@@ -243,7 +244,7 @@ HW_STATUS HW_MMU_EventDisable(const u32 baseAddress,
     return status;
 }

-HW_STATUS HW_MMU_EventEnable(const u32 baseAddress, u32 irqMask)
+HW_STATUS HW_MMU_EventEnable(const void __iomem *baseAddress, u32 irqMask)
 {
     HW_STATUS status = RET_OK;
     u32 irqReg;
@@ -256,7 +257,7 @@ HW_STATUS HW_MMU_EventEnable(const u32 baseAddress, u32 irqMask)
 }


-HW_STATUS HW_MMU_EventStatus(const u32 baseAddress, u32 *irqMask)
+HW_STATUS HW_MMU_EventStatus(const void __iomem *baseAddress, u32 *irqMask)
 {
     HW_STATUS status = RET_OK;

@@ -266,7 +267,7 @@ HW_STATUS HW_MMU_EventStatus(const u32 baseAddress, u32 *irqMask)
 }


-HW_STATUS HW_MMU_FaultAddrRead(const u32 baseAddress, u32 *addr)
+HW_STATUS HW_MMU_FaultAddrRead(const void __iomem *baseAddress, u32 *addr)
 {
     HW_STATUS status = RET_OK;

@@ -280,7 +281,7 @@ HW_STATUS HW_MMU_FaultAddrRead(const u32 baseAddress, u32 *addr)
     return status;
 }

-HW_STATUS HW_MMU_TTBSet(const u32 baseAddress, u32 TTBPhysAddr)
+HW_STATUS HW_MMU_TTBSet(const void __iomem *baseAddress, u32 TTBPhysAddr)
 {
     HW_STATUS status = RET_OK;
     u32 loadTTB;
@@ -296,7 +297,7 @@ HW_STATUS HW_MMU_TTBSet(const u32 baseAddress, u32 TTBPhysAddr)
    return status;
 }

-HW_STATUS HW_MMU_TWLEnable(const u32 baseAddress)
+HW_STATUS HW_MMU_TWLEnable(const void __iomem *baseAddress)
 {
     HW_STATUS status = RET_OK;

@@ -305,7 +306,7 @@ HW_STATUS HW_MMU_TWLEnable(const u32 baseAddress)
     return status;
 }

-HW_STATUS HW_MMU_TWLDisable(const u32 baseAddress)
+HW_STATUS HW_MMU_TWLDisable(const void __iomem *baseAddress)
 {
     HW_STATUS status = RET_OK;

@@ -314,7 +315,7 @@ HW_STATUS HW_MMU_TWLDisable(const u32 baseAddress)
     return status;
 }

-HW_STATUS HW_MMU_TLBFlush(const u32 baseAddress, u32 virtualAddr,
+HW_STATUS HW_MMU_TLBFlush(const void __iomem *baseAddress, u32 virtualAddr,
                             u32 pageSize)
 {
     HW_STATUS status = RET_OK;
@@ -352,7 +353,7 @@ HW_STATUS HW_MMU_TLBFlush(const u32 baseAddress, u32 virtualAddr,
     return status;
 }

-HW_STATUS HW_MMU_TLBAdd(const u32      baseAddress,
+HW_STATUS HW_MMU_TLBAdd(const void __iomem *baseAddress,
                           u32        physicalAddr,
                           u32        virtualAddr,
                           u32        pageSize,
@@ -538,7 +539,7 @@ HW_STATUS HW_MMU_PteClear(const u32  pgTblVa,
 }

 /* MMU_FlushEntry */
-static HW_STATUS MMU_FlushEntry(const u32 baseAddress)
+static HW_STATUS MMU_FlushEntry(const void __iomem *baseAddress)
 {
    HW_STATUS status = RET_OK;
    u32 flushEntryData = 0x1;
@@ -554,7 +555,7 @@ static HW_STATUS MMU_FlushEntry(const u32 baseAddress)
 }

 /* MMU_SetCAMEntry */
-static HW_STATUS MMU_SetCAMEntry(const u32    baseAddress,
+static HW_STATUS MMU_SetCAMEntry(const void __iomem *baseAddress,
                                   const u32    pageSize,
                                   const u32    preservedBit,
                                   const u32    validBit,
@@ -578,7 +579,7 @@ static HW_STATUS MMU_SetCAMEntry(const u32    baseAddress,
 }

 /* MMU_SetRAMEntry */
-static HW_STATUS MMU_SetRAMEntry(const u32       baseAddress,
+static HW_STATUS MMU_SetRAMEntry(const void __iomem *baseAddress,
                                   const u32       physicalAddr,
                                   enum HW_Endianism_t     endianism,
                                   enum HW_ElementSize_t   elementSize,
diff --git a/drivers/dsp/bridge/hw/hw_mmu.h b/drivers/dsp/bridge/hw/hw_mmu.h
index 924f32b..dc1aec1
--- a/drivers/dsp/bridge/hw/hw_mmu.h
+++ b/drivers/dsp/bridge/hw/hw_mmu.h
@@ -53,47 +53,47 @@ struct HW_MMUMapAttrs_t {
        enum HW_MMUMixedSize_t  mixedSize;
 } ;

-extern HW_STATUS HW_MMU_Enable(const u32 baseAddress);
+extern HW_STATUS HW_MMU_Enable(const void __iomem *baseAddress);

-extern HW_STATUS HW_MMU_Disable(const u32 baseAddress);
+extern HW_STATUS HW_MMU_Disable(const void __iomem *baseAddress);

-extern HW_STATUS HW_MMU_NumLockedSet(const u32 baseAddress,
+extern HW_STATUS HW_MMU_NumLockedSet(const void __iomem *baseAddress,
                                        u32 numLockedEntries);

-extern HW_STATUS HW_MMU_VictimNumSet(const u32 baseAddress,
+extern HW_STATUS HW_MMU_VictimNumSet(const void __iomem *baseAddress,
                                        u32 victimEntryNum);

 /* For MMU faults */
-extern HW_STATUS HW_MMU_EventAck(const u32 baseAddress,
+extern HW_STATUS HW_MMU_EventAck(const void __iomem *baseAddress,
                                    u32 irqMask);

-extern HW_STATUS HW_MMU_EventDisable(const u32 baseAddress,
+extern HW_STATUS HW_MMU_EventDisable(const void __iomem *baseAddress,
                                        u32 irqMask);

-extern HW_STATUS HW_MMU_EventEnable(const u32 baseAddress,
+extern HW_STATUS HW_MMU_EventEnable(const void __iomem *baseAddress,
                                       u32 irqMask);

-extern HW_STATUS HW_MMU_EventStatus(const u32 baseAddress,
+extern HW_STATUS HW_MMU_EventStatus(const void __iomem *baseAddress,
                                       u32 *irqMask);

-extern HW_STATUS HW_MMU_FaultAddrRead(const u32 baseAddress,
+extern HW_STATUS HW_MMU_FaultAddrRead(const void __iomem *baseAddress,
                                         u32 *addr);

 /* Set the TT base address */
-extern HW_STATUS HW_MMU_TTBSet(const u32 baseAddress,
+extern HW_STATUS HW_MMU_TTBSet(const void __iomem *baseAddress,
                                  u32 TTBPhysAddr);

-extern HW_STATUS HW_MMU_TWLEnable(const u32 baseAddress);
+extern HW_STATUS HW_MMU_TWLEnable(const void __iomem *baseAddress);

-extern HW_STATUS HW_MMU_TWLDisable(const u32 baseAddress);
+extern HW_STATUS HW_MMU_TWLDisable(const void __iomem *baseAddress);

-extern HW_STATUS HW_MMU_TLBFlush(const u32 baseAddress,
+extern HW_STATUS HW_MMU_TLBFlush(const void __iomem *baseAddress,
                                    u32 virtualAddr,
                                    u32 pageSize);

-extern HW_STATUS HW_MMU_TLBFlushAll(const u32 baseAddress);
+extern HW_STATUS HW_MMU_TLBFlushAll(const void __iomem *baseAddress);

-extern HW_STATUS HW_MMU_TLBAdd(const u32     baseAddress,
+extern HW_STATUS HW_MMU_TLBAdd(const void __iomem *baseAddress,
                                  u32      physicalAddr,
                                  u32      virtualAddr,
                                  u32      pageSize,
diff --git a/drivers/dsp/bridge/hw/hw_prcm.c b/drivers/dsp/bridge/hw/hw_prcm.c
index 61ff08f..8f04a70
--- a/drivers/dsp/bridge/hw/hw_prcm.c
+++ b/drivers/dsp/bridge/hw/hw_prcm.c
@@ -29,21 +29,21 @@
 #include <hw_defs.h>
 #include <hw_prcm.h>

-static HW_STATUS HW_RST_WriteVal(const u32 baseAddress,
+static HW_STATUS HW_RST_WriteVal(const void __iomem *baseAddress,
                                    enum HW_RstModule_t r,
                                    enum HW_SetClear_t val);

-HW_STATUS HW_RST_Reset(const u32 baseAddress, enum HW_RstModule_t r)
+HW_STATUS HW_RST_Reset(const void __iomem *baseAddress, enum HW_RstModule_t r)
 {
        return HW_RST_WriteVal(baseAddress, r, HW_SET);
 }

-HW_STATUS HW_RST_UnReset(const u32 baseAddress, enum HW_RstModule_t r)
+HW_STATUS HW_RST_UnReset(const void __iomem *baseAddress, enum HW_RstModule_t r)
 {
        return HW_RST_WriteVal(baseAddress, r, HW_CLEAR);
 }

-static HW_STATUS HW_RST_WriteVal(const u32 baseAddress,
+static HW_STATUS HW_RST_WriteVal(const void __iomem *baseAddress,
                                    enum HW_RstModule_t r,
                                    enum HW_SetClear_t val)
 {
@@ -66,8 +66,8 @@ static HW_STATUS HW_RST_WriteVal(const u32 baseAddress,
        return status;
 }

-HW_STATUS HW_PWR_IVA2StateGet(const u32 baseAddress, enum HW_PwrModule_t p,
-                               enum HW_PwrState_t *value)
+HW_STATUS HW_PWR_IVA2StateGet(const void __iomem *baseAddress,
+               enum HW_PwrModule_t p, enum HW_PwrState_t *value)
 {
        HW_STATUS status = RET_OK;
        u32 temp;
@@ -93,7 +93,7 @@ HW_STATUS HW_PWR_IVA2StateGet(const u32 baseAddress, enum HW_PwrModule_t p,
        return status;
 }

-HW_STATUS HW_PWRST_IVA2RegGet(const u32 baseAddress, u32 *value)
+HW_STATUS HW_PWRST_IVA2RegGet(const void __iomem *baseAddress, u32 *value)
 {
        HW_STATUS status = RET_OK;

@@ -103,7 +103,7 @@ HW_STATUS HW_PWRST_IVA2RegGet(const u32 baseAddress, u32 *value)
 }


-HW_STATUS HW_PWR_IVA2PowerStateSet(const u32 baseAddress,
+HW_STATUS HW_PWR_IVA2PowerStateSet(const void __iomem *baseAddress,
                                     enum HW_PwrModule_t p,
                                     enum HW_PwrState_t value)
 {
@@ -135,7 +135,7 @@ HW_STATUS HW_PWR_IVA2PowerStateSet(const u32 baseAddress,
        return status;
 }

-HW_STATUS HW_PWR_CLKCTRL_IVA2RegSet(const u32 baseAddress,
+HW_STATUS HW_PWR_CLKCTRL_IVA2RegSet(const void __iomem *baseAddress,
                                      enum HW_TransitionState_t val)
 {
        HW_STATUS status = RET_OK;
@@ -146,8 +146,8 @@ HW_STATUS HW_PWR_CLKCTRL_IVA2RegSet(const u32 baseAddress,

 }

-HW_STATUS HW_RSTST_RegGet(const u32 baseAddress, enum HW_RstModule_t m,
-                           u32 *value)
+HW_STATUS HW_RSTST_RegGet(const void __iomem *baseAddress,
+               enum HW_RstModule_t m, u32 *value)
 {
        HW_STATUS status = RET_OK;

@@ -156,8 +156,8 @@ HW_STATUS HW_RSTST_RegGet(const u32 baseAddress, enum HW_RstModule_t m,
        return status;
 }

-HW_STATUS HW_RSTCTRL_RegGet(const u32 baseAddress, enum HW_RstModule_t m,
-                             u32 *value)
+HW_STATUS HW_RSTCTRL_RegGet(const void __iomem *baseAddress,
+               enum HW_RstModule_t m, u32 *value)
 {
        HW_STATUS status = RET_OK;

diff --git a/drivers/dsp/bridge/hw/hw_prcm.h b/drivers/dsp/bridge/hw/hw_prcm.h
index 928486c..65c8bd1
--- a/drivers/dsp/bridge/hw/hw_prcm.h
+++ b/drivers/dsp/bridge/hw/hw_prcm.h
@@ -132,16 +132,16 @@ enum HW_TransitionState_t {
 } ;


-extern HW_STATUS HW_RST_Reset(const u32 baseAddress,
+extern HW_STATUS HW_RST_Reset(const void __iomem *baseAddress,
                                 enum HW_RstModule_t r);

-extern HW_STATUS HW_RST_UnReset(const u32 baseAddress,
+extern HW_STATUS HW_RST_UnReset(const void __iomem *baseAddress,
                                   enum HW_RstModule_t r);

-extern HW_STATUS HW_RSTCTRL_RegGet(const u32 baseAddress,
+extern HW_STATUS HW_RSTCTRL_RegGet(const void __iomem *baseAddress,
                                             enum HW_RstModule_t p,
                                             u32 *value);
-extern HW_STATUS HW_RSTST_RegGet(const u32 baseAddress,
+extern HW_STATUS HW_RSTST_RegGet(const void __iomem *baseAddress,
                                           enum HW_RstModule_t p, u32 *value);

 extern HW_STATUS HW_PWR_PowerStateSet(const u32 baseAddress,
@@ -152,17 +152,18 @@ extern HW_STATUS HW_CLK_SetInputClock(const u32 baseAddress,
                                        enum HW_GPtimer_t gpt,
                                        enum HW_Clocktype_t c);

-extern HW_STATUS HW_PWR_IVA2StateGet(const u32 baseAddress,
+extern HW_STATUS HW_PWR_IVA2StateGet(const void __iomem *baseAddress,
                                        enum HW_PwrModule_t p,
                                        enum HW_PwrState_t *value);

-extern HW_STATUS HW_PWRST_IVA2RegGet(const u32 baseAddress, u32 *value);
+extern HW_STATUS HW_PWRST_IVA2RegGet(const void __iomem *baseAddress,
+                                               u32 *value);

-extern HW_STATUS HW_PWR_IVA2PowerStateSet(const u32 baseAddress,
+extern HW_STATUS HW_PWR_IVA2PowerStateSet(const void __iomem *baseAddress,
                                            enum HW_PwrModule_t p,
                                            enum HW_PwrState_t value);

-extern HW_STATUS HW_PWR_CLKCTRL_IVA2RegSet(const u32 baseAddress,
+extern HW_STATUS HW_PWR_CLKCTRL_IVA2RegSet(const void __iomem *baseAddress,
                                             enum HW_TransitionState_t val);

 #endif  /* __HW_PRCM_H */
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 22faf49..07fde81
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1649,15 +1649,15 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                                        "%x. Not calling MEM_FreePhysMem\n",
                                        status);
                        }
                        pResources->dwMemBase[1] = 0;
                        pResources->dwMemPhys[1] = 0;

                        if (pResources->dwPrmBase)
-                               iounmap((void *)pResources->dwPrmBase);
+                               iounmap(pResources->dwPrmBase);
                        if (pResources->dwCmBase)
-                               iounmap((void *)pResources->dwCmBase);
+                               iounmap(pResources->dwCmBase);
                        if (pResources->dwMboxBase)
-                               iounmap((void *)pResources->dwMboxBase);
+                               iounmap(pResources->dwMboxBase);
                        if (pResources->dwMemBase[0])
                                iounmap((void *)pResources->dwMemBase[0]);
                        if (pResources->dwMemBase[2])
@@ -1667,26 +1667,26 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                        if (pResources->dwMemBase[4])
                                iounmap((void *)pResources->dwMemBase[4]);
                        if (pResources->dwWdTimerDspBase)
-                               iounmap((void *)pResources->dwWdTimerDspBase);
+                               iounmap(pResources->dwWdTimerDspBase);
                        if (pResources->dwDmmuBase)
-                               iounmap((void *)pResources->dwDmmuBase);
+                               iounmap(pResources->dwDmmuBase);
                        if (pResources->dwPerBase)
-                               iounmap((void *)pResources->dwPerBase);
+                               iounmap(pResources->dwPerBase);

                        if (pResources->dwSysCtrlBase) {
-                               iounmap((void *)pResources->dwSysCtrlBase);
+                               iounmap(pResources->dwSysCtrlBase);
                                /* don't set pResources->dwSysCtrlBase to null
                                 * as it is used in BOARD_Stop */
                        }
-                       pResources->dwPrmBase = (u32) NULL;
-                       pResources->dwCmBase = (u32) NULL;
-                       pResources->dwMboxBase = (u32) NULL;
-                       pResources->dwMemBase[0] = (u32) NULL;
-                       pResources->dwMemBase[2] = (u32) NULL;
-                       pResources->dwMemBase[3] = (u32) NULL;
-                       pResources->dwMemBase[4] = (u32) NULL;
-                       pResources->dwWdTimerDspBase = (u32) NULL;
-                       pResources->dwDmmuBase = (u32) NULL;
+                       pResources->dwPrmBase = NULL;
+                       pResources->dwCmBase = NULL;
+                       pResources->dwMboxBase = NULL;
+                       pResources->dwMemBase[0] = (u32)NULL;
+                       pResources->dwMemBase[2] = (u32)NULL;
+                       pResources->dwMemBase[3] = (u32)NULL;
+                       pResources->dwMemBase[4] = (u32)NULL;
+                       pResources->dwWdTimerDspBase = NULL;
+                       pResources->dwDmmuBase = NULL;

                        dwBuffSize = sizeof(struct CFG_HOSTRES);
                        status = REG_SetValue(NULL, (char *)driverExt->szString,
@@ -1705,13 +1705,13 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                pResources->wNumMemWindows = 2;
                /* First window is for DSP internal memory */

-               pResources->dwPrmBase = (u32)ioremap(OMAP_IVA2_PRM_BASE,
+               pResources->dwPrmBase = ioremap(OMAP_IVA2_PRM_BASE,
                                                        OMAP_IVA2_PRM_SIZE);
-               pResources->dwCmBase = (u32)ioremap(OMAP_IVA2_CM_BASE,
+               pResources->dwCmBase = ioremap(OMAP_IVA2_CM_BASE,
                                                        OMAP_IVA2_CM_SIZE);
-               pResources->dwMboxBase = (u32)ioremap(OMAP_MBOX_BASE,
+               pResources->dwMboxBase = ioremap(OMAP_MBOX_BASE,
                                                        OMAP_MBOX_SIZE);
-               pResources->dwSysCtrlBase = (u32)ioremap(OMAP_SYSC_BASE,
+               pResources->dwSysCtrlBase = ioremap(OMAP_SYSC_BASE,
                                                        OMAP_SYSC_SIZE);
                GT_1trace(curTrace, GT_2CLASS, "dwMemBase[0] 0x%x\n",
                         pResources->dwMemBase[0]);
@@ -1797,18 +1797,18 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
                /* wNumMemWindows must not be more than CFG_MAXMEMREGISTERS */
                pResources->wNumMemWindows = 4;

                pResources->dwMemBase[0] = 0;
                pResources->dwMemBase[2] = (u32)ioremap(OMAP_DSP_MEM1_BASE,
                                                        OMAP_DSP_MEM1_SIZE);
                pResources->dwMemBase[3] = (u32)ioremap(OMAP_DSP_MEM2_BASE,
                                                        OMAP_DSP_MEM2_SIZE);
                pResources->dwMemBase[4] = (u32)ioremap(OMAP_DSP_MEM3_BASE,
                                                        OMAP_DSP_MEM3_SIZE);
-               pResources->dwPerBase = (u32)ioremap(OMAP_PER_CM_BASE,
+               pResources->dwPerBase = ioremap(OMAP_PER_CM_BASE,
                                                        OMAP_PER_CM_SIZE);
-               pResources->dwDmmuBase = (u32)ioremap(OMAP_DMMU_BASE,
+               pResources->dwDmmuBase = ioremap(OMAP_DMMU_BASE,
                                                        OMAP_DMMU_SIZE);
-               pResources->dwWdTimerDspBase = 0;
+               pResources->dwWdTimerDspBase = NULL;

                GT_1trace(curTrace, GT_2CLASS, "dwMemBase[0] 0x%x\n",
                                                pResources->dwMemBase[0]);
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 1db32e9..2b029c7
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -717,7 +717,7 @@ func_cont2:
                                "0x%x\n", status);
                        }

-                       ulGppMemBase = hostRes.dwMemBase[1];
+                       ulGppMemBase = (u32)hostRes.dwMemBase[1];
                        offSet = pulValue - dynextBase;
                        ulStackSegAddr = ulGppMemBase + offSet;
                        ulStackSegVal = (u32)*((REG_UWORD32 *)
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 5267eb2..3cd2237
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -362,7 +362,7 @@ struct WMD_DEV_CONTEXT {
         */
        u32 dwDspExtBaseAddr;   /* See the comment above        */
        u32 dwAPIRegBase;       /* API memory mapped registers  */
-       u32 dwDSPMmuBase;       /* DSP MMU Mapped registers     */
+       void __iomem *dwDSPMmuBase;     /* DSP MMU Mapped registers     */
        u32 dwMailBoxBase;      /* Mail box mapped registers    */
        u32 dwAPIClkBase;       /* CLK Registers                */
        u32 dwDSPClkM2Base;     /* DSP Clock Module m2          */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 730f9b5..ad813e4
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -131,9 +131,9 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
                        u32 ulMpuAddr, u32 ulVirtAddr,
                        u32 ulNumBytes, u32 ulMapAttr);
-static DSP_STATUS run_IdleBoot(u32 prcm_base, u32 cm_base,
-                       u32 sysctrl_base);
-void GetHWRegs(u32 prcm_base, u32 cm_base);
+static DSP_STATUS run_IdleBoot(void __iomem *prcm_base, void __iomem *cm_base,
+                       void __iomem *sysctrl_base);
+static void GetHWRegs(void __iomem *prcm_base, void __iomem *cm_base);

 /*  ----------------------------------- Globals */

@@ -505,11 +505,10 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                HW_MMU_TWLEnable(resources.dwDmmuBase);
                /* Enable the SmartIdle and AutoIdle bit for MMU_SYSCONFIG */

-               temp = (u32) *((REG_UWORD32 *)
-                               ((u32) (resources.dwDmmuBase) + 0x10));
+
+               temp = __raw_readl((resources.dwDmmuBase) + 0x10);
                temp = (temp & 0xFFFFFFEF) | 0x11;
-               *((REG_UWORD32 *) ((u32) (resources.dwDmmuBase) + 0x10)) =
-                       (u32) temp;
+               __raw_writel(temp, (resources.dwDmmuBase) + 0x10);

                /* Let the DSP MMU run */
                HW_MMU_Enable(resources.dwDmmuBase);
@@ -2069,8 +2068,8 @@ func_cont:
        return status;
 }

-static DSP_STATUS run_IdleBoot(u32 prm_base, u32 cm_base,
-                              u32 sysctrl_base)
+static DSP_STATUS run_IdleBoot(void __iomem *prm_base, void __iomem *cm_base,
+                              void __iomem *sysctrl_base)
 {
        u32 temp;
        DSP_STATUS status = DSP_SOK;
@@ -2096,10 +2095,10 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, u32 cm_base,
        }
        udelay(10);
        /* Assert IVA2-RST1 and IVA2-RST2  */
-       *((REG_UWORD32 *)((u32)(prm_base) + 0x50)) = (u32)0x07;
+       __raw_writel((u32)0x07, (prm_base) + 0x50);
        udelay(30);
        /* set the SYSC for Idle Boot */
-       *((REG_UWORD32 *)((u32)(sysctrl_base) + 0x404)) = (u32)0x01;
+       __raw_writel((u32)0x01, (sysctrl_base) + 0x404);
        clk_status = CLK_Enable(SERVICESCLK_iva2_ck);
        if (DSP_FAILED(clk_status)) {
                DBG_Trace(DBG_LEVEL6, "CLK_Enable failed for clk = 0x%x \n",
@@ -2108,36 +2107,36 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, u32 cm_base,
        udelay(20);
        GetHWRegs(prm_base, cm_base);
        /* Release Reset1 and Reset2 */
-       *((REG_UWORD32 *)((u32)(prm_base) + 0x50)) = (u32)0x05;
+       __raw_writel((u32)0x05, (prm_base) + 0x50);
        udelay(20);
-       *((REG_UWORD32 *)((u32)(prm_base) + 0x50)) = (u32)0x04;
+       __raw_writel((u32)0x04, (prm_base) + 0x50);
        udelay(30);
        return status;
 }


-void GetHWRegs(u32 prm_base, u32 cm_base)
+static void GetHWRegs(void __iomem *prm_base, void __iomem *cm_base)
 {
        u32 temp;
-       temp = (u32)*((REG_UWORD32 *)((u32)(cm_base) + 0x00));
+       temp = __raw_readl((cm_base) + 0x00);
           DBG_Trace(DBG_LEVEL6, "CM_FCLKEN_IVA2 = 0x%x \n", temp);
-       temp = (u32)*((REG_UWORD32 *)((u32)(cm_base) + 0x10));
+       temp = __raw_readl((cm_base) + 0x10);
           DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_IVA2 = 0x%x \n", temp);
-       temp = (u32)*((REG_UWORD32 *)((u32)(cm_base) + 0x20));
+       temp = __raw_readl((cm_base) + 0x20);
           DBG_Trace(DBG_LEVEL6, "CM_IDLEST_IVA2 = 0x%x \n", temp);
-       temp = (u32)*((REG_UWORD32 *)((u32)(cm_base) + 0x48));
+       temp = __raw_readl((cm_base) + 0x48);
           DBG_Trace(DBG_LEVEL6, "CM_CLKSTCTRL_IVA2 = 0x%x \n", temp);
-       temp = (u32)*((REG_UWORD32 *)((u32)(cm_base) + 0x4c));
+       temp = __raw_readl((cm_base) + 0x4c);
           DBG_Trace(DBG_LEVEL6, "CM_CLKSTST_IVA2 = 0x%x \n", temp);
-       temp = (u32)*((REG_UWORD32 *)((u32)(prm_base) + 0x50));
+       temp = __raw_readl((prm_base) + 0x50);
           DBG_Trace(DBG_LEVEL6, "RM_RSTCTRL_IVA2 = 0x%x \n", temp);
-       temp = (u32)*((REG_UWORD32 *)((u32)(prm_base) + 0x58));
+       temp = __raw_readl((prm_base) + 0x58);
           DBG_Trace(DBG_LEVEL6, "RM_RSTST_IVA2 = 0x%x \n", temp);
-       temp = (u32)*((REG_UWORD32 *)((u32)(prm_base) + 0xE0));
+       temp = __raw_readl((prm_base) + 0xE0);
           DBG_Trace(DBG_LEVEL6, "PM_PWSTCTRL_IVA2 = 0x%x \n", temp);
-       temp = (u32)*((REG_UWORD32 *)((u32)(prm_base) + 0xE4));
+       temp = __raw_readl((prm_base) + 0xE4);
           DBG_Trace(DBG_LEVEL6, "PM_PWSTST_IVA2 = 0x%x \n", temp);
-       temp = (u32)*((REG_UWORD32 *)((u32)(cm_base) + 0xA10));
+       temp = __raw_readl((cm_base) + 0xA10);
           DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_CORE = 0x%x \n", temp);
 }

--
1.5.6.4

