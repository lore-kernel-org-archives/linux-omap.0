From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 4/4] ARM: OMAP: Move plat/omap-secure.h locally to mach-omap2
Date: Fri, 28 Sep 2012 19:10:09 +0530
Message-ID: <1348839609-10456-5-git-send-email-lokeshvutla@ti.com>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38154 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757026Ab2I1NkW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Sep 2012 09:40:22 -0400
In-Reply-To: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, lokeshvutla@ti.com

Moving plat/omap-secure.h locally to mach-oamp2/
as part of single zImage work

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/common.c                  |    2 +-
 arch/arm/mach-omap2/omap-secure.c             |    1 -
 arch/arm/mach-omap2/omap-secure.h             |    7 +++++++
 arch/arm/mach-omap2/omap4-common.c            |    2 +-
 arch/arm/plat-omap/common.c                   |    2 --
 arch/arm/plat-omap/include/plat/omap-secure.h |   14 --------------
 6 files changed, 9 insertions(+), 19 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/omap-secure.h

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 4ce0d63..b0f21b7 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -19,7 +19,6 @@
 #include <linux/platform_data/dsp-omap.h>
 
 #include <plat/clock.h>
-#include <plat/omap-secure.h>
 #include <plat/vram.h>
 
 #include "soc.h"
@@ -27,6 +26,7 @@
 #include "common.h"
 #include "sdrc.h"
 #include "control.h"
+#include "omap-secure.h"
 
 /* Global address base setup code */
 
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index a004cb9..98624fe 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -18,7 +18,6 @@
 #include <asm/cacheflush.h>
 #include <asm/memblock.h>
 
-#include <plat/omap-secure.h>
 #include "omap-secure.h"
 
 static phys_addr_t omap_secure_memblock_base;
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index c90a435..0e72917 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -52,6 +52,13 @@ extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
 				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
 extern phys_addr_t omap_secure_ram_mempool_base(void);
+extern int omap_secure_ram_reserve_memblock(void);
 
+#ifdef CONFIG_OMAP4_ERRATA_I688
+extern int omap_barrier_reserve_memblock(void);
+#else
+static inline void omap_barrier_reserve_memblock(void)
+{ }
+#endif
 #endif /* __ASSEMBLER__ */
 #endif /* OMAP_ARCH_OMAP_SECURE_H */
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index e1f2897..ae57b63 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -26,7 +26,6 @@
 #include <asm/memblock.h>
 
 #include <plat/sram.h>
-#include <plat/omap-secure.h>
 #include <plat/mmc.h>
 
 #include "omap-wakeupgen.h"
@@ -35,6 +34,7 @@
 #include "common.h"
 #include "hsmmc.h"
 #include "omap4-sar-layout.h"
+#include "omap-secure.h"
 
 #ifdef CONFIG_CACHE_L2X0
 static void __iomem *l2cache_base;
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 8cd5c46..6fdb8ff 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -21,8 +21,6 @@
 #include <plat/vram.h>
 #include <linux/platform_data/dsp-omap.h>
 
-#include <plat/omap-secure.h>
-
 void __init omap_init_consistent_dma_size(void)
 {
 #ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
diff --git a/arch/arm/plat-omap/include/plat/omap-secure.h b/arch/arm/plat-omap/include/plat/omap-secure.h
deleted file mode 100644
index 0e4acd2..0000000
-- 
1.7.10.4

