From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/9] OMAP2 SDRC: add timing data for Qimonda HYB18M512160AF-6
Date: Mon, 07 Jul 2008 20:55:08 -0600
Message-ID: <20080708025459.11646.15076.stgit@localhost.localdomain>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40862 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830AbYGHC4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2008 22:56:38 -0400
In-Reply-To: <20080708025225.11646.55912.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

Add timing data for the Qimonda HYB18M512160AF-6 SDRAM chip, used on
the OMAP3430SDP boards.

Thanks to Rajendra Nayak <rnayak@ti.com> for his help identifying
the chip used on 3430SDP.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/board-3430sdp.c                |    4 +
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   55 ++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 137486b..2b30aff 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -44,6 +44,8 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 
+#include "sdram-qimonda-hyb18m512160af-6.h"
+
 #define	SDP3430_SMC91X_CS	3
 
 #define ENABLE_VAUX3_DEDICATED	0x03
@@ -248,7 +250,7 @@ static inline void __init sdp3430_init_smc91x(void)
 
 static void __init omap_3430sdp_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(hyb18m512160af6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 	sdp3430_init_smc91x();
diff --git a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
new file mode 100644
index 0000000..c932a6d
--- /dev/null
+++ b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
@@ -0,0 +1,55 @@
+/*
+ * SDRC register values for the Qimonda HYB18M512160AF-6
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
+#ifndef ARCH_ARM_MACH_OMAP2_SDRAM_QIMONDA_HYB18M512160AF6
+#define ARCH_ARM_MACH_OMAP2_SDRAM_QIMONDA_HYB18M512160AF6
+
+#include <asm/arch/sdrc.h>
+
+/* Qimonda HYB18M512160AF-6 */
+/* XXX Using ARE = 0x1 (no autorefresh burst) -- can this be changed? */
+static struct omap_sdrc_params hyb18m512160af6_sdrc_params[] = {
+	[0] = {
+		.rate	     = 165941176,
+		.actim_ctrla = 0x629db4c6,
+		.actim_ctrlb = 0x00012214,
+		.rfr_ctrl    = 0x0004dc01,
+		.mr	     = 0x00000032,
+	},
+	[1] = {
+		.rate	     = 133333333,
+		.actim_ctrla = 0x5219b485,
+		.actim_ctrlb = 0x00012210,
+		.rfr_ctrl    = 0x0003de01,
+		.mr	     = 0x00000032,
+	},
+	[2] = {
+		.rate	     = 82970588,
+		.actim_ctrla = 0x31512283,
+		.actim_ctrlb = 0x0001220a,
+		.rfr_ctrl    = 0x00025501,
+		.mr	     = 0x00000022,
+	},
+	[3] = {
+		.rate	     = 66666666,
+		.actim_ctrla = 0x290d2243,
+		.actim_ctrlb = 0x00012208,
+		.rfr_ctrl    = 0x0001d601,
+		.mr	     = 0x00000022,
+	},
+	[4] = {
+		.rate	     = 0
+	},
+};
+
+#endif


