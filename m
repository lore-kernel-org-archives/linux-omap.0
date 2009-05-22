From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] ARM: OMAP3: SDRC: add timing data for Qimonda
	HYB18M512160AF-6
Date: Fri, 22 May 2009 15:42:53 -0700
Message-ID: <20090522224253.31586.43580.stgit@localhost>
References: <20090522223543.31586.44534.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54360 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757582AbZEVWnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 18:43:00 -0400
In-Reply-To: <20090522223543.31586.44534.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Add timing data for the Qimonda HYB18M512160AF-6 SDRAM chip, used on
the OMAP3430SDP boards.

Thanks to Rajendra Nayak <rnayak@ti.com> for his help identifying
the chip used on 3430SDP.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3430sdp.c                |    3 +
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   54 ++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 439b826..1d0c30a 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -41,6 +41,7 @@
 #include <mach/keypad.h>
 #include <mach/gpmc-smc91x.h>
 
+#include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
 
 #define CONFIG_DISABLE_HFCLK 1
@@ -168,7 +169,7 @@ static struct platform_device *sdp3430_devices[] __initdata = {
 
 static void __init omap_3430sdp_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(hyb18m512160af6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
new file mode 100644
index 0000000..3751d29
--- /dev/null
+++ b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
@@ -0,0 +1,54 @@
+/*
+ * SDRC register values for the Qimonda HYB18M512160AF-6
+ *
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2009 Nokia Corporation
+ *
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARCH_ARM_MACH_OMAP2_SDRAM_QIMONDA_HYB18M512160AF6
+#define ARCH_ARM_MACH_OMAP2_SDRAM_QIMONDA_HYB18M512160AF6
+
+#include <mach/sdrc.h>
+
+/* Qimonda HYB18M512160AF-6 */
+static struct omap_sdrc_params hyb18m512160af6_sdrc_params[] = {
+	[0] = {
+		.rate	     = 166000000,
+		.actim_ctrla = 0x629db4c6,
+		.actim_ctrlb = 0x00012214,
+		.rfr_ctrl    = 0x0004dc01,
+		.mr	     = 0x00000032,
+	},
+	[1] = {
+		.rate	     = 165941176,
+		.actim_ctrla = 0x629db4c6,
+		.actim_ctrlb = 0x00012214,
+		.rfr_ctrl    = 0x0004dc01,
+		.mr	     = 0x00000032,
+	},
+	[2] = {
+		.rate	     = 83000000,
+		.actim_ctrla = 0x31512283,
+		.actim_ctrlb = 0x0001220a,
+		.rfr_ctrl    = 0x00025501,
+		.mr	     = 0x00000022,
+	},
+	[3] = {
+		.rate	     = 82970588,
+		.actim_ctrla = 0x31512283,
+		.actim_ctrlb = 0x0001220a,
+		.rfr_ctrl    = 0x00025501,
+		.mr	     = 0x00000022,
+	},
+	[4] = {
+		.rate	     = 0
+	},
+};
+
+#endif

