From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 23/55] ARM: AM33xx: CM: move cm33xx.h header to a public location
Date: Mon, 31 Mar 2014 18:16:02 +0300
Message-ID: <1396278994-12624-24-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54693 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbaCaPSG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:18:06 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This file needs to be accessible from the PRCM core and mach-omap2 board
support code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm33xx.c      |    2 +-
 arch/arm/mach-omap2/cm33xx.h      |   50 +--------------------------
 include/linux/power/omap/cm33xx.h |   68 +++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 50 deletions(-)
 create mode 100644 include/linux/power/omap/cm33xx.h

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index c7be4e4..7a7b2e7 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -24,7 +24,7 @@
 
 #include "clockdomain.h"
 #include "cm.h"
-#include "cm33xx.h"
+#include <linux/power/omap/cm33xx.h>
 #include "prm33xx.h"
 
 #define AM33XX_MODULEMODE_SHIFT			0
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 8f9e479..67f1d49 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -18,6 +18,7 @@
 #define __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 
 #include "cm.h"
+#include <linux/power/omap/cm33xx.h>
 
 /* CM base address */
 #define AM33XX_CM_BASE		0x44e00000
@@ -25,16 +26,6 @@
 #define AM33XX_CM_REGADDR(inst, reg)				\
 	AM33XX_L4_WK_IO_ADDRESS(AM33XX_CM_BASE + (inst) + (reg))
 
-/* CM instances */
-#define AM33XX_CM_PER_MOD		0x0000
-#define AM33XX_CM_WKUP_MOD		0x0400
-#define AM33XX_CM_DPLL_MOD		0x0500
-#define AM33XX_CM_MPU_MOD		0x0600
-#define AM33XX_CM_DEVICE_MOD		0x0700
-#define AM33XX_CM_RTC_MOD		0x0800
-#define AM33XX_CM_GFX_MOD		0x0900
-#define AM33XX_CM_CEFUSE_MOD		0x0A00
-
 /* CM */
 
 /* CM.PER_CM register offsets */
@@ -371,43 +362,4 @@
 #define AM33XX_CM_CEFUSE_CEFUSE_CLKCTRL_OFFSET		0x0020
 #define AM33XX_CM_CEFUSE_CEFUSE_CLKCTRL			AM33XX_CM_REGADDR(AM33XX_CM_CEFUSE_MOD, 0x0020)
 
-
-#ifndef __ASSEMBLER__
-bool am33xx_cm_is_clkdm_in_hwsup(u16 inst, u16 cdoffs);
-void am33xx_cm_clkdm_enable_hwsup(u16 inst, u16 cdoffs);
-void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs);
-void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs);
-void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs);
-
-#ifdef CONFIG_SOC_AM33XX
-extern int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
-extern void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
-extern void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
-extern int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
-#else
-static inline int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-	return 0;
-}
-static inline void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-}
-static inline void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-}
-static inline int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-	return 0;
-}
-#endif
-
-#endif /* ASSEMBLER */
 #endif
diff --git a/include/linux/power/omap/cm33xx.h b/include/linux/power/omap/cm33xx.h
new file mode 100644
index 0000000..2449ba8
--- /dev/null
+++ b/include/linux/power/omap/cm33xx.h
@@ -0,0 +1,68 @@
+/*
+ * AM33XX CM offset macros
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Vaibhav Hiremath <hvaibhav@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_POWER_OMAP_CM33XX_H
+#define __LINUX_POWER_OMAP_CM33XX_H
+
+/* CM instances */
+#define AM33XX_CM_PER_MOD		0x0000
+#define AM33XX_CM_WKUP_MOD		0x0400
+#define AM33XX_CM_DPLL_MOD		0x0500
+#define AM33XX_CM_MPU_MOD		0x0600
+#define AM33XX_CM_DEVICE_MOD		0x0700
+#define AM33XX_CM_RTC_MOD		0x0800
+#define AM33XX_CM_GFX_MOD		0x0900
+#define AM33XX_CM_CEFUSE_MOD		0x0A00
+
+#ifndef __ASSEMBLER__
+bool am33xx_cm_is_clkdm_in_hwsup(u16 inst, u16 cdoffs);
+void am33xx_cm_clkdm_enable_hwsup(u16 inst, u16 cdoffs);
+void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs);
+void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs);
+void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs);
+
+#ifdef CONFIG_SOC_AM33XX
+int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs,
+			       u16 clkctrl_offs);
+void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
+			     u16 clkctrl_offs);
+void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
+			      u16 clkctrl_offs);
+int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs,
+				u16 clkctrl_offs);
+#else
+static inline int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs,
+					u16 clkctrl_offs)
+{
+	return 0;
+}
+static inline void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
+					u16 clkctrl_offs)
+{
+}
+static inline void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
+					u16 clkctrl_offs)
+{
+}
+static inline int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs,
+					u16 clkctrl_offs)
+{
+	return 0;
+}
+#endif
+
+#endif /* ASSEMBLER */
+#endif
-- 
1.7.9.5

