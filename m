From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 13/20] DSPBRIDGE: Fix multiline macros to use do while
Date: Mon, 30 Nov 2009 15:54:54 -0600
Message-ID: <1259618101-8972-14-git-send-email-omar.ramirez@ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-3-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-4-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-5-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-6-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-7-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-8-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-9-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-10-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-11-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-12-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-13-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45933 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbZK3VtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 16:49:00 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAULn7sA013334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 15:49:07 -0600
In-Reply-To: <1259618101-8972-13-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>

Fixed multiline macros that break under if statements

* Also minor indentation for complex defines

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbc.h |   10 +-
 arch/arm/plat-omap/include/dspbridge/mem.h |   24 +-
 drivers/dsp/bridge/hw/MLBRegAcM.h          |  319 ++++----
 drivers/dsp/bridge/hw/MMURegAcM.h          |  415 +++++-----
 drivers/dsp/bridge/hw/PRCMRegAcM.h         | 1197 +++++++++++++---------------
 drivers/dsp/bridge/wmd/_tiomap.h           |    6 +-
 6 files changed, 929 insertions(+), 1042 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
index 13b1ff6..a1a0b97 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
@@ -34,10 +34,12 @@
 
 #include <dspbridge/gt.h>
 
-#define DBC_Assert(exp) \
-    if (!(exp)) \
-	printk(KERN_ERR "%s, line %d: Assertion (" #exp ") failed.\n", \
-	__FILE__, __LINE__)
+#define DBC_Assert(exp) 						       \
+do {									       \
+	if (!(exp))							       \
+		printk(KERN_ERR "%s, line %d: Assertion (" #exp ") failed.\n", \
+		__FILE__, __LINE__);					       \
+} while (0)
 #define DBC_Require DBC_Assert	/* Function Precondition.  */
 #define DBC_Ensure  DBC_Assert	/* Function Postcondition. */
 
diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 276128c..d0db079 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -60,13 +60,13 @@
  *  Ensures:
  *      A subsequent call to MEM_IsValidHandle() will succeed for this object.
  */
-#define MEM_AllocObject(pObj, Obj, Signature)           \
-{                                                       \
-    pObj = MEM_Calloc(sizeof(Obj), MEM_NONPAGED);       \
-    if (pObj) {                                         \
-	pObj->dwSignature = Signature;                  \
-    }                                                   \
-}
+#define MEM_AllocObject(pObj, Obj, Signature)		\
+do {							\
+	pObj = MEM_Calloc(sizeof(Obj), MEM_NONPAGED);	\
+	if (pObj) {					\
+		pObj->dwSignature = Signature;		\
+	}						\
+} while (0)
 
 /*  ======== MEM_AllocPhysMem ========
  *  Purpose:
@@ -204,11 +204,11 @@
  *  Ensures:
  *      A subsequent call to MEM_IsValidHandle() will fail for this object.
  */
