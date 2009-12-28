From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [PATCH ] DSPBRIDGE: Remove enum constants  and replace with macros
Date: Mon, 28 Dec 2009 23:14:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A277933@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41551 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbZL1Rof convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 12:44:35 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBSHiW9Z005960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Dec 2009 11:44:34 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBSHiUed017864
	for <linux-omap@vger.kernel.org>; Mon, 28 Dec 2009 23:14:31 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 794c1834999972e9c57e0fce98bac95b5402991e Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 22 Dec 2009 16:03:20 -0600
Subject: [PATCH] DSPBRIDGE: Remove enum definitions and replace with macros

This patch removes unrelated enum constants and replaces it with
the macros

 Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |   10 ++++------
 arch/arm/plat-omap/include/dspbridge/cmm.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/cmmdefs.h  |   20 +++-----------------
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |   10 +++-------
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |    6 +++---
 drivers/dsp/bridge/hw/IPIAccInt.h               |   15 ---------------
 drivers/dsp/bridge/hw/hw_defs.h                 |   11 +++++------
 drivers/dsp/bridge/hw/hw_mmu.c                  |    4 ++--
 drivers/dsp/bridge/hw/hw_mmu.h                  |    7 ++++---
 drivers/dsp/bridge/hw/hw_prcm.c                 |    4 ++--
 drivers/dsp/bridge/pmgr/cmm.c                   |    5 ++---
 drivers/dsp/bridge/wmd/_tiomap.h                |   22 ++--------------------
 drivers/dsp/bridge/wmd/io_sm.c                  |    4 ++--
 13 files changed, 33 insertions(+), 87 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 28af799..2cd046a 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -77,6 +77,10 @@
 #endif
 
 #define MAXOPPS 16
+#define SHM_CURROPP 0
+#define SHM_OPPINFO 1
+#define SHM_GETOPP  2		/* Get DSP requested OPP info */
+
 
 struct oppTableEntry {
     u32 voltage;
@@ -105,12 +109,6 @@ struct loadMonStruct {
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
index 0df8b83..d98bffa 100644
--- a/arch/arm/plat-omap/include/dspbridge/cmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/cmm.h
@@ -261,7 +261,7 @@
 					       unsigned int dwGPPBasePA,
 					       u32 ulSize,
 					       u32 dwDSPAddrOffset,
-					       enum CMM_CNVTTYPE cFactor,
+					       int  cFactor,
 					       unsigned int dwDSPBase,
 					       u32 ulDSPSize,
 					       u32 *pulSegId,
diff --git a/arch/arm/plat-omap/include/dspbridge/cmmdefs.h b/arch/arm/plat-omap/include/dspbridge/cmmdefs.h
index a779377..eeecf94 100644
--- a/arch/arm/plat-omap/include/dspbridge/cmmdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cmmdefs.h
@@ -55,15 +55,10 @@
  *  For typical platforms:
  *      converted Address = PaDSP + ( cFactor * addressToConvert).
  */
-	enum CMM_CNVTTYPE {
-		CMM_SUBFROMDSPPA = -1,
-		/* PreOMAP is special case: not simple offset */
-		CMM_POMAPEMIF2DSPBUS = 0,
-		CMM_ADDTODSPPA = 1
-	} ;
 
-#define CMM_DEFLTDSPADDROFFSET  0
-#define CMM_DEFLTCONVFACTOR     CMM_POMAPEMIF2DSPBUS /* PreOMAP DSPBUS<->EMIF */
+#define CMM_SUBFROMDSPPA -1
+#define CMM_ADDTODSPPA 1
+
 #define CMM_ALLSEGMENTS         0xFFFFFF	/* All SegIds */
 #define CMM_MAXGPPSEGS          1	/* Maximum # of SM segs */
 
@@ -120,15 +115,6 @@
 		CMM_PA2DSPPA = 3,	/* GPP Pa to DSP Pa */
 		CMM_DSPPA2PA = 4,	/* DSP Pa to GPP Pa */
 	} ;
-
-/*
- *  Used to "map" between device process virt addr and dsp addr.
- */
-	enum CMM_KERNMAPTYPE {
-		CMM_KERNVA2DSP = 0, /* Device process context to dsp address. */
-		CMM_DSP2KERNVA = 1, /* Dsp address to device process context. */
-	} ;
-
 	struct CMM_OBJECT;
 	struct CMM_XLATOROBJECT;
 
diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 3570171..63b7d5d 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -155,6 +155,9 @@
 
 #define    MAX_PROFILES     16
 
+/* DSP CHIP TYPE */
+#define DSPTYPE_64  0x99
+
 /* Types defined for 'Bridge API */
 	typedef u32 DSP_STATUS;	/* API return code type         */
 
@@ -451,13 +454,6 @@
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
index 3dcbf74..a327e55 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -292,9 +292,9 @@
  *      pArgs != NULL
  *  Ensures:
  */
-	extern DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr,
-					IN enum SHM_DESCTYPE desc,
-					IN void *pArgs);
+	extern DSP_STATUS IO_SHMsetting(struct IO_MGR *hIOMgr,
+					int desc,
+					void *pArgs);
 
 /*
  *  Misc functions for the CHNL_IO shared memory library:
diff --git a/drivers/dsp/bridge/hw/IPIAccInt.h b/drivers/dsp/bridge/hw/IPIAccInt.h
index b88a58c..dde0ef0 100644
--- a/drivers/dsp/bridge/hw/IPIAccInt.h
+++ b/drivers/dsp/bridge/hw/IPIAccInt.h
@@ -22,20 +22,5 @@
 #define SYSC_IVA2BOOTADDR_OFFSET                0x400
 #define SYSC_IVA2BOOTADDR_MASK                 0xfffffc00
 
-
-/* The following represent the enumerated values for each bitfield */
-
-enum IPIIPI_SYSCONFIGAutoIdleE {
-	IPIIPI_SYSCONFIGAutoIdleclkfree = 0x0000,
-	IPIIPI_SYSCONFIGAutoIdleautoclkgate = 0x0001
-} ;
-
-enum IPIIPI_ENTRYElemSizeValueE {
-	IPIIPI_ENTRYElemSizeValueElemSz8b = 0x0000,
-	IPIIPI_ENTRYElemSizeValueElemSz16b = 0x0001,
-	IPIIPI_ENTRYElemSizeValueElemSz32b = 0x0002,
-	IPIIPI_ENTRYElemSizeValueReserved = 0x0003
-} ;
-
 #endif				/* _IPI_ACC_INT_H */
 /* EOF */
