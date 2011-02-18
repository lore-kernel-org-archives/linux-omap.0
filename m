From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 2/4] OMAP3630: add missing ABB PRM register definitions
Date: Fri, 18 Feb 2011 03:20:51 -0600
Message-ID: <1298020853-13761-2-git-send-email-mturquette@ti.com>
References: <1298020853-13761-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:39034 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932119Ab1BRJWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 04:22:52 -0500
Received: by mail-yi0-f50.google.com with SMTP id 30so23118yie.9
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 01:22:52 -0800 (PST)
In-Reply-To: <1298020853-13761-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Turquette <mturquette@ti.com>

OMAP3630 supports an Adaptive Body-Bias ldo as well as some MPU interrupts
related to voltage control that are not present on OMAP34XX.  This patch
adds the offsets, register addresses, bitfield shifts and masks to support
this feature.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/prm-regbits-34xx.h |   34 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h     |    4 +++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 64c087a..0309ff6 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -216,6 +216,12 @@
 /* PRM_SYSCONFIG specific bits */
 
 /* PRM_IRQSTATUS_MPU specific bits */
+#define OMAP3630_VC_BYPASS_ACK_ST_SHIFT			28
+#define OMAP3630_VC_BYPASS_ACK_ST_MASK			(1 << 28)
+#define OMAP3630_VC_VP1_ACK_ST_SHIFT			27
+#define OMAP3630_VC_VP1_ACK_ST_MASK			(1 << 27)
+#define OMAP3630_ABB_LDO_TRANXDONE_ST_SHIFT		26
+#define OMAP3630_ABB_LDO_TRANXDONE_ST_MASK		(1 << 26)
 #define OMAP3430ES2_SND_PERIPH_DPLL_ST_SHIFT		25
 #define OMAP3430ES2_SND_PERIPH_DPLL_ST_MASK		(1 << 25)
 #define OMAP3430_VC_TIMEOUTERR_ST_MASK			(1 << 24)
@@ -248,6 +254,12 @@
 #define OMAP3430_FS_USB_WKUP_ST_MASK			(1 << 1)
 
 /* PRM_IRQENABLE_MPU specific bits */
+#define OMAP3630_VC_BYPASS_ACK_EN_SHIFT				28
+#define OMAP3630_VC_BYPASS_ACK_EN_MASK				(1 << 28)
+#define OMAP3630_VC_VP1_ACK_EN_SHIFT				27
+#define OMAP3630_VC_VP1_ACK_EN_MASK				(1 << 27)
+#define OMAP3630_ABB_LDO_TRANXDONE_EN_SHIFT			26
+#define OMAP3630_ABB_LDO_TRANXDONE_EN_MASK			(1 << 26)
 #define OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_SHIFT		25
 #define OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_MASK		(1 << 25)
 #define OMAP3430_VC_TIMEOUTERR_EN_MASK				(1 << 24)
@@ -587,6 +599,28 @@
 
 /* PRM_VP2_STATUS specific bits */
 
+/* PRM_LDO_ABB_SETUP specific bits */
+#define OMAP3630_SR2_IN_TRANSITION_SHIFT		6
+#define OMAP3630_SR2_IN_TRANSITION_MASK			(1 << 6)
+#define OMAP3630_SR2_STATUS_SHIFT			3
+#define OMAP3630_SR2_STATUS_MASK			(3 << 3)
+#define OMAP3630_OPP_CHANGE_SHIFT			2
+#define OMAP3630_OPP_CHANGE_MASK			(1 << 2)
+#define OMAP3630_OPP_SEL_SHIFT				0
+#define OMAP3630_OPP_SEL_MASK				(3 << 0)
+
+/* PRM_LDO_ABB_CTRL specific bits */
+#define OMAP3630_SR2_WTCNT_VALUE_SHIFT			8
+#define OMAP3630_SR2_WTCNT_VALUE_MASK			(0xff << 8)
+#define OMAP3630_SLEEP_RBB_SEL_SHIFT			3
+#define OMAP3630_SLEEP_RBB_SEL_MASK			(1 << 3)
+#define OMAP3630_ACTIVE_FBB_SEL_SHIFT			2
+#define OMAP3630_ACTIVE_FBB_SEL_MASK			(1 << 2)
+#define OMAP3630_ACTIVE_RBB_SEL_SHIFT			1
+#define OMAP3630_ACTIVE_RBB_SEL_MASK			(1 << 1)
+#define OMAP3630_SR2EN_SHIFT				0
+#define OMAP3630_SR2EN_MASK				(1 << 0)
+
 /* RM_RSTST_NEON specific bits */
 
 /* PM_WKDEP_NEON specific bits */
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 49654c8..45b996d 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -167,6 +167,10 @@
 #define OMAP3430_PRM_VP2_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e0)
 #define OMAP3_PRM_VP2_STATUS_OFFSET	0x00e4
 #define OMAP3430_PRM_VP2_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e4)
+#define OMAP3_PRM_LDO_ABB_SETUP_OFFSET	0x00f0
+#define OMAP3630_PRM_LDO_ABB_SETUP	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00f0)
+#define OMAP3_PRM_LDO_ABB_CTRL_OFFSET	0x00f4
+#define OMAP3630_PRM_LDO_ABB_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00f4)
 
 #define OMAP3_PRM_CLKSEL_OFFSET	0x0040
 #define OMAP3430_PRM_CLKSEL		OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0040)
-- 
1.7.1