-#define MEM_FreeObject(pObj)    \
-{                               \
-    pObj->dwSignature = 0x00;   \
-    MEM_Free(pObj);             \
-}
+#define MEM_FreeObject(pObj)		\
+do {					\
+	pObj->dwSignature = 0x00;	\
+	MEM_Free(pObj);			\
+} while (0)
 
 /*
  *  ======== MEM_GetNumPages ========
diff --git a/drivers/dsp/bridge/hw/MLBRegAcM.h b/drivers/dsp/bridge/hw/MLBRegAcM.h
index 29f6de3..7f9accb 100644
--- a/drivers/dsp/bridge/hw/MLBRegAcM.h
+++ b/drivers/dsp/bridge/hw/MLBRegAcM.h
@@ -24,177 +24,158 @@
 
 #if defined(USE_LEVEL_1_MACROS)
 
-#define MLBMAILBOX_SYSCONFIGReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGReadRegister32),\
-      __raw_readl(((baseAddress))+ \
-      MLB_MAILBOX_SYSCONFIG_OFFSET))
-
-
-#define MLBMAILBOX_SYSCONFIGWriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGWriteRegister32);\
-    __raw_writel(newValue, ((baseAddress))+offset);\
-}
-
-
-#define MLBMAILBOX_SYSCONFIGSIdleModeRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGSIdleModeRead32),\
-      (((__raw_readl((((u32)(baseAddress))+\
-      (MLB_MAILBOX_SYSCONFIG_OFFSET)))) &\
-      MLB_MAILBOX_SYSCONFIG_SIdleMode_MASK) >>\
-      MLB_MAILBOX_SYSCONFIG_SIdleMode_OFFSET))
-
-
-#define MLBMAILBOX_SYSCONFIGSIdleModeWrite32(baseAddress, value)\
-{\
-    const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;\
-    register u32 data = __raw_readl(((u32)(baseAddress)) +\
-			    offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGSIdleModeWrite32);\
-    data &= ~(MLB_MAILBOX_SYSCONFIG_SIdleMode_MASK);\
-    newValue <<= MLB_MAILBOX_SYSCONFIG_SIdleMode_OFFSET;\
-    newValue &= MLB_MAILBOX_SYSCONFIG_SIdleMode_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define MLBMAILBOX_SYSCONFIGSoftResetWrite32(baseAddress, value)\
-{\
-    const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;\
-    register u32 data =\
-    __raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGSoftResetWrite32);\
-    data &= ~(MLB_MAILBOX_SYSCONFIG_SoftReset_MASK);\
-    newValue <<= MLB_MAILBOX_SYSCONFIG_SoftReset_OFFSET;\
-    newValue &= MLB_MAILBOX_SYSCONFIG_SoftReset_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define MLBMAILBOX_SYSCONFIGAutoIdleRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGAutoIdleRead32),\
-      (((__raw_readl((((u32)(baseAddress))+\
-      (MLB_MAILBOX_SYSCONFIG_OFFSET)))) &\
-      MLB_MAILBOX_SYSCONFIG_AutoIdle_MASK) >>\
-      MLB_MAILBOX_SYSCONFIG_AutoIdle_OFFSET))
-
-
-#define MLBMAILBOX_SYSCONFIGAutoIdleWrite32(baseAddress, value)\
-{\
-    const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;\
-    register u32 data =\
-    __raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGAutoIdleWrite32);\
-    data &= ~(MLB_MAILBOX_SYSCONFIG_AutoIdle_MASK);\
-    newValue <<= MLB_MAILBOX_SYSCONFIG_AutoIdle_OFFSET;\
-    newValue &= MLB_MAILBOX_SYSCONFIG_AutoIdle_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
+#define MLBMAILBOX_SYSCONFIGReadRegister32(baseAddress)			 \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGReadRegister32), \
+	__raw_readl(((baseAddress)) + MLB_MAILBOX_SYSCONFIG_OFFSET))
+
+
+#define MLBMAILBOX_SYSCONFIGWriteRegister32(baseAddress, value)		\
+do {									\
+	const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;		\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGWriteRegister32);\
+	__raw_writel(newValue, ((baseAddress)) + offset);		\
+} while (0)
+
+#define MLBMAILBOX_SYSCONFIGSIdleModeRead32(baseAddress)		  \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGSIdleModeRead32), \
+	(((__raw_readl((((u32)(baseAddress)) +				  \
+	(MLB_MAILBOX_SYSCONFIG_OFFSET)))) &				  \
+	MLB_MAILBOX_SYSCONFIG_SIdleMode_MASK) >>			  \
+	MLB_MAILBOX_SYSCONFIG_SIdleMode_OFFSET))
+
+#define MLBMAILBOX_SYSCONFIGSIdleModeWrite32(baseAddress, value)	  \
+do {									  \
+	const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;		  \
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	  \
+	register u32 newValue = ((u32)(value));				  \
+	_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGSIdleModeWrite32); \
+	data &= ~(MLB_MAILBOX_SYSCONFIG_SIdleMode_MASK);		  \
+	newValue <<= MLB_MAILBOX_SYSCONFIG_SIdleMode_OFFSET;		  \
+	newValue &= MLB_MAILBOX_SYSCONFIG_SIdleMode_MASK;		  \
+	newValue |= data;						  \
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		  \
+} while (0)
+
+#define MLBMAILBOX_SYSCONFIGSoftResetWrite32(baseAddress, value)	    \
+do {									    \
+	const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;		    \
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	    \
+	register u32 newValue = ((u32)(value));				    \
+	_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGSoftResetWrite32);   \
+	data &= ~(MLB_MAILBOX_SYSCONFIG_SoftReset_MASK);		    \
+	newValue <<= MLB_MAILBOX_SYSCONFIG_SoftReset_OFFSET;		    \
+	newValue &= MLB_MAILBOX_SYSCONFIG_SoftReset_MASK;		    \
+	newValue |= data;						    \
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		    \
+} while (0)
+
+#define MLBMAILBOX_SYSCONFIGAutoIdleRead32(baseAddress)			 \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGAutoIdleRead32), \
+	(((__raw_readl((((u32)(baseAddress)) +				 \
+	(MLB_MAILBOX_SYSCONFIG_OFFSET)))) &				 \
+	MLB_MAILBOX_SYSCONFIG_AutoIdle_MASK) >>				 \
+	MLB_MAILBOX_SYSCONFIG_AutoIdle_OFFSET))
+
+#define MLBMAILBOX_SYSCONFIGAutoIdleWrite32(baseAddress, value)		 \
+do {									 \
+	const u32 offset = MLB_MAILBOX_SYSCONFIG_OFFSET;		 \
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	 \
+	register u32 newValue = ((u32)(value));				 \
+	_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSCONFIGAutoIdleWrite32); \
+	data &= ~(MLB_MAILBOX_SYSCONFIG_AutoIdle_MASK);			 \
+	newValue <<= MLB_MAILBOX_SYSCONFIG_AutoIdle_OFFSET;		 \
+	newValue &= MLB_MAILBOX_SYSCONFIG_AutoIdle_MASK;		 \
+	newValue |= data;						 \
+	__raw_writel(newValue, (u32)(baseAddress)+offset);		 \
+} while (0)
 
 #define MLBMAILBOX_SYSSTATUSResetDoneRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSSTATUSResetDoneRead32),\
-      (((__raw_readl((((u32)(baseAddress))+\
-      (MLB_MAILBOX_SYSSTATUS_OFFSET)))) &\
-      MLB_MAILBOX_SYSSTATUS_ResetDone_MASK) >>\
-      MLB_MAILBOX_SYSSTATUS_ResetDone_OFFSET))
-
-
-#define MLBMAILBOX_MESSAGE___0_15ReadRegister32(baseAddress, bank)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_MESSAGE___0_15ReadRegister32),\
-      __raw_readl(((baseAddress))+\
-      (MLB_MAILBOX_MESSAGE___REGSET_0_15_OFFSET +\
-      MLB_MAILBOX_MESSAGE___0_15_OFFSET+(\
-      (bank)*MLB_MAILBOX_MESSAGE___REGSET_0_15_STEP))))
-
-
-#define MLBMAILBOX_MESSAGE___0_15WriteRegister32(baseAddress, bank, value)\
-{\
-    const u32 offset = MLB_MAILBOX_MESSAGE___REGSET_0_15_OFFSET +\
-    MLB_MAILBOX_MESSAGE___0_15_OFFSET +\
-    ((bank)*MLB_MAILBOX_MESSAGE___REGSET_0_15_STEP);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_MESSAGE___0_15WriteRegister32);\
-    __raw_writel(newValue, ((baseAddress))+offset);\
-}
-
-
-#define MLBMAILBOX_FIFOSTATUS___0_15ReadRegister32(baseAddress, bank)\
-    (_DEBUG_LEVEL_1_EASI(\
-      EASIL1_MLBMAILBOX_FIFOSTATUS___0_15ReadRegister32),\
-      __raw_readl(((u32)(baseAddress))+\
-      (MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_OFFSET +\
-      MLB_MAILBOX_FIFOSTATUS___0_15_OFFSET+\
-      ((bank)*MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_STEP))))
-
-
-#define MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32(baseAddress, bank)\
-    (_DEBUG_LEVEL_1_EASI(\
-      EASIL1_MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32),\
-      (((__raw_readl(((baseAddress))+\
-      (MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_OFFSET +\
-      MLB_MAILBOX_FIFOSTATUS___0_15_OFFSET+\
-      ((bank)*MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_STEP)))) &\
-      MLB_MAILBOX_FIFOSTATUS___0_15_FifoFullMBm_MASK) >>\
-      MLB_MAILBOX_FIFOSTATUS___0_15_FifoFullMBm_OFFSET))
-
-
-#define MLBMAILBOX_MSGSTATUS___0_15NbOfMsgMBmRead32(baseAddress, bank)\
-    (_DEBUG_LEVEL_1_EASI(\
-      EASIL1_MLBMAILBOX_MSGSTATUS___0_15NbOfMsgMBmRead32),\
-      (((__raw_readl(((baseAddress))+\
-      (MLB_MAILBOX_MSGSTATUS___REGSET_0_15_OFFSET +\
-      MLB_MAILBOX_MSGSTATUS___0_15_OFFSET+\
-      ((bank)*MLB_MAILBOX_MSGSTATUS___REGSET_0_15_STEP)))) &\
-      MLB_MAILBOX_MSGSTATUS___0_15_NbOfMsgMBm_MASK) >>\
-      MLB_MAILBOX_MSGSTATUS___0_15_NbOfMsgMBm_OFFSET))
-
-
-#define MLBMAILBOX_IRQSTATUS___0_3ReadRegister32(baseAddress, bank)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQSTATUS___0_3ReadRegister32),\
-      __raw_readl(((baseAddress))+\
-      (MLB_MAILBOX_IRQSTATUS___REGSET_0_3_OFFSET +\
-      MLB_MAILBOX_IRQSTATUS___0_3_OFFSET+\
-      ((bank)*MLB_MAILBOX_IRQSTATUS___REGSET_0_3_STEP))))
-
-
-#define MLBMAILBOX_IRQSTATUS___0_3WriteRegister32(baseAddress, bank, value)\
-{\
-    const u32 offset = MLB_MAILBOX_IRQSTATUS___REGSET_0_3_OFFSET +\
-    MLB_MAILBOX_IRQSTATUS___0_3_OFFSET +\
-    ((bank)*MLB_MAILBOX_IRQSTATUS___REGSET_0_3_STEP);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQSTATUS___0_3WriteRegister32);\
-    __raw_writel(newValue, ((baseAddress))+offset);\
-}
-
-
-#define MLBMAILBOX_IRQENABLE___0_3ReadRegister32(baseAddress, bank)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQENABLE___0_3ReadRegister32),\
-      __raw_readl(((baseAddress))+\
-      (MLB_MAILBOX_IRQENABLE___REGSET_0_3_OFFSET +\
-      MLB_MAILBOX_IRQENABLE___0_3_OFFSET+\
-       ((bank)*MLB_MAILBOX_IRQENABLE___REGSET_0_3_STEP))))
-
-
-#define MLBMAILBOX_IRQENABLE___0_3WriteRegister32(baseAddress, bank, value)\
-{\
-    const u32 offset = MLB_MAILBOX_IRQENABLE___REGSET_0_3_OFFSET +\
-      MLB_MAILBOX_IRQENABLE___0_3_OFFSET +\
-      ((bank)*MLB_MAILBOX_IRQENABLE___REGSET_0_3_STEP);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQENABLE___0_3WriteRegister32);\
-    __raw_writel(newValue, ((baseAddress))+offset);\
-}
-
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_SYSSTATUSResetDoneRead32), \
+	(((__raw_readl((((u32)(baseAddress)) +				  \
+	(MLB_MAILBOX_SYSSTATUS_OFFSET)))) &				  \
+	MLB_MAILBOX_SYSSTATUS_ResetDone_MASK) >>			  \
+	MLB_MAILBOX_SYSSTATUS_ResetDone_OFFSET))
+
+#define MLBMAILBOX_MESSAGE___0_15ReadRegister32(baseAddress, bank)	      \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_MESSAGE___0_15ReadRegister32), \
+	__raw_readl(((baseAddress)) +					      \
+	(MLB_MAILBOX_MESSAGE___REGSET_0_15_OFFSET +			      \
+	MLB_MAILBOX_MESSAGE___0_15_OFFSET +				      \
+	((bank) * MLB_MAILBOX_MESSAGE___REGSET_0_15_STEP))))
+
+#define MLBMAILBOX_MESSAGE___0_15WriteRegister32(baseAddress, bank, value)    \
+do {									      \
+	const u32 offset = MLB_MAILBOX_MESSAGE___REGSET_0_15_OFFSET +	      \
+	MLB_MAILBOX_MESSAGE___0_15_OFFSET +				      \
+	((bank) * MLB_MAILBOX_MESSAGE___REGSET_0_15_STEP);		      \
+	register u32 newValue = ((u32)(value));				      \
+	_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_MESSAGE___0_15WriteRegister32); \
+	__raw_writel(newValue, ((baseAddress)) + offset);		      \
+} while (0)
+
+#define MLBMAILBOX_FIFOSTATUS___0_15ReadRegister32(baseAddress, bank)	\
+	(_DEBUG_LEVEL_1_EASI						\
+	(EASIL1_MLBMAILBOX_FIFOSTATUS___0_15ReadRegister32),		\
+	__raw_readl(((u32)(baseAddress)) +				\
+	(MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_OFFSET +			\
+	MLB_MAILBOX_FIFOSTATUS___0_15_OFFSET +				\
+	((bank) * MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_STEP))))
+
+#define MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32(baseAddress, bank) \
+	(_DEBUG_LEVEL_1_EASI(						 \
+	EASIL1_MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32),		 \
+	(((__raw_readl(((baseAddress)) +				 \
+	(MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_OFFSET +			 \
+	MLB_MAILBOX_FIFOSTATUS___0_15_OFFSET +				 \
+	((bank) * MLB_MAILBOX_FIFOSTATUS___REGSET_0_15_STEP)))) &	 \
+	MLB_MAILBOX_FIFOSTATUS___0_15_FifoFullMBm_MASK) >>		 \
+	MLB_MAILBOX_FIFOSTATUS___0_15_FifoFullMBm_OFFSET))
+
+#define MLBMAILBOX_MSGSTATUS___0_15NbOfMsgMBmRead32(baseAddress, bank)	\
+	(_DEBUG_LEVEL_1_EASI(						\
+	EASIL1_MLBMAILBOX_MSGSTATUS___0_15NbOfMsgMBmRead32),		\
+	(((__raw_readl(((baseAddress)) +				\
+	(MLB_MAILBOX_MSGSTATUS___REGSET_0_15_OFFSET +			\
+	MLB_MAILBOX_MSGSTATUS___0_15_OFFSET +				\
+	((bank) * MLB_MAILBOX_MSGSTATUS___REGSET_0_15_STEP)))) &	\
+	MLB_MAILBOX_MSGSTATUS___0_15_NbOfMsgMBm_MASK) >>		\
+	MLB_MAILBOX_MSGSTATUS___0_15_NbOfMsgMBm_OFFSET))
+
+#define MLBMAILBOX_IRQSTATUS___0_3ReadRegister32(baseAddress, bank)	       \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQSTATUS___0_3ReadRegister32), \
+	__raw_readl(((baseAddress)) +					       \
+	(MLB_MAILBOX_IRQSTATUS___REGSET_0_3_OFFSET +			       \
+	MLB_MAILBOX_IRQSTATUS___0_3_OFFSET +				       \
+	((bank) * MLB_MAILBOX_IRQSTATUS___REGSET_0_3_STEP))))
+
+#define MLBMAILBOX_IRQSTATUS___0_3WriteRegister32(baseAddress, bank, value)    \
+do {									       \
+	const u32 offset = MLB_MAILBOX_IRQSTATUS___REGSET_0_3_OFFSET +	       \
+	MLB_MAILBOX_IRQSTATUS___0_3_OFFSET +				       \
+	((bank) * MLB_MAILBOX_IRQSTATUS___REGSET_0_3_STEP);		       \
+	register u32 newValue = ((u32)(value));				       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQSTATUS___0_3WriteRegister32); \
+	__raw_writel(newValue, ((baseAddress)) + offset);		       \
+} while (0)
+
+#define MLBMAILBOX_IRQENABLE___0_3ReadRegister32(baseAddress, bank)	       \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQENABLE___0_3ReadRegister32), \
+	__raw_readl(((baseAddress)) +					       \
+	(MLB_MAILBOX_IRQENABLE___REGSET_0_3_OFFSET +			       \
+	MLB_MAILBOX_IRQENABLE___0_3_OFFSET +				       \
+	((bank) * MLB_MAILBOX_IRQENABLE___REGSET_0_3_STEP))))
+
+
+#define MLBMAILBOX_IRQENABLE___0_3WriteRegister32(baseAddress, bank, value)    \
+do {									       \
+	const u32 offset = MLB_MAILBOX_IRQENABLE___REGSET_0_3_OFFSET +	       \
+	MLB_MAILBOX_IRQENABLE___0_3_OFFSET +				       \
+	((bank)*MLB_MAILBOX_IRQENABLE___REGSET_0_3_STEP);		       \
+	register u32 newValue = ((u32)(value));				       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_MLBMAILBOX_IRQENABLE___0_3WriteRegister32); \
+	__raw_writel(newValue, ((baseAddress)) + offset);		       \
+} while (0)
 
 #endif	/* USE_LEVEL_1_MACROS */
 
diff --git a/drivers/dsp/bridge/hw/MMURegAcM.h b/drivers/dsp/bridge/hw/MMURegAcM.h
index 52a3d99..00ef881 100644
--- a/drivers/dsp/bridge/hw/MMURegAcM.h
+++ b/drivers/dsp/bridge/hw/MMURegAcM.h
@@ -25,227 +25,200 @@
 
 #if defined(USE_LEVEL_1_MACROS)
 
