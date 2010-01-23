From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: Remove enum definitions and replace with macros
Date: Fri, 22 Jan 2010 22:44:30 -0600
Message-ID: <1264221870-11178-3-git-send-email-omar.ramirez@ti.com>
References: <1264221870-11178-1-git-send-email-omar.ramirez@ti.com>
 <1264221870-11178-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50562 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415Ab0AWEeI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jan 2010 23:34:08 -0500
In-Reply-To: <1264221870-11178-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>

From: Shivananda Hebbar <x0hebbar@ti.com>

This patch removes unrelated enum constants and replaces it with
the macros

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |   11 +++++------
 arch/arm/plat-omap/include/dspbridge/cmm.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/cmmdefs.h  |   10 ++--------
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |   10 +++-------
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |    5 ++---
 drivers/dsp/bridge/hw/hw_defs.h                 |    8 +++-----
 drivers/dsp/bridge/hw/hw_mmu.c                  |    3 +--
 drivers/dsp/bridge/hw/hw_mmu.h                  |    3 +--
 drivers/dsp/bridge/hw/hw_prcm.c                 |    6 ++----
 drivers/dsp/bridge/pmgr/cmm.c                   |    5 ++---
 drivers/dsp/bridge/wmd/_tiomap.h                |    8 ++------
 drivers/dsp/bridge/wmd/io_sm.c                  |    3 +--
 12 files changed, 25 insertions(+), 49 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 6e812b2..b142ede 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -45,6 +45,11 @@
 
 #define MAXOPPS 16
 
+/* Shared memory config options */
+#define SHM_CURROPP	0	/* Set current OPP in SHM */
+#define SHM_OPPINFO	1	/* Set dsp voltage and freq table values */
+#define SHM_GETOPP	2	/* Get opp requested by DSP */
+
 struct oppTableEntry {
     u32 voltage;
     u32 frequency;
@@ -72,12 +77,6 @@ struct loadMonStruct {
     u32 predDspFreq;
 };
 
-	enum SHM_DESCTYPE {
-		SHM_CURROPP = 0,
-		SHM_OPPINFO = 1,
-		SHM_GETOPP = 2,		/* Get DSP requested OPP info */
-	} ;
-
 /* Structure in shared between DSP and PC for communication.*/
 	struct SHM {
 		u32 dspFreeMask;	/* Written by DSP, read by PC. */
diff --git a/arch/arm/plat-omap/include/dspbridge/cmm.h b/arch/arm/plat-omap/include/dspbridge/cmm.h
index fc2f51e..30402c2 100644
--- a/arch/arm/plat-omap/include/dspbridge/cmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/cmm.h
@@ -227,7 +227,7 @@
 					       unsigned int dwGPPBasePA,
 					       u32 ulSize,
 					       u32 dwDSPAddrOffset,
-					       enum CMM_CNVTTYPE cFactor,
+					       s8  cFactor,
 					       unsigned int dwDSPBase,
 					       u32 ulDSPSize,
 					       u32 *pulSegId,
diff --git a/arch/arm/plat-omap/include/dspbridge/cmmdefs.h b/arch/arm/plat-omap/include/dspbridge/cmmdefs.h
index 91db7a9..c6eb6dd 100644
--- a/arch/arm/plat-omap/include/dspbridge/cmmdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cmmdefs.h
@@ -39,15 +39,9 @@
  *  For typical platforms:
  *      converted Address = PaDSP + ( cFactor * addressToConvert).
  */
-	enum CMM_CNVTTYPE {
-		CMM_SUBFROMDSPPA = -1,
-		/* PreOMAP is special case: not simple offset */
-		CMM_POMAPEMIF2DSPBUS = 0,
-		CMM_ADDTODSPPA = 1
-	} ;
+#define CMM_SUBFROMDSPPA	-1
+#define CMM_ADDTODSPPA		1
 
-#define CMM_DEFLTDSPADDROFFSET  0
-#define CMM_DEFLTCONVFACTOR     CMM_POMAPEMIF2DSPBUS /* PreOMAP DSPBUS<->EMIF */
 #define CMM_ALLSEGMENTS         0xFFFFFF	/* All SegIds */
 #define CMM_MAXGPPSEGS          1	/* Maximum # of SM segs */
 
diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index fc9fdc8..a05d339 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -106,6 +106,9 @@
 
 #define    MAX_PROFILES     16
 
+/* DSP chip type */
+#define DSPTYPE_64	0x99
+
 /* Types defined for 'Bridge API */
 	typedef u32 DSP_STATUS;	/* API return code type         */
 
@@ -403,13 +406,6 @@
 		u32 cbStruct;
 		u32 uTimeout;
 	} ;
-
-	enum chipTypes {
-		DSPTYPE_55 = 6,
-		IVA_ARM7 = 0x97,
-		DSPTYPE_64 = 0x99
-	};
-
 /*
  * The DSP_PROCESSORINFO structure describes basic capabilities of a
  * DSP processor
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index 67e3834..8eae7af 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -260,9 +260,8 @@
  *      pArgs != NULL
  *  Ensures:
  */
-	extern DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr,
-					IN enum SHM_DESCTYPE desc,
-					IN void *pArgs);
+	extern DSP_STATUS IO_SHMsetting(struct IO_MGR *hIOMgr,
+					u8 desc, void *pArgs);
 
 /*
  *  Misc functions for the CHNL_IO shared memory library:
diff --git a/drivers/dsp/bridge/hw/hw_defs.h b/drivers/dsp/bridge/hw/hw_defs.h
index a7926d4..827fff3 100644
--- a/drivers/dsp/bridge/hw/hw_defs.h
+++ b/drivers/dsp/bridge/hw/hw_defs.h
@@ -30,11 +30,9 @@
 /* HW_STATUS:  return type for HW API */
 typedef long HW_STATUS;
 
