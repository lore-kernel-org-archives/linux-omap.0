From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 02/12] ARM: OMAP: add includes for missing prototypes
Date: Tue, 10 Apr 2012 18:35:25 -0600
Message-ID: <20120411003521.27059.7720.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43915 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759892Ab2DKAiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:20 -0400
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Several C files in arch/arm/mach-omap* and arch/arm/plat-omap declare
functions that are used by other files, but don't include the header
file where the prototype is declared.  This results in the following
warnings from sparse:

    arch/arm/mach-omap2/irq.c:114:5: warning: symbol 'omap_irq_pending' was not declared. Should it be static?
    arch/arm/mach-omap2/irq.c:186:13: warning: symbol 'omap2_init_irq' was not declared. Should it be static?
    arch/arm/mach-omap2/irq.c:191:13: warning: symbol 'omap3_init_irq' was not declared. Should it be static?
    arch/arm/mach-omap2/irq.c:196:13: warning: symbol 'ti81xx_init_irq' was not declared. Should it be static?
    arch/arm/mach-omap2/irq.c:233:39: warning: symbol 'omap2_intc_handle_irq' was not declared. Should it be static?
    arch/arm/mach-omap2/irq.c:242:6: warning: symbol 'omap_intc_save_context' was not declared. Should it be static?
    arch/arm/mach-omap2/irq.c:265:6: warning: symbol 'omap_intc_restore_context' was not declared. Should it be static?
    arch/arm/mach-omap2/irq.c:291:6: warning: symbol 'omap3_intc_suspend' was not declared. Should it be static?
    arch/arm/mach-omap2/irq.c:297:6: warning: symbol 'omap3_intc_prepare_idle' was not declared. Should it be static?
    arch/arm/mach-omap2/irq.c:306:6: warning: symbol 'omap3_intc_resume_idle' was not declared. Should it be static?
    arch/arm/mach-omap2/irq.c:312:39: warning: symbol 'omap3_intc_handle_irq' was not declared. Should it be static?
    arch/arm/mach-omap2/omap-secure.c:59:12: warning: symbol 'omap_secure_ram_reserve_memblock' was not declared. Should it be static?
    arch/arm/mach-omap2/board-zoom-display.c:133:13: warning: symbol 'zoom_display_init' was not declared. Should it be static?
    arch/arm/plat-omap/common.c:73:13: warning: symbol 'omap_init_consistent_dma_size' was not declared. Should it be static?
    arch/arm/mach-omap1/irq.c:61:5: warning: symbol 'omap_irq_flags' was not declared. Should it be static?
    arch/arm/mach-omap1/irq.c:179:13: warning: symbol 'omap1_init_irq' was not declared. Should it be static?
    arch/arm/mach-omap1/reset.c:11:6: warning: symbol 'omap1_restart' was not declared. Should it be static?

Fix by including the appropriate header files.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap1/common.h             |    5 ++++-
 arch/arm/mach-omap1/id.c                 |    2 ++
 arch/arm/mach-omap1/io.c                 |    3 +--
 arch/arm/mach-omap1/irq.c                |    2 ++
 arch/arm/mach-omap1/reset.c              |    2 ++
 arch/arm/mach-omap2/board-zoom-display.c |    1 +
 arch/arm/mach-omap2/common.h             |    2 --
 arch/arm/mach-omap2/io.c                 |    1 +
 arch/arm/mach-omap2/irq.c                |    1 +
 arch/arm/mach-omap2/omap-secure.c        |    1 +
 arch/arm/plat-omap/common.c              |    1 +
 arch/arm/plat-omap/include/plat/common.h |    2 ++
 arch/arm/plat-omap/include/plat/dma.h    |    1 +
 13 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index af658ad..ef656ff 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -56,8 +56,11 @@ void omap1_init_early(void);
 void omap1_init_irq(void);
 void omap1_restart(char, const char *);
 