-
-#define MMUMMU_SYSCONFIGReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_SYSCONFIGReadRegister32),\
-      __raw_readl((baseAddress)+MMU_MMU_SYSCONFIG_OFFSET))
-
-
-#define MMUMMU_SYSCONFIGIdleModeWrite32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_SYSCONFIG_OFFSET;\
-    register u32 data = __raw_readl((baseAddress)+offset);\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_SYSCONFIGIdleModeWrite32);\
-    data &= ~(MMU_MMU_SYSCONFIG_IdleMode_MASK);\
-    newValue <<= MMU_MMU_SYSCONFIG_IdleMode_OFFSET;\
-    newValue &= MMU_MMU_SYSCONFIG_IdleMode_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, baseAddress+offset);\
-}
-
-
-#define MMUMMU_SYSCONFIGAutoIdleWrite32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_SYSCONFIG_OFFSET;\
-    register u32 data = __raw_readl((baseAddress)+offset);\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_SYSCONFIGAutoIdleWrite32);\
-    data &= ~(MMU_MMU_SYSCONFIG_AutoIdle_MASK);\
-    newValue <<= MMU_MMU_SYSCONFIG_AutoIdle_OFFSET;\
-    newValue &= MMU_MMU_SYSCONFIG_AutoIdle_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, baseAddress+offset);\
-}
-
-
-#define MMUMMU_IRQSTATUSReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQSTATUSReadRegister32),\
-      __raw_readl((baseAddress)+MMU_MMU_IRQSTATUS_OFFSET))
-
-
-#define MMUMMU_IRQSTATUSWriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_IRQSTATUS_OFFSET;\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQSTATUSWriteRegister32);\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
-
-#define MMUMMU_IRQENABLEReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQENABLEReadRegister32),\
-      __raw_readl((baseAddress)+MMU_MMU_IRQENABLE_OFFSET))
-
-
-#define MMUMMU_IRQENABLEWriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_IRQENABLE_OFFSET;\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQENABLEWriteRegister32);\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
-
-#define MMUMMU_WALKING_STTWLRunningRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_WALKING_STTWLRunningRead32),\
-      (((__raw_readl(((baseAddress)+(MMU_MMU_WALKING_ST_OFFSET))))\
-      & MMU_MMU_WALKING_ST_TWLRunning_MASK) >>\
-      MMU_MMU_WALKING_ST_TWLRunning_OFFSET))
-
-
-#define MMUMMU_CNTLTWLEnableRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CNTLTWLEnableRead32),\
-      (((__raw_readl(((baseAddress)+(MMU_MMU_CNTL_OFFSET)))) &\
-      MMU_MMU_CNTL_TWLEnable_MASK) >>\
-      MMU_MMU_CNTL_TWLEnable_OFFSET))
-
-
-#define MMUMMU_CNTLTWLEnableWrite32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_CNTL_OFFSET;\
-    register u32 data = __raw_readl((baseAddress)+offset);\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CNTLTWLEnableWrite32);\
-    data &= ~(MMU_MMU_CNTL_TWLEnable_MASK);\
-    newValue <<= MMU_MMU_CNTL_TWLEnable_OFFSET;\
-    newValue &= MMU_MMU_CNTL_TWLEnable_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, baseAddress+offset);\
-}
-
-
-#define MMUMMU_CNTLMMUEnableWrite32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_CNTL_OFFSET;\
-    register u32 data = __raw_readl((baseAddress)+offset);\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CNTLMMUEnableWrite32);\
-    data &= ~(MMU_MMU_CNTL_MMUEnable_MASK);\
-    newValue <<= MMU_MMU_CNTL_MMUEnable_OFFSET;\
-    newValue &= MMU_MMU_CNTL_MMUEnable_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, baseAddress+offset);\
-}
-
-
-#define MMUMMU_FAULT_ADReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_FAULT_ADReadRegister32),\
-      __raw_readl((baseAddress)+MMU_MMU_FAULT_AD_OFFSET))
-
-
-#define MMUMMU_TTBWriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_TTB_OFFSET;\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_TTBWriteRegister32);\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
-
-#define MMUMMU_LOCKReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKReadRegister32),\
-      __raw_readl((baseAddress)+MMU_MMU_LOCK_OFFSET))
-
-
-#define MMUMMU_LOCKWriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_LOCK_OFFSET;\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKWriteRegister32);\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
-
-#define MMUMMU_LOCKBaseValueRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKBaseValueRead32),\
-      (((__raw_readl(((baseAddress)+(MMU_MMU_LOCK_OFFSET)))) &\
-      MMU_MMU_LOCK_BaseValue_MASK) >>\
-      MMU_MMU_LOCK_BaseValue_OFFSET))
-
-
-#define MMUMMU_LOCKBaseValueWrite32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_LOCK_OFFSET;\
-    register u32 data = __raw_readl((baseAddress)+offset);\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKBaseValueWrite32);\
-    data &= ~(MMU_MMU_LOCK_BaseValue_MASK);\
-    newValue <<= MMU_MMU_LOCK_BaseValue_OFFSET;\
-    newValue &= MMU_MMU_LOCK_BaseValue_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, baseAddress+offset);\
-}
-
-
-#define MMUMMU_LOCKCurrentVictimRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKCurrentVictimRead32),\
-      (((__raw_readl(((baseAddress)+(MMU_MMU_LOCK_OFFSET)))) &\
-      MMU_MMU_LOCK_CurrentVictim_MASK) >>\
-      MMU_MMU_LOCK_CurrentVictim_OFFSET))
-
-
-#define MMUMMU_LOCKCurrentVictimWrite32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_LOCK_OFFSET;\
-    register u32 data = __raw_readl((baseAddress)+offset);\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKCurrentVictimWrite32);\
-    data &= ~(MMU_MMU_LOCK_CurrentVictim_MASK);\
-    newValue <<= MMU_MMU_LOCK_CurrentVictim_OFFSET;\
-    newValue &= MMU_MMU_LOCK_CurrentVictim_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, baseAddress+offset);\
-}
-
-
-#define MMUMMU_LOCKCurrentVictimSet32(var, value)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKCurrentVictimSet32),\
-      (((var) & ~(MMU_MMU_LOCK_CurrentVictim_MASK)) |\
-      (((value) << MMU_MMU_LOCK_CurrentVictim_OFFSET) &\
-      MMU_MMU_LOCK_CurrentVictim_MASK)))
-
-
-#define MMUMMU_LD_TLBReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LD_TLBReadRegister32),\
-      __raw_readl((baseAddress)+MMU_MMU_LD_TLB_OFFSET))
-
-
-#define MMUMMU_LD_TLBWriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_LD_TLB_OFFSET;\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LD_TLBWriteRegister32);\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
-
-#define MMUMMU_CAMWriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_CAM_OFFSET;\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CAMWriteRegister32);\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
-
-#define MMUMMU_RAMWriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_RAM_OFFSET;\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_RAMWriteRegister32);\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
-
-#define MMUMMU_FLUSH_ENTRYWriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = MMU_MMU_FLUSH_ENTRY_OFFSET;\
-    register u32 newValue = (value);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_FLUSH_ENTRYWriteRegister32);\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
+#define MMUMMU_SYSCONFIGReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_SYSCONFIGReadRegister32),	\
+	__raw_readl((baseAddress) + MMU_MMU_SYSCONFIG_OFFSET))
+
+#define MMUMMU_SYSCONFIGIdleModeWrite32(baseAddress, value)		\
+do {									\
+	const u32 offset = MMU_MMU_SYSCONFIG_OFFSET;			\
+	register u32 data = __raw_readl((baseAddress) + offset);	\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_SYSCONFIGIdleModeWrite32);	\
+	data &= ~(MMU_MMU_SYSCONFIG_IdleMode_MASK);			\
+	newValue <<= MMU_MMU_SYSCONFIG_IdleMode_OFFSET;			\
+	newValue &= MMU_MMU_SYSCONFIG_IdleMode_MASK;			\
+	newValue |= data;						\
+	__raw_writel(newValue, baseAddress + offset);			\
+} while (0)
+
+#define MMUMMU_SYSCONFIGAutoIdleWrite32(baseAddress, value)		\
+do {									\
+	const u32 offset = MMU_MMU_SYSCONFIG_OFFSET;			\
+	register u32 data = __raw_readl((baseAddress) + offset);	\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_SYSCONFIGAutoIdleWrite32);	\
+	data &= ~(MMU_MMU_SYSCONFIG_AutoIdle_MASK);			\
+	newValue <<= MMU_MMU_SYSCONFIG_AutoIdle_OFFSET;			\
+	newValue &= MMU_MMU_SYSCONFIG_AutoIdle_MASK;			\
+	newValue |= data;						\
+	__raw_writel(newValue, baseAddress + offset);			\
+} while (0)
+
+#define MMUMMU_IRQSTATUSReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQSTATUSReadRegister32),	\
+	__raw_readl((baseAddress) + MMU_MMU_IRQSTATUS_OFFSET))
+
+#define MMUMMU_IRQSTATUSWriteRegister32(baseAddress, value)		\
+do {									\
+	const u32 offset = MMU_MMU_IRQSTATUS_OFFSET;			\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQSTATUSWriteRegister32);	\
+	__raw_writel(newValue, (baseAddress) + offset);			\
+} while (0)
+
+#define MMUMMU_IRQENABLEReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQENABLEReadRegister32),	\
+	__raw_readl((baseAddress) + MMU_MMU_IRQENABLE_OFFSET))
+
+#define MMUMMU_IRQENABLEWriteRegister32(baseAddress, value)		\
+do {									\
+	const u32 offset = MMU_MMU_IRQENABLE_OFFSET;			\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_IRQENABLEWriteRegister32);	\
+	__raw_writel(newValue, (baseAddress) + offset);			\
+} while (0)
+
+#define MMUMMU_WALKING_STTWLRunningRead32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_WALKING_STTWLRunningRead32),	\
+	(((__raw_readl(((baseAddress) + (MMU_MMU_WALKING_ST_OFFSET))))	\
+	& MMU_MMU_WALKING_ST_TWLRunning_MASK) >>			\
+	MMU_MMU_WALKING_ST_TWLRunning_OFFSET))
+
+#define MMUMMU_CNTLTWLEnableRead32(baseAddress)				\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CNTLTWLEnableRead32),	\
+	(((__raw_readl(((baseAddress)+(MMU_MMU_CNTL_OFFSET)))) &	\
+	MMU_MMU_CNTL_TWLEnable_MASK) >>					\
+	MMU_MMU_CNTL_TWLEnable_OFFSET))
+
+#define MMUMMU_CNTLTWLEnableWrite32(baseAddress, value)			\
+do {									\
+	const u32 offset = MMU_MMU_CNTL_OFFSET;				\
+	register u32 data = __raw_readl((baseAddress) + offset);	\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CNTLTWLEnableWrite32);	\
+	data &= ~(MMU_MMU_CNTL_TWLEnable_MASK);				\
+	newValue <<= MMU_MMU_CNTL_TWLEnable_OFFSET;			\
+	newValue &= MMU_MMU_CNTL_TWLEnable_MASK;			\
+	newValue |= data;						\
+	__raw_writel(newValue, baseAddress+offset);			\
+} while (0)
+
+#define MMUMMU_CNTLMMUEnableWrite32(baseAddress, value)			\
+do {									\
+	const u32 offset = MMU_MMU_CNTL_OFFSET;				\
+	register u32 data = __raw_readl((baseAddress) + offset);	\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CNTLMMUEnableWrite32);	\
+	data &= ~(MMU_MMU_CNTL_MMUEnable_MASK);				\
+	newValue <<= MMU_MMU_CNTL_MMUEnable_OFFSET;			\
+	newValue &= MMU_MMU_CNTL_MMUEnable_MASK;			\
+	newValue |= data;						\
+	__raw_writel(newValue, baseAddress + offset);			\
+} while (0)
+
+#define MMUMMU_FAULT_ADReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_FAULT_ADReadRegister32),	\
+	__raw_readl((baseAddress) + MMU_MMU_FAULT_AD_OFFSET))
+
+#define MMUMMU_TTBWriteRegister32(baseAddress, value)			\
+do {									\
+	const u32 offset = MMU_MMU_TTB_OFFSET;				\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_TTBWriteRegister32);		\
+	__raw_writel(newValue, (baseAddress) + offset);			\
+} while (0)
+
+#define MMUMMU_LOCKReadRegister32(baseAddress)				\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKReadRegister32),		\
+	__raw_readl((baseAddress) + MMU_MMU_LOCK_OFFSET))
+
+#define MMUMMU_LOCKWriteRegister32(baseAddress, value)			\
+do {									\
+	const u32 offset = MMU_MMU_LOCK_OFFSET;				\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKWriteRegister32);		\
+	__raw_writel(newValue, (baseAddress) + offset);			\
+} while (0)
+
+#define MMUMMU_LOCKBaseValueRead32(baseAddress)				\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKBaseValueRead32),	\
+	(((__raw_readl(((baseAddress) + (MMU_MMU_LOCK_OFFSET)))) &	\
+	MMU_MMU_LOCK_BaseValue_MASK) >>	MMU_MMU_LOCK_BaseValue_OFFSET))	\
+
+#define MMUMMU_LOCKBaseValueWrite32(baseAddress, value)			\
+do {									\
+	const u32 offset = MMU_MMU_LOCK_OFFSET;				\
+	register u32 data = __raw_readl((baseAddress) + offset);	\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKBaseValueWrite32);	\
+	data &= ~(MMU_MMU_LOCK_BaseValue_MASK);				\
+	newValue <<= MMU_MMU_LOCK_BaseValue_OFFSET;			\
+	newValue &= MMU_MMU_LOCK_BaseValue_MASK;			\
+	newValue |= data;						\
+	__raw_writel(newValue, baseAddress+offset);			\
+} while (0)
+
+#define MMUMMU_LOCKCurrentVictimRead32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKCurrentVictimRead32),	\
+	(((__raw_readl(((baseAddress) + (MMU_MMU_LOCK_OFFSET)))) &	\
+	MMU_MMU_LOCK_CurrentVictim_MASK) >>				\
+	MMU_MMU_LOCK_CurrentVictim_OFFSET))
+
+#define MMUMMU_LOCKCurrentVictimWrite32(baseAddress, value)		\
+do {									\
+	const u32 offset = MMU_MMU_LOCK_OFFSET;				\
+	register u32 data = __raw_readl((baseAddress) + offset);	\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKCurrentVictimWrite32);	\
+	data &= ~(MMU_MMU_LOCK_CurrentVictim_MASK);			\
+	newValue <<= MMU_MMU_LOCK_CurrentVictim_OFFSET;			\
+	newValue &= MMU_MMU_LOCK_CurrentVictim_MASK;			\
+	newValue |= data;						\
+	__raw_writel(newValue, baseAddress + offset);			\
+} while (0)
+
+#define MMUMMU_LOCKCurrentVictimSet32(var, value)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LOCKCurrentVictimSet32),	\
+	(((var) & ~(MMU_MMU_LOCK_CurrentVictim_MASK)) |			\
+	(((value) << MMU_MMU_LOCK_CurrentVictim_OFFSET) &		\
+	MMU_MMU_LOCK_CurrentVictim_MASK)))
+
+#define MMUMMU_LD_TLBReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LD_TLBReadRegister32),	\
+	__raw_readl((baseAddress) + MMU_MMU_LD_TLB_OFFSET))
+
+#define MMUMMU_LD_TLBWriteRegister32(baseAddress, value)		\
+do {									\
+	const u32 offset = MMU_MMU_LD_TLB_OFFSET;			\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_LD_TLBWriteRegister32);	\
+	__raw_writel(newValue, (baseAddress) + offset);			\
+} while (0)
+
+#define MMUMMU_CAMWriteRegister32(baseAddress, value)			\
+do {									\
+	const u32 offset = MMU_MMU_CAM_OFFSET;				\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_CAMWriteRegister32);		\
+	__raw_writel(newValue, (baseAddress) + offset);			\
+} while (0)
+
+#define MMUMMU_RAMWriteRegister32(baseAddress, value)			\
+do {									\
+	const u32 offset = MMU_MMU_RAM_OFFSET;				\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_RAMWriteRegister32);		\
+	__raw_writel(newValue, (baseAddress) + offset);			\
+} while (0)
+
+#define MMUMMU_FLUSH_ENTRYWriteRegister32(baseAddress, value)		\
+do {									\
+	const u32 offset = MMU_MMU_FLUSH_ENTRY_OFFSET;			\
+	register u32 newValue = (value);				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_MMUMMU_FLUSH_ENTRYWriteRegister32);	\
+	__raw_writel(newValue, (baseAddress) + offset);			\
+} while (0)
 
 #endif	/* USE_LEVEL_1_MACROS */
 
