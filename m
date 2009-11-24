From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/9] DSPBRIDGE: trivial checkpatch fixes
Date: Mon, 23 Nov 2009 18:50:23 -0600
Message-ID: <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56908 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757361AbZKXApJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Nov 2009 19:45:09 -0500
In-Reply-To: <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Quick fixes like:
* ERROR: space required after that ',' (ctx:VxV)
* ERROR: "foo *const	bar" should be "foo *const bar"
* WARNING: line over 80 characters
* ERROR: code indent should use tabs where possible
* ERROR: space required before the open parenthesis '('
* WARNING: suspect code indent for conditional statements

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/dbc.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |    8 +-
 arch/arm/plat-omap/include/dspbridge/gt.h       |    2 +-
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |    6 +-
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |    4 +-
 drivers/dsp/bridge/dynload/reloc.c              |   29 +-
 drivers/dsp/bridge/gen/_gt_para.c               |    2 +-
 drivers/dsp/bridge/gen/gs.c                     |    3 +-
 drivers/dsp/bridge/hw/GlobalTypes.h             |    4 +-
 drivers/dsp/bridge/hw/PRCMRegAcM.h              |   24 +-
 drivers/dsp/bridge/hw/hw_mbox.h                 |   44 +--
 drivers/dsp/bridge/pmgr/cmm.c                   |    5 +-
 drivers/dsp/bridge/pmgr/cod.c                   |    4 +-
 drivers/dsp/bridge/pmgr/dbll.c                  |   45 ++--
 drivers/dsp/bridge/pmgr/dev.c                   |    2 +-
 drivers/dsp/bridge/rmgr/disp.c                  |    4 +-
 drivers/dsp/bridge/rmgr/drv.c                   |   24 +-
 drivers/dsp/bridge/rmgr/drv_interface.c         |   12 +-
 drivers/dsp/bridge/rmgr/nldr.c                  |   28 +-
 drivers/dsp/bridge/rmgr/node.c                  |  209 ++++++------
 drivers/dsp/bridge/rmgr/proc.c                  |   14 +-
 drivers/dsp/bridge/services/cfg.c               |   18 +-
 drivers/dsp/bridge/services/clk.c               |    5 +-
 drivers/dsp/bridge/services/dbg.c               |    2 +-
 drivers/dsp/bridge/services/regsup.c            |   14 +-
 drivers/dsp/bridge/wmd/_tiomap.h                |   48 ++--
 drivers/dsp/bridge/wmd/chnl_sm.c                |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c                  |  396 +++++++++++------------
 drivers/dsp/bridge/wmd/mmu_fault.c              |    3 +-
 drivers/dsp/bridge/wmd/msg_sm.c                 |   77 +++---
 drivers/dsp/bridge/wmd/tiomap3430.c             |   23 +-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c         |   24 +-
 drivers/dsp/bridge/wmd/tiomap_sm.c              |   11 +-
 drivers/dsp/bridge/wmd/ue_deh.c                 |   29 +-
 36 files changed, 564 insertions(+), 567 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 33c2135..f22b2cb 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -145,7 +145,7 @@ struct loadMonStruct {
 		struct SYNC_OBJECT *hSyncEvent;
 		/* Name of Sync event */
 		char szEventName[SYNC_MAXNAMELENGTH + 1];
-               u32 hProcess;   /* Process which created this channel */
+		u32 hProcess;   /* Process which created this channel */
 		u32 pCBArg;	/* Argument to use with callback */
 		struct LST_LIST *pIORequests;	/* List of IOR's to driver */
 		s32 cIOCs;	/* Number of IOC's in queue */
diff --git a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
index 86fc468..2eadfa0 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
@@ -83,7 +83,7 @@
 		u32 cPosition;	/* Total bytes transferred.        */
 		u32 cIOCs;	/* Number of IOCs in queue.               */
 		u32 cIOReqs;	/* Number of IO Requests in queue.        */
-               u32 hProcess;   /* Process owning this channel.     */
+		u32 hProcess;   /* Process owning this channel.     */
 		/*
 		 * Name of channel I/O completion event. Not required in Linux
 		 */
diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
index e9cb548..13b1ff6 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
@@ -36,7 +36,7 @@
 
 #define DBC_Assert(exp) \
     if (!(exp)) \
-	printk("%s, line %d: Assertion (" #exp ") failed.\n", \
+	printk(KERN_ERR "%s, line %d: Assertion (" #exp ") failed.\n", \
 	__FILE__, __LINE__)
 #define DBC_Require DBC_Assert	/* Function Precondition.  */
 #define DBC_Ensure  DBC_Assert	/* Function Postcondition. */
diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index bae19e7..1a7d5fa 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -21,9 +21,9 @@
 
 #include <linux/types.h>
 
-#include <dspbridge/dbtype.h>		/* GPP side type definitions           */
-#include <dspbridge/std.h>		/* DSP/BIOS type definitions           */
-#include <dspbridge/rms_sh.h>		/* Types shared between GPP and DSP    */
+#include <dspbridge/dbtype.h>		/* GPP side type definitions */
+#include <dspbridge/std.h>		/* DSP/BIOS type definitions */
+#include <dspbridge/rms_sh.h>		/* Types shared between GPP and DSP */
 
 #define PG_SIZE_4K 4096
 #define PG_MASK(pg_size) (~((pg_size)-1))
@@ -553,7 +553,7 @@ bit 6 - MMU element size = 64bit (valid only for non mixed page entries)
 #define AUTOSTART	"AutoStart"		/* Statically load flag */
 #define CURRENTCONFIG	"CurrentConfig"		/* Current resources */
 #define SHMSIZE		"SHMSize"		/* Size of SHM reservd on MPU */
-#define TCWORDSWAP	"TCWordSwap"		/* Traffic Contoller Word Swap */
+#define TCWORDSWAP	"TCWordSwap"		/* Traffic Controller WordSwp */
 #define DSPRESOURCES	"DspTMSResources"	/* C55 DSP resurces on OMAP */
 
 #endif				/* DBDEFS_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/gt.h b/arch/arm/plat-omap/include/dspbridge/gt.h
index b43b1e7..c110234 100644
--- a/arch/arm/plat-omap/include/dspbridge/gt.h
+++ b/arch/arm/plat-omap/include/dspbridge/gt.h
@@ -232,7 +232,7 @@ extern struct GT_Config _GT_params;
 
 #define GT_assert(mask, expr) \
 	(!(expr) ? \
-	    printk("assertion violation: %s, line %d\n", \
+	    printk(KERN_ERR "assertion violation: %s, line %d\n", \
 			    __FILE__, __LINE__), NULL : NULL)
 
 #define GT_config(config)     (_GT_params = *(config))
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index b8f4fb7..77f9e25 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -291,13 +291,13 @@
 
 	extern void IO_IntrDSP2(IN struct IO_MGR *pIOMgr, IN u16 wMbVal);
 
-       extern void IO_SM_init(void);
+	extern void IO_SM_init(void);
 
 /*
  *  ========PrintDspTraceBuffer ========
  *      Print DSP tracebuffer.
  */
-       extern DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT
-                                               *hWmdContext);
+	extern DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT
+						*hWmdContext);
 
 #endif				/* IOSM_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index b213b82..397361c 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -54,7 +54,7 @@ union Trapped_Args {
 	} ARGS_MGR_UNREGISTEROBJECT;
 
 	struct {
-		struct DSP_NOTIFICATION  __user*__user *aNotifications;
+		struct DSP_NOTIFICATION  __user *__user *aNotifications;
 		u32 uCount;
 		u32 __user *puIndex;
 		u32 uTimeout;
@@ -111,7 +111,7 @@ union Trapped_Args {
 	struct {
 		DSP_HPROCESSOR hProcessor;
 		s32 iArgc;
-		char __user*__user *aArgv;
+		char __user *__user *aArgv;
 		char *__user *aEnvp;
 	} ARGS_PROC_LOAD;
 
diff --git a/drivers/dsp/bridge/dynload/reloc.c b/drivers/dsp/bridge/dynload/reloc.c
index d4457c5..b9e2a9b 100644
--- a/drivers/dsp/bridge/dynload/reloc.c
+++ b/drivers/dsp/bridge/dynload/reloc.c
@@ -195,20 +195,22 @@ void dload_relocate(struct dload_state *dlthis, TgtAU_t *data,
 		rx = HASH_L(rop_map2[rx]);
 		if (rx < 0) {
 #if TMS32060
-		switch (rp->r_type) {
-		case R_C60ALIGN:
-		case R_C60NOCMP:
-		case R_C60FPHEAD:
-		    /* Ignore these reloc types and return */
-		    break;
-		default:
-		    /* Unknown reloc type, print error and return */
-		    dload_error(dlthis, "Bad coff operator 0x%x", rp->r_type);
-	    }
+			switch (rp->r_type) {
+			case R_C60ALIGN:
+			case R_C60NOCMP:
+			case R_C60FPHEAD:
+				/* Ignore these reloc types and return */
+				break;
+			default:
+				/* Unknown reloc type, print error and return */
+				dload_error(dlthis, "Bad coff operator 0x%x",
+						rp->r_type);
+			}
 #else
-	    dload_error(dlthis, "Bad coff operator 0x%x", rp->r_type);
+			dload_error(dlthis, "Bad coff operator 0x%x",
+					rp->r_type);
 #endif
-	    return;
+			return;
 		}
 	}
 	rx = HASH_I(rop_map2[rx]);
@@ -216,7 +218,8 @@ void dload_relocate(struct dload_state *dlthis, TgtAU_t *data,
 	   && (rx < (sizeof(rop_info)/sizeof(uint_least16_t))) && (rx > 0)) {
 		reloc_action = rop_action[rx]; reloc_info = rop_info[rx];
 	} else {
-	    dload_error(dlthis, "Buffer Overflow - Array Index Out of Bounds");
+		dload_error(dlthis, "Buffer Overflow - Array Index Out "
+				"of Bounds");
 	}
 
 	/* Compute the relocation amount for the referenced symbol, if any */
diff --git a/drivers/dsp/bridge/gen/_gt_para.c b/drivers/dsp/bridge/gen/_gt_para.c
index 9f8246b..dd22f77 100644
--- a/drivers/dsp/bridge/gen/_gt_para.c
+++ b/drivers/dsp/bridge/gen/_gt_para.c
@@ -77,7 +77,7 @@ static void error(char *fmt, ...)
 
 	va_end(va);
 
-	printk("ERROR: ");
+	printk(KERN_ERR "ERROR: ");
 	printk(fmt, arg1, arg2, arg3, arg4, arg5, arg6);
 
 #if defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)
diff --git a/drivers/dsp/bridge/gen/gs.c b/drivers/dsp/bridge/gen/gs.c
index 5a5684c..7d6c278 100644
--- a/drivers/dsp/bridge/gen/gs.c
+++ b/drivers/dsp/bridge/gen/gs.c
@@ -87,7 +87,6 @@ void GS_init(void)
 {
 	static bool curInit;
 
-	if (curInit == false) {
+	if (curInit == false)
 		curInit = MEM_Init(); /* which can't fail currently. */
-	}
 }
diff --git a/drivers/dsp/bridge/hw/GlobalTypes.h b/drivers/dsp/bridge/hw/GlobalTypes.h
index 6f54589..73a2d93 100644
--- a/drivers/dsp/bridge/hw/GlobalTypes.h
+++ b/drivers/dsp/bridge/hw/GlobalTypes.h
@@ -101,7 +101,7 @@
  * DESCRIPTION: Returns a 32 bit value given a 16 bit lower value and a 16
  *		bit upper value
  */
-#define RETURN_32BITS_FROM_16LOWER_AND_16UPPER(lower16Bits,upper16Bits)\
+#define RETURN_32BITS_FROM_16LOWER_AND_16UPPER(lower16Bits, upper16Bits)\
     (((((u32)lower16Bits)  & LOWER_16BIT_MASK)) | \
      (((((u32)upper16Bits) & LOWER_16BIT_MASK) << UPPER_16BIT_SHIFT)))
 
@@ -111,7 +111,7 @@
  * DESCRIPTION:  Returns a 16 bit value given a 8 bit lower value and a 8
  *	       bit upper value
  */
-#define RETURN_16BITS_FROM_8LOWER_AND_8UPPER(lower8Bits,upper8Bits)\
+#define RETURN_16BITS_FROM_8LOWER_AND_8UPPER(lower8Bits, upper8Bits)\
     (((((u32)lower8Bits)  & LOWER_8BIT_MASK)) | \
      (((((u32)upper8Bits) & LOWER_8BIT_MASK) << UPPER_8BIT_OF16_SHIFT)))
 
diff --git a/drivers/dsp/bridge/hw/PRCMRegAcM.h b/drivers/dsp/bridge/hw/PRCMRegAcM.h
index 280a812..4c9d732 100644
--- a/drivers/dsp/bridge/hw/PRCMRegAcM.h
+++ b/drivers/dsp/bridge/hw/PRCMRegAcM.h
@@ -51,7 +51,7 @@
       __raw_readl(((u32)(baseAddress))+CM_ICLKEN_PER_OFFSET))
 
 
-#define CM_FCLKEN_PER_GPT5WriteRegister32(baseAddress,value)\
+#define CM_FCLKEN_PER_GPT5WriteRegister32(baseAddress, value)\
 {\
     const u32 offset = CM_FCLKEN_PER_OFFSET;\
     register u32 data = \
@@ -66,7 +66,7 @@
 }
 
 
-#define CM_FCLKEN_PER_GPT6WriteRegister32(baseAddress,value)\
+#define CM_FCLKEN_PER_GPT6WriteRegister32(baseAddress, value)\
 {\
     const u32 offset = CM_FCLKEN_PER_OFFSET;\
     register u32 data =\
@@ -81,7 +81,7 @@
 }
 
 
-#define CM_ICLKEN_PER_GPT5WriteRegister32(baseAddress,value)\
+#define CM_ICLKEN_PER_GPT5WriteRegister32(baseAddress, value)\
 {\
     const u32 offset = CM_ICLKEN_PER_OFFSET;\
     register u32 data = \
@@ -96,7 +96,7 @@
 }
 
 
-#define CM_ICLKEN_PER_GPT6WriteRegister32(baseAddress,value)\
+#define CM_ICLKEN_PER_GPT6WriteRegister32(baseAddress, value)\
 {\
     const u32 offset = CM_ICLKEN_PER_OFFSET;\
     register u32 data = \
@@ -116,7 +116,7 @@
       __raw_readl(((u32)(baseAddress))+CM_FCLKEN1_CORE_OFFSET))
 
 
-#define PRCMCM_FCLKEN1_COREEN_GPT8Write32(baseAddress,value)\
+#define PRCMCM_FCLKEN1_COREEN_GPT8Write32(baseAddress, value)\
 {\
     const u32 offset = PRCM_CM_FCLKEN1_CORE_OFFSET;\
     register u32 data = \
@@ -131,7 +131,7 @@
 }
 
 
-#define PRCMCM_FCLKEN1_COREEN_GPT7Write32(baseAddress,value)\
+#define PRCMCM_FCLKEN1_COREEN_GPT7Write32(baseAddress, value)\
 {\
     const u32 offset = PRCM_CM_FCLKEN1_CORE_OFFSET;\
     register u32 data = \
@@ -360,7 +360,7 @@
       PRCM_CM_CLKSEL1_PLL_APLLs_Clkin_OFFSET))
 
 
