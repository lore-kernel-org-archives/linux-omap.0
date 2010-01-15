From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 05/10] DSPBRIDGE: checkpatch - space required after comma
Date: Fri, 15 Jan 2010 15:28:36 -0600
Message-ID: <1263590921-24357-6-git-send-email-omar.ramirez@ti.com>
References: <1263590921-24357-1-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-2-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-3-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-4-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38517 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758282Ab0AOVS5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 16:18:57 -0500
In-Reply-To: <1263590921-24357-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/hw/GlobalTypes.h |    4 ++--
 drivers/dsp/bridge/hw/PRCMRegAcM.h  |   24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

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
-- 
1.6.2.4