diff --git a/drivers/dsp/bridge/hw/PRCMRegAcM.h b/drivers/dsp/bridge/hw/PRCMRegAcM.h
index 4c9d732..080a998 100644
--- a/drivers/dsp/bridge/hw/PRCMRegAcM.h
+++ b/drivers/dsp/bridge/hw/PRCMRegAcM.h
@@ -26,644 +26,575 @@
 
 #if defined(USE_LEVEL_1_MACROS)
 
-#define PRCMPRCM_CLKCFG_CTRLValid_configWriteClk_valid32(baseAddress)\
-{\
-    const u32 offset = PRCM_PRCM_CLKCFG_CTRL_OFFSET;\
-    const u32 newValue = \
-	(u32)PRCMPRCM_CLKCFG_CTRLValid_configClk_valid <<\
-      PRCM_PRCM_CLKCFG_CTRL_Valid_config_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(\
-      EASIL1_PRCMPRCM_CLKCFG_CTRLValid_configWriteClk_valid32);\
-    data &= ~(PRCM_PRCM_CLKCFG_CTRL_Valid_config_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define CM_FCLKEN_PERReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),\
-      __raw_readl(((u32)(baseAddress))+CM_FCLKEN_PER_OFFSET))
-
-
-#define CM_ICLKEN_PERReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),\
-      __raw_readl(((u32)(baseAddress))+CM_ICLKEN_PER_OFFSET))
-
-
-#define CM_FCLKEN_PER_GPT5WriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = CM_FCLKEN_PER_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_CM_FCLKEN_PER_GPT5WriteRegister32);\
-   data &= ~(CM_FCLKEN_PER_GPT5_MASK);\
-   newValue <<= CM_FCLKEN_PER_GPT5_OFFSET;\
-   newValue &= CM_FCLKEN_PER_GPT5_MASK;\
-   newValue |= data;\
-    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
-}
-
-
-#define CM_FCLKEN_PER_GPT6WriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = CM_FCLKEN_PER_OFFSET;\
-    register u32 data =\
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_CM_FCLKEN_PER_GPT5WriteRegister32);\
-   data &= ~(CM_FCLKEN_PER_GPT6_MASK);\
-   newValue <<= CM_FCLKEN_PER_GPT6_OFFSET;\
-   newValue &= CM_FCLKEN_PER_GPT6_MASK;\
-   newValue |= data;\
-    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
-}
-
-
-#define CM_ICLKEN_PER_GPT5WriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = CM_ICLKEN_PER_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_CM_ICLKEN_PER_GPT5WriteRegister32);\
-   data &= ~(CM_ICLKEN_PER_GPT5_MASK);\
-   newValue <<= CM_ICLKEN_PER_GPT5_OFFSET;\
-   newValue &= CM_ICLKEN_PER_GPT5_MASK;\
-   newValue |= data;\
-    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
-}
-
-
-#define CM_ICLKEN_PER_GPT6WriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = CM_ICLKEN_PER_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_CM_ICLKEN_PER_GPT5WriteRegister32);\
-   data &= ~(CM_ICLKEN_PER_GPT6_MASK);\
-   newValue <<= CM_ICLKEN_PER_GPT6_OFFSET;\
-   newValue &= CM_ICLKEN_PER_GPT6_MASK;\
-   newValue |= data;\
-    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
-}
-
-
-#define CM_FCLKEN1_COREReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),\
-      __raw_readl(((u32)(baseAddress))+CM_FCLKEN1_CORE_OFFSET))
-
-
-#define PRCMCM_FCLKEN1_COREEN_GPT8Write32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_CM_FCLKEN1_CORE_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREEN_GPT8Write32);\
-    data &= ~(PRCM_CM_FCLKEN1_CORE_EN_GPT8_MASK);\
-    newValue <<= PRCM_CM_FCLKEN1_CORE_EN_GPT8_OFFSET;\
-    newValue &= PRCM_CM_FCLKEN1_CORE_EN_GPT8_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_FCLKEN1_COREEN_GPT7Write32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_CM_FCLKEN1_CORE_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREEN_GPT7Write32);\
-    data &= ~(PRCM_CM_FCLKEN1_CORE_EN_GPT7_MASK);\
-    newValue <<= PRCM_CM_FCLKEN1_CORE_EN_GPT7_OFFSET;\
-    newValue &= PRCM_CM_FCLKEN1_CORE_EN_GPT7_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define CM_ICLKEN1_COREReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREReadRegister32),\
-      __raw_readl(((u32)(baseAddress))+CM_ICLKEN1_CORE_OFFSET))
-
-
-#define  CM_ICLKEN1_COREEN_MAILBOXESWrite32(baseAddress, value)\
-{\
-    const u32 offset = CM_ICLKEN1_CORE_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREEN_MAILBOXESWrite32);\
-    data &= ~(CM_ICLKEN1_CORE_EN_MAILBOXES_MASK);\
-    newValue <<= CM_ICLKEN1_CORE_EN_MAILBOXES_OFFSET;\
-    newValue &= CM_ICLKEN1_CORE_EN_MAILBOXES_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_ICLKEN1_COREEN_GPT8Write32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_CM_ICLKEN1_CORE_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREEN_GPT8Write32);\
-    data &= ~(PRCM_CM_ICLKEN1_CORE_EN_GPT8_MASK);\
-    newValue <<= PRCM_CM_ICLKEN1_CORE_EN_GPT8_OFFSET;\
-    newValue &= PRCM_CM_ICLKEN1_CORE_EN_GPT8_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_ICLKEN1_COREEN_GPT7Write32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_CM_ICLKEN1_CORE_OFFSET;\
-    register u32 data =\
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREEN_GPT7Write32);\
-    data &= ~(PRCM_CM_ICLKEN1_CORE_EN_GPT7_MASK);\
-    newValue <<= PRCM_CM_ICLKEN1_CORE_EN_GPT7_OFFSET;\
-    newValue &= PRCM_CM_ICLKEN1_CORE_EN_GPT7_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL2_CORECLKSEL_GPT8Write32k32(baseAddress)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT832k <<\
-      PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT8Write32k32);\
-    data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL2_CORECLKSEL_GPT8WriteSys32(baseAddress)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT8Sys <<\
-      PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT8WriteSys32);\
-    data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL2_CORECLKSEL_GPT8WriteExt32(baseAddress)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT8Ext <<\
-      PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT8WriteExt32);\
-    data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL2_CORECLKSEL_GPT7Write32k32(baseAddress)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT732k <<\
-      PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT7Write32k32);\
-    data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL2_CORECLKSEL_GPT7WriteSys32(baseAddress)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT7Sys <<\
-      PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT7WriteSys32);\
-    data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL2_CORECLKSEL_GPT7WriteExt32(baseAddress)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT7Ext <<\
-      PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT7WriteExt32);\
-    data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL2_CORECLKSEL_GPT6WriteSys32(baseAddress)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT6Sys <<\
-      PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT6WriteSys32);\
-    data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL2_CORECLKSEL_GPT6WriteExt32(baseAddress)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT6Ext <<\
-      PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT6WriteExt32);\
-    data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define CM_CLKSEL_PER_GPT5Write32k32(baseAddress)\
-{\
-    const u32 offset = CM_CLKSEL_PER_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT532k <<\
-      CM_CLKSEL_PER_GPT5_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_CM_CLKSEL_PER_GPT5Write32k32);\
-    data &= ~(CM_CLKSEL_PER_GPT5_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define CM_CLKSEL_PER_GPT6Write32k32(baseAddress)\
-{\
-    const u32 offset = CM_CLKSEL_PER_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT532k <<\
-      CM_CLKSEL_PER_GPT6_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_CM_CLKSEL_PER_GPT6Write32k32);\
-    data &= ~(CM_CLKSEL_PER_GPT6_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL2_CORECLKSEL_GPT5WriteSys32(baseAddress)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT5Sys <<\
-      PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT5WriteSys32);\
-    data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL2_CORECLKSEL_GPT5WriteExt32(baseAddress)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;\
-    const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT5Ext <<\
-      PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_OFFSET;\
-    register u32 data = __raw_readl((u32)(baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT5WriteExt32);\
-    data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL1_PLLAPLLs_ClkinRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL1_PLLAPLLs_ClkinRead32),\
-      (((__raw_readl((((u32)(baseAddress))+\
-	(PRCM_CM_CLKSEL1_PLL_OFFSET)))) &\
-      PRCM_CM_CLKSEL1_PLL_APLLs_Clkin_MASK) >>\
-      PRCM_CM_CLKSEL1_PLL_APLLs_Clkin_OFFSET))
-
-
-#define CM_FCLKEN_IVA2EN_DSPWrite32(baseAddress, value)\
-{\
-    const u32 offset = CM_FCLKEN_IVA2_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN_DSPEN_DSPWrite32);\
-    data &= ~(CM_FCLKEN_IVA2_EN_MASK);\
-    newValue <<= CM_FCLKEN_IVA2_EN_OFFSET;\
-    newValue &= CM_FCLKEN_IVA2_EN_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_ICLKEN_DSPEN_DSP_IPIWrite32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_CM_ICLKEN_DSP_OFFSET;\
-    register u32 data = \
-      __raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN_DSPEN_DSP_IPIWrite32);\
-    data &= ~(PRCM_CM_ICLKEN_DSP_EN_DSP_IPI_MASK);\
-    newValue <<= PRCM_CM_ICLKEN_DSP_EN_DSP_IPI_OFFSET;\
-    newValue &= PRCM_CM_ICLKEN_DSP_EN_DSP_IPI_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_IDLEST_DSPReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_IDLEST_DSPReadRegister32),\
-      __raw_readl(((u32)(baseAddress))+PRCM_CM_IDLEST_DSP_OFFSET))
-
-
-#define PRCMCM_IDLEST_DSPST_IPIRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_IDLEST_DSPST_IPIRead32),\
-      (((__raw_readl((((u32)(baseAddress))+\
-	(PRCM_CM_IDLEST_DSP_OFFSET)))) &\
-      PRCM_CM_IDLEST_DSP_ST_IPI_MASK) >>\
-      PRCM_CM_IDLEST_DSP_ST_IPI_OFFSET))
+#define PRCMPRCM_CLKCFG_CTRLValid_configWriteClk_valid32(baseAddress)	       \
+do {									       \
+	const u32 offset = PRCM_PRCM_CLKCFG_CTRL_OFFSET;		       \
+	const u32 newValue = (u32)PRCMPRCM_CLKCFG_CTRLValid_configClk_valid << \
+			PRCM_PRCM_CLKCFG_CTRL_Valid_config_OFFSET;	       \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	       \
+	_DEBUG_LEVEL_1_EASI(						       \
+		EASIL1_PRCMPRCM_CLKCFG_CTRLValid_configWriteClk_valid32);      \
+	data &= ~(PRCM_PRCM_CLKCFG_CTRL_Valid_config_MASK);		       \
+	data |= newValue;						       \
+	__raw_writel(data, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define CM_FCLKEN_PERReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),	\
+	__raw_readl(((u32)(baseAddress)) + CM_FCLKEN_PER_OFFSET))
+
+#define CM_ICLKEN_PERReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),	\
+	__raw_readl(((u32)(baseAddress)) + CM_ICLKEN_PER_OFFSET))
+
+#define CM_FCLKEN_PER_GPT5WriteRegister32(baseAddress, value)		\
+do {									\
+	const u32 offset = CM_FCLKEN_PER_OFFSET;			\
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_CM_FCLKEN_PER_GPT5WriteRegister32);	\
+	data &= ~(CM_FCLKEN_PER_GPT5_MASK);				\
+	newValue <<= CM_FCLKEN_PER_GPT5_OFFSET;				\
+	newValue &= CM_FCLKEN_PER_GPT5_MASK;				\
+	newValue |= data;						\
+	__raw_writel(newValue, ((u32)(baseAddress)) + offset);		\
+} while (0)
+
+#define CM_FCLKEN_PER_GPT6WriteRegister32(baseAddress, value)		\
+do {									\
+	const u32 offset = CM_FCLKEN_PER_OFFSET;			\
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_CM_FCLKEN_PER_GPT5WriteRegister32);	\
+	data &= ~(CM_FCLKEN_PER_GPT6_MASK);				\
+	newValue <<= CM_FCLKEN_PER_GPT6_OFFSET;				\
+	newValue &= CM_FCLKEN_PER_GPT6_MASK;				\
+	newValue |= data;						\
+	__raw_writel(newValue, ((u32)(baseAddress)) + offset);		\
+} while (0)
+
+#define CM_ICLKEN_PER_GPT5WriteRegister32(baseAddress, value)		\
+do {									\
+	const u32 offset = CM_ICLKEN_PER_OFFSET;			\
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_CM_ICLKEN_PER_GPT5WriteRegister32);	\
+	data &= ~(CM_ICLKEN_PER_GPT5_MASK);				\
+	newValue <<= CM_ICLKEN_PER_GPT5_OFFSET;				\
+	newValue &= CM_ICLKEN_PER_GPT5_MASK;				\
+	newValue |= data;						\
+	__raw_writel(newValue, ((u32)(baseAddress)) + offset);		\
+} while (0)
+
+#define CM_ICLKEN_PER_GPT6WriteRegister32(baseAddress, value)		\
+do {									\
+	const u32 offset = CM_ICLKEN_PER_OFFSET;			\
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_CM_ICLKEN_PER_GPT5WriteRegister32);	\
+	data &= ~(CM_ICLKEN_PER_GPT6_MASK);				\
+	newValue <<= CM_ICLKEN_PER_GPT6_OFFSET;				\
+	newValue &= CM_ICLKEN_PER_GPT6_MASK;				\
+	newValue |= data;						\
+	__raw_writel(newValue, ((u32)(baseAddress)) + offset);		\
+} while (0)
+
+#define CM_FCLKEN1_COREReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),	\
+	__raw_readl(((u32)(baseAddress)) + CM_FCLKEN1_CORE_OFFSET))
+
+
+#define PRCMCM_FCLKEN1_COREEN_GPT8Write32(baseAddress, value)		\
+do {									\
+	const u32 offset = PRCM_CM_FCLKEN1_CORE_OFFSET;			\
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREEN_GPT8Write32);	\
+	data &= ~(PRCM_CM_FCLKEN1_CORE_EN_GPT8_MASK);			\
+	newValue <<= PRCM_CM_FCLKEN1_CORE_EN_GPT8_OFFSET;		\
+	newValue &= PRCM_CM_FCLKEN1_CORE_EN_GPT8_MASK;			\
+	newValue |= data;						\
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		\
+} while (0)
+
+#define PRCMCM_FCLKEN1_COREEN_GPT7Write32(baseAddress, value)		\
+do {									\
+	const u32 offset = PRCM_CM_FCLKEN1_CORE_OFFSET;			\
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREEN_GPT7Write32);	\
+	data &= ~(PRCM_CM_FCLKEN1_CORE_EN_GPT7_MASK);			\
+	newValue <<= PRCM_CM_FCLKEN1_CORE_EN_GPT7_OFFSET;		\
+	newValue &= PRCM_CM_FCLKEN1_CORE_EN_GPT7_MASK;			\
+	newValue |= data;						\
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		\
+} while (0)
+
+#define CM_ICLKEN1_COREReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREReadRegister32),	\
+	__raw_readl(((u32)(baseAddress)) + CM_ICLKEN1_CORE_OFFSET))
+
+#define CM_ICLKEN1_COREEN_MAILBOXESWrite32(baseAddress, value)		    \
+do {									    \
+	const u32 offset = CM_ICLKEN1_CORE_OFFSET;			    \
+	register u32 data = 						    \
+	__raw_readl(((u32)(baseAddress)) + offset);			    \
+	register u32 newValue = ((u32)(value));				    \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREEN_MAILBOXESWrite32); \
+	data &= ~(CM_ICLKEN1_CORE_EN_MAILBOXES_MASK);			    \
+	newValue <<= CM_ICLKEN1_CORE_EN_MAILBOXES_OFFSET;		    \
+	newValue &= CM_ICLKEN1_CORE_EN_MAILBOXES_MASK;			    \
+	newValue |= data;						    \
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		    \
+} while (0)
+
+#define PRCMCM_ICLKEN1_COREEN_GPT8Write32(baseAddress, value)		\
+do {									\
+	const u32 offset = PRCM_CM_ICLKEN1_CORE_OFFSET;			\
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREEN_GPT8Write32);	\
+	data &= ~(PRCM_CM_ICLKEN1_CORE_EN_GPT8_MASK);			\
+	newValue <<= PRCM_CM_ICLKEN1_CORE_EN_GPT8_OFFSET;		\
+	newValue &= PRCM_CM_ICLKEN1_CORE_EN_GPT8_MASK;			\
+	newValue |= data;						\
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		\
+} while (0)
+
+#define PRCMCM_ICLKEN1_COREEN_GPT7Write32(baseAddress, value)		\
+do {									\
+	const u32 offset = PRCM_CM_ICLKEN1_CORE_OFFSET;			\
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN1_COREEN_GPT7Write32);	\
+	data &= ~(PRCM_CM_ICLKEN1_CORE_EN_GPT7_MASK);			\
+	newValue <<= PRCM_CM_ICLKEN1_CORE_EN_GPT7_OFFSET;		\
+	newValue &= PRCM_CM_ICLKEN1_CORE_EN_GPT7_MASK;			\
+	newValue |= data;						\
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		\
+} while (0)
+
+#define PRCMCM_CLKSEL2_CORECLKSEL_GPT8Write32k32(baseAddress)		      \
+do {									      \
+	const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;			      \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT832k <<	      \
+		PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_OFFSET;		      \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	      \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT8Write32k32); \
+	data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_MASK);		      \
+	data |= newValue;						      \
+	__raw_writel(data, (u32)(baseAddress) + offset);		      \
+} while (0)
+
+
+#define PRCMCM_CLKSEL2_CORECLKSEL_GPT8WriteSys32(baseAddress)		      \
+do {									      \
+	const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;			      \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT8Sys <<	      \
+		PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_OFFSET;		      \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	      \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT8WriteSys32); \
+	data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_MASK);		      \
+	data |= newValue;						      \
+	__raw_writel(data, (u32)(baseAddress) + offset);		      \
+} while (0)
+
+#define PRCMCM_CLKSEL2_CORECLKSEL_GPT8WriteExt32(baseAddress)		      \
+do {									      \
+	const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;			      \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT8Ext <<	      \
+		PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_OFFSET;		      \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	      \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT8WriteExt32); \
+	data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT8_MASK);		      \
+	data |= newValue;						      \
+	__raw_writel(data, (u32)(baseAddress) + offset);		      \
+} while (0)
+
+#define PRCMCM_CLKSEL2_CORECLKSEL_GPT7Write32k32(baseAddress)		      \
+do {									      \
+	const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;			      \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT732k <<	      \
+		PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_OFFSET;		      \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	      \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT7Write32k32); \
+	data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_MASK);		      \
+	data |= newValue;						      \
+	__raw_writel(data, (u32)(baseAddress) + offset);		      \
+} while (0)
+
+#define PRCMCM_CLKSEL2_CORECLKSEL_GPT7WriteSys32(baseAddress)		      \
+do {									      \
+	const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;			      \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT7Sys <<	      \
+		PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_OFFSET;		      \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	      \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT7WriteSys32); \
+	data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_MASK);		      \
+	data |= newValue;						      \
+	__raw_writel(data, (u32)(baseAddress) + offset);		      \
+} while (0)
+
+#define PRCMCM_CLKSEL2_CORECLKSEL_GPT7WriteExt32(baseAddress)		       \
+do {									       \
+	const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;			       \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT7Ext <<	       \
+		PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_OFFSET;		       \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT7WriteExt32);  \
+	data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT7_MASK);		       \
+	data |= newValue;						       \
+	__raw_writel(data, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define PRCMCM_CLKSEL2_CORECLKSEL_GPT6WriteSys32(baseAddress)		       \
+do {									       \
+	const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;			       \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT6Sys <<	       \
+		PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_OFFSET;		       \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT6WriteSys32);  \
+	data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_MASK);		       \
+	data |= newValue;						       \
+	__raw_writel(data, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define PRCMCM_CLKSEL2_CORECLKSEL_GPT6WriteExt32(baseAddress)		       \
+do {									       \
+	const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;			       \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT6Ext <<	       \
+		PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_OFFSET;		       \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT6WriteExt32);  \
+	data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT6_MASK);		       \
+	data |= newValue;						       \
+	__raw_writel(data, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define CM_CLKSEL_PER_GPT5Write32k32(baseAddress)			       \
+do {									       \
+	const u32 offset = CM_CLKSEL_PER_OFFSET;			       \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT532k <<	       \
+		CM_CLKSEL_PER_GPT5_OFFSET;				       \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_CM_CLKSEL_PER_GPT5Write32k32);	       \
+	data &= ~(CM_CLKSEL_PER_GPT5_MASK);				       \
+	data |= newValue;						       \
+	__raw_writel(data, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define CM_CLKSEL_PER_GPT6Write32k32(baseAddress)			       \
+do {									       \
+	const u32 offset = CM_CLKSEL_PER_OFFSET;			       \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT532k <<	       \
+		CM_CLKSEL_PER_GPT6_OFFSET;				       \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_CM_CLKSEL_PER_GPT6Write32k32);	       \
+	data &= ~(CM_CLKSEL_PER_GPT6_MASK);				       \
+	data |= newValue;						       \
+	__raw_writel(data, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define PRCMCM_CLKSEL2_CORECLKSEL_GPT5WriteSys32(baseAddress)		       \
+do {									       \
+	const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;			       \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT5Sys <<	       \
+		PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_OFFSET;		       \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT5WriteSys32);  \
+	data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_MASK);		       \
+	data |= newValue;						       \
+	__raw_writel(data, (u32)(baseAddress) + offset);		       \
+} while (0);
+
+#define PRCMCM_CLKSEL2_CORECLKSEL_GPT5WriteExt32(baseAddress)		       \
+do {									       \
+	const u32 offset = PRCM_CM_CLKSEL2_CORE_OFFSET;			       \
+	const u32 newValue = (u32)PRCMCM_CLKSEL2_CORECLKSEL_GPT5Ext <<	       \
+		PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_OFFSET;		       \
+	register u32 data = __raw_readl((u32)(baseAddress) + offset);	       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT5WriteExt32);  \
+	data &= ~(PRCM_CM_CLKSEL2_CORE_CLKSEL_GPT5_MASK);		       \
+	data |= newValue;						       \
+	__raw_writel(data, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define PRCMCM_CLKSEL1_PLLAPLLs_ClkinRead32(baseAddress)		       \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL1_PLLAPLLs_ClkinRead32),      \
+	(((__raw_readl((((u32)(baseAddress)) +				       \
+	(PRCM_CM_CLKSEL1_PLL_OFFSET)))) &				       \
+	PRCM_CM_CLKSEL1_PLL_APLLs_Clkin_MASK) >>			       \
+	PRCM_CM_CLKSEL1_PLL_APLLs_Clkin_OFFSET))
+
+#define CM_FCLKEN_IVA2EN_DSPWrite32(baseAddress, value)			       \
+do {									       \
+	const u32 offset = CM_FCLKEN_IVA2_OFFSET;			       \
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	       \
+	register u32 newValue = ((u32)(value));				       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN_DSPEN_DSPWrite32);	       \
+	data &= ~(CM_FCLKEN_IVA2_EN_MASK);				       \
+	newValue <<= CM_FCLKEN_IVA2_EN_OFFSET;				       \
+	newValue &= CM_FCLKEN_IVA2_EN_MASK;				       \
+	newValue |= data;						       \
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define PRCMCM_ICLKEN_DSPEN_DSP_IPIWrite32(baseAddress, value)		       \
+do {									       \
+	const u32 offset = PRCM_CM_ICLKEN_DSP_OFFSET;			       \
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	       \
+	register u32 newValue = ((u32)(value));				       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_ICLKEN_DSPEN_DSP_IPIWrite32);	       \
+	data &= ~(PRCM_CM_ICLKEN_DSP_EN_DSP_IPI_MASK);			       \
+	newValue <<= PRCM_CM_ICLKEN_DSP_EN_DSP_IPI_OFFSET;		       \
+	newValue &= PRCM_CM_ICLKEN_DSP_EN_DSP_IPI_MASK;			       \
+	newValue |= data;						       \
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define PRCMCM_IDLEST_DSPReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_IDLEST_DSPReadRegister32),	\
+	__raw_readl(((u32)(baseAddress)) + PRCM_CM_IDLEST_DSP_OFFSET))
+
+
+#define PRCMCM_IDLEST_DSPST_IPIRead32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_IDLEST_DSPST_IPIRead32),	\
+	(((__raw_readl((((u32)(baseAddress)) +				\
+	(PRCM_CM_IDLEST_DSP_OFFSET)))) &				\
+	PRCM_CM_IDLEST_DSP_ST_IPI_MASK) >>				\
+	PRCM_CM_IDLEST_DSP_ST_IPI_OFFSET))
 
 
 #define PRM_IDLEST_IVA2ST_IVA2Read32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_IDLEST_DSPST_DSPRead32),\