-#define CM_FCLKEN_IVA2EN_DSPWrite32(baseAddress,value)\
+#define CM_FCLKEN_IVA2EN_DSPWrite32(baseAddress, value)\
 {\
     const u32 offset = CM_FCLKEN_IVA2_OFFSET;\
     register u32 data = \
@@ -426,7 +426,7 @@
 }
 
 
-#define PRCMCM_CLKSEL_DSPSYNC_DSPWrite32(baseAddress,value)\
+#define PRCMCM_CLKSEL_DSPSYNC_DSPWrite32(baseAddress, value)\
 {\
     const u32 offset = PRCM_CM_CLKSEL_DSP_OFFSET;\
     register u32 data = \
@@ -514,7 +514,7 @@
       __raw_readl(((baseAddress))+PRCM_RM_RSTCTRL_DSP_OFFSET))
 
 
-#define PRM_RSTCTRL_IVA2RST1_DSPWrite32(baseAddress,value)\
+#define PRM_RSTCTRL_IVA2RST1_DSPWrite32(baseAddress, value)\
 {\
     const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;\
     register u32 data =\
@@ -529,7 +529,7 @@
 }
 
 
-#define PRM_RSTCTRL_IVA2RST2_DSPWrite32(baseAddress,value)\
+#define PRM_RSTCTRL_IVA2RST2_DSPWrite32(baseAddress, value)\
 {\
     const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;\
     register u32 data =\
@@ -544,7 +544,7 @@
 }
 
 
-#define PRM_RSTCTRL_IVA2RST3_DSPWrite32(baseAddress,value)\
+#define PRM_RSTCTRL_IVA2RST3_DSPWrite32(baseAddress, value)\
 {\
     const u32 offset = PRM_RSTCTRL_IVA2_OFFSET;\
     register u32 data =\
@@ -564,7 +564,7 @@
       __raw_readl(((baseAddress))+PRCM_RM_RSTST_DSP_OFFSET))
 
 
