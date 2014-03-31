From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 26/55] ARM: OMAP3: move cm2xxx_3xxx.h header to public location
Date: Mon, 31 Mar 2014 18:16:05 +0300
Message-ID: <1396278994-12624-27-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54708 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591AbaCaPST (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:18:19 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This file needs to be accessible from the PRCM core and mach-omap2 board
support code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt_iclk.c                  |    2 +-
 arch/arm/mach-omap2/clock3xxx.c                  |    2 +-
 arch/arm/mach-omap2/clockdomains2420_data.c      |    2 +-
 arch/arm/mach-omap2/clockdomains2430_data.c      |    2 +-
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/clockdomains3xxx_data.c      |    2 +-
 arch/arm/mach-omap2/cm2xxx.h                     |    2 +-
 arch/arm/mach-omap2/cm2xxx_3xxx.h                |   72 ----------------------
 arch/arm/mach-omap2/cm2xxx_3xxx_private.h        |    2 +-
 arch/arm/mach-omap2/cm3xxx.h                     |    2 +-
 arch/arm/mach-omap2/dpll3xxx.c                   |    2 +-
 arch/arm/mach-omap2/dsp.c                        |    2 +-
 arch/arm/mach-omap2/pm-debug.c                   |    2 +-
 arch/arm/mach-omap2/powerdomain.c                |    2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |    2 +-
 arch/arm/mach-omap2/prm2xxx.c                    |    2 +-
 arch/arm/mach-omap2/serial.c                     |    2 +-
 include/linux/power/omap/cm2xxx_3xxx.h           |   70 +++++++++++++++++++++
 18 files changed, 86 insertions(+), 88 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/cm2xxx_3xxx.h
 create mode 100644 include/linux/power/omap/cm2xxx_3xxx.h

diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index 333f0a6..b4cf577 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/arch/arm/mach-omap2/clkt_iclk.c
@@ -17,7 +17,7 @@
 
 #include "clock.h"
 #include "clock2xxx.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-24xx.h"
 
 /* Private functions */
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 0b02b41..4706f2f 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -26,7 +26,7 @@
 #include "clock3xxx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-34xx.h"
 
 /*
diff --git a/arch/arm/mach-omap2/clockdomains2420_data.c b/arch/arm/mach-omap2/clockdomains2420_data.c
index 7e76bec..7931fd1 100644
--- a/arch/arm/mach-omap2/clockdomains2420_data.c
+++ b/arch/arm/mach-omap2/clockdomains2420_data.c
@@ -38,7 +38,7 @@
 #include "soc.h"
 #include "clockdomain.h"
 #include "prm2xxx_3xxx.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
 
diff --git a/arch/arm/mach-omap2/clockdomains2430_data.c b/arch/arm/mach-omap2/clockdomains2430_data.c
index b923007..2e3918c 100644
--- a/arch/arm/mach-omap2/clockdomains2430_data.c
+++ b/arch/arm/mach-omap2/clockdomains2430_data.c
@@ -38,7 +38,7 @@
 #include "soc.h"
 #include "clockdomain.h"
 #include "prm2xxx_3xxx.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
 
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 4972219..b728d6e 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -37,7 +37,7 @@
 
 #include "clockdomain.h"
 #include "prm2xxx_3xxx.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
 #include "cm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index e6b91e5..27851ac 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -36,7 +36,7 @@
 #include "soc.h"
 #include "clockdomain.h"
 #include "prm2xxx_3xxx.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
 
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index 5eaa007..80e9892 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -17,7 +17,7 @@
 #define __ARCH_ASM_MACH_OMAP2_CM2XXX_H
 
 #include "prcm-common.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include <linux/power/omap/cm2xxx.h>
 
 #define OMAP2420_CM_REGADDR(module, reg)				\
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
deleted file mode 100644
index b40b5bd..0000000
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * OMAP2/3 Clock Management (CM) register definitions
- *
- * Copyright (C) 2007-2009 Texas Instruments, Inc.
- * Copyright (C) 2007-2010 Nokia Corporation
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * The CM hardware modules on the OMAP2/3 are quite similar to each
- * other.  The CM modules/instances on OMAP4 are quite different, so
- * they are handled in a separate file.
- */
-#ifndef __ARCH_ASM_MACH_OMAP2_CM2XXX_3XXX_H
-#define __ARCH_ASM_MACH_OMAP2_CM2XXX_3XXX_H
-
-#include "cm.h"
-
-/*
- * Module specific CM register offsets from CM_BASE + domain offset
- * Use cm_{read,write}_mod_reg() with these registers.
- * These register offsets generally appear in more than one PRCM submodule.
- */
-
-/* Common between OMAP2 and OMAP3 */
-
-#define CM_FCLKEN					0x0000
-#define CM_FCLKEN1					CM_FCLKEN
-#define CM_CLKEN					CM_FCLKEN
-#define CM_ICLKEN					0x0010
-#define CM_ICLKEN1					CM_ICLKEN
-#define CM_ICLKEN2					0x0014
-#define CM_ICLKEN3					0x0018
-#define CM_IDLEST					0x0020
-#define CM_IDLEST1					CM_IDLEST
-#define CM_IDLEST2					0x0024
-#define OMAP2430_CM_IDLEST3				0x0028
-#define CM_AUTOIDLE					0x0030
-#define CM_AUTOIDLE1					CM_AUTOIDLE
-#define CM_AUTOIDLE2					0x0034
-#define CM_AUTOIDLE3					0x0038
-#define CM_CLKSEL					0x0040
-#define CM_CLKSEL1					CM_CLKSEL
-#define CM_CLKSEL2					0x0044
-#define OMAP2_CM_CLKSTCTRL				0x0048
-
-#ifndef __ASSEMBLER__
-
-extern int omap2xxx_cm_apll54_enable(void);
-extern void omap2xxx_cm_apll54_disable(void);
-extern int omap2xxx_cm_apll96_enable(void);
-extern void omap2xxx_cm_apll96_disable(void);
-
-#endif
-
-/* CM register bits shared between 24XX and 3430 */
-
-/* CM_CLKSEL_GFX */
-#define OMAP_CLKSEL_GFX_SHIFT				0
-#define OMAP_CLKSEL_GFX_MASK				(0x7 << 0)
-#define OMAP_CLKSEL_GFX_WIDTH				3
-
-/* CM_ICLKEN_GFX */
-#define OMAP_EN_GFX_SHIFT				0
-#define OMAP_EN_GFX_MASK				(1 << 0)
-
-/* CM_IDLEST_GFX */
-#define OMAP_ST_GFX_MASK				(1 << 0)
-
-#endif
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx_private.h b/arch/arm/mach-omap2/cm2xxx_3xxx_private.h
index 9131829..ca7ca94 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx_private.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx_private.h
@@ -17,7 +17,7 @@
 #define __ARCH_ARM_MACH_OMAP2_CM2XXX_3XXX_PRIVATE_H
 
 #include "cm.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 9c2047f..5fdc14c 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -17,7 +17,7 @@
 #define __ARCH_ASM_MACH_OMAP2_CM3XXX_H
 
 #include "prcm-common.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include <linux/power/omap/cm3xxx.h>
 
 #define OMAP34XX_CM_REGADDR(module, reg)				\
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 3185ced..79ce6e8 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -31,7 +31,7 @@
 #include "soc.h"
 #include "clockdomain.h"
 #include "clock.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-34xx.h"
 
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index b8208b4..1d802fe 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -24,7 +24,7 @@
 #include <asm/memblock.h>
 
 #include "control.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "prm2xxx_3xxx.h"
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 #include "omap-pm.h"
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 0b33986..95f28b2 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -33,7 +33,7 @@
 #include "omap-pm.h"
 
 #include "soc.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 62649ba..e532d2b 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -22,7 +22,7 @@
 #include <linux/spinlock.h>
 #include <trace/events/power.h>
 
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "prcm44xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 328c103..9db6a8e 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -21,7 +21,7 @@
 #include "prcm-common.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-34xx.h"
 
 /*
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 7264ae6..5b5260c 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -22,7 +22,7 @@
 #include "clockdomain.h"
 #include "prm2xxx.h"
 #include "prm2xxx_3xxx_private.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 
 #define OMAP24XX_FORCESTATE_MASK		(1 << 18)
 #define OMAP24XX_AUTOIDLE_MASK			(1 << 0)
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index a388f8c..90e06b3 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -36,7 +36,7 @@
 #include "soc.h"
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
-#include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx_3xxx.h>
 #include "prm-regbits-34xx.h"
 #include "control.h"
 #include "mux.h"
diff --git a/include/linux/power/omap/cm2xxx_3xxx.h b/include/linux/power/omap/cm2xxx_3xxx.h
new file mode 100644
index 0000000..c4a8ea7
--- /dev/null
+++ b/include/linux/power/omap/cm2xxx_3xxx.h
@@ -0,0 +1,70 @@
+/*
+ * OMAP2/3 Clock Management (CM) register definitions
+ *
+ * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * The CM hardware modules on the OMAP2/3 are quite similar to each
+ * other.  The CM modules/instances on OMAP4 are quite different, so
+ * they are handled in a separate file.
+ */
+#ifndef __LINUX_POWER_OMAP_CM2XXX_3XXX_H
+#define __LINUX_POWER_OMAP_CM2XXX_3XXX_H
+
+/*
+ * Module specific CM register offsets from CM_BASE + domain offset
+ * Use cm_{read,write}_mod_reg() with these registers.
+ * These register offsets generally appear in more than one PRCM submodule.
+ */
+
+/* Common between OMAP2 and OMAP3 */
+
+#define CM_FCLKEN					0x0000
+#define CM_FCLKEN1					CM_FCLKEN
+#define CM_CLKEN					CM_FCLKEN
+#define CM_ICLKEN					0x0010
+#define CM_ICLKEN1					CM_ICLKEN
+#define CM_ICLKEN2					0x0014
+#define CM_ICLKEN3					0x0018
+#define CM_IDLEST					0x0020
+#define CM_IDLEST1					CM_IDLEST
+#define CM_IDLEST2					0x0024
+#define OMAP2430_CM_IDLEST3				0x0028
+#define CM_AUTOIDLE					0x0030
+#define CM_AUTOIDLE1					CM_AUTOIDLE
+#define CM_AUTOIDLE2					0x0034
+#define CM_AUTOIDLE3					0x0038
+#define CM_CLKSEL					0x0040
+#define CM_CLKSEL1					CM_CLKSEL
+#define CM_CLKSEL2					0x0044
+#define OMAP2_CM_CLKSTCTRL				0x0048
+
+#ifndef __ASSEMBLER__
+
+int omap2xxx_cm_apll54_enable(void);
+void omap2xxx_cm_apll54_disable(void);
+int omap2xxx_cm_apll96_enable(void);
+void omap2xxx_cm_apll96_disable(void);
+
+#endif
+
+/* CM register bits shared between 24XX and 3430 */
+
+/* CM_CLKSEL_GFX */
+#define OMAP_CLKSEL_GFX_SHIFT				0
+#define OMAP_CLKSEL_GFX_MASK				(0x7 << 0)
+#define OMAP_CLKSEL_GFX_WIDTH				3
+
+/* CM_ICLKEN_GFX */
+#define OMAP_EN_GFX_SHIFT				0
+#define OMAP_EN_GFX_MASK				(1 << 0)
+
+/* CM_IDLEST_GFX */
+#define OMAP_ST_GFX_MASK				(1 << 0)
+
+#endif
-- 
1.7.9.5

