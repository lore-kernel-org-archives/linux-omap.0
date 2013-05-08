From: Jason Cooper <jason@lakedaemon.net>
Subject: [RFC PATCH 1/3] ARM: omap3: Seagate Wireless Plus board
Date: Wed,  8 May 2013 19:23:32 +0000
Message-ID: <3721abb26b5f3a54d88b4be9578b0c9d88c92ae0.1368038129.git.jason@lakedaemon.net>
References: <cover.1368038129.git.jason@lakedaemon.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57499 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753060Ab3EHTX5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 15:23:57 -0400
In-Reply-To: <cover.1368038129.git.jason@lakedaemon.net>
In-Reply-To: <cover.1368038129.git.jason@lakedaemon.net>
References: <cover.1368038129.git.jason@lakedaemon.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>

Hynix include file copied from vendor supplied source code.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/mach-omap2/board-generic.c                | 26 +++++++++++++++++++
 arch/arm/mach-omap2/sdram-hynix-h8kds0un0mer-4em.h | 30 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 arch/arm/mach-omap2/sdram-hynix-h8kds0un0mer-4em.h

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index e54a480..10b567c 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -21,6 +21,7 @@
 #include "common.h"
 #include "common-board-devices.h"
 #include "dss-common.h"
+#include "sdram-hynix-h8kds0un0mer-4em.h"
 
 #if !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
 #define intc_of_init	NULL
@@ -51,6 +52,13 @@ static void __init omap_generic_init(void)
 		omap_4430sdp_display_init_of();
 }
 
+static void __init seagate_wireless_plus_init(void)
+{
+	omap_sdrc_init(h8kds0un0mer4em_sdrc_params, NULL);
+
+	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
+}
+
 #ifdef CONFIG_SOC_OMAP2420
 static const char *omap242x_boards_compat[] __initdata = {
 	"ti,omap2420",
@@ -90,6 +98,24 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
+static const char *seagate_wireless_plus_compat[] __initdata = {
+	"seagate,wireless-plus",
+	NULL,
+};
+
+DT_MACHINE_START(SEAGATE_WIRELESS_PLUS_DT, "Seagate Wireless Plus (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= omap3430_init_early,
+	.init_irq	= omap_intc_of_init,
+	.handle_irq	= omap3_intc_handle_irq,
+	.init_machine	= seagate_wireless_plus_init,
+	.init_late	= omap3_init_late,
+	.init_time	= omap3_sync32k_timer_init,
+	.dt_compat	= seagate_wireless_plus_compat,
+	.restart	= omap3xxx_restart,
+MACHINE_END
+
 static const char *omap3_boards_compat[] __initdata = {
 	"ti,omap3",
 	NULL,
diff --git a/arch/arm/mach-omap2/sdram-hynix-h8kds0un0mer-4em.h b/arch/arm/mach-omap2/sdram-hynix-h8kds0un0mer-4em.h
new file mode 100644
index 0000000..82b58131
--- /dev/null
+++ b/arch/arm/mach-omap2/sdram-hynix-h8kds0un0mer-4em.h
@@ -0,0 +1,30 @@
+/*
+ * SDRC register values for the Hynix H8KDS0UN0MER-4EM
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_SDRAM_HYNIX_H8KDS0UN0MER4EM
+#define __ARCH_ARM_MACH_OMAP2_SDRAM_HYNIX_H8KDS0UN0MER4EM
+
+#include "sdrc.h"
+
+/* Hynix H8KDS0UN0MER-4EM */
+static struct omap_sdrc_params h8kds0un0mer4em_sdrc_params[] = {
+	[0] = {
+		.rate        = 200000000,
+		.actim_ctrla = 0x92e1c4c6,
+		.actim_ctrlb = 0x0002111c,
+		.rfr_ctrl    = 0x0004dc01,
+		.mr          = 0x00000032,
+	},
+	[1] = {
+		.rate        = 0
+	},
+};
+
+#endif
-- 
1.8.2.1