-      (((__raw_readl((((u32)(baseAddress))+\
-	  (CM_IDLEST_IVA2_OFFSET)))) &\
-      CM_IDLEST_IVA2_ST_IVA2_MASK) >>\
-      CM_IDLEST_IVA2_ST_IVA2_OFFSET))
-
-
-#define PRCMCM_AUTOIDLE_DSPAUTO_DSP_IPIWrite32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_CM_AUTOIDLE_DSP_OFFSET;\
-    register u32 data =\
-      __raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_AUTOIDLE_DSPAUTO_DSP_IPIWrite32);\
-    data &= ~(PRCM_CM_AUTOIDLE_DSP_AUTO_DSP_IPI_MASK);\
-    newValue <<= PRCM_CM_AUTOIDLE_DSP_AUTO_DSP_IPI_OFFSET;\
-    newValue &= PRCM_CM_AUTOIDLE_DSP_AUTO_DSP_IPI_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL_DSPSYNC_DSPWrite32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL_DSP_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL_DSPSYNC_DSPWrite32);\
-    data &= ~(PRCM_CM_CLKSEL_DSP_SYNC_DSP_MASK);\
-    newValue <<= PRCM_CM_CLKSEL_DSP_SYNC_DSP_OFFSET;\
-    newValue &= PRCM_CM_CLKSEL_DSP_SYNC_DSP_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL_DSPCLKSEL_DSP_IFWrite32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL_DSP_OFFSET;\
-    register u32 data = \
-      __raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL_DSPCLKSEL_DSP_IFWrite32);\
-    data &= ~(PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_IF_MASK);\
-    newValue <<= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_IF_OFFSET;\
-    newValue &= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_IF_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSEL_DSPCLKSEL_DSPWrite32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_CM_CLKSEL_DSP_OFFSET;\
-    register u32 data = \
-      __raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL_DSPCLKSEL_DSPWrite32);\
-    data &= ~(PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_MASK);\
-    newValue <<= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_OFFSET;\
-    newValue &= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSTCTRL_IVA2WriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_CM_CLKSTCTRL_IVA2_OFFSET;\
-    register u32 data = \
-      __raw_readl(((baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSTCTRL_IVA2WriteRegister32);\
-    data &= ~(CM_CLKSTCTRL_IVA2_MASK);\
-    newValue <<= CM_CLKSTCTRL_IVA2_OFFSET;\
-    newValue &= CM_CLKSTCTRL_IVA2_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
-
-#define PRCMCM_CLKSTCTRL_DSPAutostate_DSPRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSTCTRL_DSPAutostate_DSPRead32),\
-      (((__raw_readl((((u32)(baseAddress))+\
-	(PRCM_CM_CLKSTCTRL_DSP_OFFSET)))) &\
-      PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_MASK) >>\
-      PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_OFFSET))
-
-
-#define PRCMCM_CLKSTCTRL_DSPAutostate_DSPWrite32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_CM_CLKSTCTRL_DSP_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSTCTRL_DSPAutostate_DSPWrite32);\
-    data &= ~(PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_MASK);\
-    newValue <<= PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_OFFSET;\
-    newValue &= PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMRM_RSTCTRL_DSPReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPReadRegister32),\
-      __raw_readl(((baseAddress))+PRCM_RM_RSTCTRL_DSP_OFFSET))
-
-
-#define PRM_RSTCTRL_IVA2RST1_DSPWrite32(baseAddress, value)\
-{\
-    const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;\
-    register u32 data =\
-    __raw_readl(((baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPRST1_DSPWrite32);\
-    data &= ~(PRM_RSTCTRL_IVA2_RST1_MASK);\
-    newValue <<= PRM_RSTCTRL_IVA2_RST1_OFFSET;\
-    newValue &= PRM_RSTCTRL_IVA2_RST1_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
-
-#define PRM_RSTCTRL_IVA2RST2_DSPWrite32(baseAddress, value)\
-{\
-    const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;\
-    register u32 data =\
-	__raw_readl(((baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPRST1_DSPWrite32);\
-    data &= ~(PRM_RSTCTRL_IVA2_RST2_MASK);\
-    newValue <<= PRM_RSTCTRL_IVA2_RST2_OFFSET;\
-    newValue &= PRM_RSTCTRL_IVA2_RST2_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
-
-#define PRM_RSTCTRL_IVA2RST3_DSPWrite32(baseAddress, value)\
-{\
-    const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;\
-    register u32 data =\
-      __raw_readl(((baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPRST1_DSPWrite32);\
-    data &= ~(PRM_RSTCTRL_IVA2_RST3_MASK);\
-    newValue <<= PRM_RSTCTRL_IVA2_RST3_OFFSET;\
-    newValue &= PRM_RSTCTRL_IVA2_RST3_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (baseAddress)+offset);\
-}
-
-
-#define PRCMRM_RSTST_DSPReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTST_DSPReadRegister32),\
-      __raw_readl(((baseAddress))+PRCM_RM_RSTST_DSP_OFFSET))
-
-
-#define PRCMRM_RSTST_DSPWriteRegister32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_RM_RSTST_DSP_OFFSET;\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTST_DSPWriteRegister32);\
-    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
-}
-
-
-#define PRCMPM_PWSTCTRL_DSPForceStateWrite32(baseAddress, value)\
-{\
-    const u32 offset = PRCM_PM_PWSTCTRL_DSP_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_DSPForceStateWrite32);\
-    data &= ~(PRCM_PM_PWSTCTRL_DSP_ForceState_MASK);\
-    newValue <<= PRCM_PM_PWSTCTRL_DSP_ForceState_OFFSET;\
-    newValue &= PRCM_PM_PWSTCTRL_DSP_ForceState_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
-#define PRCMPM_PWSTCTRL_IVA2PowerStateWriteON32(baseAddress)\
-{\
-    const u32 offset = PRCM_PM_PWSTCTRL_IVA2_OFFSET;\
-    const u32 newValue = (u32)PRCMPM_PWSTCTRL_IVA2PowerStateON <<\
-      PRCM_PM_PWSTCTRL_IVA2_PowerState_OFFSET;\
-    register u32 data = __raw_readl((baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_IVA2PowerStateWriteON32);\
-    data &= ~(PRCM_PM_PWSTCTRL_IVA2_PowerState_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (baseAddress)+offset);\
-}
-
-
-#define PRCMPM_PWSTCTRL_IVA2PowerStateWriteOFF32(baseAddress)\
-{\
-    const u32 offset = PRCM_PM_PWSTCTRL_IVA2_OFFSET;\
-    const u32 newValue = (u32)PRCMPM_PWSTCTRL_IVA2PowerStateOFF <<\
-      PRCM_PM_PWSTCTRL_IVA2_PowerState_OFFSET;\
-    register u32 data = __raw_readl((baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_IVA2PowerStateWriteOFF32);\
-    data &= ~(PRCM_PM_PWSTCTRL_IVA2_PowerState_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (baseAddress)+offset);\
-}
-
-
-#define PRCMPM_PWSTCTRL_DSPPowerStateWriteRET32(baseAddress)\
-{\
-    const u32 offset = PRCM_PM_PWSTCTRL_DSP_OFFSET;\
-    const u32 newValue = (u32)PRCMPM_PWSTCTRL_DSPPowerStateRET <<\
-      PRCM_PM_PWSTCTRL_DSP_PowerState_OFFSET;\
-    register u32 data = __raw_readl((baseAddress)+offset);\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_DSPPowerStateWriteRET32);\
-    data &= ~(PRCM_PM_PWSTCTRL_DSP_PowerState_MASK);\
-    data |= newValue;\
-    __raw_writel(data, (baseAddress)+offset);\
-}
-
-
-#define PRCMPM_PWSTST_DSPReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_DSPReadRegister32),\
-      __raw_readl(((u32)(baseAddress))+PRCM_PM_PWSTST_DSP_OFFSET))
-
-
-#define PRCMPM_PWSTST_IVA2ReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_IVA2ReadRegister32),\
-      __raw_readl((baseAddress) + PRCM_PM_PWSTST_IVA2_OFFSET))
-
-
-#define PRCMPM_PWSTST_DSPInTransitionRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_DSPInTransitionRead32),\
-      (((__raw_readl((((u32)(baseAddress))+\
-	(PRCM_PM_PWSTST_DSP_OFFSET)))) &\
-      PRCM_PM_PWSTST_DSP_InTransition_MASK) >>\
-      PRCM_PM_PWSTST_DSP_InTransition_OFFSET))
-
-
-#define PRCMPM_PWSTST_IVA2InTransitionRead32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_IVA2InTransitionRead32),\
-      (((__raw_readl((((baseAddress))+\
-	(PRCM_PM_PWSTST_IVA2_OFFSET)))) &\
-      PRCM_PM_PWSTST_IVA2_InTransition_MASK) >>\
-      PRCM_PM_PWSTST_IVA2_InTransition_OFFSET))
-
-
-#define PRCMPM_PWSTST_DSPPowerStateStGet32(var)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_DSPPowerStateStGet32),\
-      (u32)((((u32)(var)) & PRCM_PM_PWSTST_DSP_PowerStateSt_MASK) >>\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_IDLEST_DSPST_DSPRead32),	       \
+	(((__raw_readl((((u32)(baseAddress)) + (CM_IDLEST_IVA2_OFFSET)))) &    \
+	CM_IDLEST_IVA2_ST_IVA2_MASK) >>	CM_IDLEST_IVA2_ST_IVA2_OFFSET))
+
+#define PRCMCM_AUTOIDLE_DSPAUTO_DSP_IPIWrite32(baseAddress, value)	       \
+do {									       \
+	const u32 offset = PRCM_CM_AUTOIDLE_DSP_OFFSET;			       \
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	       \
+	register u32 newValue = ((u32)(value));				       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_AUTOIDLE_DSPAUTO_DSP_IPIWrite32);    \
+	data &= ~(PRCM_CM_AUTOIDLE_DSP_AUTO_DSP_IPI_MASK);		       \
+	newValue <<= PRCM_CM_AUTOIDLE_DSP_AUTO_DSP_IPI_OFFSET;		       \
+	newValue &= PRCM_CM_AUTOIDLE_DSP_AUTO_DSP_IPI_MASK;		       \
+	newValue |= data;						       \
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+
+#define PRCMCM_CLKSEL_DSPSYNC_DSPWrite32(baseAddress, value)		       \
+do {									       \
+	const u32 offset = PRCM_CM_CLKSEL_DSP_OFFSET;			       \
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	       \
+	register u32 newValue = ((u32)(value));				       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL_DSPSYNC_DSPWrite32);	       \
+	data &= ~(PRCM_CM_CLKSEL_DSP_SYNC_DSP_MASK);			       \
+	newValue <<= PRCM_CM_CLKSEL_DSP_SYNC_DSP_OFFSET;		       \
+	newValue &= PRCM_CM_CLKSEL_DSP_SYNC_DSP_MASK;			       \
+	newValue |= data;						       \
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+
+#define PRCMCM_CLKSEL_DSPCLKSEL_DSP_IFWrite32(baseAddress, value)	       \
+do {									       \
+	const u32 offset = PRCM_CM_CLKSEL_DSP_OFFSET;			       \
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	       \
+	register u32 newValue = ((u32)(value));				       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL_DSPCLKSEL_DSP_IFWrite32);     \
+	data &= ~(PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_IF_MASK);		       \
+	newValue <<= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_IF_OFFSET;		       \
+	newValue &= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_IF_MASK;		       \
+	newValue |= data;						       \
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define PRCMCM_CLKSEL_DSPCLKSEL_DSPWrite32(baseAddress, value)		       \
+do {									       \
+	const u32 offset = PRCM_CM_CLKSEL_DSP_OFFSET;			       \
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	       \
+	register u32 newValue = ((u32)(value));				       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSEL_DSPCLKSEL_DSPWrite32);	       \
+	data &= ~(PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_MASK);			       \
+	newValue <<= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_OFFSET;		       \
+	newValue &= PRCM_CM_CLKSEL_DSP_CLKSEL_DSP_MASK;			       \
+	newValue |= data;						       \
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define PRCMCM_CLKSTCTRL_IVA2WriteRegister32(baseAddress, value)	       \
+do {									       \
+	const u32 offset = PRCM_CM_CLKSTCTRL_IVA2_OFFSET;		       \
+	register u32 data = __raw_readl(((baseAddress)) + offset);	       \
+	register u32 newValue = ((u32)(value));				       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSTCTRL_IVA2WriteRegister32);      \
+	data &= ~(CM_CLKSTCTRL_IVA2_MASK);				       \
+	newValue <<= CM_CLKSTCTRL_IVA2_OFFSET;				       \
+	newValue &= CM_CLKSTCTRL_IVA2_MASK;				       \
+	newValue |= data;						       \
+	__raw_writel(newValue, (baseAddress) + offset);			       \
+} while (0)
+
+
+#define PRCMCM_CLKSTCTRL_DSPAutostate_DSPRead32(baseAddress)		       \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSTCTRL_DSPAutostate_DSPRead32),  \
+	(((__raw_readl((((u32)(baseAddress)) +				       \
+	(PRCM_CM_CLKSTCTRL_DSP_OFFSET)))) &				       \
+	PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_MASK) >>			       \
+	PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_OFFSET))
+
+#define PRCMCM_CLKSTCTRL_DSPAutostate_DSPWrite32(baseAddress, value)	       \
+do {									       \
+	const u32 offset = PRCM_CM_CLKSTCTRL_DSP_OFFSET;		       \
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	       \
+	register u32 newValue = ((u32)(value));				       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_CLKSTCTRL_DSPAutostate_DSPWrite32);  \
+	data &= ~(PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_MASK);		       \
+	newValue <<= PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_OFFSET;	       \
+	newValue &= PRCM_CM_CLKSTCTRL_DSP_Autostate_DSP_MASK;		       \
+	newValue |= data;						       \
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		       \
+} while (0)
+
+#define PRCMRM_RSTCTRL_DSPReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPReadRegister32),	\
+	__raw_readl(((baseAddress)) + PRCM_RM_RSTCTRL_DSP_OFFSET))
+
+#define PRM_RSTCTRL_IVA2RST1_DSPWrite32(baseAddress, value)		       \
+do {									       \
+	const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;			       \
+	register u32 data = __raw_readl(((baseAddress)) + offset);	       \
+	register u32 newValue = ((u32)(value));				       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPRST1_DSPWrite32);	       \
+	data &= ~(PRM_RSTCTRL_IVA2_RST1_MASK);				       \
+	newValue <<= PRM_RSTCTRL_IVA2_RST1_OFFSET;			       \
+	newValue &= PRM_RSTCTRL_IVA2_RST1_MASK;				       \
+	newValue |= data;						       \
+	__raw_writel(newValue, (baseAddress) + offset);			       \
+} while (0)
+
+#define PRM_RSTCTRL_IVA2RST2_DSPWrite32(baseAddress, value)		\
+do {									\
+	const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;			\
+	register u32 data = __raw_readl(((baseAddress)) + offset);	\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPRST1_DSPWrite32);	\
+	data &= ~(PRM_RSTCTRL_IVA2_RST2_MASK);				\
+	newValue <<= PRM_RSTCTRL_IVA2_RST2_OFFSET;			\
+	newValue &= PRM_RSTCTRL_IVA2_RST2_MASK;				\
+	newValue |= data;						\
+	__raw_writel(newValue, (baseAddress) + offset);			\
+} while (0)
+
+#define PRM_RSTCTRL_IVA2RST3_DSPWrite32(baseAddress, value)		\
+do {									\
+	const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;			\
+	register u32 data = __raw_readl(((baseAddress)) + offset);	\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTCTRL_DSPRST1_DSPWrite32);	\
+	data &= ~(PRM_RSTCTRL_IVA2_RST3_MASK);				\
+	newValue <<= PRM_RSTCTRL_IVA2_RST3_OFFSET;			\
+	newValue &= PRM_RSTCTRL_IVA2_RST3_MASK;				\
+	newValue |= data;						\
+	__raw_writel(newValue, (baseAddress) + offset);			\
+} while (0)
+
+#define PRCMRM_RSTST_DSPReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTST_DSPReadRegister32),	\
+	__raw_readl(((baseAddress)) + PRCM_RM_RSTST_DSP_OFFSET))
+
+#define PRCMRM_RSTST_DSPWriteRegister32(baseAddress, value)		\
+do {									\
+	const u32 offset = PRCM_RM_RSTST_DSP_OFFSET;			\
+	register u32 newValue = ((u32)(value));				\
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMRM_RSTST_DSPWriteRegister32);	\
+	__raw_writel(newValue, ((u32)(baseAddress)) + offset);		\
+} while (0)
+
+#define PRCMPM_PWSTCTRL_DSPForceStateWrite32(baseAddress, value)	  \
+do {									  \
+	const u32 offset = PRCM_PM_PWSTCTRL_DSP_OFFSET;			  \
+	register u32 data = __raw_readl(((u32)(baseAddress)) + offset);	  \
+	register u32 newValue = ((u32)(value));				  \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_DSPForceStateWrite32); \
+	data &= ~(PRCM_PM_PWSTCTRL_DSP_ForceState_MASK);		  \
+	newValue <<= PRCM_PM_PWSTCTRL_DSP_ForceState_OFFSET;		  \
+	newValue &= PRCM_PM_PWSTCTRL_DSP_ForceState_MASK;		  \
+	newValue |= data;						  \
+	__raw_writel(newValue, (u32)(baseAddress) + offset);		  \
+} while (0)
+
+#define PRCMPM_PWSTCTRL_IVA2PowerStateWriteON32(baseAddress)		       \
+do {									       \
+	const u32 offset = PRCM_PM_PWSTCTRL_IVA2_OFFSET;		       \
+	const u32 newValue = (u32)PRCMPM_PWSTCTRL_IVA2PowerStateON <<	       \
+		PRCM_PM_PWSTCTRL_IVA2_PowerState_OFFSET;		       \
+	register u32 data = __raw_readl((baseAddress) + offset);	       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_IVA2PowerStateWriteON32);   \
+	data &= ~(PRCM_PM_PWSTCTRL_IVA2_PowerState_MASK);		       \
+	data |= newValue;						       \
+	__raw_writel(data, (baseAddress) + offset);			       \
+} while (0)
+
+#define PRCMPM_PWSTCTRL_IVA2PowerStateWriteOFF32(baseAddress)		       \
+do {									       \
+	const u32 offset = PRCM_PM_PWSTCTRL_IVA2_OFFSET;		       \
+	const u32 newValue = (u32)PRCMPM_PWSTCTRL_IVA2PowerStateOFF <<	       \
+		PRCM_PM_PWSTCTRL_IVA2_PowerState_OFFSET;		       \
+	register u32 data = __raw_readl((baseAddress) + offset);	       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_IVA2PowerStateWriteOFF32);  \
+	data &= ~(PRCM_PM_PWSTCTRL_IVA2_PowerState_MASK);		       \
+	data |= newValue;						       \
+	__raw_writel(data, (baseAddress) + offset);			       \
+} while (0)
+
+#define PRCMPM_PWSTCTRL_DSPPowerStateWriteRET32(baseAddress)		       \
+do {									       \
+	const u32 offset = PRCM_PM_PWSTCTRL_DSP_OFFSET;			       \
+	const u32 newValue = (u32)PRCMPM_PWSTCTRL_DSPPowerStateRET <<	       \
+		PRCM_PM_PWSTCTRL_DSP_PowerState_OFFSET;			       \
+	register u32 data = __raw_readl((baseAddress) + offset);	       \
+	_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTCTRL_DSPPowerStateWriteRET32);   \
+	data &= ~(PRCM_PM_PWSTCTRL_DSP_PowerState_MASK);		       \
+	data |= newValue;						       \
+	__raw_writel(data, (baseAddress) + offset);			       \
+} while (0)
+
+#define PRCMPM_PWSTST_DSPReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_DSPReadRegister32),	\
+	__raw_readl(((u32)(baseAddress)) + PRCM_PM_PWSTST_DSP_OFFSET))
+
+
+#define PRCMPM_PWSTST_IVA2ReadRegister32(baseAddress)			\
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_IVA2ReadRegister32),	\
+	__raw_readl((baseAddress) + PRCM_PM_PWSTST_IVA2_OFFSET))
+
+
+#define PRCMPM_PWSTST_DSPInTransitionRead32(baseAddress)		       \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_DSPInTransitionRead32),      \
+	(((__raw_readl((((u32)(baseAddress)) + 				       \
+	(PRCM_PM_PWSTST_DSP_OFFSET)))) &				       \
+	PRCM_PM_PWSTST_DSP_InTransition_MASK) >>			       \
+	PRCM_PM_PWSTST_DSP_InTransition_OFFSET))
+
+#define PRCMPM_PWSTST_IVA2InTransitionRead32(baseAddress)		       \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_IVA2InTransitionRead32),     \
+	(((__raw_readl((((baseAddress)) +	 			       \
+	(PRCM_PM_PWSTST_IVA2_OFFSET)))) &				       \
+	PRCM_PM_PWSTST_IVA2_InTransition_MASK) >>			       \
+	PRCM_PM_PWSTST_IVA2_InTransition_OFFSET))
+
+#define PRCMPM_PWSTST_DSPPowerStateStGet32(var)				       \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_DSPPowerStateStGet32),       \
+	(u32)((((u32)(var)) & PRCM_PM_PWSTST_DSP_PowerStateSt_MASK) >>	       \
 	PRCM_PM_PWSTST_DSP_PowerStateSt_OFFSET))
 
