From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] ARM: OMAP3: SDRC: add timing data for Micron
	MT46H32M32LF-6, v2
Date: Fri, 22 May 2009 19:02:17 -0700
Message-ID: <20090523020216.GC9283@atomide.com>
References: <20090522223543.31586.44534.stgit@localhost> <20090522224137.31586.16744.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57440 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbZEWCCY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 22:02:24 -0400
Content-Disposition: inline
In-Reply-To: <20090522224137.31586.16744.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090522 15:41]:
> From: Paul Walmsley <paul@pwsan.com>
> 
> Add timing data for the Micron MT46H32M32LF-6 SDRAM chip, used on the
> OMAP3 Beagle and EVM boards.  Original timing data is from the Micron
> datasheet PDF downloaded from:
> 
> http://download.micron.com/pdf/datasheets/dram/mobile/1gb_ddr_mobile_sdram_t48m.pdf
> 
> Thanks to Rajendra Nayak <rnayak@ti.com> for his help identifying
> the chips used on Beagle & OMAP3EVM.

Here's this one with updated timings from Paul:

Boards that used 133.3MHz maximum rate SDRAM were never released to the
public and presumably used the OMAPZoom kernel; so, drop these unused
rates.  Viz.:

    http://marc.info/?l=linux-omap&m=124232922426311&w=2

Regards,

Tony


--9amGYk9869ThD9tj
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="sdram-micron-v2.patch"

>From 91429b625404116b31f7c03700407df11ed61bcb Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 21 May 2009 09:50:27 -0700
Subject: [PATCH] ARM: OMAP3: SDRC: add timing data for Micron MT46H32M32LF-6, v2

Add timing data for the Micron MT46H32M32LF-6 SDRAM chip, used on the
OMAP3 Beagle and EVM boards.  Original timing data is from the Micron
datasheet PDF downloaded from:

http://download.micron.com/pdf/datasheets/dram/mobile/1gb_ddr_mobile_sdram_t48m.pdf

Thanks to Rajendra Nayak <rnayak@ti.com> for his help identifying
the chips used on Beagle & OMAP3EVM.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

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
index 0000000..02e1c2d
--- /dev/null
+++ b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
@@ -0,0 +1,55 @@
+/*
+ * SDRC register values for the Micron MT46H32M32LF-6
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008-2009 Nokia Corporation
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
+		.rate	     = 83000000,
+		.actim_ctrla = 0x51512283,
+		.actim_ctrlb = 0x0001120c,
+		.rfr_ctrl    = 0x00025501,
+		.mr	     = 0x00000032,
+	},
+	[3] = {
+		.rate	     = 82970588,
+		.actim_ctrla = 0x51512283,
+		.actim_ctrlb = 0x0001120c,
+		.rfr_ctrl    = 0x00025501,
+		.mr	     = 0x00000032,
+	},
+	[4] = {
+		.rate	     = 0
+	},
+};
+
+#endif

--9amGYk9869ThD9tj--
