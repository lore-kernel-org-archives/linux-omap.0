From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] ARM: OMAP3: SDRC: add timing data for Micron
	MT46H32M32LF-6
Date: Fri, 22 May 2009 15:41:37 -0700
Message-ID: <20090522224137.31586.16744.stgit@localhost>
References: <20090522223543.31586.44534.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49665 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580AbZEVWlh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 18:41:37 -0400
In-Reply-To: <20090522223543.31586.44534.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Add timing data for the Micron MT46H32M32LF-6 SDRAM chip, used on the
OMAP3 Beagle and EVM boards.  Original timing data is from the Micron
datasheet PDF downloaded from:

http://download.micron.com/pdf/datasheets/dram/mobile/1gb_ddr_mobile_sdram_t48m.pdf

Thanks to Rajendra Nayak <rnayak@ti.com> for his help identifying
the chips used on Beagle & OMAP3EVM.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c           |    4 +
 arch/arm/mach-omap2/board-omap3pandora.c          |    3 +
 arch/arm/mach-omap2/board-overo.c                 |    3 +
 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h |   69 +++++++++++++++++++++
 4 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 3a7a29d..f25082c 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -105,6 +105,8 @@ static struct platform_device omap3beagle_nand_device = {
 	.resource	= &omap3beagle_nand_resource,
 };
 
+#include "sdram-micron-mt46h32m32lf-6.h"
+
 static struct omap_uart_config omap3_beagle_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -185,7 +187,7 @@ static int __init omap3_beagle_i2c_init(void)
 
 static void __init omap3_beagle_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 402f09c..3571bb4 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -36,6 +36,7 @@
 #include <mach/mcspi.h>
 #include <mach/usb.h>
 
+#include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
 #define OMAP3_PANDORA_TS_GPIO		94
@@ -118,7 +119,7 @@ static int __init omap3pandora_i2c_init(void)
 
 static void __init omap3pandora_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index b1f23be..c7443ff 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -45,6 +45,7 @@
 #include <mach/nand.h>
 #include <mach/usb.h>
 
+#include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
 #define OVERO_GPIO_BT_XGATE	15
@@ -303,7 +304,7 @@ static int __init overo_i2c_init(void)
 
 static void __init overo_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
new file mode 100644
index 0000000..b6c1db3
--- /dev/null
+++ b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
@@ -0,0 +1,69 @@
+/*
+ * SDRC register values for the Micron MT46H32M32LF-6
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H32M32LF
+#define ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H32M32LF
+
+#include <mach/sdrc.h>
+
+/* Micron MT46H32M32LF-6 */
+/* XXX Using ARE = 0x1 (no autorefresh burst) -- can this be changed? */
+static struct omap_sdrc_params mt46h32m32lf6_sdrc_params[] = {
+	[0] = {
+		.rate	     = 166000000,
+		.actim_ctrla = 0x9a9db4c6,
+		.actim_ctrlb = 0x00011217,
+		.rfr_ctrl    = 0x0004dc01,
+		.mr	     = 0x00000032,
+	},
+	[1] = {
+		.rate	     = 165941176,
+		.actim_ctrla = 0x9a9db4c6,
+		.actim_ctrlb = 0x00011217,
+		.rfr_ctrl    = 0x0004dc01,
+		.mr	     = 0x00000032,
+	},
+	[2] = {
+		.rate	     = 133333333,
+		.actim_ctrla = 0x7a19b485,
+		.actim_ctrlb = 0x00011213,
+		.rfr_ctrl    = 0x0003de01,
+		.mr	     = 0x00000032,
+	},
+	[3] = {
+		.rate	     = 83000000,
+		.actim_ctrla = 0x51512283,
+		.actim_ctrlb = 0x0001120c,
+		.rfr_ctrl    = 0x00025501,
+		.mr	     = 0x00000032,
+	},
+	[4] = {
+		.rate	     = 82970588,
+		.actim_ctrla = 0x51512283,
+		.actim_ctrlb = 0x0001120c,
+		.rfr_ctrl    = 0x00025501,
+		.mr	     = 0x00000032,
+	},
+	[5] = {
+		.rate	     = 66666666,
+		.actim_ctrla = 0x410d2243,
+		.actim_ctrlb = 0x0001120a,
+		.rfr_ctrl    = 0x0001d601,
+		.mr	     = 0x00000032,
+	},
+	[6] = {
+		.rate	     = 0
+	},
+};
+
+#endif

