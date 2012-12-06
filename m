From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] ARM: OMAP3: cm-t3517: add MMC support
Date: Thu,  6 Dec 2012 14:00:06 +0200
Message-ID: <1354795206-12048-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:36227 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab2LFMAQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Dec 2012 07:00:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

cm-t3517 uses two MMC interfaces. Add support for both.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t3517.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index ebbc2ad..fb1f993 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -32,6 +32,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mmc/host.h>
 #include <linux/can/platform/ti_hecc.h>
 
 #include <asm/mach-types.h>
@@ -46,6 +47,7 @@
 
 #include "mux.h"
 #include "control.h"
+#include "hsmmc.h"
 #include "common-board-devices.h"
 #include "am35xx-emac.h"
 #include "gpmc-nand.h"
@@ -121,6 +123,24 @@ static void cm_t3517_init_hecc(void)
 static inline void cm_t3517_init_hecc(void) {}
 #endif
 
+#if defined(CONFIG_MMC) || defined(CONFIG_MMC_MODULE)
+static struct omap2_hsmmc_info mmc[] = {
+	{
+		.mmc		= 1,
+		.caps		= MMC_CAP_4_BIT_DATA,
+		.gpio_cd	= 144,
+		.gpio_wp	= 59,
+	},
+	{
+		.mmc		= 2,
+		.caps		= MMC_CAP_4_BIT_DATA,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+	},
+	{}	/* Terminator */
+};
+#endif
+
 #if defined(CONFIG_RTC_DRV_V3020) || defined(CONFIG_RTC_DRV_V3020_MODULE)
 #define RTC_IO_GPIO		(153)
 #define RTC_WR_GPIO		(154)
@@ -271,6 +291,10 @@ static struct omap_board_mux board_mux[] __initdata = {
 	/* CM-T3517 USB HUB nRESET */
 	OMAP3_MUX(MCBSP4_CLKX, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
 
+	/* CD - GPIO144 and WP - GPIO59 for MMC1 - SB-T35 */
+	OMAP3_MUX(UART2_CTS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(GPMC_CLK, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #endif
@@ -286,6 +310,7 @@ static void __init cm_t3517_init(void)
 	cm_t3517_init_usbh();
 	cm_t3517_init_hecc();
 	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);
+	omap_hsmmc_init(mmc);
 }
 
 MACHINE_START(CM_T3517, "Compulab CM-T3517")
-- 
1.7.3.4

