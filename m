From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 05/20] DSPBRIDGE: checkpatch - space required after comma
Date: Mon, 30 Nov 2009 15:54:46 -0600
Message-ID: <1259618101-8972-6-git-send-email-omar.ramirez@ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-3-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-4-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47752 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbZK3Vs7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Nov 2009 16:48:59 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAULn5Cs028736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 15:49:05 -0600
In-Reply-To: <1259618101-8972-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
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

