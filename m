From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 30/55] ARM: OMAP2+: CM: move cm.h header to public location
Date: Mon, 31 Mar 2014 18:16:09 +0300
Message-ID: <1396278994-12624-31-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58796 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbaCaPSZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 11:18:25 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This file needs to be accessible from the PRCM core and mach-omap2 board
support code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c                 |    2 +-
 arch/arm/mach-omap2/clock2xxx.c             |    2 +-
 arch/arm/mach-omap2/clockdomains33xx_data.c |    2 +-
 arch/arm/mach-omap2/cm.h                    |   64 ---------------------------
 arch/arm/mach-omap2/cm2xxx.c                |    2 +-
 arch/arm/mach-omap2/cm2xxx_3xxx_private.h   |    2 +-
 arch/arm/mach-omap2/cm33xx.c                |    2 +-
 arch/arm/mach-omap2/cm33xx.h                |    2 +-
 arch/arm/mach-omap2/cm3xxx.c                |    2 +-
 arch/arm/mach-omap2/cm44xx.c                |    2 +-
 arch/arm/mach-omap2/cm_common.c             |    2 +-
 arch/arm/mach-omap2/cminst44xx.c            |    2 +-
 arch/arm/mach-omap2/io.c                    |    2 +-
 arch/arm/mach-omap2/powerdomain-common.c    |    2 +-
 include/linux/power/omap/cm.h               |   64 +++++++++++++++++++++++++++
 15 files changed, 77 insertions(+), 77 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/cm.h
 create mode 100644 include/linux/power/omap/cm.h

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 4ac6e3d..4276c46 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -31,7 +31,7 @@
 #include "soc.h"
 #include "clockdomain.h"
 #include "clock.h"
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include "cm2xxx.h"
 #include "cm3xxx.h"
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index b870f6a..4c996dd 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -25,7 +25,7 @@
 #include "soc.h"
 #include "clock.h"
 #include "clock2xxx.h"
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include "cm-regbits-24xx.h"
 
 struct clk_hw *dclk_hw;
diff --git a/arch/arm/mach-omap2/clockdomains33xx_data.c b/arch/arm/mach-omap2/clockdomains33xx_data.c
index 32c90fd..e86f84e 100644
--- a/arch/arm/mach-omap2/clockdomains33xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains33xx_data.c
@@ -18,7 +18,7 @@
 #include <linux/io.h>
 
 #include "clockdomain.h"
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include "cm33xx.h"
 #include "cm-regbits-33xx.h"
 
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
deleted file mode 100644
index 93473f9..0000000
--- a/arch/arm/mach-omap2/cm.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * OMAP2+ Clock Management prototypes
- *
- * Copyright (C) 2007-2009, 2012 Texas Instruments, Inc.
- * Copyright (C) 2007-2009 Nokia Corporation
- *
- * Written by Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ARCH_ASM_MACH_OMAP2_CM_H
-#define __ARCH_ASM_MACH_OMAP2_CM_H
-
-/*
- * MAX_MODULE_READY_TIME: max duration in microseconds to wait for the
- * PRCM to request that a module exit the inactive state in the case of
- * OMAP2 & 3.
- * In the case of OMAP4 this is the max duration in microseconds for the
- * module to reach the functionnal state from an inactive state.
- */
-#define MAX_MODULE_READY_TIME		2000
-
-# ifndef __ASSEMBLER__
-extern void __iomem *cm_base;
-extern void __iomem *cm2_base;
-extern void omap2_set_globals_cm(void __iomem *cm, void __iomem *cm2);
-# endif
-
-/*
- * MAX_MODULE_DISABLE_TIME: max duration in microseconds to wait for
- * the PRCM to request that a module enter the inactive state in the
- * case of OMAP2 & 3.  In the case of OMAP4 this is the max duration
- * in microseconds for the module to reach the inactive state from
- * a functional state.
- * XXX FSUSB on OMAP4430 takes ~4ms to idle after reset during
- * kernel init.
- */
-#define MAX_MODULE_DISABLE_TIME		5000
-
-# ifndef __ASSEMBLER__
-
-/**
- * struct cm_ll_data - fn ptrs to per-SoC CM function implementations
- * @split_idlest_reg: ptr to the SoC CM-specific split_idlest_reg impl
- * @wait_module_ready: ptr to the SoC CM-specific wait_module_ready impl
- */
-struct cm_ll_data {
-	int (*split_idlest_reg)(void __iomem *idlest_reg, s16 *prcm_inst,
-				u8 *idlest_reg_id);
-	int (*wait_module_ready)(s16 prcm_mod, u8 idlest_id, u8 idlest_shift);
-};
-
-extern int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
-			       u8 *idlest_reg_id);
-extern int cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift);
-
-extern int cm_register(struct cm_ll_data *cld);
-extern int cm_unregister(struct cm_ll_data *cld);
-
-# endif
-
-#endif
diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 6f04031..f4a070c 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -19,7 +19,7 @@
 #include <linux/io.h>
 
 #include "prm2xxx.h"
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include "cm2xxx_3xxx_private.h"
 #include <linux/power/omap/cm2xxx.h>
 #include "clockdomain.h"
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx_private.h b/arch/arm/mach-omap2/cm2xxx_3xxx_private.h
index ca7ca94..a28dff0 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx_private.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx_private.h
@@ -16,7 +16,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM2XXX_3XXX_PRIVATE_H
 #define __ARCH_ARM_MACH_OMAP2_CM2XXX_3XXX_PRIVATE_H
 
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include <linux/power/omap/cm2xxx_3xxx.h>
 
 #ifndef __ASSEMBLER__
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 7a7b2e7..7717eeb 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -23,7 +23,7 @@
 #include <linux/io.h>
 
 #include "clockdomain.h"
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include <linux/power/omap/cm33xx.h>
 #include "prm33xx.h"
 
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 67f1d49..d8c4278 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -17,7 +17,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include <linux/power/omap/cm33xx.h>
 
 /* CM base address */
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index cbba617..0818156 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -19,7 +19,7 @@
 #include <linux/io.h>
 
 #include "prm2xxx_3xxx.h"
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include "cm2xxx_3xxx_private.h"
 #include <linux/power/omap/cm3xxx.h>
 #include "clockdomain.h"
diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
index c440ba7..506974b 100644
--- a/arch/arm/mach-omap2/cm44xx.c
+++ b/arch/arm/mach-omap2/cm44xx.c
@@ -18,7 +18,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
 
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 8655538..3843f1f 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -18,7 +18,7 @@
 
 #include <linux/power/omap/cm2xxx.h>
 #include <linux/power/omap/cm3xxx.h>
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include "prcm-common.h"
 
 /*
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 2f780df..b577a8e 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -22,7 +22,7 @@
 #include <linux/io.h>
 
 #include "clockdomain.h"
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
 #include <linux/power/omap/cm44xx.h>
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6212c10..ed677bb 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -46,7 +46,7 @@
 #include "cm2xxx.h"
 #include "cm3xxx.h"
 #include "prm.h"
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include "prcm_mpu44xx.h"
 #include "prminst44xx.h"
 #include <linux/power/omap/cm44xx.h>
diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
index 2c62cd9..8c511e3 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include "pm.h"
-#include "cm.h"
+#include <linux/power/omap/cm.h>
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 
diff --git a/include/linux/power/omap/cm.h b/include/linux/power/omap/cm.h
new file mode 100644
index 0000000..cff447a
--- /dev/null
+++ b/include/linux/power/omap/cm.h
@@ -0,0 +1,64 @@
+/*
+ * OMAP2+ Clock Management prototypes
+ *
+ * Copyright (C) 2007-2009, 2012 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __LINUX_POWER_OMAP_CM_H
+#define __LINUX_POWER_OMAP_CM_H
+
+/*
+ * MAX_MODULE_READY_TIME: max duration in microseconds to wait for the
+ * PRCM to request that a module exit the inactive state in the case of
+ * OMAP2 & 3.
+ * In the case of OMAP4 this is the max duration in microseconds for the
+ * module to reach the functionnal state from an inactive state.
+ */
+#define MAX_MODULE_READY_TIME		2000
+
+# ifndef __ASSEMBLER__
+extern void __iomem *cm_base;
+extern void __iomem *cm2_base;
+void omap2_set_globals_cm(void __iomem *cm, void __iomem *cm2);
+# endif
+
+/*
+ * MAX_MODULE_DISABLE_TIME: max duration in microseconds to wait for
+ * the PRCM to request that a module enter the inactive state in the
+ * case of OMAP2 & 3.  In the case of OMAP4 this is the max duration
+ * in microseconds for the module to reach the inactive state from
+ * a functional state.
+ * XXX FSUSB on OMAP4430 takes ~4ms to idle after reset during
+ * kernel init.
+ */
+#define MAX_MODULE_DISABLE_TIME		5000
+
+# ifndef __ASSEMBLER__
+
+/**
+ * struct cm_ll_data - fn ptrs to per-SoC CM function implementations
+ * @split_idlest_reg: ptr to the SoC CM-specific split_idlest_reg impl
+ * @wait_module_ready: ptr to the SoC CM-specific wait_module_ready impl
+ */
+struct cm_ll_data {
+	int (*split_idlest_reg)(void __iomem *idlest_reg, s16 *prcm_inst,
+				u8 *idlest_reg_id);
+	int (*wait_module_ready)(s16 prcm_mod, u8 idlest_id, u8 idlest_shift);
+};
+
+int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
+			u8 *idlest_reg_id);
+int cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift);
+
+int cm_register(struct cm_ll_data *cld);
+int cm_unregister(struct cm_ll_data *cld);
+
+# endif
+
+#endif
-- 
1.7.9.5

