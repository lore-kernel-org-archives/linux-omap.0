From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 7/9] 34XX: Add miscellaneous definitions related to 34xx
Date: Fri, 16 May 2008 13:58:18 +0300
Message-ID: <1210935498-27678-1-git-send-email-jouni.hogander@nokia.com>
References: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46395 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbYEPK6X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 06:58:23 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GAw6Yq011532
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 13:58:20 +0300
In-Reply-To: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com


Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h  |    7 +++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h |    9 +++++++++
 arch/arm/mach-omap2/prm.h              |   24 +++++++++++++-----------
 include/asm-arm/arch-omap/irqs.h       |    1 +
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 219f5c8..6ec66f4 100644
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
index f816165..27d44e2 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -142,6 +142,19 @@ static __inline__ u32 __attribute__((unused)) prm_rmw_reg_bits(u32 mask,
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
 
@@ -172,16 +185,6 @@ static u32 __attribute__((unused)) prm_clear_mod_reg_bits(u32 bits, s16 module,
 	return prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
 
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
 /* Power/reset management domain register get/set */
 
 static __inline__ void __attribute__((unused)) prm_write_mod_reg(u32 val,
@@ -243,7 +246,6 @@ static __inline__ u32 __attribute__((unused)) prm_read_mod_reg(s16 module,
 #define OMAP_RSTTIME1_SHIFT				0
 #define OMAP_RSTTIME1_MASK				(0xff << 0)
 
-
 /* PRM_RSTCTRL */
 /* Named RM_RSTCTRL_WKUP on the 24xx */
 /* 2420 calls RST_DPLL3 'RST_DPLL' */
diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-omap/irqs.h
index 343e93e..f901e8b 100644
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
@@ -300,6 +300,7 @@
 #define INT_34XX_ST_MCBSP2_IRQ	4
 #define INT_34XX_ST_MCBSP3_IRQ	5
 #define INT_34XX_SYS_NIRQ	7
+#define INT_34XX_PRCM_MPU_IRQ	11
 #define INT_34XX_MCBSP1_IRQ	16
 #define INT_34XX_MCBSP2_IRQ	17
 #define INT_34XX_MCBSP3_IRQ	22
-- 
1.5.5

