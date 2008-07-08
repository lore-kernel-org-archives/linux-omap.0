From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/9] OMAP2 SDRC: move mach-omap2/memory.h into
	include/asm-arm/arch-omap/sdrc.h
Date: Mon, 07 Jul 2008 20:54:41 -0600
Message-ID: <20080708025438.11646.68120.stgit@localhost.localdomain>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40855 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185AbYGHC4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2008 22:56:37 -0400
In-Reply-To: <20080708025225.11646.55912.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Move the contents of the arch/arm/mach-omap2/memory.h file to the
existing include/asm-arm/arch-omap/sdrc.h file, and remove memory.h.
Modify files which include memory.h to include asm/arch/sdrc.h instead.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock.c      |    2 +-
 arch/arm/mach-omap2/clock24xx.c  |    2 +-
 arch/arm/mach-omap2/clock34xx.c  |    2 +-
 arch/arm/mach-omap2/gpmc.c       |    2 +-
 arch/arm/mach-omap2/io.c         |    4 ++--
 arch/arm/mach-omap2/memory.c     |    9 +++++++-
 arch/arm/mach-omap2/memory.h     |   43 --------------------------------------
 include/asm-arm/arch-omap/gpmc.h |    1 +
 include/asm-arm/arch-omap/sdrc.h |   39 ++++++++++++++++++++++++++++------
 9 files changed, 47 insertions(+), 57 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/memory.h

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 577be44..794059f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -31,7 +31,7 @@
 #include <asm/arch/prcm.h>
 #include <asm/div64.h>
 
-#include "memory.h"
+#include <asm/arch/sdrc.h>
 #include "sdrc.h"
 #include "clock.h"
 #include "prm.h"
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 54cc6e1..aa3027c 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -33,7 +33,7 @@
 #include <asm/arch/sram.h>
 #include <asm/div64.h>
 
-#include "memory.h"
+#include <asm/arch/sdrc.h>
 #include "clock.h"
 #include "clock24xx.h"
 #include "prm.h"
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 6831ae9..482f05c 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -32,7 +32,7 @@
 #include <asm/div64.h>
 #include <asm/bitops.h>
 
-#include "memory.h"
+#include <asm/arch/sdrc.h>
 #include "clock.h"
 #include "clock34xx.h"
 #include "prm.h"
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 83984f7..7e9457d 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -23,7 +23,7 @@
 #include <asm/mach-types.h>
 #include <asm/arch/gpmc.h>
 
-#include "memory.h"
+#include <asm/arch/sdrc.h>
 
 /* GPMC register offsets */
 #define GPMC_REVISION		0x00
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 314994b..4aa1abf 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -26,8 +26,8 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/omapfb.h>
 #include <asm/arch/sram.h>
-
-#include "memory.h"
+#include <asm/arch/sdrc.h>
+#include <asm/arch/gpmc.h>
 
 #include "clock.h"
 
diff --git a/arch/arm/mach-omap2/memory.c b/arch/arm/mach-omap2/memory.c
index 2ad29fd..176658f 100644
--- a/arch/arm/mach-omap2/memory.c
+++ b/arch/arm/mach-omap2/memory.c
@@ -30,9 +30,16 @@
 
 #include "prm.h"
 
-#include "memory.h"
+#include <asm/arch/sdrc.h>
 #include "sdrc.h"
 
+/* Memory timing, DLL mode flags */
+#define M_DDR		1
+#define M_LOCK_CTRL	(1 << 2)
+#define M_UNLOCK	0
+#define M_LOCK		1
+
+
 void __iomem *omap2_sdrc_base;
 void __iomem *omap2_sms_base;
 
