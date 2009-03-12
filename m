From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 62/86] [ARM] OMAP34XX: Add miscellaneous definitions related to 34xx
Date: Thu, 12 Mar 2009 11:28:12 -0700
Message-ID: <1236882516-29403-63-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756904AbZCLSdF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:33:05 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:33:03 -0700 (PDT)
In-Reply-To: <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jouni Hogander <jouni.hogander@nokia.com>

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h  |    7 +++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h |    9 +++++++++
 arch/arm/mach-omap2/prm.h              |   24 +++++++++++++-----------
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index aaf68a5..844356c 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -208,6 +208,10 @@
 #define OMAP3430ES2_ST_USBTLL_MASK			(1 << 2)
 
 /* CM_AUTOIDLE1_CORE */
+#define OMAP3430ES2_AUTO_MMC3				(1 << 30)
+#define OMAP3430ES2_AUTO_MMC3_SHIFT			30
+#define OMAP3430ES2_AUTO_ICR				(1 << 29)
+#define OMAP3430ES2_AUTO_ICR_SHIFT			29
 #define OMAP3430_AUTO_AES2				(1 << 28)
 #define OMAP3430_AUTO_AES2_SHIFT			28
 #define OMAP3430_AUTO_SHA12				(1 << 27)
@@ -276,6 +280,9 @@
 #define OMAP3430_AUTO_DES1_SHIFT			0
 
 /* CM_AUTOIDLE3_CORE */
+#define	OMAP3430ES2_AUTO_USBHOST			(1 << 0)
+#define	OMAP3430ES2_AUTO_USBHOST_SHIFT			0
+#define	OMAP3430ES2_AUTO_USBTLL				(1 << 2)
 #define OMAP3430ES2_AUTO_USBTLL_SHIFT			2
 #define OMAP3430ES2_AUTO_USBTLL_MASK			(1 << 2)
 
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 5b5ecfe..c6a7940 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -366,6 +366,7 @@
 
 /* PM_WKEN_WKUP specific bits */
 #define OMAP3430_EN_IO					(1 << 8)
+#define OMAP3430_EN_GPIO1				(1 << 3)
 
 /* PM_MPUGRPSEL_WKUP specific bits */
 
@@ -452,6 +453,14 @@
 #define OMAP3430_CMDRA0_MASK				(0xff << 0)
 
 /* PRM_VC_CMD_VAL_0 specific bits */
+#define OMAP3430_VC_CMD_ON_SHIFT			24
+#define OMAP3430_VC_CMD_ON_MASK				(0xFF << 24)
+#define OMAP3430_VC_CMD_ONLP_SHIFT			16
+#define OMAP3430_VC_CMD_ONLP_MASK			(0xFF << 16)
+#define OMAP3430_VC_CMD_RET_SHIFT			8
+#define OMAP3430_VC_CMD_RET_MASK			(0xFF << 8)
+#define OMAP3430_VC_CMD_OFF_SHIFT			0
+#define OMAP3430_VC_CMD_OFF_MASK			(0xFF << 0)
 
 /* PRM_VC_CMD_VAL_1 specific bits */
 
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index e4dc4b1..826d326 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -141,6 +141,19 @@
 #define PM_PWSTCTRL					0x00e0
 #define PM_PWSTST					0x00e4
 
+/* Omap2 specific registers */
+#define OMAP24XX_PM_WKEN2				0x00a4
+#define OMAP24XX_PM_WKST2				0x00b4
+
+#define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
+#define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
+#define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
+#define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
+
+/* Omap3 specific registers */
+#define OMAP3430ES2_PM_WKEN3				0x00f0
+#define OMAP3430ES2_PM_WKST3				0x00b8
+
 #define OMAP3430_PM_MPUGRPSEL				0x00a4
 #define OMAP3430_PM_MPUGRPSEL1				OMAP3430_PM_MPUGRPSEL
 
@@ -153,16 +166,6 @@
 #define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
 
 
-/* Architecture-specific registers */
-
-#define OMAP24XX_PM_WKEN2				0x00a4
-#define OMAP24XX_PM_WKST2				0x00b4
-
-#define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
-#define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
-#define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
-#define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
-
 #ifndef __ASSEMBLER__
 
 /* Power/reset management domain register get/set */
@@ -228,7 +231,6 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 #define OMAP_RSTTIME1_SHIFT				0
 #define OMAP_RSTTIME1_MASK				(0xff << 0)
 
-
 /* PRM_RSTCTRL */
 /* Named RM_RSTCTRL_WKUP on the 24xx */
 /* 2420 calls RST_DPLL3 'RST_DPLL' */
-- 
1.6.1.2