+extern void __init omap_check_revision(void);
+
 extern struct sys_timer omap1_timer;
 extern bool omap_32k_timer_init(void);
-extern void __init omap_init_consistent_dma_size(void);
+
+extern u32 omap_irq_flags;
 
 #endif /* __ARCH_ARM_MACH_OMAP1_COMMON_H */
diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index 2b28e1d..a1b846a 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -21,6 +21,8 @@
 
 #include <mach/hardware.h>
 
+#include "common.h"
+
 #define OMAP_DIE_ID_0		0xfffe1800
 #define OMAP_DIE_ID_1		0xfffe1804
 #define OMAP_PRODUCTION_ID_0	0xfffe2000
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index d969a72..71ce017 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -18,13 +18,12 @@
 
 #include <plat/mux.h>
 #include <plat/tc.h>
+#include <plat/dma.h>
 
 #include "iomap.h"
 #include "common.h"
 #include "clock.h"
 
-extern void omap_check_revision(void);
-
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index 4448114..6995fb6 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -49,6 +49,8 @@
 
 #include <mach/hardware.h>
 
+#include "common.h"
+
 #define IRQ_BANK(irq) ((irq) >> 5)
 #define IRQ_BIT(irq)  ((irq) & 0x1f)
 
diff --git a/arch/arm/mach-omap1/reset.c b/arch/arm/mach-omap1/reset.c
index f255b15..b177091 100644
--- a/arch/arm/mach-omap1/reset.c
+++ b/arch/arm/mach-omap1/reset.c
@@ -8,6 +8,8 @@
 
 #include <mach/hardware.h>
 
+#include "common.h"
+
 void omap1_restart(char mode, const char *cmd)
 {
 	/*
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index a43a765..28187f1 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -16,6 +16,7 @@
 #include <linux/spi/spi.h>
 #include <plat/mcspi.h>
 #include <video/omapdss.h>
+#include <mach/board-zoom.h>
 
 #define LCD_PANEL_RESET_GPIO_PROD	96
 #define LCD_PANEL_RESET_GPIO_PILOT	55
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 57da7f4..0e95efc 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -134,8 +134,6 @@ void omap4_map_io(void);
 void ti81xx_map_io(void);
 void omap_barriers_init(void);
 
-extern void __init omap_init_consistent_dma_size(void);
-
 /**
  * omap_test_timeout - busy-loop, testing a condition
  * @cond: condition to test until it evaluates to true
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 065bd76..2d5a576 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -31,6 +31,7 @@
 #include <plat/omap-pm.h>
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
+#include <plat/dma.h>
 
 #include "iomap.h"
 #include "voltage.h"
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 65f0d257..14fbc78 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -25,6 +25,7 @@
 #include <mach/hardware.h>
 
 #include "iomap.h"
+#include "common.h"
 
 /* selected INTC register offsets */
 
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index d8f8ef4..d9ae4a5 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -18,6 +18,7 @@
 #include <asm/cacheflush.h>
 #include <asm/memblock.h>
 
+#include <plat/omap-secure.h>
 #include <mach/omap-secure.h>
 
 static phys_addr_t omap_secure_memblock_base;
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index f1e46ea..0a9b9a9 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -20,6 +20,7 @@
 #include <plat/board.h>
 #include <plat/vram.h>
 #include <plat/dsp.h>
+#include <plat/dma.h>
 
 #include <plat/omap-secure.h>
 
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index b4d7ec3..a557b84 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -32,6 +32,8 @@
 
 extern int __init omap_init_clocksource_32k(void);
 
+extern void __init omap_check_revision(void);
+
 extern void omap_reserve(void);
 extern int omap_dss_reset(struct omap_hwmod *);
 
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index dc562a5..42afb4c 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -442,6 +442,7 @@ struct omap_system_dma_plat_info {
 	u32 (*dma_read)(int reg, int lch);
 };
 
+extern void __init omap_init_consistent_dma_size(void);
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
 			void (*callback)(int lch, u16 ch_status, void *data),