-
-#define PRCMPM_PWSTST_IVA2PowerStateStGet32(var)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_IVA2PowerStateStGet32),\
-      (u32)((((u32)(var)) & PRCM_PM_PWSTST_IVA2_PowerStateSt_MASK) >>\
-      PRCM_PM_PWSTST_IVA2_PowerStateSt_OFFSET))
-
+#define PRCMPM_PWSTST_IVA2PowerStateStGet32(var)			       \
+	(_DEBUG_LEVEL_1_EASI(EASIL1_PRCMPM_PWSTST_IVA2PowerStateStGet32),      \
+	(u32)((((u32)(var)) & PRCM_PM_PWSTST_IVA2_PowerStateSt_MASK) >>	       \
+	PRCM_PM_PWSTST_IVA2_PowerStateSt_OFFSET))
 
 #endif  /* USE_LEVEL_1_MACROS */
 
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 5c613b4..d5399bd 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -317,9 +317,9 @@ enum INTH_SensitiveEdge_t {
 #define ClearBit(reg, mask)             (reg &= ~mask)
 #define SetBit(reg, mask)               (reg |= mask)
 
-#define SetGroupBits16(reg, position, width, value) \
-	do {\
-		reg &= ~((0xFFFF >> (16 - (width))) << (position)) ; \
+#define SetGroupBits16(reg, position, width, value)			     \
+	do {								     \
+		reg &= ~((0xFFFF >> (16 - (width))) << (position));	     \
 		reg |= ((value & (0xFFFF >> (16 - (width)))) << (position)); \
 	} while (0);
 
-- 
1.6.2.4

