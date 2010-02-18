From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/23] ARM: OMAP3: SDRC: add timing data for Numonyx M65KxxxxAM
Date: Wed, 17 Feb 2010 17:32:23 -0800
Message-ID: <20100218013223.32075.60686.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63372 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab0BRBbc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:31:32 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, linux-omap@vger.kernel.org

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add timing data for the Numonyx M65KxxxxAM SDRAM chip, used on the
IGEP v2 board.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h |   51 ++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h

diff --git a/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h b/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
new file mode 100644
index 0000000..cd43529
--- /dev/null
+++ b/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
@@ -0,0 +1,51 @@
+/*
+ * SDRC register values for the Numonyx M65KXXXXAM
+ *
+ * Copyright (C) 2009 Integration Software and Electronic Engineering.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_SDRAM_NUMONYX_M65KXXXXAM
+#define __ARCH_ARM_MACH_OMAP2_SDRAM_NUMONYX_M65KXXXXAM
+
+#include <plat/sdrc.h>
+
+/* Numonyx  M65KXXXXAM */
+static struct omap_sdrc_params m65kxxxxam_sdrc_params[] = {
+	[0] = {
+		.rate		= 200000000,
+		.actim_ctrla	= 0xe321d4c6,
+		.actim_ctrlb	= 0x00022328,
+		.rfr_ctrl	= 0x0005e601,
+		.mr		= 0x00000032,
+	},
+	[1] = {
+		.rate		= 166000000,
+		.actim_ctrla	= 0xba9dc485,
+		.actim_ctrlb	= 0x00022321,
+		.rfr_ctrl	= 0x0004dc01,
+		.mr		= 0x00000032,
+	},
+	[2] = {
+		.rate		= 133000000,
+		.actim_ctrla	= 0x9a19b485,
+		.actim_ctrlb	= 0x0002231b,
+		.rfr_ctrl	= 0x0003de01,
+		.mr		= 0x00000032,
+	},
+	[3] = {
+		.rate		= 83000000,
+		.actim_ctrla	= 0x594ca242,
+		.actim_ctrlb	= 0x00022310,
+		.rfr_ctrl	= 0x00025501,
+		.mr		= 0x00000032,
+	},
+	[4] = {
+		.rate			= 0
+	},
+};
+
+#endif

