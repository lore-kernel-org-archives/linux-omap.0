From: Mike Turquette <mturquette@gmail.com>
Subject: [PATCH 1/3] OMAP: PM: update PRM registers for ABB
Date: Fri, 16 Apr 2010 16:33:21 -0500
Message-ID: <1271453603-21929-2-git-send-email-mturquette@ti.com>
References: <1271453603-21929-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55072 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932503Ab0DPVeE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 17:34:04 -0400
Received: by gyg13 with SMTP id 13so1563039gyg.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 14:34:02 -0700 (PDT)
In-Reply-To: <1271453603-21929-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, Thara Gopinath <thara@ti.com>, Shweta Gulati <shweta.gulati@ti.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Mike Turquette <mturquette@ti.com>

PRCM on OMAP devices using the 45nm process support Adaptive Body Bias
ldo as well as some new MPU interrupts related to voltage control.
These devices currently include OMAP 3630 and 4430.  This patch adds
these bitfields to the appropriate headers.

Also adds register offset for OMAP36XX_CONTROL_VBBLDO_EFUSE_CTRL.
Though currently unused it might be used in the future to enable other
ABB features such as active RBB and sleep RBB based on silicon
characteristics.

OMAP3630_VC_BYPASS_ACK_EN, OMAP3630_VC_VP1_ACK_EN &
OMAP3630_ABB_LDO_TRANXDONE_EN have been added for completeness sake, but
these interrupts do not have to be enabled to poll on their
corresponding status bits.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/prm-regbits-34xx.h    |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/prm.h                 |    6 ++++++
 arch/arm/plat-omap/include/plat/control.h |    4 ++++
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 0066693..58c9765 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -212,6 +212,9 @@
 /* PRM_SYSCONFIG specific bits */
 
 /* PRM_IRQSTATUS_MPU specific bits */
+#define OMAP3630_VC_BYPASS_ACK_ST			(1 << 28)
+#define OMAP3630_VC_VP1_ACK_ST				(1 << 27)
+#define OMAP3630_ABB_LDO_TRANXDONE_ST			(1 << 26)
 #define OMAP3430ES2_SND_PERIPH_DPLL_ST_SHIFT		25
 #define OMAP3430ES2_SND_PERIPH_DPLL_ST			(1 << 25)
 #define OMAP3430_VC_TIMEOUTERR_ST			(1 << 24)
@@ -244,6 +247,9 @@
 #define OMAP3430_FS_USB_WKUP_ST				(1 << 1)
 
 /* PRM_IRQENABLE_MPU specific bits */
+#define OMAP3630_VC_BYPASS_ACK_EN				(1 << 28)
+#define OMAP3630_VC_VP1_ACK_EN					(1 << 27)
+#define OMAP3630_ABB_LDO_TRANXDONE_EN				(1 << 26)
 #define OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_SHIFT		25
 #define OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN			(1 << 25)
 #define OMAP3430_VC_TIMEOUTERR_EN				(1 << 24)
@@ -581,6 +587,22 @@
 
 /* PRM_VP2_STATUS specific bits */
 
+/* PRM_LDO_ABB_SETUP specific bits */
+#define OMAP3630_SR2_IN_TRANSITION			(1 << 6)
+#define OMAP3630_SR2_STATUS_SHIFT			3
+#define OMAP3630_SR2_STATUS_MASK			(3 << 3)
+#define OMAP3630_OPP_CHANGE				(1 << 2)
+#define OMAP3630_OPP_SEL_SHIFT				0
+#define OMAP3630_OPP_SEL_MASK				(3 << 0)
+
+/* PRM_LDO_ABB_CTRL specific bits */
+#define OMAP3630_SR2_WTCNT_VALUE_SHIFT			8
+#define OMAP3630_SR2_WTCNT_VALUE_MASK			(0xff << 8)
+#define OMAP3630_SLEEP_RBB_SEL				(1 << 3)
+#define OMAP3630_ACTIVE_FBB_SEL				(1 << 2)
+#define OMAP3630_ACTIVE_RBB_SEL				(1 << 1)
+#define OMAP3630_SR2EN					(1 << 0)
+
 /* RM_RSTST_NEON specific bits */
 
 /* PM_WKDEP_NEON specific bits */
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 5fba2aa..2a58847 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -160,6 +160,12 @@
 #define OMAP3430_PRM_VP2_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e0)
 #define OMAP3_PRM_VP2_STATUS_OFFSET	0x00e4
 #define OMAP3430_PRM_VP2_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e4)
+#define OMAP3_PRM_LDO_ABB_SETUP_OFFSET	0X00f0
+#define OMAP3630_PRM_LDO_ABB_SETUP	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, \
+								0X00f0)
+#define OMAP3_PRM_LDO_ABB_CTRL_OFFSET	0X00f4
+#define OMAP3630_PRM_LDO_ABB_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, \
+								0X00f4)
 
 #define OMAP3_PRM_CLKSEL_OFFSET	0x0040
 #define OMAP3430_PRM_CLKSEL		OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0040)
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index d540ae8..120d0c1 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -209,6 +209,10 @@
 #define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WKUP + 0x014)
 #define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WKUP + 0x018)
 
+/* 36xx GENERAL_WKUP register offsets */
+#define OMAP36XX_CONTROL_VBBLDO_EFUSE_CTRL (OMAP343X_CONTROL_GENERAL_WKUP + \
+						0X02C)
+
 /* 34xx D2D idle-related pins, handled by PM core */
 #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
 #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
-- 
1.6.3.2