-#define PRCMRM_RSTST_DSPWriteRegister32(baseAddress,value)\
+#define PRCMRM_RSTST_DSPWriteRegister32(baseAddress, value)\
 {\
     const u32 offset = PRCM_RM_RSTST_DSP_OFFSET;\
     register u32 newValue = ((u32)(value));\
diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/hw_mbox.h
index 9e67ede..a561fb5 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.h
+++ b/drivers/dsp/bridge/hw/hw_mbox.h
@@ -116,11 +116,8 @@ extern HW_STATUS HW_MBOX_MsgRead(const void __iomem *baseAddress,
 * PURPOSE:      : this function writes a u32 from the sub module message
 *		 box Specified.
 */
-extern HW_STATUS HW_MBOX_MsgWrite(
-		      const void __iomem *baseAddress,
-		      const HW_MBOX_Id_t   mailBoxId,
-		      const u32	 writeValue
-		  );
+extern HW_STATUS HW_MBOX_MsgWrite(const void __iomem *baseAddress,
+			const HW_MBOX_Id_t mailBoxId, const u32 writeValue);
 
 /*
 * FUNCTION      : HW_MBOX_NumMsgGet
@@ -150,11 +147,8 @@ extern HW_STATUS HW_MBOX_MsgWrite(
 *
 * PURPOSE:      : this function gets number of messages in a specified mailbox.
 */
-extern HW_STATUS HW_MBOX_NumMsgGet(
-		      const void	 __iomem *baseAddress,
-		      const HW_MBOX_Id_t   mailBoxId,
-		      u32 *const	pNumMsg
-		  );
+extern HW_STATUS HW_MBOX_NumMsgGet(const void __iomem *baseAddress,
+			const HW_MBOX_Id_t mailBoxId, u32 *const pNumMsg);
 
 /*
 * FUNCTION      : HW_MBOX_EventEnable
@@ -186,12 +180,10 @@ extern HW_STATUS HW_MBOX_NumMsgGet(
 *
 * PURPOSE:      : this function enables the specified IRQ.
 */
-extern HW_STATUS HW_MBOX_EventEnable(
-		      const void __iomem *baseAddress,
-		      const HW_MBOX_Id_t       mailBoxId,
-		      const HW_MBOX_UserId_t   userId,
-		      const u32	     events
-		  );
+extern HW_STATUS HW_MBOX_EventEnable(const void __iomem *baseAddress,
+			const HW_MBOX_Id_t mailBoxId,
+			const HW_MBOX_UserId_t userId,
+			const u32 events);
 
 /*
 * FUNCTION      : HW_MBOX_EventDisable
@@ -223,12 +215,10 @@ extern HW_STATUS HW_MBOX_EventEnable(
 *
 * PURPOSE:      : this function disables the specified IRQ.
 */
-extern HW_STATUS HW_MBOX_EventDisable(
-		      const void __iomem *baseAddress,
-		      const HW_MBOX_Id_t       mailBoxId,
-		      const HW_MBOX_UserId_t   userId,
-		      const u32	     events
-		  );
+extern HW_STATUS HW_MBOX_EventDisable(const void __iomem *baseAddress,
+		const HW_MBOX_Id_t mailBoxId,
+		const HW_MBOX_UserId_t userId,
+		const u32 events);
 
 /*
 * FUNCTION      : HW_MBOX_EventAck
@@ -262,12 +252,10 @@ extern HW_STATUS HW_MBOX_EventDisable(
 *
 * PURPOSE:      : this function sets the status of the specified IRQ.
 */
-extern HW_STATUS HW_MBOX_EventAck(
-		      const void	__iomem *baseAddress,
-		      const HW_MBOX_Id_t	mailBoxId,
-		      const HW_MBOX_UserId_t    userId,
-		      const u32	      event
-		  );
+extern HW_STATUS HW_MBOX_EventAck(const void __iomem *baseAddress,
+			const HW_MBOX_Id_t mailBoxId,
+			const HW_MBOX_UserId_t userId,
+			const u32 event);
 
 /*
 * FUNCTION      : HW_MBOX_initSettings
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 556749f..63d1dec 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -1044,11 +1044,10 @@ DSP_STATUS CMM_XlatorDelete(struct CMM_XLATOROBJECT *hXlator, bool bForce)
 
 	DBC_Require(cRefs > 0);
 
-	if (MEM_IsValidHandle(pXlator, CMMXLATESIGNATURE)) {
+	if (MEM_IsValidHandle(pXlator, CMMXLATESIGNATURE))
 		MEM_FreeObject(pXlator);
-	} else {
+	else
 		status = DSP_EHANDLE;
-	}
 
 	return status;
 }
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 0bbee3c..979778d 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -368,7 +368,7 @@ DSP_STATUS COD_GetBaseName(struct COD_MANAGER *hManager, char *pszName,
 	DBC_Require(pszName != NULL);
 
 	if (uSize <= COD_MAXPATHLENGTH)
-               strncpy(pszName, hManager->szZLFile, uSize);
+		strncpy(pszName, hManager->szZLFile, uSize);
 	else
 		status = DSP_EFAIL;
 
@@ -401,7 +401,7 @@ DSP_STATUS COD_GetEntry(struct COD_MANAGER *hManager, u32 *pulEntry)
  *      Get handle to the DBLL loader.
  */
 DSP_STATUS COD_GetLoader(struct COD_MANAGER *hManager,
-			       struct DBLL_TarObj **phLoader)
+				struct DBLL_TarObj **phLoader)
 {
 	DSP_STATUS status = DSP_SOK;
 
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index e1c706c..857a5db 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -648,7 +648,7 @@ DSP_STATUS DBLL_open(struct DBLL_TarObj *target, char *file, DBLL_Flags flags,
 		 " 0x%x\n", target, file, pLib);
 	zlLib = zlTarget->head;
 	while (zlLib != NULL) {
-               if (strcmp(zlLib->fileName, file) == 0) {
+		if (strcmp(zlLib->fileName, file) == 0) {
 			/* Library is already opened */
 			zlLib->openRef++;
 			break;
@@ -670,7 +670,7 @@ DSP_STATUS DBLL_open(struct DBLL_TarObj *target, char *file, DBLL_Flags flags,
 			zlLib->openRef++;
 			zlLib->pTarget = zlTarget;
 			/* Keep a copy of the file name */
-                       zlLib->fileName = MEM_Calloc(strlen(file) + 1,
+			zlLib->fileName = MEM_Calloc(strlen(file) + 1,
 							MEM_PAGED);
 			if (zlLib->fileName == NULL) {
 				GT_0trace(DBLL_debugMask, GT_6CLASS,
@@ -678,8 +678,8 @@ DSP_STATUS DBLL_open(struct DBLL_TarObj *target, char *file, DBLL_Flags flags,
 					 "allocation failed\n");
 				status = DSP_EMEMORY;
 			} else {
-                               strncpy(zlLib->fileName, file,
-                                          strlen(file) + 1);
+				strncpy(zlLib->fileName, file,
+					strlen(file) + 1);
 			}
 			zlLib->symTab = NULL;
 		}
@@ -998,7 +998,7 @@ static bool nameMatch(void *key, void *value)
 	DBC_Require(value != NULL);
 
 	if ((key != NULL) && (value != NULL)) {
-               if (strcmp((char *)key, ((struct Symbol *)value)->name) == 0)
+		if (strcmp((char *)key, ((struct Symbol *)value)->name) == 0)
 			return true;
 	}
 	return false;
@@ -1157,7 +1157,7 @@ static struct dynload_symbol *addToSymbolTable(struct Dynamic_Loader_Sym *this,
 	struct dynload_symbol *retVal;
 
 	DBC_Require(this != NULL);
-       DBC_Require(name);
+	DBC_Require(name);
 	lib = pSymbol->lib;
 	DBC_Require(MEM_IsValidHandle(lib, DBLL_LIBSIGNATURE));
 
@@ -1175,15 +1175,15 @@ static struct dynload_symbol *addToSymbolTable(struct Dynamic_Loader_Sym *this,
 		}
 	}
 	/* Allocate string to copy symbol name */
-       symbol.name = (char *)MEM_Calloc(strlen((char *const)name) + 1,
+	symbol.name = (char *)MEM_Calloc(strlen((char *const)name) + 1,
 							MEM_PAGED);
 	if (symbol.name == NULL)
 		return NULL;
 
 	if (symbol.name != NULL) {
 		/* Just copy name (value will be filled in by dynamic loader) */
-               strncpy(symbol.name, (char *const)name,
-                          strlen((char *const)name) + 1);
+		strncpy(symbol.name, (char *const)name,
+			strlen((char *const)name) + 1);
 
 		/* Add symbol to symbol table */
 		symPtr = (struct Symbol *)GH_insert(lib->symTab, (void *)name,
@@ -1301,8 +1301,8 @@ static int rmmAlloc(struct Dynamic_Loader_Allocate *this,
 
 	/* Attempt to extract the segment ID and requirement information from
 	 the name of the section */
-       DBC_Require(info->name);
-       tokenLen = strlen((char *)(info->name)) + 1;
+	DBC_Require(info->name);
+	tokenLen = strlen((char *)(info->name)) + 1;
 
 	szSectName = MEM_Calloc(tokenLen, MEM_PAGED);
 	szLastToken = MEM_Calloc(tokenLen, MEM_PAGED);
@@ -1313,11 +1313,11 @@ static int rmmAlloc(struct Dynamic_Loader_Allocate *this,
 		status = DSP_EMEMORY;
 		goto func_cont;
 	}
-       strncpy(szSectName, (char *)(info->name), tokenLen);
+	strncpy(szSectName, (char *)(info->name), tokenLen);
 	pszCur = szSectName;
 	while ((pToken = strsep(&pszCur, ":")) && *pToken != '\0') {
-               strncpy(szSecLastToken, szLastToken, strlen(szLastToken) + 1);
-               strncpy(szLastToken, pToken, strlen(pToken) + 1);
+		strncpy(szSecLastToken, szLastToken, strlen(szLastToken) + 1);
+		strncpy(szLastToken, pToken, strlen(pToken) + 1);
 		pToken = strsep(&pszCur, ":");
 		count++; 	/* optimizes processing*/
 	}
@@ -1326,13 +1326,13 @@ static int rmmAlloc(struct Dynamic_Loader_Allocate *this,
 	 within the section name - only process if there are at least three
 	 tokens within the section name (just a minor optimization)*/
 	if (count >= 3)
-               strict_strtol(szLastToken, 10, (long *)&req);
+		strict_strtol(szLastToken, 10, (long *)&req);
 
 	if ((req == 0) || (req == 1)) {
-               if (strcmp(szSecLastToken, "DYN_DARAM") == 0) {
+		if (strcmp(szSecLastToken, "DYN_DARAM") == 0) {
 			segId = 0;
 		} else {
-                       if (strcmp(szSecLastToken, "DYN_SARAM") == 0) {
+			if (strcmp(szSecLastToken, "DYN_SARAM") == 0) {
 				segId = 1;
 			} else {
 				if (strcmp(szSecLastToken,
@@ -1393,7 +1393,7 @@ func_cont:
  *  ======== rmmDealloc ========
  */
 static void rmmDealloc(struct Dynamic_Loader_Allocate *this,
-		       struct LDR_SECTION_INFO *info)
+			struct LDR_SECTION_INFO *info)
 {
 	struct DBLLAlloc *pAlloc = (struct DBLLAlloc *)this;
 	struct DBLL_LibraryObj *lib;
@@ -1471,13 +1471,14 @@ static int writeMem(struct Dynamic_Loader_Initialize *this, void *buf,
 
 	DBC_Require(this != NULL);
 	lib = pInit->lib;
-	DBC_Require(MEM_IsValidHandle(lib, DBLL_LIBSIGNATURE));
+	if (!MEM_IsValidHandle(lib, DBLL_LIBSIGNATURE))
+		return false;
+
+	pTarget = lib->pTarget;
 
 	memType = (DLOAD_SECTION_TYPE(info->type) == DLOAD_TEXT) ? DBLL_CODE :
 		  DBLL_DATA;
-	if ((lib != NULL) &&
-	    ((pTarget = lib->pTarget) != NULL) &&
-	    (pTarget->attrs.write != NULL)) {
+	if (lib && pTarget && pTarget->attrs.write) {
 		retVal = (*pTarget->attrs.write)(pTarget->attrs.wHandle,
 						 addr, buf, nBytes, memType);
 
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index a9cce95..5c5e056 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -441,7 +441,7 @@ DSP_STATUS DEV_DestroyDevice(struct DEV_OBJECT *hDevObject)
 
 		/* Call the driver's WMD_DEV_Destroy() function: */
 		/* Require of DevDestroy */
-		if(pDevObject->hWmdContext) {
+		if (pDevObject->hWmdContext) {
 			status = (*pDevObject->intfFxns.pfnDevDestroy)
 				(pDevObject->hWmdContext);
 			pDevObject->hWmdContext = NULL;
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 3b4286b..6ea15b4 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -766,8 +766,8 @@ static DSP_STATUS FillStreamDef(RMS_WORD *pdwBuf, u32 *ptotal, u32 offset,
 		 *  1 from total.
 		 */
 		total += sizeof(struct RMS_StrmDef) / sizeof(RMS_WORD) - 1;
-               DBC_Require(strmDef.szDevice);
-               dwLength = strlen(strmDef.szDevice) + 1;
+		DBC_Require(strmDef.szDevice);
+		dwLength = strlen(strmDef.szDevice) + 1;
 
 		/* Number of RMS_WORDS needed to hold device name */
 		uNameLen = (dwLength + uCharsInRMSWord - 1) / uCharsInRMSWord;
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 7ec1ccc..d455c5b 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -888,7 +888,7 @@ DSP_STATUS DRV_Init(void)
  *      Insert a DevObject into the list of Manager object.
  */
 DSP_STATUS DRV_InsertDevObject(struct DRV_OBJECT *hDRVObject,
-			       struct DEV_OBJECT *hDevObject)
+				struct DEV_OBJECT *hDevObject)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DRV_OBJECT *pDRVObject = (struct DRV_OBJECT *)hDRVObject;
@@ -919,7 +919,7 @@ DSP_STATUS DRV_InsertDevObject(struct DRV_OBJECT *hDRVObject,
  *      objects.
  */
 DSP_STATUS DRV_RemoveDevObject(struct DRV_OBJECT *hDRVObject,
-			       struct DEV_OBJECT *hDevObject)
+				struct DEV_OBJECT *hDevObject)
 {
 	DSP_STATUS status = DSP_EFAIL;
 	struct DRV_OBJECT *pDRVObject = (struct DRV_OBJECT *)hDRVObject;
@@ -1001,7 +1001,7 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
 		*pDevNodeString = 0;
 	}
 
-       if (!(strcmp((char *) dwContext, "TIOMAP1510"))) {
+	if (!(strcmp((char *) dwContext, "TIOMAP1510"))) {
 		GT_0trace(curTrace, GT_1CLASS,
 			  " Allocating resources for UMA \n");
 		status = RequestBridgeResourcesDSP(dwContext, DRV_ASSIGN);
@@ -1034,7 +1034,7 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
 
 	GT_0trace(curTrace, GT_ENTER, "Entering DRV_Release Resources\n");
 
-       if (!(strcmp((char *)((struct DRV_EXT *)dwContext)->szString,
+	if (!(strcmp((char *)((struct DRV_EXT *)dwContext)->szString,
 	   "TIOMAP1510"))) {
 		GT_0trace(curTrace, GT_1CLASS,
 			 " Releasing DSP-Bridge resources \n");
@@ -1149,10 +1149,10 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 				iounmap(pResources->dwDmmuBase);
 			if (pResources->dwPerBase)
 				iounmap(pResources->dwPerBase);
-                       if (pResources->dwPerPmBase)
-                               iounmap((void *)pResources->dwPerPmBase);
-                       if (pResources->dwCorePmBase)
-                               iounmap((void *)pResources->dwCorePmBase);
+			if (pResources->dwPerPmBase)
+				iounmap((void *)pResources->dwPerPmBase);
+			if (pResources->dwCorePmBase)
+				iounmap((void *)pResources->dwCorePmBase);
 			if (pResources->dwSysCtrlBase) {
 				iounmap(pResources->dwSysCtrlBase);
 				/* don't set pResources->dwSysCtrlBase to null
@@ -1284,10 +1284,10 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 							OMAP_DSP_MEM3_SIZE);
 		pResources->dwPerBase = ioremap(OMAP_PER_CM_BASE,
 							OMAP_PER_CM_SIZE);
-               pResources->dwPerPmBase = ioremap(OMAP_PER_PRM_BASE,
-                                                       OMAP_PER_PRM_SIZE);
-               pResources->dwCorePmBase = (u32)ioremap(OMAP_CORE_PRM_BASE,
-                                                       OMAP_CORE_PRM_SIZE);
+		pResources->dwPerPmBase = ioremap(OMAP_PER_PRM_BASE,
+							OMAP_PER_PRM_SIZE);
+		pResources->dwCorePmBase = (u32)ioremap(OMAP_CORE_PRM_BASE,
+							OMAP_CORE_PRM_SIZE);
 		pResources->dwDmmuBase = ioremap(OMAP_DMMU_BASE,
 							OMAP_DMMU_SIZE);
 		pResources->dwWdTimerDspBase = NULL;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 030bf14..09f212e 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -169,7 +169,7 @@ static char *driver_name = DRIVER_NAME;
 static struct GT_Mask driverTrace;
 #endif /* CONFIG_BRIDGE_DEBUG */
 
-static struct file_operations bridge_fops = {
+static const struct file_operations bridge_fops = {
 	.open		= bridge_open,
 	.release	= bridge_release,
 	.unlocked_ioctl	= bridge_ioctl,
@@ -653,7 +653,7 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
  * sysfs
  */
 static ssize_t drv_state_show(struct kobject *kobj, struct kobj_attribute *attr,
-                        char *buf)
+				char *buf)
 {
 	struct WMD_DEV_CONTEXT *dwContext;
 	struct DEV_OBJECT *hDevObject = NULL;
@@ -670,18 +670,18 @@ static ssize_t drv_state_show(struct kobject *kobj, struct kobj_attribute *attr,
 		drv_state = dwContext->dwBrdState;
 	}
 
-        return sprintf(buf, "%d\n", drv_state);
+	return sprintf(buf, "%d\n", drv_state);
 }
 
 static struct kobj_attribute drv_state_attr = __ATTR_RO(drv_state);
 
 static struct attribute *attrs[] = {
-        &drv_state_attr.attr,
-        NULL,
+	&drv_state_attr.attr,
+	NULL,
 };
 
 static struct attribute_group attr_group = {
-        .attrs = attrs,
+	.attrs = attrs,
 };
 
 static void bridge_create_sysfs(void)
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 336a2fd..8f5139c 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -93,15 +93,15 @@
 #define FLAGBIT	 7	/* 7th bit is pref./req. flag */
 #define SEGMASK	 0x3f	/* Bits 0 - 5 */
 
-#define CREATEBIT       0	/* Create segid starts at bit 0 */
-#define DELETEBIT       8	/* Delete segid starts at bit 8 */
+#define CREATEBIT	0	/* Create segid starts at bit 0 */
+#define DELETEBIT	8	/* Delete segid starts at bit 8 */
 #define EXECUTEBIT      16	/* Execute segid starts at bit 16 */
 
 /*
  *  Masks that define memory type.  Must match defines in dynm.cdb.
  */
-#define DYNM_CODE       0x2
-#define DYNM_DATA       0x4
+#define DYNM_CODE	0x2
+#define DYNM_DATA	0x4
 #define DYNM_CODEDATA   (DYNM_CODE | DYNM_DATA)
 #define DYNM_INTERNAL   0x8
 #define DYNM_EXTERNAL   0x10
@@ -151,7 +151,7 @@
 	((uuid1).usData3 == (uuid2).usData3) && \
 	((uuid1).ucData4 == (uuid2).ucData4) && \
 	((uuid1).ucData5 == (uuid2).ucData5) && \
-       (strncmp((void *)(uuid1).ucData6, (void *)(uuid2).ucData6, 6)) == 0)
+	(strncmp((void *)(uuid1).ucData6, (void *)(uuid2).ucData6, 6)) == 0)
 
     /*
      *  ======== MemInfo ========
@@ -1005,9 +1005,9 @@ static DSP_STATUS AddOvlyInfo(void *handle, struct DBLL_SectInfo *sectInfo,
 	/* Find the node it belongs to */
 	for (i = 0; i < hNldr->nOvlyNodes; i++) {
 		pNodeName = hNldr->ovlyTable[i].pNodeName;
-               DBC_Require(pNodeName);
-               if (strncmp(pNodeName, pSectName + 1,
-                               strlen(pNodeName)) == 0) {
+		DBC_Require(pNodeName);
+		if (strncmp(pNodeName, pSectName + 1,
+				strlen(pNodeName)) == 0) {
 				/* Found the node */
 				break;
 		}
@@ -1021,14 +1021,14 @@ static DSP_STATUS AddOvlyInfo(void *handle, struct DBLL_SectInfo *sectInfo,
 
 	if (*pch) {
 		pch++;	/* Skip over the ':' */
-               if (strncmp(pch, PCREATE, strlen(PCREATE)) == 0) {
+		if (strncmp(pch, PCREATE, strlen(PCREATE)) == 0) {
 			status = AddOvlySect(hNldr, &hNldr->ovlyTable[i].
 				pCreateSects, sectInfo, &fExists, addr, nBytes);
 			if (DSP_SUCCEEDED(status) && !fExists)
 				hNldr->ovlyTable[i].nCreateSects++;
 
 		} else
-               if (strncmp(pch, PDELETE, strlen(PDELETE)) == 0) {
+		if (strncmp(pch, PDELETE, strlen(PDELETE)) == 0) {
 			status = AddOvlySect(hNldr, &hNldr->ovlyTable[i].
 					    pDeleteSects, sectInfo, &fExists,
 					    addr, nBytes);
@@ -1036,7 +1036,7 @@ static DSP_STATUS AddOvlyInfo(void *handle, struct DBLL_SectInfo *sectInfo,
 				hNldr->ovlyTable[i].nDeleteSects++;
 
 		} else
-               if (strncmp(pch, PEXECUTE, strlen(PEXECUTE)) == 0) {
+		if (strncmp(pch, PEXECUTE, strlen(PEXECUTE)) == 0) {
 			status = AddOvlySect(hNldr, &hNldr->ovlyTable[i].
 					    pExecuteSects, sectInfo, &fExists,
 					    addr, nBytes);
@@ -1086,14 +1086,14 @@ static DSP_STATUS AddOvlyNode(struct DSP_UUID *pUuid,
 		} else {
 			/* Add node to table */
 			hNldr->ovlyTable[hNldr->nNode].uuid = *pUuid;
-                       DBC_Require(objDef.objData.nodeObj.ndbProps.acName);
-                       uLen = strlen(objDef.objData.nodeObj.ndbProps.acName);
+			DBC_Require(objDef.objData.nodeObj.ndbProps.acName);
+			uLen = strlen(objDef.objData.nodeObj.ndbProps.acName);
 			pNodeName = objDef.objData.nodeObj.ndbProps.acName;
 			pBuf = MEM_Calloc(uLen + 1, MEM_PAGED);
 			if (pBuf == NULL) {
 				status = DSP_EMEMORY;
 			} else {
-                               strncpy(pBuf, pNodeName, uLen);
+				strncpy(pBuf, pNodeName, uLen);
 				hNldr->ovlyTable[hNldr->nNode].pNodeName = pBuf;
 				hNldr->nNode++;
 			}
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index cf9c9a1..0b4e202 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -257,9 +257,9 @@ static void FreeStream(struct NODE_MGR *hNodeMgr, struct STREAM stream);
 static DSP_STATUS GetFxnAddress(struct NODE_OBJECT *hNode, u32 *pulFxnAddr,
 				u32 uPhase);
 static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
-			       struct NODE_OBJECT *hNode,
-			       CONST struct DSP_UUID *pNodeId,
-			       struct DCD_GENERICOBJ *pdcdProps);
+				struct NODE_OBJECT *hNode,
+				CONST struct DSP_UUID *pNodeId,
+				struct DCD_GENERICOBJ *pdcdProps);
 static DSP_STATUS GetProcProps(struct NODE_MGR *hNodeMgr,
 			      struct DEV_OBJECT *hDevObject);
 static DSP_STATUS GetRMSFxns(struct NODE_MGR *hNodeMgr);
@@ -293,14 +293,13 @@ static struct NLDR_FXNS nldrFxns = {
 
 enum NODE_STATE NODE_GetState(HANDLE hNode)
 {
-       struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
-       if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE)) {
-               GT_1trace(NODE_debugMask, GT_5CLASS,
-                "NODE_GetState:hNode 0x%x\n", pNode);
-               return  -1;
-       } else
-               return pNode->nState;
-
+	struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
+	if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE)) {
+		GT_1trace(NODE_debugMask, GT_5CLASS,
+				"NODE_GetState:hNode 0x%x\n", pNode);
+		return  -1;
+	} else
+		return pNode->nState;
 }
 
 /*
@@ -341,7 +340,7 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 #endif
 
 #ifndef RES_CLEANUP_DISABLE
-	HANDLE	     nodeRes;
+	HANDLE nodeRes;
 #endif
 
 	DBC_Require(cRefs > 0);
@@ -516,8 +515,8 @@ func_cont2:
 		if (nodeType != NODE_MESSAGE) {
 			uNumStreams = MaxInputs(pNode) + MaxOutputs(pNode);
 			pNode->streamConnect = MEM_Calloc(uNumStreams *
-					       sizeof(struct DSP_STREAMCONNECT),
-					       MEM_PAGED);
+					sizeof(struct DSP_STREAMCONNECT),
+					MEM_PAGED);
 			if (uNumStreams > 0 && pNode->streamConnect == NULL)
 				status = DSP_EMEMORY;
 
@@ -565,9 +564,9 @@ func_cont2:
 					 hCmmMgr, NULL);
 				if (DSP_FAILED(status)) {
 					GT_1trace(NODE_debugMask, GT_5CLASS,
-					    "NODE_Allocate: Failed"
-					    " to create SM translator: 0x%x\n",
-					    status);
+						"NODE_Allocate: Failed to "
+						"create SM translator: 0x%x\n",
+						status);
 				}
 			}
 		}
@@ -582,7 +581,7 @@ func_cont2:
 				} else {
 					pmsgArgs->uArgLength = pArgs->cbData;
 					memcpy(pmsgArgs->pData, pArgs->cData,
-					      pArgs->cbData);
+						pArgs->cbData);
 				}
 			}
 		}
@@ -720,8 +719,8 @@ func_end:
  *      Allocates buffer for zero copy messaging.
  */
 DBAPI NODE_AllocMsgBuf(struct NODE_OBJECT *hNode, u32 uSize,
-		       OPTIONAL IN OUT struct DSP_BUFFERATTR *pAttr,
-		       OUT u8 **pBuffer)
+			OPTIONAL IN OUT struct DSP_BUFFERATTR *pAttr,
+			OUT u8 **pBuffer)
 {
 	struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
 	DSP_STATUS status = DSP_SOK;
@@ -1130,7 +1129,7 @@ func_cont2:
 		}
 		/* Set up create args */
 		pStream->type = DEVICECONNECT;
-               dwLength = strlen(hDevNode->pstrDevName);
+		dwLength = strlen(hDevNode->pstrDevName);
 		if (pConnParam != NULL) {
 			pstrmDef->szDevice = MEM_Calloc(dwLength + 1 +
 						(u32) pConnParam->cbData,
@@ -1143,12 +1142,12 @@ func_cont2:
 			status = DSP_EMEMORY;
 		} else {
 			/* Copy device name */
-                       strncpy(pstrmDef->szDevice, hDevNode->pstrDevName,
-				   dwLength);
+			strncpy(pstrmDef->szDevice, hDevNode->pstrDevName,
+				dwLength);
 			if (pConnParam != NULL) {
-                               strncat(pstrmDef->szDevice,
-                                       (char *)pConnParam->cData,
-                                       (u32)pConnParam->cbData);
+				strncat(pstrmDef->szDevice,
+					(char *)pConnParam->cData,
+					(u32)pConnParam->cbData);
 			}
 			hDevNode->hDeviceOwner = hNode;
 		}
@@ -2035,16 +2034,15 @@ DSP_STATUS NODE_GetStrmMgr(struct NODE_OBJECT *hNode,
  */
 enum NLDR_LOADTYPE NODE_GetLoadType(struct NODE_OBJECT *hNode)
 {
-
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               GT_1trace(NODE_debugMask, GT_5CLASS,
-                        "NODE_GetLoadType: Failed. hNode:"
-                         " 0x%x\n", hNode);
-               return -1;
-       } else
-               return hNode->dcdProps.objData.nodeObj.usLoadType;
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+		GT_1trace(NODE_debugMask, GT_5CLASS,
+			"NODE_GetLoadType: Failed. hNode:"
+			" 0x%x\n", hNode);
+		return -1;
+	} else
+		return hNode->dcdProps.objData.nodeObj.usLoadType;
 }
 
 /*
@@ -2056,13 +2054,13 @@ u32 NODE_GetTimeout(struct NODE_OBJECT *hNode)
 {
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               GT_1trace(NODE_debugMask, GT_5CLASS,
-                        "NODE_GetTimeout: Failed. hNode:"
-                         " 0x%x\n", hNode);
-               return 0;
-       } else
-               return hNode->uTimeout;
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+		GT_1trace(NODE_debugMask, GT_5CLASS,
+			"NODE_GetTimeout: Failed. hNode:"
+			" 0x%x\n", hNode);
+		return 0;
+	} else
+		return hNode->uTimeout;
 }
 
 /*
@@ -2077,10 +2075,10 @@ enum NODE_TYPE NODE_GetType(struct NODE_OBJECT *hNode)
 	if (hNode == (struct NODE_OBJECT *) DSP_HGPPNODE)
 		nodeType = NODE_GPP;
 	else {
-                if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
-                        nodeType = -1;
-                else
-                        nodeType = hNode->nType;
+		if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
+			nodeType = -1;
+		else
+			nodeType = hNode->nType;
 	}
 	return nodeType;
 }
@@ -2118,9 +2116,9 @@ bool NODE_Init(void)
  */
 void NODE_OnExit(struct NODE_OBJECT *hNode, s32 nStatus)
 {
-	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
 		return;
-	}
+
 	/* Set node state to done */
 	NODE_SetState(hNode, NODE_DONE);
 	hNode->nExitStatus = nStatus;
@@ -2339,8 +2337,8 @@ func_end:
  *      Register to be notified on specific events for this node.
  */
 DSP_STATUS NODE_RegisterNotify(struct NODE_OBJECT *hNode, u32 uEventMask,
-			       u32 uNotifyType,
-			       struct DSP_NOTIFICATION *hNotification)
+				u32 uNotifyType,
+				struct DSP_NOTIFICATION *hNotification)
 {
 	struct WMD_DRV_INTERFACE *pIntfFxns;
 	DSP_STATUS status = DSP_SOK;
@@ -2704,8 +2702,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 		if (hNode->hMsgQueue) {
 			pIntfFxns = hNodeMgr->pIntfFxns;
 			(*pIntfFxns->pfnMsgDeleteQueue) (hNode->hMsgQueue);
-                       hNode->hMsgQueue = NULL;
-
+			hNode->hMsgQueue = NULL;
 		}
 		if (hNode->hSyncDone)
 			(void) SYNC_CloseEvent(hNode->hSyncDone);
@@ -2717,7 +2714,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 				FreeStream(hNodeMgr, stream);
 			}
 			MEM_Free(hNode->inputs);
-                       hNode->inputs = NULL;
+			hNode->inputs = NULL;
 		}
 		if (hNode->outputs) {
 			for (i = 0; i < MaxOutputs(hNode); i++) {
@@ -2725,7 +2722,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 				FreeStream(hNodeMgr, stream);
 			}
 			MEM_Free(hNode->outputs);
-                       hNode->outputs = NULL;
+			hNode->outputs = NULL;
 		}
 		taskArgs = hNode->createArgs.asa.taskArgs;
 		if (taskArgs.strmInDef) {
@@ -2733,7 +2730,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 				if (taskArgs.strmInDef[i].szDevice) {
 					MEM_Free(taskArgs.strmInDef[i].
 						szDevice);
-                                       taskArgs.strmInDef[i].szDevice = NULL;
+					taskArgs.strmInDef[i].szDevice = NULL;
 				}
 			}
 			MEM_Free(taskArgs.strmInDef);
@@ -2744,7 +2741,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 				if (taskArgs.strmOutDef[i].szDevice) {
 					MEM_Free(taskArgs.strmOutDef[i].
 						szDevice);
-                                       taskArgs.strmOutDef[i].szDevice = NULL;
+					taskArgs.strmOutDef[i].szDevice = NULL;
 				}
 			}
 			MEM_Free(taskArgs.strmOutDef);
@@ -2782,52 +2779,52 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 		}
 	}
 	if (nodeType != NODE_MESSAGE) {
-               if (hNode->streamConnect) {
+		if (hNode->streamConnect) {
 			MEM_Free(hNode->streamConnect);
-                       hNode->streamConnect = NULL;
-               }
+			hNode->streamConnect = NULL;
+		}
 	}
-       if (hNode->pstrDevName) {
+	if (hNode->pstrDevName) {
 		MEM_Free(hNode->pstrDevName);
-               hNode->pstrDevName = NULL;
-       }
+		hNode->pstrDevName = NULL;
+	}
 
-       if (hNode->hNtfy) {
+	if (hNode->hNtfy) {
 		NTFY_Delete(hNode->hNtfy);
-               hNode->hNtfy = NULL;
-       }
+		hNode->hNtfy = NULL;
+	}
 
 	/* These were allocated in DCD_GetObjectDef (via NODE_Allocate) */
-       if (hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn) {
+	if (hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn) {
 		MEM_Free(hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn);
-               hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn = NULL;
-       }
+		hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn = NULL;
+	}
 
-       if (hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn) {
+	if (hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn) {
 		MEM_Free(hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn);
-               hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn = NULL;
-       }
+		hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn = NULL;
+	}
 
-       if (hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn) {
+	if (hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn) {
 		MEM_Free(hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn);
-               hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn = NULL;
-       }
+		hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn = NULL;
+	}
 
-       if (hNode->dcdProps.objData.nodeObj.pstrIAlgName) {
+	if (hNode->dcdProps.objData.nodeObj.pstrIAlgName) {
 		MEM_Free(hNode->dcdProps.objData.nodeObj.pstrIAlgName);
-               hNode->dcdProps.objData.nodeObj.pstrIAlgName = NULL;
-       }
+		hNode->dcdProps.objData.nodeObj.pstrIAlgName = NULL;
+	}
 
 	/* Free all SM address translator resources */
-       if (hXlator) {
+	if (hXlator) {
 		(void) CMM_XlatorDelete(hXlator, TRUE);	/* force free */
-               hXlator = NULL;
-       }
+		hXlator = NULL;
+	}
 
-       if (hNode->hNldrNode) {
+	if (hNode->hNldrNode) {
 		hNodeMgr->nldrFxns.pfnFree(hNode->hNldrNode);
-               hNode->hNldrNode = NULL;
-       }
+		hNode->hNldrNode = NULL;
+	}
 	hNode->hNodeMgr = NULL;
 	MEM_FreeObject(hNode);
 	hNode = NULL;
@@ -2903,8 +2900,8 @@ static void DeleteNodeMgr(struct NODE_MGR *hNodeMgr)
  *      Fills stream information.
  */
 static void FillStreamConnect(struct NODE_OBJECT *hNode1,
-			     struct NODE_OBJECT *hNode2,
-			     u32 uStream1, u32 uStream2)
+				struct NODE_OBJECT *hNode2,
+				u32 uStream1, u32 uStream2)
 {
 	u32 uStrmIndex;
 	struct DSP_STREAMCONNECT *pStrm1 = NULL;
@@ -2918,7 +2915,7 @@ static void FillStreamConnect(struct NODE_OBJECT *hNode1,
 
 		if (node1Type != NODE_DEVICE) {
 			uStrmIndex = hNode1->uNumInputs +
-				     hNode1->uNumOutputs - 1;
+					hNode1->uNumOutputs - 1;
 			pStrm1 = &(hNode1->streamConnect[uStrmIndex]);
 			pStrm1->cbStruct = sizeof(struct DSP_STREAMCONNECT);
 			pStrm1->uThisNodeStreamIndex = uStream1;
@@ -2978,7 +2975,7 @@ static void FillStreamDef(struct NODE_OBJECT *hNode,
 	} else {
 		pstrmDef->uNumBufs = DEFAULTNBUFS;
 		pstrmDef->uBufsize = DEFAULTBUFSIZE / hNodeMgr->
-						      uDSPDataMauSize;
+							uDSPDataMauSize;
 		pstrmDef->uSegid = DEFAULTSEGID;
 		pstrmDef->uAlignment = DEFAULTALIGNMENT;
 		pstrmDef->uTimeout = DEFAULTTIMEOUT;
@@ -3035,15 +3032,15 @@ static DSP_STATUS GetFxnAddress(struct NODE_OBJECT *hNode, u32 *pulFxnAddr,
 	switch (uPhase) {
 	case CREATEPHASE:
 		pstrFxnName = hNode->dcdProps.objData.nodeObj.
-			      pstrCreatePhaseFxn;
+				pstrCreatePhaseFxn;
 		break;
 	case EXECUTEPHASE:
 		pstrFxnName = hNode->dcdProps.objData.nodeObj.
-			      pstrExecutePhaseFxn;
+				pstrExecutePhaseFxn;
 		break;
 	case DELETEPHASE:
 		pstrFxnName = hNode->dcdProps.objData.nodeObj.
-			      pstrDeletePhaseFxn;
+				pstrDeletePhaseFxn;
 		break;
 	default:
 		/* Should never get here */
@@ -3091,9 +3088,9 @@ void GetNodeInfo(struct NODE_OBJECT *hNode, struct DSP_NODEINFO *pNodeInfo)
  *      Retrieve node properties.
  */
 static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
-			      struct NODE_OBJECT *hNode,
-			      CONST struct DSP_UUID *pNodeId,
-			      struct DCD_GENERICOBJ *pdcdProps)
+				struct NODE_OBJECT *hNode,
+				CONST struct DSP_UUID *pNodeId,
+				struct DCD_GENERICOBJ *pdcdProps)
 {
 	u32 uLen;
 	struct NODE_MSGARGS *pMsgArgs;
@@ -3132,15 +3129,15 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 #endif
 		} else {
 			/* Copy device name */
-                       DBC_Require(pndbProps->acName);
-                       uLen = strlen(pndbProps->acName);
+			DBC_Require(pndbProps->acName);
+			uLen = strlen(pndbProps->acName);
 			DBC_Assert(uLen < MAXDEVNAMELEN);
 			hNode->pstrDevName = MEM_Calloc(uLen + 1, MEM_PAGED);
 			if (hNode->pstrDevName == NULL) {
 				status = DSP_EMEMORY;
 			} else {
-                               strncpy(hNode->pstrDevName,
-					   pndbProps->acName, uLen);
+				strncpy(hNode->pstrDevName,
+					pndbProps->acName, uLen);
 			}
 		}
 	}
@@ -3154,15 +3151,15 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 			pTaskArgs->uStackSeg = pndbProps->uStackSeg;
 #ifdef DEBUG
 			DBG_Trace(DBG_LEVEL7,
-				 "** (node) Priority: 0x%x\n" "** (node) Stack"
-				 " Size: 0x%x words\n" "** (node) System Stack"
-				 " Size: 0x%x words\n" "** (node) Stack"
-				 " Segment: 0x%x\n\n",
-				  "** (node) profile count : 0x%x \n \n",
-				  pTaskArgs->nPriority, pTaskArgs->uStackSize,
-				  pTaskArgs->uSysStackSize,
-				  pTaskArgs->uStackSeg,
-				  pndbProps->uCountProfiles);
+				"** (node) Priority: 0x%x\n" "** (node) Stack"
+				" Size: 0x%x words\n" "** (node) System Stack"
+				" Size: 0x%x words\n" "** (node) Stack"
+				" Segment: 0x%x\n\n",
+				"** (node) profile count : 0x%x \n \n",
+				pTaskArgs->nPriority, pTaskArgs->uStackSize,
+				pTaskArgs->uSysStackSize,
+				pTaskArgs->uStackSeg,
+				pndbProps->uCountProfiles);
 #endif
 		}
 	}
@@ -3222,7 +3219,7 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 	struct NODE_MGR *hNodeMgr = NULL;
 	struct DEV_OBJECT *hDevObject;
 	DSP_STATUS status = DSP_SOK;
-	struct DCD_NODEPROPS   dcdNodeProps;
+	struct DCD_NODEPROPS dcdNodeProps;
 	struct DSP_PROCESSORSTATE procStatus;
 
 	DBC_Require(cRefs > 0);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index bfffb38..29860a0 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -294,8 +294,8 @@ static DSP_STATUS GetExecFile(struct CFG_DEVNODE *hDevNode,
 		return CFG_GetExecFile(hDevNode, size, execFile);
 	} else if (devType == IVA_UNIT) {
 		if (iva_img) {
-                       len = strlen(iva_img);
-                       strncpy(execFile, iva_img, len + 1);
+			len = strlen(iva_img);
+			strncpy(execFile, iva_img, len + 1);
 			return DSP_SOK;
 		}
 	}
@@ -537,8 +537,8 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
  *      on a DSP processor.
  */
 DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
-               IN u32 uNodeTabSize, OUT u32 *puNumNodes,
-               OUT u32 *puAllocated)
+		IN u32 uNodeTabSize, OUT u32 *puNumNodes,
+		OUT u32 *puAllocated)
 {
 	DSP_STATUS status = DSP_EFAIL;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
@@ -1092,13 +1092,13 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 				DBC_Assert(pProcObject->g_pszLastCoff == NULL);
 				/* Allocate memory for pszLastCoff */
 				pProcObject->g_pszLastCoff = MEM_Calloc(
-                                       (strlen((char *)aArgv[0]) + 1),
+					(strlen((char *)aArgv[0]) + 1),
 					MEM_PAGED);
 				/* If memory allocated, save COFF file name*/
 				if (pProcObject->g_pszLastCoff) {
-                                       strncpy(pProcObject->g_pszLastCoff,
+					strncpy(pProcObject->g_pszLastCoff,
 						(char *)aArgv[0],
-                                       (strlen((char *)aArgv[0]) + 1));
+						(strlen((char *)aArgv[0]) + 1));
 				}
 			}
 		}
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 9667a08..fcdf682 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -113,7 +113,7 @@ DSP_STATUS CFG_GetDevObject(struct CFG_DEVNODE *hDevNode, OUT u32 *pdwValue)
 	if (DSP_SUCCEEDED(status)) {
 
 		/* check the device string and then call the REG_SetValue*/
-               if (!(strcmp((char *)((struct DRV_EXT *)hDevNode)->szString,
+		if (!(strcmp((char *)((struct DRV_EXT *)hDevNode)->szString,
 							"TIOMAP1510"))) {
 			GT_0trace(CFG_debugMask, GT_1CLASS,
 				  "Fetching DSP Device from "
@@ -152,13 +152,13 @@ DSP_STATUS CFG_GetDSPResources(struct CFG_DEVNODE *hDevNode,
 		  "Entered CFG_GetDSPResources, args: "
 		  "\n\thDevNode:  0x%x\n\tpDSPResTable:  0x%x\n",
 		  hDevNode, pDSPResTable);
-	if (!hDevNode) {
+	if (!hDevNode)
 		status = CFG_E_INVALIDHDEVNODE;
-	} else if (!pDSPResTable) {
+	else if (!pDSPResTable)
 		status = CFG_E_INVALIDPOINTER;
-	} else {
-		status = REG_GetValue(DSPRESOURCES, (u8 *)pDSPResTable,						&dwResSize);
-	}
+	else
+		status = REG_GetValue(DSPRESOURCES, (u8 *)pDSPResTable,
+					&dwResSize);
 	if (DSP_SUCCEEDED(status)) {
 		GT_0trace(CFG_debugMask, GT_1CLASS,
 			  "CFG_GetDSPResources SUCCESS\n");
@@ -217,7 +217,7 @@ DSP_STATUS CFG_GetExecFile(struct CFG_DEVNODE *hDevNode, u32 ulBufSize,
 	}
 #endif
 	DBC_Ensure(((status == DSP_SOK) &&
-                 (strlen(pstrExecFile) <= ulBufSize)) || (status != DSP_SOK));
+		(strlen(pstrExecFile) <= ulBufSize)) || (status != DSP_SOK));
 	return status;
 }
 
@@ -348,11 +348,11 @@ DSP_STATUS CFG_SetDevObject(struct CFG_DEVNODE *hDevNode, u32 dwValue)
 	if (DSP_SUCCEEDED(status)) {
 		/* Store the WCD device object in the Registry */
 
-               if (!(strcmp((char *)hDevNode, "TIOMAP1510"))) {
+		if (!(strcmp((char *)hDevNode, "TIOMAP1510"))) {
 			GT_0trace(CFG_debugMask, GT_1CLASS,
 				  "Registering the DSP Device \n");
 			status = REG_SetValue("DEVICE_DSP", (u8 *)&dwValue,
-					      dwBuffSize);
+						dwBuffSize);
 		} else {
 			GT_0trace(CFG_debugMask, GT_6CLASS,
 				  "Failed to Register Device \n");
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index ae317c5..a56f01e 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -220,7 +220,7 @@ DSP_STATUS CLK_Set_32KHz(IN enum SERVICES_ClkId clk_id)
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
 		if (!(clk_set_parent(pClk, pClkParent) == 0x0)) {
-		       GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Set_32KHz: "
+			GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Set_32KHz: "
 				"Failed to set to 32KHz %s, CLK dev id = %s\n",
 				SERVICES_Clks[clk_id].clk_name,
 				SERVICES_Clks[clk_id].dev);
@@ -323,7 +323,8 @@ s32 CLK_Get_UseCnt(IN enum SERVICES_ClkId clk_id)
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 
 	if (pClk) {
-		useCount =  pClk->usecount; /* FIXME: usecount shouldn't be used */
+		/* FIXME: usecount shouldn't be used */
+		useCount = pClk->usecount;
 	} else {
 		GT_2trace(CLK_debugMask, GT_7CLASS,
 			 "CLK_GetRate: failed to get CLK %s, "
diff --git a/drivers/dsp/bridge/services/dbg.c b/drivers/dsp/bridge/services/dbg.c
index bc57fa8..bc5c8cd 100644
--- a/drivers/dsp/bridge/services/dbg.c
+++ b/drivers/dsp/bridge/services/dbg.c
@@ -33,7 +33,7 @@
 static struct GT_Mask DBG_debugMask = { NULL, NULL };	/* GT trace var. */
 #endif
 
-#if (defined(DEBUG) || defined (DDSP_DEBUG_PRODUCT)) && GT_TRACE
+#if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 
 /*
  *  ======== DBG_Init ========
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 5c2421b..4376b36 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -129,7 +129,7 @@ DSP_STATUS regsupGetValue(char *valName, void *pBuf, u32 *dataSize)
 	/*  Need to search through the entries looking for the right one.  */
 	for (i = 0; i < pRegKey->numValueEntries; i++) {
 		/*  See if the name matches.  */
-               if (strncmp(pRegKey->values[i].name, valName,
+		if (strncmp(pRegKey->values[i].name, valName,
 		    BRIDGE_MAX_NAME_SIZE) == 0) {
 
 			/*  We have a match!  Copy out the data.  */
@@ -171,7 +171,7 @@ DSP_STATUS regsupSetValue(char *valName, void *pBuf, u32 dataSize)
 	/*  Need to search through the entries looking for the right one.  */
 	for (i = 0; i < pRegKey->numValueEntries; i++) {
 		/*  See if the name matches.  */
-               if (strncmp(pRegKey->values[i].name, valName,
+		if (strncmp(pRegKey->values[i].name, valName,
 		    BRIDGE_MAX_NAME_SIZE) == 0) {
 			/*  Make sure the new data size is the same.  */
 			if (dataSize != pRegKey->values[i].dataSize) {
@@ -247,16 +247,16 @@ DSP_STATUS regsupEnumValue(IN u32 dwIndex, IN CONST char *pstrKey,
 	/*  Need to search through the entries looking for the right one.  */
 	for (i = 0; i < pRegKey->numValueEntries; i++) {
 		/*  See if the name matches.  */
-               if ((strncmp(pRegKey->values[i].name, pstrKey,
+		if ((strncmp(pRegKey->values[i].name, pstrKey,
 		    dwKeyLen) == 0) && count++ == dwIndex) {
 			/*  We have a match!  Copy out the data.  */
 			memcpy(pstrData, pRegKey->values[i].pData,
 				pRegKey->values[i].dataSize);
 			/*  Get the size for the caller.  */
 			*pdwDataSize = pRegKey->values[i].dataSize;
-                       *pdwValueSize = strlen(&(pRegKey->
+			*pdwValueSize = strlen(&(pRegKey->
 						values[i].name[dwKeyLen]));
-                       strncpy(pstrValue,
+			strncpy(pstrValue,
 				    &(pRegKey->values[i].name[dwKeyLen]),
 				    *pdwValueSize + 1);
 			GT_3trace(REG_debugMask, GT_2CLASS,
@@ -285,7 +285,7 @@ DSP_STATUS regsupDeleteValue(IN CONST char *pstrValue)
 	for (i = 0; ((i < BRIDGE_MAX_NUM_REG_ENTRIES) &&
 	    (i < pRegKey->numValueEntries)); i++) {
 		/*  See if the name matches...  */
-               if (strncmp(pRegKey->values[i].name, pstrValue,
+		if (strncmp(pRegKey->values[i].name, pstrValue,
 		    BRIDGE_MAX_NAME_SIZE) == 0) {
 			/* We have a match!  Delete this key.  To delete a
 			 * key, we free all resources associated with this
@@ -301,7 +301,7 @@ DSP_STATUS regsupDeleteValue(IN CONST char *pstrValue)
 				pRegKey->values[i].pData = NULL;
 			} else {
 				/* move the last one here */
-                               strncpy(pRegKey->values[i].name, pRegKey->
+				strncpy(pRegKey->values[i].name, pRegKey->
 				    values[pRegKey->numValueEntries - 1].name,
 				    BRIDGE_MAX_NAME_SIZE);
 				pRegKey->values[i].dataSize =
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index ac6e115..5c613b4 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -328,28 +328,28 @@ enum INTH_SensitiveEdge_t {
 /* This mini driver's device context: */
 struct WMD_DEV_CONTEXT {
 	struct DEV_OBJECT *hDevObject;	/* Handle to WCD device object. */
-	u32 dwDspBaseAddr;	/* Arm's API to DSP virtual base addr */
+	u32 dwDspBaseAddr; 		/* Arm's API to DSP virt base addr */
 	/*
 	 * DSP External memory prog address as seen virtually by the OS on
 	 * the host side.
 	 */
-	u32 dwDspExtBaseAddr;	/* See the comment above        */
-	u32 dwAPIRegBase;	/* API memory mapped registers  */
-	void __iomem *dwDSPMmuBase;	/* DSP MMU Mapped registers	*/
-	void __iomem *dwMailBoxBase;	/* Mail box mapped registers	*/
-	void __iomem *cmbase;			/* CM mapped registers		*/
-	void __iomem *sysctrlbase;		/* SysCtrl mapped registers		*/
-	void __iomem *prmbase;			/* PRM mapped registers		*/
-	void __iomem *perbase;			/* PER mapped registers		*/
-	u32 dwAPIClkBase;	/* CLK Registers                */
-	u32 dwDSPClkM2Base;	/* DSP Clock Module m2          */
-	u32 dwPublicRhea;	/* Pub Rhea                     */
-	u32 dwIntAddr;	/* MB INTR reg                  */
-	u32 dwTCEndianism;	/* TC Endianism register        */
-	u32 dwTestBase;	/* DSP MMU Mapped registers     */
-	u32 dwSelfLoop;	/* Pointer to the selfloop      */
-	u32 dwDSPStartAdd;	/* API Boot vector              */
-	u32 dwInternalSize;	/* Internal memory size         */
+	u32 dwDspExtBaseAddr;		/* See the comment above */
+	u32 dwAPIRegBase;		/* API mem map'd registers */
+	void __iomem *dwDSPMmuBase;	/* DSP MMU Mapped registers */
+	void __iomem *dwMailBoxBase;	/* Mail box mapped registers */
+	void __iomem *cmbase;		/* CM mapped registers */
+	void __iomem *sysctrlbase;	/* SysCtrl mapped registers */
+	void __iomem *prmbase;		/* PRM mapped registers	*/
+	void __iomem *perbase;		/* PER mapped registers	*/
+	u32 dwAPIClkBase;		/* CLK Registers */
+	u32 dwDSPClkM2Base;		/* DSP Clock Module m2 */
+	u32 dwPublicRhea;		/* Pub Rhea */
+	u32 dwIntAddr;			/* MB INTR reg */
+	u32 dwTCEndianism;		/* TC Endianism register */
+	u32 dwTestBase;			/* DSP MMU Mapped registers */
+	u32 dwSelfLoop;			/* Pointer to the selfloop */
+	u32 dwDSPStartAdd;		/* API Boot vector */
+	u32 dwInternalSize;		/* Internal memory size */
 
 	/*
 	 * Processor specific info is set when prog loaded and read from DCD.
@@ -357,14 +357,14 @@ struct WMD_DEV_CONTEXT {
 	 */
 	/* DMMU TLB entries */
 	struct WMDIOCTL_EXTPROC aTLBEntry[WMDIOCTL_NUMOFMMUTLB];
-	u32 dwBrdState;	/* Last known board state.      */
-	u32 ulIntMask;	/* int mask                     */
-	u16 ioBase;	/* Board I/O base               */
-	u32 numTLBEntries;	/* DSP MMU TLB entry counter    */
-	u32 fixedTLBEntries;	/* Fixed DSPMMU TLB entry count */
+	u32 dwBrdState;			/* Last known board state. */
+	u32 ulIntMask;			/* int mask */
+	u16 ioBase;			/* Board I/O base */
+	u32 numTLBEntries;		/* DSP MMU TLB entry counter */
+	u32 fixedTLBEntries;		/* Fixed DSPMMU TLB entry count */
 
 	/* TC Settings */
-	bool tcWordSwapOn;	/* Traffic Controller Word Swap */
+	bool tcWordSwapOn;		/* Traffic Controller Word Swap */
 	struct PgTableAttrs *pPtAttrs;
 	u32 uDspPerClks;
 } ;
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 61dc84f..a3ea624 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -861,7 +861,7 @@ DSP_STATUS WMD_CHNL_Open(OUT struct CHNL_OBJECT **phChnl,
 			pChnl->uMode = uMode;
 			pChnl->hUserEvent = hSyncEvent;	/* for Linux */
 			pChnl->hSyncEvent = hSyncEvent;
-                       /* get the process handle */
+			/* Get the process handle */
 			pChnl->hProcess = current->tgid;
 			pChnl->pCBArg = 0;
 			pChnl->cBytesMoved = 0;
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 396a10b..af31831 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -201,7 +201,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	 *  size of message buffer in shared memory is configurable in
 	 *  the base image.  */
 	DEV_GetWMDContext(hDevObject, &hWmdContext);
-	if(!hWmdContext) {
+	if (!hWmdContext) {
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
@@ -214,17 +214,15 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	if (DSP_FAILED(status))
 		goto func_cont;
 
-    /*
-     *  Create a Single Threaded Work Queue
-     */
-
-       if (ref_count == 0)
-               bridge_workqueue = create_workqueue("bridge_work-queue");
-
-       if (bridge_workqueue <= 0)
-               DBG_Trace(DBG_LEVEL1, "Workque Create"
-                       " failed 0x%d \n", bridge_workqueue);
+	/*
+	 * Create a Single Threaded Work Queue
+	 */
+	if (ref_count == 0)
+		bridge_workqueue = create_workqueue("bridge_work-queue");
 
+	if (bridge_workqueue <= 0)
+		DBG_Trace(DBG_LEVEL1, "Workque Create failed 0x%d \n",
+						bridge_workqueue);
 
 	/* Allocate IO manager object: */
 	MEM_AllocObject(pIOMgr, struct IO_MGR, IO_MGRSIGNATURE);
@@ -232,12 +230,12 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		status = DSP_EMEMORY;
 		goto func_cont;
 	}
-       /*Intializing Work Element*/
-       if (ref_count == 0) {
-               INIT_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
-               ref_count = 1;
-       } else
-               PREPARE_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
+	/*Intializing Work Element*/
+	if (ref_count == 0) {
+		INIT_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
+		ref_count = 1;
+	} else
+		PREPARE_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
 
 	/* Initialize CHNL_MGR object:    */
 #ifndef DSP_TRACEBUF_DISABLED
@@ -269,18 +267,15 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		if (devType == DSP_UNIT) {
 			HW_MBOX_initSettings(hostRes.dwMboxBase);
 			/* Plug the channel ISR:. */
-                       if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
-                               "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
-                               status = DSP_SOK;
-                       else
-                               status = DSP_EFAIL;
+			if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
+			  "DspBridge\tmailbox", (void *)pIOMgr)) == 0) {
+				status = DSP_SOK;
+				DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
+						pIOMgr);
+			} else
+				status = CHNL_E_ISR;
 		}
-       if (DSP_SUCCEEDED(status))
-               DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
-                               pIOMgr);
-       else
-               status = CHNL_E_ISR;
-       } else
+	} else
 		status = CHNL_E_ISR;
 func_cont:
 	if (DSP_FAILED(status)) {
@@ -307,7 +302,7 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
 	struct WMD_DEV_CONTEXT *hWmdContext;
 	if (MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE)) {
 		/* Unplug IRQ:    */
-               /* Disable interrupts from the board:  */
+		/* Disable interrupts from the board:  */
 		status = DEV_GetWMDContext(hIOMgr->hDevObject, &hWmdContext);
 		if (DSP_SUCCEEDED(status))
 			(void)CHNLSM_DisableInterrupt(hWmdContext);
@@ -601,9 +596,8 @@ func_cont1:
 					 aEProc[ndx].ulGppVa,
 					 aEProc[ndx].ulDspVa *
 					 hIOMgr->uWordSize, pgSize[i]);
-				if (DSP_FAILED(status)) {
+				if (DSP_FAILED(status))
 					goto func_end;
-				}
 			}
 			paCurr += pgSize[i];
 			vaCurr += pgSize[i];
@@ -913,14 +907,13 @@ func_end:
  */
 static void IO_DispatchPM(struct work_struct *work)
 {
-       struct IO_MGR *pIOMgr =
-                               container_of(work, struct IO_MGR, io_workq);
+	struct IO_MGR *pIOMgr = container_of(work, struct IO_MGR, io_workq);
 	DSP_STATUS status;
 	u32 pArg[2];
 
 	DBG_Trace(DBG_LEVEL7, "IO_DispatchPM: Entering IO_DispatchPM : \n");
 
-	/*  Perform Power message processing here  */
+	/* Perform Power message processing here */
 	while (pIOMgr->iQuePowerHead != pIOMgr->iQuePowerTail) {
 		pArg[0] = *(u32 *)&(pIOMgr->dQuePowerMbxVal[pIOMgr->
 			  iQuePowerTail]);
@@ -1044,7 +1037,7 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 				if (hIOMgr->iQuePowerHead >= MAX_PM_REQS)
 					hIOMgr->iQuePowerHead = 0;
 
-                               queue_work(bridge_workqueue, &hIOMgr->io_workq);
+				queue_work(bridge_workqueue, &hIOMgr->io_workq);
 			}
 			if (hIOMgr->wIntrVal == MBX_DEH_RESET) {
 				DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
@@ -1106,7 +1099,7 @@ func_end:
  */
 void IO_Schedule(struct IO_MGR *pIOMgr)
 {
-	if(!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
+	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
 		return;
 	tiomap3430_bump_dsp_opp_level();
 	DPC_Schedule(pIOMgr->hDPC);
@@ -1187,8 +1180,8 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 	pChnl = pChnlMgr->apChannel[chnlId];
 	if ((pChnl != NULL) && CHNL_IsInput(pChnl->uMode)) {
 		if ((pChnl->dwState & ~CHNL_STATEEOS) == CHNL_STATEREADY) {
-                       if (!pChnl->pIORequests)
-                               goto func_end;
+			if (!pChnl->pIORequests)
+				goto func_end;
 			/* Get the I/O request, and attempt a transfer:  */
 			pChirp = (struct CHNL_IRP *)LST_GetHead(pChnl->
 				 pIORequests);
@@ -1229,8 +1222,8 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 						 "chnl = 0x%x\n", pChnl);
 				}
 				/* Tell DSP if no more I/O buffers available: */
-                               if (!pChnl->pIORequests)
-                                       goto func_end;
+				if (!pChnl->pIORequests)
+					goto func_end;
 				if (LST_IsEmpty(pChnl->pIORequests)) {
 					IO_AndValue(pIOMgr->hWmdContext,
 						   struct SHM, sm, hostFreeMask,
@@ -1302,19 +1295,19 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 		addr = (u32)&(((struct MSG_DSPMSG *)pMsgInput)->dwId);
 		msg.dwId = ReadExt32BitDspData(pIOMgr->hWmdContext, addr);
 		pMsgInput += sizeof(struct MSG_DSPMSG);
-               if (!hMsgMgr->queueList)
-                       goto func_end;
+		if (!hMsgMgr->queueList)
+			goto func_end;
 
 		/* Determine which queue to put the message in */
 		hMsgQueue = (struct MSG_QUEUE *)LST_First(hMsgMgr->queueList);
 		DBG_Trace(DBG_LEVEL7, "InputMsg RECVD: dwCmd=0x%x dwArg1=0x%x "
 			 "dwArg2=0x%x dwId=0x%x \n", msg.msg.dwCmd,
 			 msg.msg.dwArg1, msg.msg.dwArg2, msg.dwId);
-		 /*  Interrupt may occur before shared memory and message
+		/*  Interrupt may occur before shared memory and message
 		 *  input locations have been set up. If all nodes were
 		 *  cleaned up, hMsgMgr->uMaxMsgs should be 0.  */
-               if (hMsgQueue && uMsgs > hMsgMgr->uMaxMsgs)
-                       goto func_end;
+		if (hMsgQueue && uMsgs > hMsgMgr->uMaxMsgs)
+			goto func_end;
 
 		while (hMsgQueue != NULL) {
 			if (msg.dwId == hMsgQueue->dwId) {
@@ -1329,11 +1322,11 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 				} else {
 					/* Not an exit acknowledgement, queue
 					 * the message */
-                                       if (!hMsgQueue->msgFreeList)
-                                               goto func_end;
+					if (!hMsgQueue->msgFreeList)
+						goto func_end;
 					pMsg = (struct MSG_FRAME *)LST_GetHead
 						(hMsgQueue->msgFreeList);
-                                       if (hMsgQueue->msgUsedList && pMsg) {
+					if (hMsgQueue->msgUsedList && pMsg) {
 						pMsg->msgData = msg;
 						LST_PutTail(hMsgQueue->
 						      msgUsedList,
@@ -1353,8 +1346,8 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 				break;
 			}
 
-                       if (!hMsgMgr->queueList || !hMsgQueue)
-                               goto func_end;
+			if (!hMsgMgr->queueList || !hMsgQueue)
+				goto func_end;
 			hMsgQueue = (struct MSG_QUEUE *)LST_Next(hMsgMgr->
 				    queueList, (struct LST_ELEM *)hMsgQueue);
 		}
@@ -1451,8 +1444,8 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 		goto func_end;
 
 	pChnl->cIOReqs--;
-       if (pChnl->cIOReqs < 0 || !pChnl->pIORequests)
-               goto func_end;
+	if (pChnl->cIOReqs < 0 || !pChnl->pIORequests)
+		goto func_end;
 
 	/* Record fact that no more I/O buffers available:  */
 	if (LST_IsEmpty(pChnl->pIORequests))
@@ -1516,13 +1509,13 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 		pMsgOutput = pIOMgr->pMsgOutput;
 		/* Copy uMsgs messages into shared memory */
 		for (i = 0; i < uMsgs; i++) {
-                       if (!hMsgMgr->msgUsedList) {
-                               DBG_Trace(DBG_LEVEL3, "msgUsedList is NULL\n");
-                               pMsg = NULL;
-                               goto func_end;
-                       } else
-                               pMsg = (struct MSG_FRAME *)LST_GetHead(
-                                       hMsgMgr->msgUsedList);
+			if (!hMsgMgr->msgUsedList) {
+				DBG_Trace(DBG_LEVEL3, "msgUsedList is NULL\n");
+				pMsg = NULL;
+				goto func_end;
+			} else
+				pMsg = (struct MSG_FRAME *)LST_GetHead(
+					hMsgMgr->msgUsedList);
 			if (pMsg != NULL) {
 				val = (pMsg->msgData).dwId;
 				addr = (u32)&(((struct MSG_DSPMSG *)
@@ -1547,8 +1540,8 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 				WriteExt32BitDspData(pIOMgr->hWmdContext, addr,
 						    val);
 				pMsgOutput += sizeof(struct MSG_DSPMSG);
-                               if (!hMsgMgr->msgFreeList)
-                                       goto func_end;
+				if (!hMsgMgr->msgFreeList)
+					goto func_end;
 				LST_PutTail(hMsgMgr->msgFreeList,
 					   (struct LST_ELEM *) pMsg);
 				SYNC_SetEvent(hMsgMgr->hSyncEvent);
@@ -1572,7 +1565,8 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 			IO_SetValue(pIOMgr->hWmdContext, struct MSG, pCtrl,
 				   postSWI, true);
 			/* Tell the DSP we have written the output. */
-			CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+			CHNLSM_InterruptDSP2(pIOMgr->hWmdContext,
+						MBX_PCPY_CLASS);
 		}
 	}
 func_end:
@@ -1844,7 +1838,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 			 * pointer */
 			hIOMgr->ulGPPReadPointer += ulNewMessageLength;
 			/* Print the trace messages */
-                       GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
+			GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
 		}
 		/* Handle trace buffer wraparound */
 		else if (ulGPPCurPointer < hIOMgr->ulGPPReadPointer) {
@@ -1865,7 +1859,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 			hIOMgr->ulGPPReadPointer = hIOMgr->ulTraceBufferBegin +
 						   ulNewMessageLength;
 			/* Print the trace messages */
-                       GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
+			GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
 		}
 	}
 }
@@ -1893,48 +1887,48 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 #if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 {
-       DSP_STATUS status = DSP_SOK;
-       char *lpTmpBuf;
-       char *lpBufStart;
-       char *lpTmpStart;
-       u32 nCnt;
-       char thisChar;
-
-       /* tmp workspace, 1 KB longer than input buf */
-       lpTmpBuf = MEM_Calloc((nBytes + ulNumWords), MEM_PAGED);
-       if (lpTmpBuf == NULL) {
-               DBG_Trace(DBG_LEVEL7, "PackTrace buffer:OutofMemory \n");
-               status = DSP_EMEMORY;
-       }
-
-       if (DSP_SUCCEEDED(status)) {
-               lpBufStart = lpBuf;
-               lpTmpStart = lpTmpBuf;
-               for (nCnt = nBytes; nCnt > 0; nCnt--) {
-                       thisChar = *lpBuf++;
-                       switch (thisChar) {
-                       case '\0':      /* Skip null bytes */
-                       break;
-                       case '\n':      /* Convert \n to \r\n */
-                       /* NOTE: do not reverse order; Some OS */
-                       /* editors control doesn't understand "\n\r" */
-                       *lpTmpBuf++ = '\r';
-                       *lpTmpBuf++ = '\n';
-                       break;
-                       default:        /* Copy in the actual ascii byte */
-                       *lpTmpBuf++ = thisChar;
-                       break;
-                       }
-               }
-               *lpTmpBuf = '\0';    /* Make sure tmp buf is null terminated */
-               /* Cut output down to input buf size */
-               strncpy(lpBufStart, lpTmpStart, nBytes);
-               /*Make sure output is null terminated */
-               lpBufStart[nBytes - 1] = '\0';
-               MEM_Free(lpTmpStart);
-       }
-
-       return status;
+	DSP_STATUS status = DSP_SOK;
+	char *lpTmpBuf;
+	char *lpBufStart;
+	char *lpTmpStart;
+	u32 nCnt;
+	char thisChar;
+
+	/* tmp workspace, 1 KB longer than input buf */
+	lpTmpBuf = MEM_Calloc((nBytes + ulNumWords), MEM_PAGED);
+	if (lpTmpBuf == NULL) {
+		DBG_Trace(DBG_LEVEL7, "PackTrace buffer:OutofMemory \n");
+		status = DSP_EMEMORY;
+	}
+
+	if (DSP_SUCCEEDED(status)) {
+		lpBufStart = lpBuf;
+		lpTmpStart = lpTmpBuf;
+		for (nCnt = nBytes; nCnt > 0; nCnt--) {
+			thisChar = *lpBuf++;
+			switch (thisChar) {
+			case '\0':      /* Skip null bytes */
+				break;
+			case '\n':      /* Convert \n to \r\n */
+				/* NOTE: do not reverse order; Some OS */
+				/* editors control doesn't understand "\n\r" */
+				*lpTmpBuf++ = '\r';
+				*lpTmpBuf++ = '\n';
+				break;
+			default:	 /* Copy in the actual ascii byte */
+				*lpTmpBuf++ = thisChar;
+				break;
+			}
+		}
+		*lpTmpBuf = '\0';    /* Make sure tmp buf is null terminated */
+		/* Cut output down to input buf size */
+		strncpy(lpBufStart, lpTmpStart, nBytes);
+		/*Make sure output is null terminated */
+		lpBufStart[nBytes - 1] = '\0';
+		MEM_Free(lpTmpStart);
+	}
+
+	return status;
 }
 #endif    /* (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE */
 
@@ -1952,106 +1946,106 @@ static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
  */
 DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 {
-       DSP_STATUS status = DSP_SOK;
+	DSP_STATUS status = DSP_SOK;
 
 #if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
-       struct COD_MANAGER *hCodMgr;
-       u32 ulTraceEnd;
-       u32 ulTraceBegin;
-       u32 ulNumBytes = 0;
-       u32 ulNumWords = 0;
-       u32 ulWordSize = 2;
-       CONST u32 uMaxSize = 512;
-       char *pszBuf;
-       u16 *lpszBuf;
-
-       struct WMD_DEV_CONTEXT *pWmdContext = (struct WMD_DEV_CONTEXT *)
-                                               hWmdContext;
-       struct WMD_DRV_INTERFACE *pIntfFxns;
-       struct DEV_OBJECT *pDevObject = (struct DEV_OBJECT *)
-                                       pWmdContext->hDevObject;
-
-       status = DEV_GetCodMgr(pDevObject, &hCodMgr);
-       if (DSP_FAILED(status))
-               GT_0trace(dsp_trace_mask, GT_2CLASS,
-               "PrintDspTraceBuffer: Failed on DEV_GetCodMgr.\n");
-
-       if (DSP_SUCCEEDED(status)) {
-               /* Look for SYS_PUTCBEG/SYS_PUTCEND: */
-               status = COD_GetSymValue(hCodMgr, COD_TRACEBEG, &ulTraceBegin);
-               GT_1trace(dsp_trace_mask, GT_2CLASS,
-                       "PrintDspTraceBuffer: ulTraceBegin Value 0x%x\n",
-                       ulTraceBegin);
-               if (DSP_FAILED(status))
-                       GT_0trace(dsp_trace_mask, GT_2CLASS,
-                               "PrintDspTraceBuffer: Failed on "
-                               "COD_GetSymValue.\n");
-       }
-       if (DSP_SUCCEEDED(status)) {
-               status = COD_GetSymValue(hCodMgr, COD_TRACEEND, &ulTraceEnd);
-               GT_1trace(dsp_trace_mask, GT_2CLASS,
-                       "PrintDspTraceBuffer: ulTraceEnd Value 0x%x\n",
-                       ulTraceEnd);
-               if (DSP_FAILED(status))
-                       GT_0trace(dsp_trace_mask, GT_2CLASS,
-                               "PrintDspTraceBuffer: Failed on "
-                               "COD_GetSymValue.\n");
-       }
-       if (DSP_SUCCEEDED(status)) {
-               ulNumBytes = (ulTraceEnd - ulTraceBegin) * ulWordSize;
-               /*  If the chip type is 55 then the addresses will be
-               *  byte addresses; convert them to word addresses.  */
-               if (ulNumBytes > uMaxSize)
-                       ulNumBytes = uMaxSize;
-
-               /* make sure the data we request fits evenly */
-               ulNumBytes = (ulNumBytes / ulWordSize) * ulWordSize;
-               GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
-                       "ulNumBytes 0x%x\n", ulNumBytes);
-               ulNumWords = ulNumBytes * ulWordSize;
-               GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
-                       "ulNumWords 0x%x\n", ulNumWords);
-               status = DEV_GetIntfFxns(pDevObject, &pIntfFxns);
-       }
-
-       if (DSP_SUCCEEDED(status)) {
-               pszBuf = MEM_Calloc(uMaxSize, MEM_NONPAGED);
-               lpszBuf = MEM_Calloc(ulNumBytes * 2, MEM_NONPAGED);
-               if (pszBuf != NULL) {
-                       /* Read bytes from the DSP trace buffer... */
-                       status = (*pIntfFxns->pfnBrdRead)(hWmdContext,
-                               (u8 *)pszBuf, (u32)ulTraceBegin,
-                               ulNumBytes, 0);
-                       if (DSP_FAILED(status))
-                               GT_0trace(dsp_trace_mask, GT_2CLASS,
-                                       "PrintDspTraceBuffer: "
-                                       "Failed to Read Trace Buffer.\n");
-
-                       if (DSP_SUCCEEDED(status)) {
-                               /* Pack and do newline conversion */
-                               GT_0trace(dsp_trace_mask, GT_2CLASS,
-                                       "PrintDspTraceBuffer: "
-                                       "before pack and unpack.\n");
-                               PackTraceBuffer(pszBuf, ulNumBytes, ulNumWords);
-                               GT_1trace(dsp_trace_mask, GT_1CLASS,
-                                       "DSP Trace Buffer:\n%s\n", pszBuf);
-                       }
-                       MEM_Free(pszBuf);
-                       MEM_Free(lpszBuf);
-               } else {
-                       GT_0trace(dsp_trace_mask, GT_2CLASS,
-                               "PrintDspTraceBuffer: Failed to "
-                               "allocate trace buffer.\n");
-                       status = DSP_EMEMORY;
-               }
-       }
+	struct COD_MANAGER *hCodMgr;
+	u32 ulTraceEnd;
+	u32 ulTraceBegin;
+	u32 ulNumBytes = 0;
+	u32 ulNumWords = 0;
+	u32 ulWordSize = 2;
+	CONST u32 uMaxSize = 512;
+	char *pszBuf;
+	u16 *lpszBuf;
+
+	struct WMD_DEV_CONTEXT *pWmdContext = (struct WMD_DEV_CONTEXT *)
+						     hWmdContext;
+	struct WMD_DRV_INTERFACE *pIntfFxns;
+	struct DEV_OBJECT *pDevObject = (struct DEV_OBJECT *)
+					    pWmdContext->hDevObject;
+
+	status = DEV_GetCodMgr(pDevObject, &hCodMgr);
+	if (DSP_FAILED(status))
+		GT_0trace(dsp_trace_mask, GT_2CLASS,
+			"PrintDspTraceBuffer: Failed on DEV_GetCodMgr.\n");
+
+	if (DSP_SUCCEEDED(status)) {
+		/* Look for SYS_PUTCBEG/SYS_PUTCEND: */
+		status = COD_GetSymValue(hCodMgr, COD_TRACEBEG, &ulTraceBegin);
+		GT_1trace(dsp_trace_mask, GT_2CLASS,
+			"PrintDspTraceBuffer: ulTraceBegin Value 0x%x\n",
+			ulTraceBegin);
+		if (DSP_FAILED(status))
+			GT_0trace(dsp_trace_mask, GT_2CLASS,
+				"PrintDspTraceBuffer: Failed on "
+				"COD_GetSymValue.\n");
+	}
+	if (DSP_SUCCEEDED(status)) {
+		status = COD_GetSymValue(hCodMgr, COD_TRACEEND, &ulTraceEnd);
+		GT_1trace(dsp_trace_mask, GT_2CLASS,
+			"PrintDspTraceBuffer: ulTraceEnd Value 0x%x\n",
+			ulTraceEnd);
+		 if (DSP_FAILED(status))
+			GT_0trace(dsp_trace_mask, GT_2CLASS,
+				"PrintDspTraceBuffer: Failed on "
+				"COD_GetSymValue.\n");
+	}
+	if (DSP_SUCCEEDED(status)) {
+		ulNumBytes = (ulTraceEnd - ulTraceBegin) * ulWordSize;
+		/*
+		 * If the chip type is 55 then the addresses will be
+		 * byte addresses; convert them to word addresses.
+		 */
+		if (ulNumBytes > uMaxSize)
+			ulNumBytes = uMaxSize;
+
+		/* Make sure the data we request fits evenly */
+		ulNumBytes = (ulNumBytes / ulWordSize) * ulWordSize;
+		GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
+			"ulNumBytes 0x%x\n", ulNumBytes);
+		ulNumWords = ulNumBytes * ulWordSize;
+		GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
+			"ulNumWords 0x%x\n", ulNumWords);
+		status = DEV_GetIntfFxns(pDevObject, &pIntfFxns);
+	}
+
+	if (DSP_SUCCEEDED(status)) {
+		pszBuf = MEM_Calloc(uMaxSize, MEM_NONPAGED);
+		lpszBuf = MEM_Calloc(ulNumBytes * 2, MEM_NONPAGED);
+		if (pszBuf != NULL) {
+			/* Read bytes from the DSP trace buffer... */
+			status = (*pIntfFxns->pfnBrdRead)(hWmdContext,
+				(u8 *)pszBuf, (u32)ulTraceBegin,
+				ulNumBytes, 0);
+			if (DSP_FAILED(status))
+				GT_0trace(dsp_trace_mask, GT_2CLASS,
+					"PrintDspTraceBuffer: "
+					"Failed to Read Trace Buffer.\n");
+
+			if (DSP_SUCCEEDED(status)) {
+				/* Pack and do newline conversion */
+				GT_0trace(dsp_trace_mask, GT_2CLASS,
+					"PrintDspTraceBuffer: "
+					"before pack and unpack.\n");
+				PackTraceBuffer(pszBuf, ulNumBytes, ulNumWords);
+				GT_1trace(dsp_trace_mask, GT_1CLASS,
+					"DSP Trace Buffer:\n%s\n", pszBuf);
+			}
+			MEM_Free(pszBuf);
+			MEM_Free(lpszBuf);
+		} else {
+			  GT_0trace(dsp_trace_mask, GT_2CLASS,
+				"PrintDspTraceBuffer: Failed to "
+				"allocate trace buffer.\n");
+			  status = DSP_EMEMORY;
+		}
+	}
 #endif
-       return status;
+	return status;
 }
 
 void IO_SM_init(void)
 {
-
-       GT_create(&dsp_trace_mask, "DT"); /* DSP Trace Mask */
-
+	GT_create(&dsp_trace_mask, "DT"); /* DSP Trace Mask */
 }
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index b6cbbb3..bb98e56 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -140,7 +140,8 @@ static bool MMU_CheckIfFault(struct WMD_DEV_CONTEXT *pDevContext)
 		DBG_Trace(DBG_LEVEL7, "**Failed to get Host Resources in "
 			 "MMU_CheckIfFault **\n");
 
-	hwStatus = HW_MMU_EventStatus(pDevContext->dwDSPMmuBase, &dmmuEventMask);
+	hwStatus = HW_MMU_EventStatus(pDevContext->dwDSPMmuBase,
+					&dmmuEventMask);
 	if (dmmuEventMask  ==  HW_MMU_TRANSLATION_FAULT) {
 		HW_MMU_FaultAddrRead(pDevContext->dwDSPMmuBase, &faultAddr);
 		DBG_Trace(DBG_LEVEL1, "WMD_DEH_Notify: DSP_MMUFAULT, fault "
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index c29b64e..8e0aa9d 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -65,7 +65,7 @@ DSP_STATUS WMD_MSG_Create(OUT struct MSG_MGR **phMsgMgr,
 		goto func_end;
 	}
 	DEV_GetIOMgr(hDevObject, &hIOMgr);
-	if(!hIOMgr) {
+	if (!hIOMgr) {
 		status = DSP_EPOINTER;
 		goto func_end;
 	}
@@ -166,10 +166,10 @@ DSP_STATUS WMD_MSG_CreateQueue(struct MSG_MGR *hMsgMgr,
 		status = SYNC_OpenEvent(&pMsgQ->hSyncDoneAck, NULL);
 
 	if (DSP_SUCCEEDED(status)) {
-               if (!hMsgMgr->msgFreeList) {
-                       status = DSP_EHANDLE;
-                       goto func_end;
-               }
+		if (!hMsgMgr->msgFreeList) {
+			status = DSP_EHANDLE;
+			goto func_end;
+		}
 		/* Enter critical section */
 		(void)SYNC_EnterCS(hMsgMgr->hSyncCS);
 		/* Initialize message frames and put in appropriate queues */
@@ -241,8 +241,8 @@ void WMD_MSG_DeleteQueue(struct MSG_QUEUE *hMsgQueue)
 	LST_RemoveElem(hMsgMgr->queueList, (struct LST_ELEM *)hMsgQueue);
 	/* Free the message queue object */
 	DeleteMsgQueue(hMsgQueue, hMsgQueue->uMaxMsgs);
-       if (!hMsgMgr->msgFreeList)
-               goto func_cont;
+	if (!hMsgMgr->msgFreeList)
+		goto func_cont;
 	if (LST_IsEmpty(hMsgMgr->msgFreeList))
 		SYNC_ResetEvent(hMsgMgr->hSyncEvent);
 func_cont:
@@ -271,10 +271,10 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 	}
 
 	hMsgMgr = hMsgQueue->hMsgMgr;
-       if (!hMsgQueue->msgUsedList) {
-               status = DSP_EHANDLE;
-               goto func_end;
-       }
+	if (!hMsgQueue->msgUsedList) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 
 	/* Enter critical section */
 	(void)SYNC_EnterCS(hMsgMgr->hSyncCS);
@@ -373,11 +373,10 @@ DSP_STATUS WMD_MSG_Put(struct MSG_QUEUE *hMsgQueue,
 		goto func_end;
 	}
 	hMsgMgr = hMsgQueue->hMsgMgr;
-       if (!hMsgMgr->msgFreeList) {
-               status = DSP_EHANDLE;
-               goto func_end;
-       }
-
+	if (!hMsgMgr->msgFreeList) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 
 	(void) SYNC_EnterCS(hMsgMgr->hSyncCS);
 
@@ -427,10 +426,10 @@ DSP_STATUS WMD_MSG_Put(struct MSG_QUEUE *hMsgQueue,
 			status = DSP_EFAIL;
 		} else {
 			if (DSP_SUCCEEDED(status)) {
-                               if (LST_IsEmpty(hMsgMgr->msgFreeList)) {
-                                       status = DSP_EPOINTER;
-                                       goto func_cont;
-                               }
+				if (LST_IsEmpty(hMsgMgr->msgFreeList)) {
+					status = DSP_EPOINTER;
+					goto func_cont;
+				}
 				/* Get msg from free list */
 				pMsgFrame = (struct MSG_FRAME *)
 					    LST_GetHead(hMsgMgr->msgFreeList);
@@ -545,21 +544,21 @@ static void DeleteMsgMgr(struct MSG_MGR *hMsgMgr)
 		goto func_end;
 
 	if (hMsgMgr->queueList) {
-               if (LST_IsEmpty(hMsgMgr->queueList)) {
-                       LST_Delete(hMsgMgr->queueList);
-                       hMsgMgr->queueList = NULL;
-               }
+		if (LST_IsEmpty(hMsgMgr->queueList)) {
+			LST_Delete(hMsgMgr->queueList);
+			hMsgMgr->queueList = NULL;
+		}
 	}
 
-       if (hMsgMgr->msgFreeList) {
+	if (hMsgMgr->msgFreeList) {
 		FreeMsgList(hMsgMgr->msgFreeList);
-               hMsgMgr->msgFreeList = NULL;
-       }
+		hMsgMgr->msgFreeList = NULL;
+	}
 
-       if (hMsgMgr->msgUsedList) {
+	if (hMsgMgr->msgUsedList) {
 		FreeMsgList(hMsgMgr->msgUsedList);
-               hMsgMgr->msgUsedList = NULL;
-       }
+		hMsgMgr->msgUsedList = NULL;
+	}
 
 	if (hMsgMgr->hSyncEvent)
 		SYNC_CloseEvent(hMsgMgr->hSyncEvent);
@@ -581,11 +580,11 @@ static void DeleteMsgQueue(struct MSG_QUEUE *hMsgQueue, u32 uNumToDSP)
 	struct MSG_FRAME *pMsg;
 	u32 i;
 
-       if (!MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE)
-               || !hMsgQueue->hMsgMgr || !hMsgQueue->hMsgMgr->msgFreeList)
-               goto func_end;
-       hMsgMgr = hMsgQueue->hMsgMgr;
+	if (!MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE)
+	   || !hMsgQueue->hMsgMgr || !hMsgQueue->hMsgMgr->msgFreeList)
+		goto func_end;
 
+	hMsgMgr = hMsgQueue->hMsgMgr;
 
 	/* Pull off uNumToDSP message frames from Msg manager and free */
 	for (i = 0; i < uNumToDSP; i++) {
@@ -602,12 +601,12 @@ static void DeleteMsgQueue(struct MSG_QUEUE *hMsgQueue, u32 uNumToDSP)
 
        if (hMsgQueue->msgFreeList) {
 		FreeMsgList(hMsgQueue->msgFreeList);
-               hMsgQueue->msgFreeList = NULL;
+		hMsgQueue->msgFreeList = NULL;
        }
 
        if (hMsgQueue->msgUsedList) {
 		FreeMsgList(hMsgQueue->msgUsedList);
-               hMsgQueue->msgUsedList = NULL;
+		hMsgQueue->msgUsedList = NULL;
        }
 
 
@@ -636,8 +635,8 @@ static void FreeMsgList(struct LST_LIST *msgList)
 {
 	struct MSG_FRAME *pMsg;
 
-       if (!msgList)
-               goto func_end;
+	if (!msgList)
+		goto func_end;
 
 	while ((pMsg = (struct MSG_FRAME *)LST_GetHead(msgList)) != NULL)
 		MEM_Free(pMsg);
@@ -646,6 +645,6 @@ static void FreeMsgList(struct LST_LIST *msgList)
 
 	LST_Delete(msgList);
 func_end:
-       return;
+	return;
 }
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index c73cea7..cfa8868 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -340,12 +340,14 @@ static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *hDevContext)
 					  HW_PWR_DOMAIN_DSP,
 					  HW_PWR_STATE_ON);
 		/* Set the SW supervised state transition */
-		HW_PWR_CLKCTRL_IVA2RegSet(pDevContext->cmbase, HW_SW_SUP_WAKEUP);
+		HW_PWR_CLKCTRL_IVA2RegSet(pDevContext->cmbase,
+							HW_SW_SUP_WAKEUP);
 		/* Wait until the state has moved to ON */
 		HW_PWR_IVA2StateGet(pDevContext->prmbase, HW_PWR_DOMAIN_DSP,
 				     &pwrState);
 		/* Disable Automatic transition */
-		HW_PWR_CLKCTRL_IVA2RegSet(pDevContext->cmbase, HW_AUTOTRANS_DIS);
+		HW_PWR_CLKCTRL_IVA2RegSet(pDevContext->cmbase,
+							HW_AUTOTRANS_DIS);
 	}
 	DBG_Trace(DBG_LEVEL6, "WMD_BRD_Monitor - Middle ****** \n");
 	GetHWRegs(pDevContext->prmbase, pDevContext->cmbase);
@@ -490,7 +492,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		if (dsp_debug) {
 			/* Set the bootmode to self loop  */
 			DBG_Trace(DBG_LEVEL7,
-					"Set boot mode to self loop for IVA2 Device\n");
+				"Set boot mode to self loop for IVA2 Device\n");
 			HW_DSPSS_BootModeSet(pDevContext->sysctrlbase,
 				HW_DSPSYSC_SELFLOOPBOOT, dwDSPAddr);
 		} else {
@@ -540,8 +542,8 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		}		/* end for */
 
 		/*
-		 * Lock the above TLB entries and get the BIOS and load monitor timer
-		 * information
+		 * Lock the above TLB entries and get the BIOS and load
+		 * monitor timer information
 		 */
 		HW_MMU_NumLockedSet(pDevContext->dwDSPMmuBase, itmpEntryNdx);
 		HW_MMU_VictimNumSet(pDevContext->dwDSPMmuBase, itmpEntryNdx);
@@ -559,10 +561,11 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 
 		/* Enable the BIOS clock  */
 		(void)DEV_GetSymbol(pDevContext->hDevObject,
-					BRIDGEINIT_BIOSGPTIMER, &ulBiosGpTimer);
+				BRIDGEINIT_BIOSGPTIMER, &ulBiosGpTimer);
 		DBG_Trace(DBG_LEVEL7, "BIOS GPTimer : 0x%x\n", ulBiosGpTimer);
 		(void)DEV_GetSymbol(pDevContext->hDevObject,
-				BRIDGEINIT_LOADMON_GPTIMER, &ulLoadMonitorTimer);
+				BRIDGEINIT_LOADMON_GPTIMER,
+				&ulLoadMonitorTimer);
 		DBG_Trace(DBG_LEVEL7, "Load Monitor Timer : 0x%x\n",
 			  ulLoadMonitorTimer);
 
@@ -575,7 +578,8 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			DSPPeripheralClkCtrl(pDevContext, &uClkCmd);
 
 			extClkId = uClkCmd & MBX_PM_CLK_IDMASK;
-			for (tmpIndex = 0; tmpIndex < MBX_PM_MAX_RESOURCES; tmpIndex++) {
+			for (tmpIndex = 0; tmpIndex < MBX_PM_MAX_RESOURCES;
+			     tmpIndex++) {
 				if (extClkId == BPWR_CLKID[tmpIndex]) {
 					clkIdIndex = tmpIndex;
 					break;
@@ -583,7 +587,8 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 			}
 
 			if (clkIdIndex < MBX_PM_MAX_RESOURCES)
-				status = CLK_Set_32KHz(BPWR_Clks[clkIdIndex].funClk);
+				status =
+				    CLK_Set_32KHz(BPWR_Clks[clkIdIndex].funClk);
 			else
 				status = DSP_EFAIL;
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index dc20684..f5eb21c 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -547,14 +547,18 @@ DSP_STATUS DSP_PeripheralClocks_Disable(struct WMD_DEV_CONTEXT *pDevContext,
 			status = CLK_Disable(BPWR_Clks[clkIdx].intClk);
 			if (BPWR_CLKID[clkIdx] == BPWR_MCBSP1) {
 				/* clear MCBSP1_CLKS, on McBSP1 OFF */
-				value = __raw_readl(pDevContext->sysctrlbase + 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase
+								+ 0x274);
 				value &= ~(1 << 2);
-				__raw_writel(value, pDevContext->sysctrlbase + 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase
+								+ 0x274);
 			} else if (BPWR_CLKID[clkIdx] == BPWR_MCBSP2) {
 				/* clear MCBSP2_CLKS, on McBSP2 OFF */
-				value = __raw_readl(pDevContext->sysctrlbase + 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase
+								+ 0x274);
 				value &= ~(1 << 6);
-				__raw_writel(value, pDevContext->sysctrlbase + 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase
+								+ 0x274);
 			}
 			if (DSP_FAILED(status)) {
 				DBG_Trace(DBG_LEVEL7,
@@ -590,14 +594,18 @@ DSP_STATUS DSP_PeripheralClocks_Enable(struct WMD_DEV_CONTEXT *pDevContext,
 			int_clk_status = CLK_Enable(BPWR_Clks[clkIdx].intClk);
 			if (BPWR_CLKID[clkIdx] == BPWR_MCBSP1) {
 				/* set MCBSP1_CLKS, on McBSP1 ON */
-				value = __raw_readl(pDevContext->sysctrlbase + 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase
+								+ 0x274);
 				value |= 1 << 2;
-				__raw_writel(value, pDevContext->sysctrlbase + 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase
+								+ 0x274);
 			} else if (BPWR_CLKID[clkIdx] == BPWR_MCBSP2) {
 				/* set MCBSP2_CLKS, on McBSP2 ON */
-				value = __raw_readl(pDevContext->sysctrlbase + 0x274);
+				value = __raw_readl(pDevContext->sysctrlbase
+								+ 0x274);
 				value |= 1 << 6;
-				__raw_writel(value, pDevContext->sysctrlbase + 0x274);
+				__raw_writel(value, pDevContext->sysctrlbase
+								+ 0x274);
 			}
 			/* Enable the functional clock of the periphearl */
 			fun_clk_status = CLK_Enable(BPWR_Clks[clkIdx].funClk);
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index fb0b661..b74ce68 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -65,9 +65,9 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 			numMbxMsg--;
 			udelay(10);
 
-			HW_MBOX_EventAck(pDevContext->dwMailBoxBase, MBOX_ARM2DSP,
-					 HW_MBOX_U1_DSP1,
-					 HW_MBOX_INT_NEW_MSG);
+			HW_MBOX_EventAck(pDevContext->dwMailBoxBase,
+					MBOX_ARM2DSP, HW_MBOX_U1_DSP1,
+					HW_MBOX_INT_NEW_MSG);
 		}
 		/* Enable the new message events on this IRQ line */
 		HW_MBOX_EventEnable(pDevContext->dwMailBoxBase,
@@ -158,10 +158,11 @@ bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *pDevContext, bool *pfSchedDPC,
 	HW_MBOX_NumMsgGet(pDevContext->dwMailBoxBase, MBOX_DSP2ARM, &numMbxMsg);
 
 	if (numMbxMsg > 0) {
-		HW_MBOX_MsgRead(pDevContext->dwMailBoxBase, MBOX_DSP2ARM, &mbxValue);
+		HW_MBOX_MsgRead(pDevContext->dwMailBoxBase, MBOX_DSP2ARM,
+				&mbxValue);
 
 		HW_MBOX_EventAck(pDevContext->dwMailBoxBase, MBOX_DSP2ARM,
-				 HW_MBOX_U0_ARM, HW_MBOX_INT_NEW_MSG);
+				HW_MBOX_U0_ARM, HW_MBOX_INT_NEW_MSG);
 
 		DBG_Trace(DBG_LEVEL3, "Read %x from Mailbox\n", mbxValue);
 		*pwIntrVal = (u16) mbxValue;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 658cd73..6d6c76b 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -107,11 +107,11 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
 			pDehMgr->errInfo.dwVal2 = 0L;
 			pDehMgr->errInfo.dwVal3 = 0L;
 			/* Install ISR function for DSP MMU fault */
-                       if ((request_irq(INT_DSP_MMU_IRQ, MMU_FaultIsr, 0,
-                                           "DspBridge\tiommu fault", (void *)pDehMgr)) == 0)
-                               status = DSP_SOK;
-                       else
-                               status = DSP_EFAIL;
+			if ((request_irq(INT_DSP_MMU_IRQ, MMU_FaultIsr, 0,
+			   "DspBridge\tiommu fault", (void *)pDehMgr)) == 0)
+				status = DSP_SOK;
+			else
+				status = DSP_EFAIL;
 		}
 	}
 	if (DSP_FAILED(status)) {
@@ -120,8 +120,7 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
 		*phDehMgr = NULL;
 	} else {
 		*phDehMgr = (struct DEH_MGR *)pDehMgr;
-               DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
-                                        pDehMgr);
+		DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n", pDehMgr);
 	}
 	DBG_Trace(DBG_LEVEL1, "Exiting DEH_Create.\n");
 	return status;
@@ -144,7 +143,7 @@ DSP_STATUS WMD_DEH_Destroy(struct DEH_MGR *hDehMgr)
 		if (pDehMgr->hNtfy)
 			(void)NTFY_Delete(pDehMgr->hNtfy);
 		/* Disable DSP MMU fault */
-               free_irq(INT_DSP_MMU_IRQ, pDehMgr);
+		free_irq(INT_DSP_MMU_IRQ, pDehMgr);
 		(void)DPC_Destroy(pDehMgr->hMmuFaultDpc);
 		/* Deallocate the DEH manager object */
 		MEM_FreeObject(pDehMgr);
@@ -249,14 +248,16 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
 				 "PA: 0x%x\n", pDevContext->
 				numTLBEntries, faultAddr, memPhysical);
 			if (DSP_SUCCEEDED(status)) {
-				hwStatus = HW_MMU_TLBAdd(pDevContext->dwDSPMmuBase,
-					memPhysical, faultAddr,
-					HW_PAGE_SIZE_4KB, 1, &mapAttrs,
-					HW_SET, HW_SET);
+				hwStatus =
+					HW_MMU_TLBAdd(pDevContext->dwDSPMmuBase,
+						memPhysical, faultAddr,
+						HW_PAGE_SIZE_4KB, 1, &mapAttrs,
+						HW_SET, HW_SET);
 			}
 			/* send an interrupt to DSP */
-			HW_MBOX_MsgWrite(pDevContext->dwMailBoxBase, MBOX_ARM2DSP,
-					 MBX_DEH_CLASS | MBX_DEH_EMMU);
+			HW_MBOX_MsgWrite(pDevContext->dwMailBoxBase,
+					MBOX_ARM2DSP,
+					MBX_DEH_CLASS | MBX_DEH_EMMU);
 			/* Clear MMU interrupt */
 			HW_MMU_EventAck(pDevContext->dwDSPMmuBase,
 					 HW_MMU_TRANSLATION_FAULT);
-- 
1.6.2.4

