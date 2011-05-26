From: Nishanth Menon <nm@ti.com>
Subject: [RFC][PATCH 5/9] OMAP4: PRM: OMAP4460 specific PRM and CM register bitshifts
Date: Wed, 25 May 2011 18:56:52 -0700
Message-ID: <1306375016-707-6-git-send-email-nm@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:51697 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757036Ab1EZB5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 21:57:24 -0400
Received: by mail-yx0-f180.google.com with SMTP id 1so157901yxe.11
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 18:57:22 -0700 (PDT)
In-Reply-To: <1306375016-707-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch adds additional register bitshifts for
registers added in OMAP4460 platform.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cm-regbits-44xx.h  |   32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm-regbits-44xx.h |   10 +++++++++-
 2 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-44xx.h b/arch/arm/mach-omap2/cm-regbits-44xx.h
index 9d47a05..4c4cbfa 100644
--- a/arch/arm/mach-omap2/cm-regbits-44xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-44xx.h
@@ -106,6 +106,10 @@
 #define OMAP4430_CLKACTIVITY_CORE_DPLL_EMU_CLK_SHIFT		9
 #define OMAP4430_CLKACTIVITY_CORE_DPLL_EMU_CLK_MASK		(1 << 9)
 
+/* Used by CM_L4CFG_CLKSTCTRL */
+#define OMAP4460_CLKACTIVITY_CORE_TS_GFCLK_SHIFT		9
+#define OMAP4460_CLKACTIVITY_CORE_TS_GFCLK_MASK			(1 << 9)
+
 /* Used by CM_CEFUSE_CLKSTCTRL */
 #define OMAP4430_CLKACTIVITY_CUST_EFUSE_SYS_CLK_SHIFT		9
 #define OMAP4430_CLKACTIVITY_CUST_EFUSE_SYS_CLK_MASK		(1 << 9)
@@ -418,6 +422,10 @@
 #define OMAP4430_CLKACTIVITY_WKUP_32K_GFCLK_SHIFT		11
 #define OMAP4430_CLKACTIVITY_WKUP_32K_GFCLK_MASK		(1 << 11)
 
+/* Used by CM_WKUP_CLKSTCTRL */
+#define OMAP4460_CLKACTIVITY_WKUP_TS_GFCLK_SHIFT		13
+#define OMAP4460_CLKACTIVITY_WKUP_TS_GFCLK_MASK			(1 << 13)
+
 /*
  * Used by CM1_ABE_TIMER5_CLKCTRL, CM1_ABE_TIMER6_CLKCTRL,
  * CM1_ABE_TIMER7_CLKCTRL, CM1_ABE_TIMER8_CLKCTRL, CM_L3INIT_MMC1_CLKCTRL,
@@ -449,6 +457,10 @@
 #define OMAP4430_CLKSEL_60M_SHIFT				24
 #define OMAP4430_CLKSEL_60M_MASK				(1 << 24)
 
+/* Used by CM_MPU_MPU_CLKCTRL */
+#define OMAP4460_CLKSEL_ABE_DIV_MODE_SHIFT			25
+#define OMAP4460_CLKSEL_ABE_DIV_MODE_MASK			(1 << 25)
+
 /* Used by CM1_ABE_AESS_CLKCTRL */
 #define OMAP4430_CLKSEL_AESS_FCLK_SHIFT				24
 #define OMAP4430_CLKSEL_AESS_FCLK_MASK				(1 << 24)
@@ -468,6 +480,10 @@
 #define OMAP4430_CLKSEL_DIV_SHIFT				24
 #define OMAP4430_CLKSEL_DIV_MASK				(1 << 24)
 
+/* Used by CM_MPU_MPU_CLKCTRL */
+#define OMAP4460_CLKSEL_EMIF_DIV_MODE_SHIFT			24
+#define OMAP4460_CLKSEL_EMIF_DIV_MODE_MASK			(1 << 24)
+
 /* Used by CM_CAM_FDIF_CLKCTRL */
 #define OMAP4430_CLKSEL_FCLK_SHIFT				24
 #define OMAP4430_CLKSEL_FCLK_MASK				(0x3 << 24)
