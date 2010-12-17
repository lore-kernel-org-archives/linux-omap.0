From: jean.pihet@newoldbits.com
Subject: [PATCH 3/7] OMAP3: remove hardcoded values from the ASM sleep code
Date: Fri, 17 Dec 2010 11:08:22 +0100
Message-ID: <1292580506-4421-4-git-send-email-j-pihet@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58496 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab0LQKIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 05:08:44 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so447858wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 02:08:44 -0800 (PST)
In-Reply-To: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Using macros from existing include files for registers addresses.

Tested on N900 and Beagleboard with full RET and OFF modes,
using cpuidle and suspend.

Based on original patch from Vishwa.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/control.h   |    2 ++
 arch/arm/mach-omap2/sleep34xx.S |   29 ++++++++++++++++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index d7911c5..72efefb 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -274,6 +274,8 @@
 #define OMAP343X_SCRATCHPAD_ROM		(OMAP343X_CTRL_BASE + 0x860)
 #define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
 #define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
+#define OMAP343X_SCRATCHPAD_REGADDR(reg)	OMAP2_L4_IO_ADDRESS(\
+						OMAP343X_SCRATCHPAD + reg)
 
 /* AM35XX_CONTROL_IPSS_CLK_CTRL bits */
 #define AM35XX_USBOTG_VBUSP_CLK_SHIFT   0
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 406cd2a..8e9f38f 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -34,20 +34,27 @@
 #include "sdrc.h"
 #include "control.h"
 
-#define SDRC_SCRATCHPAD_SEM_V	0xfa00291c
-
-#define PM_PREPWSTST_CORE_P	0x48306AE8
+/*
+ * Registers access definitions
+ */
+#define SDRC_SCRATCHPAD_SEM_OFFS	0xc
+#define SDRC_SCRATCHPAD_SEM_V	OMAP343X_SCRATCHPAD_REGADDR\
+					(SDRC_SCRATCHPAD_SEM_OFFS)
+#define PM_PREPWSTST_CORE_P	OMAP3430_PRM_BASE + CORE_MOD +\
+					OMAP3430_PM_PREPWSTST
 #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + OMAP2_PM_PWSTCTRL
 #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
 #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
-#define SRAM_BASE_P		0x40200000
-#define CONTROL_STAT		0x480022F0
-#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE\
-					+ OMAP36XX_CONTROL_MEM_RTA_CTRL)
-#define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
-				       * available */
-#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
-						+ SCRATCHPAD_MEM_OFFS)
+#define SRAM_BASE_P		OMAP3_SRAM_PA
+#define CONTROL_STAT		OMAP343X_CTRL_BASE + OMAP343X_CONTROL_STATUS
+#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE +\
+					OMAP36XX_CONTROL_MEM_RTA_CTRL)
+
+/* Move this as correct place is available */
+#define SCRATCHPAD_MEM_OFFS	0x310
+#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE +\
+					OMAP343X_CONTROL_MEM_WKUP +\
+					SCRATCHPAD_MEM_OFFS)
 #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
 #define SDRC_SYSCONFIG_P	(OMAP343X_SDRC_BASE + SDRC_SYSCONFIG)
 #define SDRC_MR_0_P		(OMAP343X_SDRC_BASE + SDRC_MR_0)
-- 
1.7.1