-/* HW_SetClear_t:  Enumerated Type used to set and clear any bit */
-enum HW_SetClear_t {
-    HW_CLEAR,
-    HW_SET
-} ;
+/*  Macro used to set and clear any bit */
+#define HW_CLEAR	0
+#define HW_SET		1
 
 /* HW_Endianism_t:  Enumerated Type used to specify the endianism
  *		Do NOT change these values. They are used as bit fields. */
diff --git a/drivers/dsp/bridge/hw/hw_mmu.c b/drivers/dsp/bridge/hw/hw_mmu.c
index c13dfe1..abaf0f6 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.c
+++ b/drivers/dsp/bridge/hw/hw_mmu.c
@@ -337,8 +337,7 @@ HW_STATUS HW_MMU_TLBAdd(const void __iomem *baseAddress,
 			   u32	      pageSize,
 			   u32	      entryNum,
 			   struct HW_MMUMapAttrs_t    *mapAttrs,
-			   enum HW_SetClear_t       preservedBit,
-			   enum HW_SetClear_t       validBit)
+			   s8 preservedBit, s8 validBit)
 {
     HW_STATUS  status = RET_OK;
     u32 lockReg;
diff --git a/drivers/dsp/bridge/hw/hw_mmu.h b/drivers/dsp/bridge/hw/hw_mmu.h
index b800d15..ddb0843 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.h
+++ b/drivers/dsp/bridge/hw/hw_mmu.h
@@ -87,8 +87,7 @@ extern HW_STATUS HW_MMU_TLBAdd(const void __iomem *baseAddress,
 				  u32	   pageSize,
 				  u32	    entryNum,
 				  struct HW_MMUMapAttrs_t *mapAttrs,
-				  enum HW_SetClear_t    preservedBit,
-				  enum HW_SetClear_t    validBit);
+				  s8 preservedBit, s8 validBit);
 
 
 /* For PTEs */
diff --git a/drivers/dsp/bridge/hw/hw_prcm.c b/drivers/dsp/bridge/hw/hw_prcm.c
index e5e0bc5..703ca67 100644
--- a/drivers/dsp/bridge/hw/hw_prcm.c
+++ b/drivers/dsp/bridge/hw/hw_prcm.c
@@ -22,8 +22,7 @@
 #include <hw_prcm.h>
 
 static HW_STATUS HW_RST_WriteVal(const void __iomem *baseAddress,
-				    enum HW_RstModule_t r,
-				    enum HW_SetClear_t val);
+				    enum HW_RstModule_t r, s8 val);
 
 HW_STATUS HW_RST_Reset(const void __iomem *baseAddress, enum HW_RstModule_t r)
 {
@@ -36,8 +35,7 @@ HW_STATUS HW_RST_UnReset(const void __iomem *baseAddress, enum HW_RstModule_t r)
 }
 
 static HW_STATUS HW_RST_WriteVal(const void __iomem *baseAddress,
-				    enum HW_RstModule_t r,
-				    enum HW_SetClear_t val)
+				    enum HW_RstModule_t r, s8 val)
 {
 	HW_STATUS status = RET_OK;
 
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 225e5fd..262f087 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -79,8 +79,7 @@ struct CMM_ALLOCATOR {	/* sma */
 				 * context for 'sma') */
 	u32 dwDSPPhysAddrOffset;	/* DSP PA to GPP PA offset for this
 					 * SM space */
-	/* CMM_ADDTO[SUBFROM]DSPPA, _POMAPEMIF2DSPBUS */
-	enum CMM_CNVTTYPE cFactor;
+	s8 cFactor;			/* DSPPa to GPPPa Conversion Factor */
 	unsigned int dwDSPBase;	/* DSP virt base byte address */
 	u32 ulDSPSize;	/* DSP seg size in bytes */
 	struct CMM_OBJECT *hCmmMgr;	/* back ref to parent mgr */
@@ -571,7 +570,7 @@ bool CMM_Init(void)
  */
 DSP_STATUS CMM_RegisterGPPSMSeg(struct CMM_OBJECT *hCmmMgr, u32 dwGPPBasePA,
 				u32 ulSize, u32 dwDSPAddrOffset,
-				enum CMM_CNVTTYPE cFactor, u32 dwDSPBase,
+				s8 cFactor, u32 dwDSPBase,
 				u32 ulDSPSize, u32 *pulSegId,
 				u32 dwGPPBaseVA)
 {
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 077e693..6ea9ec9 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -209,12 +209,8 @@ static const struct MAP_L4PERIPHERAL L4PeripheralTable[] = {
 #define MBX_PM_MAX_RESOURCES 11
 
 /*  Power Management Commands */
-enum BPWR_ExtClockCmd {
-	BPWR_DisableClock = 0,
-	BPWR_EnableClock,
-	BPWR_DisableAutoIdle,
-	BPWR_EnableAutoIdle
-} ;
+#define BPWR_DisableClock	0
+#define BPWR_EnableClock	1
 
 /* OMAP242x specific resources */
 enum BPWR_ExtClockId {
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index b86e498..5991d85 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1791,8 +1791,7 @@ void IO_IntrDSP2(IN struct IO_MGR *pIOMgr, IN u16 wMbVal)
  *  ======== IO_SHMcontrol ========
  *      Sets the requested SHM setting.
  */
-DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE desc,
-			 IN void *pArgs)
+DSP_STATUS IO_SHMsetting(struct IO_MGR *hIOMgr, u8 desc, void *pArgs)
 {
 #ifdef CONFIG_BRIDGE_DVFS
 	u32 i;
-- 
1.6.2.4

