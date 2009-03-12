From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 65/86] [ARM] OMAP2 SDRC: move mach-omap2/memory.h into mach/sdrc.h
Date: Thu, 12 Mar 2009 11:28:15 -0700
Message-ID: <1236882516-29403-66-git-send-email-khilman@deeprootsystems.com>
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
 <1236882516-29403-63-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-64-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-65-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757176AbZCLSdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:33:21 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:33:20 -0700 (PDT)
In-Reply-To: <1236882516-29403-65-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Move the contents of the arch/arm/mach-omap2/memory.h file to the
existing mach/sdrc.h file, and remove memory.h.  Modify files which
include memory.h to include asm/arch/sdrc.h instead.

linux-omap source commit is e7ae2d89921372fc4b9712a32cc401d645597807.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c            |    2 +-
 arch/arm/mach-omap2/clock24xx.c        |    2 +-
 arch/arm/mach-omap2/clock34xx.c        |    2 +-
 arch/arm/mach-omap2/io.c               |    4 +-
 arch/arm/mach-omap2/memory.c           |    9 ++++++-
 arch/arm/mach-omap2/memory.h           |   43 --------------------------------
 arch/arm/plat-omap/include/mach/gpmc.h |    2 +-
 arch/arm/plat-omap/include/mach/sdrc.h |   21 +++++++++++++++
 8 files changed, 35 insertions(+), 50 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/memory.h

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 5d7d4c5..18fddb6 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -29,7 +29,7 @@
 #include <mach/cpu.h>
 #include <asm/div64.h>
 
-#include "memory.h"
+#include <mach/sdrc.h>
 #include "sdrc.h"
 #include "clock.h"
 #include "prm.h"
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index b990266..83911ad 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -33,7 +33,7 @@
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
-#include "memory.h"
+#include <mach/sdrc.h>
 #include "clock.h"
 #include "prm.h"
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 3d756ba..52385b1 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -32,7 +32,7 @@
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
-#include "memory.h"
+#include <mach/sdrc.h>
 #include "clock.h"
 #include "prm.h"
 #include "prm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5ea64f9..2b5f28a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -27,8 +27,8 @@
 #include <mach/mux.h>
 #include <mach/omapfb.h>
 #include <mach/sram.h>
-
-#include "memory.h"
+#include <mach/sdrc.h>
+#include <mach/gpmc.h>
 
 #include "clock.h"
 
diff --git a/arch/arm/mach-omap2/memory.c b/arch/arm/mach-omap2/memory.c
index 882c702..93cb257 100644
--- a/arch/arm/mach-omap2/memory.c
+++ b/arch/arm/mach-omap2/memory.c
@@ -29,9 +29,16 @@
 
 #include "prm.h"
 
-#include "memory.h"
+#include <mach/sdrc.h>
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
diff --git a/arch/arm/plat-omap/include/mach/gpmc.h b/arch/arm/plat-omap/include/mach/gpmc.h
index 45b6784..921b165 100644
--- a/arch/arm/plat-omap/include/mach/gpmc.h
+++ b/arch/arm/plat-omap/include/mach/gpmc.h
@@ -103,6 +103,6 @@ extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
 extern int gpmc_cs_set_reserved(int cs, int reserved);
 extern int gpmc_cs_reserved(int cs);
-extern void gpmc_init(void);
+extern void __init gpmc_init(void);
 
 #endif
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index a98c6c3..c905b52 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -74,4 +74,25 @@
 #define SMS_SYSCONFIG		0x010
 /* REVISIT: fill in other SMS registers here */
 
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
+
 #endif
-- 
1.6.1.2

