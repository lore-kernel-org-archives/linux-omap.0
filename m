From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 29/55] ARM: OMAP4: CM: rename cminst44xx.h to cm44xx.h and move it to public location
Date: Mon, 31 Mar 2014 18:16:08 +0300
Message-ID: <1396278994-12624-30-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58788 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbaCaPSS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 11:18:18 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

The new name follows the naming convention of the other public CM header
files.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c  |    2 +-
 arch/arm/mach-omap2/cminst44xx.h  |   29 -----------------------------
 arch/arm/mach-omap2/io.c          |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c  |    2 +-
 include/linux/power/omap/cm44xx.h |   30 ++++++++++++++++++++++++++++++
 5 files changed, 33 insertions(+), 32 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/cminst44xx.h
 create mode 100644 include/linux/power/omap/cm44xx.h

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 20681de..2f780df 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -25,7 +25,7 @@
 #include "cm.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
-#include "cminst44xx.h"
+#include <linux/power/omap/cm44xx.h>
 #include "prcm44xx.h"
 #include "prm44xx.h"
 #include "prcm_mpu44xx.h"
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
deleted file mode 100644
index ad06525..0000000
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * OMAP4 Clock Management (CM) function prototypes
- *
- * Copyright (C) 2010 Nokia Corporation
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
-#define __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
-
-bool omap4_cminst_is_clkdm_in_hwsup(u8 part, u16 inst, u16 cdoffs);
-void omap4_cminst_clkdm_enable_hwsup(u8 part, u16 inst, u16 cdoffs);
-void omap4_cminst_clkdm_disable_hwsup(u8 part, u16 inst, u16 cdoffs);
-void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs);
-void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs);
-extern int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
-extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
-					 u16 clkctrl_offs);
-extern void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
-				       u16 clkctrl_offs);
-extern void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
-
-extern void omap_cm_base_init(void);
-
-#endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index dfba898..6212c10 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -49,7 +49,7 @@
 #include "cm.h"
 #include "prcm_mpu44xx.h"
 #include "prminst44xx.h"
-#include "cminst44xx.h"
+#include <linux/power/omap/cm44xx.h>
 #include "prm2xxx.h"
 #include "prm3xxx.h"
 #include "prm44xx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 54c24e1..4576f0b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -153,7 +153,7 @@
 #include "powerdomain.h"
 #include "cm2xxx.h"
 #include "cm3xxx.h"
-#include "cminst44xx.h"
+#include <linux/power/omap/cm44xx.h>
 #include "cm33xx.h"
 #include "prm.h"
 #include "prm3xxx.h"
diff --git a/include/linux/power/omap/cm44xx.h b/include/linux/power/omap/cm44xx.h
new file mode 100644
index 0000000..eda5670
--- /dev/null
+++ b/include/linux/power/omap/cm44xx.h
@@ -0,0 +1,30 @@
+/*
+ * OMAP4 Clock Management (CM) function prototypes
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __LINUX_POWER_OMAP_CM44XX_H
+#define __LINUX_POWER_OMAP_CM44XX_H
+
+bool omap4_cminst_is_clkdm_in_hwsup(u8 part, u16 inst, u16 cdoffs);
+void omap4_cminst_clkdm_enable_hwsup(u8 part, u16 inst, u16 cdoffs);
+void omap4_cminst_clkdm_disable_hwsup(u8 part, u16 inst, u16 cdoffs);
+void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs);
+void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs);
+int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
+				   u16 clkctrl_offs);
+int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
+				  u16 clkctrl_offs);
+void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
+				u16 clkctrl_offs);
+void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
+				 u16 clkctrl_offs);
+
+void omap_cm_base_init(void);
+
+#endif
-- 
1.7.9.5