diff --git a/drivers/dsp/bridge/hw/hw_defs.h b/drivers/dsp/bridge/hw/hw_defs.h
index a973f5c..31fcc34 100644
--- a/drivers/dsp/bridge/hw/hw_defs.h
+++ b/drivers/dsp/bridge/hw/hw_defs.h
@@ -39,14 +39,13 @@
 /* HW_STATUS:  return type for HW API */
 typedef long HW_STATUS;
 
-/* HW_SetClear_t:  Enumerated Type used to set and clear any bit */
-enum HW_SetClear_t {
-    HW_CLEAR,
-    HW_SET
-} ;
+/*  Macro used to set and clear any bit */
+#define HW_CLEAR 0
+#define HW_SET   1
 
 /* HW_Endianism_t:  Enumerated Type used to specify the endianism
- *		Do NOT change these values. They are used as bit fields. */
+ *		Do NOT change these values. They are used as bit fields.
+ */
 enum HW_Endianism_t {
     HW_LITTLE_ENDIAN,
     HW_BIG_ENDIAN
diff --git a/drivers/dsp/bridge/hw/hw_mmu.c b/drivers/dsp/bridge/hw/hw_mmu.c
index ce9d586..e8740e1 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.c
+++ b/drivers/dsp/bridge/hw/hw_mmu.c
@@ -350,8 +350,8 @@ HW_STATUS HW_MMU_TLBAdd(const void __iomem *baseAddress,
 			   u32	      pageSize,
 			   u32	      entryNum,
 			   struct HW_MMUMapAttrs_t    *mapAttrs,
-			   enum HW_SetClear_t       preservedBit,
-			   enum HW_SetClear_t       validBit)
+			   int preservedBit,
+			   int validBit)
 {
     HW_STATUS  status = RET_OK;
     u32 lockReg;
diff --git a/drivers/dsp/bridge/hw/hw_mmu.h b/drivers/dsp/bridge/hw/hw_mmu.h
index b1e2458..56daed1 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.h
+++ b/drivers/dsp/bridge/hw/hw_mmu.h
@@ -39,7 +39,8 @@
 #define HW_MMU_COARSE_PAGE_SIZE 0x400
 
 /* HW_MMUMixedSize_t:  Enumerated Type used to specify whether to follow
-			CPU/TLB Element size */
+ *			CPU/TLB Element size
+ */
 enum HW_MMUMixedSize_t {
 	HW_MMU_TLBES,
 	HW_MMU_CPUES
@@ -98,8 +99,8 @@ extern HW_STATUS HW_MMU_TLBAdd(const void __iomem *baseAddress,
 				  u32	   pageSize,
 				  u32	    entryNum,
 				  struct HW_MMUMapAttrs_t *mapAttrs,
-				  enum HW_SetClear_t    preservedBit,
-				  enum HW_SetClear_t    validBit);
+				  int preservedBit,
+				  int validBit);
 
 
 /* For PTEs */
diff --git a/drivers/dsp/bridge/hw/hw_prcm.c b/drivers/dsp/bridge/hw/hw_prcm.c
index 8f04a70..68b1cc5 100644
--- a/drivers/dsp/bridge/hw/hw_prcm.c
+++ b/drivers/dsp/bridge/hw/hw_prcm.c
@@ -31,7 +31,7 @@
 
 static HW_STATUS HW_RST_WriteVal(const void __iomem *baseAddress,
 				    enum HW_RstModule_t r,
-				    enum HW_SetClear_t val);
+				    int val);
 
 HW_STATUS HW_RST_Reset(const void __iomem *baseAddress, enum HW_RstModule_t r)
 {
@@ -45,7 +45,7 @@ HW_STATUS HW_RST_UnReset(const void __iomem *baseAddress, enum HW_RstModule_t r)
 
 static HW_STATUS HW_RST_WriteVal(const void __iomem *baseAddress,
 				    enum HW_RstModule_t r,
-				    enum HW_SetClear_t val)
+				    int val)
 {
 	HW_STATUS status = RET_OK;
 
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index db9baf3..ad646af 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -142,8 +142,7 @@ struct CMM_ALLOCATOR {	/* sma */
 				 * context for 'sma') */
 	u32 dwDSPPhysAddrOffset;	/* DSP PA to GPP PA offset for this
 					 * SM space */
-	/* CMM_ADDTO[SUBFROM]DSPPA, _POMAPEMIF2DSPBUS */
-	enum CMM_CNVTTYPE cFactor;
+	int cFactor;			/* DSPPa to GPPPa Conversion Factor */
 	unsigned int dwDSPBase;	/* DSP virt base byte address */
 	u32 ulDSPSize;	/* DSP seg size in bytes */
 	struct CMM_OBJECT *hCmmMgr;	/* back ref to parent mgr */
@@ -632,7 +631,7 @@ bool CMM_Init(void)
  */
 DSP_STATUS CMM_RegisterGPPSMSeg(struct CMM_OBJECT *hCmmMgr, u32 dwGPPBasePA,
 				u32 ulSize, u32 dwDSPAddrOffset,
-				enum CMM_CNVTTYPE cFactor, u32 dwDSPBase,
+				int cFactor, u32 dwDSPBase,
 				u32 ulDSPSize, u32 *pulSegId,
 				u32 dwGPPBaseVA)
 {
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 268c50c..4066158 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -214,12 +214,8 @@ static const struct MAP_L4PERIPHERAL L4PeripheralTable[] = {
 #define MBX_PM_MAX_RESOURCES 11
 
 /*  Power Management Commands */
-enum BPWR_ExtClockCmd {
-	BPWR_DisableClock = 0,
-	BPWR_EnableClock,
-	BPWR_DisableAutoIdle,
-	BPWR_EnableAutoIdle
-} ;
+#define BPWR_DisableClock 0
+#define BPWR_EnableClock 1
 
 /* OMAP242x specific resources */
 enum BPWR_ExtClockId {
@@ -277,20 +273,6 @@ static const struct BPWR_Clk_t BPWR_Clks[] = {
 #define   DSP_MAILBOX1_INT              10
 
 /*
- *  INTH_InterruptKind_t
- *  Identify the kind of interrupt: either FIQ/IRQ
- */
-enum INTH_InterruptKind_t {
-	INTH_IRQ = 0,
-	INTH_FIQ = 1
-} ;
-
-enum INTH_SensitiveEdge_t {
-	FALLING_EDGE_SENSITIVE = 0,
-	LOW_LEVEL_SENSITIVE = 1
-} ;
-
-/*
  *  Bit definition of  Interrupt  Level  Registers
  */
 
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index a6c8e31..f87b4d0 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1754,8 +1754,8 @@ void IO_IntrDSP2(IN struct IO_MGR *pIOMgr, IN u16 wMbVal)
  *  ======== IO_SHMcontrol ========
  *      Sets the requested SHM setting.
  */
-DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE desc,
-			 IN void *pArgs)
+DSP_STATUS IO_SHMsetting(struct IO_MGR *hIOMgr, int desc,
+			 void *pArgs)
 {
 #ifdef CONFIG_BRIDGE_DVFS
 	u32 i;
-- 
1.6.0.4

