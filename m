From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2420: Fix ethernet support for OMAP2420 H4
Date: Tue, 13 Nov 2012 16:02:19 -0600
Message-ID: <1352844140-11103-2-git-send-email-jon-hunter@ti.com>
References: <1352844140-11103-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51847 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab2KMWC2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 17:02:28 -0500
In-Reply-To: <1352844140-11103-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Ethernet is not currently working on the OMAP2420 H4 board. In commit
f604931 (ARM: OMAP: abstract debug card setup (smc, leds)) the function
h4_init_smc91x() that initialised the ethernet controller was renamed to
h4_init_debug() but was never called when initialising the board.

Adding a call to h4_init_debug() fixes ethernet support, however,
instead of using the legacy H4 code migrate the H4 to use the
gpmc_smc91x_init() function instead and remove the legacy H4 code.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/board-h4.c |   80 ++++++++++------------------------------
 1 file changed, 19 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 8d04bf8..2adba9d 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -34,19 +34,16 @@
 #include <plat/menelaus.h>
 #include <plat/dma.h>
 #include <plat/gpmc.h>
-#include "debug-devices.h"
 
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
 
 #include "common.h"
+#include "gpmc-smc91x.h"
 #include "mux.h"
 #include "control.h"
 
 #define H4_FLASH_CS	0
-#define H4_SMC91X_CS	1
-
-#define H4_ETHR_GPIO_IRQ		92
 
 #if defined(CONFIG_KEYBOARD_MATRIX) || defined(CONFIG_KEYBOARD_MATRIX_MODULE)
 static const uint32_t board_matrix_keys[] = {
@@ -250,71 +247,31 @@ static u32 is_gpmc_muxed(void)
 		return 0;
 }
 
-static inline void __init h4_init_debug(void)
-{
-	int eth_cs;
-	unsigned long cs_mem_base;
-	unsigned int muxed, rate;
-	struct clk *gpmc_fck;
-
-	eth_cs	= H4_SMC91X_CS;
+#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
 
-	gpmc_fck = clk_get(NULL, "gpmc_fck");	/* Always on ENABLE_ON_INIT */
-	if (IS_ERR(gpmc_fck)) {
-		WARN_ON(1);
-		return;
-	}
-
-	clk_prepare_enable(gpmc_fck);
-	rate = clk_get_rate(gpmc_fck);
-	clk_disable_unprepare(gpmc_fck);
-	clk_put(gpmc_fck);
+static struct omap_smc91x_platform_data board_smc91x_data = {
+	.cs		= 1,
+	.gpio_irq	= 92,
+	.flags		= GPMC_TIMINGS_SMC91C96 | IORESOURCE_IRQ_LOWLEVEL,
+};
 
+static void __init board_smc91x_init(void)
+{
 	if (is_gpmc_muxed())
-		muxed = 0x200;
-	else
-		muxed = 0;
-
-	/* Make sure CS1 timings are correct */
-	gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG1,
-			  0x00011000 | muxed);
-
-	if (rate >= 160000000) {
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f01);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080803);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1c0b1c0a);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
-	} else if (rate >= 130000000) {
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
-	} else {/* rate = 100000000 */
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x031A1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000003C2);
-	}
-
-	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
-		goto out;
-	}
+		board_smc91x_data.flags |= GPMC_MUX_ADD_DATA;
 
-	udelay(100);
+	omap_mux_init_gpio(board_smc91x_data.gpio_irq, OMAP_PIN_INPUT);
+	gpmc_smc91x_init(&board_smc91x_data);
+}
 
-	omap_mux_init_gpio(92, 0);
-	if (debug_card_init(cs_mem_base, H4_ETHR_GPIO_IRQ) < 0)
-		gpmc_cs_free(eth_cs);
+#else
 
-out:
-	clk_disable_unprepare(gpmc_fck);
-	clk_put(gpmc_fck);
+static inline void board_smc91x_init(void)
+{
 }
 
+#endif
+
 static void __init h4_init_flash(void)
 {
 	unsigned long base;
@@ -371,6 +328,7 @@ static void __init omap_h4_init(void)
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	h4_init_flash();
+	board_smc91x_init();
 
 	omap_display_init(&h4_dss_data);
 }
-- 
1.7.9.5