diff --git a/arch/arm/mach-omap2/memory.h b/arch/arm/mach-omap2/memory.h
deleted file mode 100644
index bb3db80..0000000
--- a/arch/arm/mach-omap2/memory.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/memory.h
- *
- * Interface for memory timing related functions for OMAP24XX
- *
- * Copyright (C) 2005 Texas Instruments Inc.
- * Richard Woodruff <r-woodruff2@ti.com>
- *
- * Copyright (C) 2005 Nokia Corporation
- * Tony Lindgren <tony@atomide.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef ARCH_ARM_MACH_OMAP2_MEMORY_H
-#define ARCH_ARM_MACH_OMAP2_MEMORY_H
-
-/* Memory timings */
-#define M_DDR		1
-#define M_LOCK_CTRL	(1 << 2)
-#define M_UNLOCK	0
-#define M_LOCK		1
-
-struct memory_timings {
-	u32 m_type;		/* ddr = 1, sdr = 0 */
-	u32 dll_mode;		/* use lock mode = 1, unlock mode = 0 */
-	u32 slow_dll_ctrl;	/* unlock mode, dll value for slow speed */
-	u32 fast_dll_ctrl;	/* unlock mode, dll value for fast speed */
-	u32 base_cs;		/* base chip select to use for calculations */
-};
-
-extern void omap2_init_memory_params(u32 force_lock_to_unlock_mode);
-extern u32 omap2_memory_get_slow_dll_ctrl(void);
-extern u32 omap2_memory_get_fast_dll_ctrl(void);
-extern u32 omap2_memory_get_type(void);
-u32 omap2_dll_force_needed(void);
-u32 omap2_reprogram_sdrc(u32 level, u32 force);
-void __init omap2_init_memory(void);
-void __init gpmc_init(void);
-
-#endif
diff --git a/include/asm-arm/arch-omap/gpmc.h b/include/asm-arm/arch-omap/gpmc.h
index 53dc246..a3df76a 100644
--- a/include/asm-arm/arch-omap/gpmc.h
+++ b/include/asm-arm/arch-omap/gpmc.h
@@ -99,5 +99,6 @@ extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
 extern int gpmc_cs_set_reserved(int cs, int reserved);
 extern int gpmc_cs_reserved(int cs);
+extern void __init gpmc_init(void);
 
 #endif
diff --git a/include/asm-arm/arch-omap/sdrc.h b/include/asm-arm/arch-omap/sdrc.h
index 660da4d..0edce1c 100644
--- a/include/asm-arm/arch-omap/sdrc.h
+++ b/include/asm-arm/arch-omap/sdrc.h
@@ -4,10 +4,12 @@
 /*
  * OMAP2/3 SDRC/SMS register definitions
  *
- * Copyright (C) 2007 Texas Instruments, Inc.
- * Copyright (C) 2007 Nokia Corporation
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008 Nokia Corporation
  *
- * Written by Paul Walmsley
+ * Tony Lindgren
+ * Paul Walmsley
+ * Richard Woodruff
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -64,14 +66,37 @@
  * SMS register access
  */
 
-
-#define OMAP242X_SMS_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP2420_SMS_BASE + reg)
-#define OMAP243X_SMS_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP243X_SMS_BASE + reg)
-#define OMAP343X_SMS_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP343X_SMS_BASE + reg)
+#define OMAP242X_SMS_REGADDR(reg)					\
+			(void __iomem *)IO_ADDRESS(OMAP2420_SMS_BASE + reg)
+#define OMAP243X_SMS_REGADDR(reg)					\
+			(void __iomem *)IO_ADDRESS(OMAP243X_SMS_BASE + reg)
+#define OMAP343X_SMS_REGADDR(reg)					\
+			(void __iomem *)IO_ADDRESS(OMAP343X_SMS_BASE + reg)
 
 /* SMS register offsets - read/write with sms_{read,write}_reg() */
 
 #define SMS_SYSCONFIG		0x010
 /* REVISIT: fill in other SMS registers here */
 
+
+#ifndef __ASSEMBLER__
+
+struct memory_timings {
+	u32 m_type;		/* ddr = 1, sdr = 0 */
+	u32 dll_mode;		/* use lock mode = 1, unlock mode = 0 */
+	u32 slow_dll_ctrl;	/* unlock mode, dll value for slow speed */
+	u32 fast_dll_ctrl;	/* unlock mode, dll value for fast speed */
+	u32 base_cs;		/* base chip select to use for calculations */
+};
+
+extern void omap2_init_memory_params(u32 force_lock_to_unlock_mode);
+extern u32 omap2_memory_get_slow_dll_ctrl(void);
+extern u32 omap2_memory_get_fast_dll_ctrl(void);
+extern u32 omap2_memory_get_type(void);
+u32 omap2_dll_force_needed(void);
+u32 omap2_reprogram_sdrc(u32 level, u32 force);
+void __init omap2_init_memory(void);
+
+#endif
+
 #endif


