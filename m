From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 03/12] ARM: OMAP1: OCPI: move to mach-omap1/
Date: Tue, 10 Apr 2012 18:35:28 -0600
Message-ID: <20120411003525.27059.43118.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43919 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759902Ab2DKAiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:20 -0400
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

Move the OMAP1 OCPI "bus" code to arch/arm/mach-omap1, since it is
only used on OMAP1 devices.  In the long term, it probably makes sense
to move the OCPI bus code to somewhere under drivers/.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/Makefile |    3 +++
 arch/arm/mach-omap1/common.h |    2 ++
 arch/arm/mach-omap1/ocpi.c   |    7 +++++--
 arch/arm/plat-omap/Makefile  |    3 ---
 4 files changed, 10 insertions(+), 5 deletions(-)
 rename arch/arm/{plat-omap/ocpi.c => mach-omap1/ocpi.c} (93%)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 9923f92..20d65af 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -12,6 +12,9 @@ endif
 
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 
+# OCPI interconnect support for 1710, 1610 and 5912
+obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
+
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o
 
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index ef656ff..a90b9d7 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -63,4 +63,6 @@ extern bool omap_32k_timer_init(void);
 
 extern u32 omap_irq_flags;
 
+extern int ocpi_enable(void);
+
 #endif /* __ARCH_ARM_MACH_OMAP1_COMMON_H */
diff --git a/arch/arm/plat-omap/ocpi.c b/arch/arm/mach-omap1/ocpi.c
similarity index 93%
rename from arch/arm/plat-omap/ocpi.c
rename to arch/arm/mach-omap1/ocpi.c
index ebe0c73..238170c 100644
--- a/arch/arm/plat-omap/ocpi.c
+++ b/arch/arm/mach-omap1/ocpi.c
@@ -4,6 +4,7 @@
  * Minimal OCP bus support for omap16xx
  *
  * Copyright (C) 2003 - 2005 Nokia Corporation
+ * Copyright (C) 2012 Texas Instruments, Inc.
  * Written by Tony Lindgren <tony@atomide.com>
  *
  * Modified for clock framework by Paul Mundt <paul.mundt@nokia.com>.
@@ -35,6 +36,8 @@
 
 #include <mach/hardware.h>
 
+#include "common.h"
+
 #define OCPI_BASE		0xfffec320
 #define OCPI_FAULT		(OCPI_BASE + 0x00)
 #define OCPI_CMD_FAULT		(OCPI_BASE + 0x04)
@@ -64,7 +67,7 @@ int ocpi_enable(void)
 	/* Enable access for OHCI in OCPI */
 	val = omap_readl(OCPI_PROT);
 	val &= ~0xff;
-	//val &= (1 << 0);	/* Allow access only to EMIFS */
+	/* val &= (1 << 0);	 Allow access only to EMIFS */
 	omap_writel(val, OCPI_PROT);
 
 	val = omap_readl(OCPI_SEC);
@@ -86,7 +89,7 @@ static int __init omap_ocpi_init(void)
 
 	clk_enable(ocpi_ck);
 	ocpi_enable();
-	printk("OMAP OCPI interconnect driver loaded\n");
+	pr_info("OMAP OCPI interconnect driver loaded\n");
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index c0fe275..ed8605f 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -9,9 +9,6 @@ obj-m :=
 obj-n :=
 obj-  :=
 
-# OCPI interconnect support for 1710, 1610 and 5912
-obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
-
 # omap_device support (OMAP2+ only at the moment)
 obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
 obj-$(CONFIG_ARCH_OMAP3) += omap_device.o


