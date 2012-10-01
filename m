From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 6/7] ARM: OMAP2+: Move omap_reserve() locally to mach-omap2
Date: Tue, 2 Oct 2012 00:17:05 +0530
Message-ID: <1349117226-4980-7-git-send-email-lokeshvutla@ti.com>
References: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37043 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab2JASro (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 14:47:44 -0400
In-Reply-To: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, lokeshvutla@ti.com

omap_reserve() callback is defned only for mach-omap2.
So, moving definition of omap_reserve() to mach-omap2.
This helps is moving plat/omap_secure.h local to
mach-omap2

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/common.c             |   20 ++++++++++++++++++++
 arch/arm/mach-omap2/common.h             |    1 +
 arch/arm/plat-omap/common.c              |   21 ---------------------
 arch/arm/plat-omap/include/plat/common.h |    1 -
 4 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 17950c6..4ce0d63 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -16,8 +16,11 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/platform_data/dsp-omap.h>
 
 #include <plat/clock.h>
+#include <plat/omap-secure.h>
+#include <plat/vram.h>
 
 #include "soc.h"
 #include "iomap.h"
@@ -200,3 +203,20 @@ void __init omap5_map_io(void)
 	omap5_map_common_io();
 }
 #endif
+
+/*
+ * Stub function for OMAP2 so that common files
+ * continue to build when custom builds are used
+ */
+int __weak omap_secure_ram_reserve_memblock(void)
+{
+	return 0;
+}
+
+void __init omap_reserve(void)
+{
+	omap_vram_reserve_sdram_memblock();
+	omap_dsp_reserve_sdram_memblock();
+	omap_secure_ram_reserve_memblock();
+	omap_barrier_reserve_memblock();
+}
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 7045e4d..e84c589 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -338,6 +338,7 @@ extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1);
 struct omap2_hsmmc_info;
 extern int omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers);
+extern void omap_reserve(void);
 
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index b388e87..aa23d49 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -17,32 +17,11 @@
 #include <linux/dma-mapping.h>
 
 #include <plat/common.h>
-#include <plat/vram.h>
-#include <linux/platform_data/dsp-omap.h>
 #include <plat-omap/dma-omap.h>
 
-#include <plat/omap-secure.h>
-
-void __init omap_reserve(void)
-{
-	omap_vram_reserve_sdram_memblock();
-	omap_dsp_reserve_sdram_memblock();
-	omap_secure_ram_reserve_memblock();
-	omap_barrier_reserve_memblock();
-}
-
 void __init omap_init_consistent_dma_size(void)
 {
 #ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
 	init_consistent_dma_size(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE << 20);
 #endif
 }
-
-/*
- * Stub function for OMAP2 so that common files
- * continue to build when custom builds are used
- */
-int __weak omap_secure_ram_reserve_memblock(void)
-{
-	return 0;
-}
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index d1cb6f5..cb337c3 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -34,7 +34,6 @@ extern int __init omap_init_clocksource_32k(void __iomem *vbase);
 
 extern void __init omap_check_revision(void);
 
-extern void omap_reserve(void);
 extern int omap_dss_reset(struct omap_hwmod *);
 
 void omap_sram_init(void);
-- 
1.7.10.4

