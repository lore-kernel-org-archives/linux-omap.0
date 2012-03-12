From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/5] ARM: OMAP2+: add includes for missing prototypes
Date: Mon, 12 Mar 2012 16:42:53 -0600
Message-ID: <20120312224252.4103.75837.stgit@dusk>
References: <20120312224006.4103.29464.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37687 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757604Ab2CLWnk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 18:43:40 -0400
In-Reply-To: <20120312224006.4103.29464.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Several C files in arch/arm/mach-omap2 declare functions that are used
by other files, but don't include the header file where the prototype is
declared.  This results in the following warnings from sparse:

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

Fix by including the appropriate header files.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/board-zoom-display.c |    1 +
 arch/arm/mach-omap2/irq.c                |    1 +
 arch/arm/mach-omap2/omap-secure.c        |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index d4683ba..75ff74e 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -16,6 +16,7 @@
 #include <linux/spi/spi.h>
 #include <plat/mcspi.h>
 #include <video/omapdss.h>
+#include <mach/board-zoom.h>
 
 #define LCD_PANEL_RESET_GPIO_PROD	96
 #define LCD_PANEL_RESET_GPIO_PILOT	55
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 1fef061..8247c51 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -18,6 +18,7 @@
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
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