@@ -572,6 +588,14 @@
 #define OMAP4430_D2D_STATDEP_SHIFT				18
 #define OMAP4430_D2D_STATDEP_MASK				(1 << 18)
 
+/* Used by CM_CLKSEL_DPLL_MPU */
+#define OMAP4460_DCC_COUNT_MAX_SHIFT				24
+#define OMAP4460_DCC_COUNT_MAX_MASK				(0xff << 24)
+
+/* Used by CM_CLKSEL_DPLL_MPU */
+#define OMAP4460_DCC_EN_SHIFT					22
+#define OMAP4460_DCC_EN_MASK					(1 << 22)
+
 /*
  * Used by CM_SSC_DELTAMSTEP_DPLL_ABE, CM_SSC_DELTAMSTEP_DPLL_CORE,
  * CM_SSC_DELTAMSTEP_DPLL_CORE_RESTORE, CM_SSC_DELTAMSTEP_DPLL_DDRPHY,
@@ -1204,6 +1228,10 @@
 #define OMAP4430_MODULEMODE_SHIFT				0
 #define OMAP4430_MODULEMODE_MASK				(0x3 << 0)
 
+/* Used by CM_L4CFG_DYNAMICDEP */
+#define OMAP4460_MPU_DYNDEP_SHIFT				19
+#define OMAP4460_MPU_DYNDEP_MASK				(1 << 19)
+
 /* Used by CM_DSS_DSS_CLKCTRL */
 #define OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT			9
 #define OMAP4430_OPTFCLKEN_48MHZ_CLK_MASK			(1 << 9)
@@ -1298,6 +1326,10 @@
 #define OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT			10
 #define OMAP4430_OPTFCLKEN_SYS_CLK_MASK				(1 << 10)
 
+/* Used by CM_WKUP_BANDGAP_CLKCTRL */
+#define OMAP4460_OPTFCLKEN_TS_FCLK_SHIFT			8
+#define OMAP4460_OPTFCLKEN_TS_FCLK_MASK				(1 << 8)
+
 /* Used by CM_DSS_DSS_CLKCTRL */
 #define OMAP4430_OPTFCLKEN_TV_CLK_SHIFT				11
 #define OMAP4430_OPTFCLKEN_TV_CLK_MASK				(1 << 11)
diff --git a/arch/arm/mach-omap2/prm-regbits-44xx.h b/arch/arm/mach-omap2/prm-regbits-44xx.h
index 6d2776f..2ae607e 100644
--- a/arch/arm/mach-omap2/prm-regbits-44xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-44xx.h
@@ -1,7 +1,7 @@
 /*
  * OMAP44xx Power Management register bits
  *
- * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2009-2011 Texas Instruments, Inc.
  * Copyright (C) 2009-2010 Nokia Corporation
  *
  * Paul Walmsley (paul@pwsan.com)
@@ -283,6 +283,14 @@
 #define OMAP4430_DUCATI_UNICACHE_STATEST_SHIFT				10
 #define OMAP4430_DUCATI_UNICACHE_STATEST_MASK				(0x3 << 10)
 
+/* Used by PRM_DEVICE_OFF_CTRL */
+#define OMAP4460_EMIF1_OFFWKUP_DISABLE_SHIFT				8
+#define OMAP4460_EMIF1_OFFWKUP_DISABLE_MASK				(1 << 8)
+
+/* Used by PRM_DEVICE_OFF_CTRL */
+#define OMAP4460_EMIF2_OFFWKUP_DISABLE_SHIFT				9
+#define OMAP4460_EMIF2_OFFWKUP_DISABLE_MASK				(1 << 9)
+
 /* Used by RM_MPU_RSTST */
 #define OMAP4430_EMULATION_RST_SHIFT					0
 #define OMAP4430_EMULATION_RST_MASK					(1 << 0)
-- 
1.7.1

