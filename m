From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH v2] ARM: OMAP3: cm-t3517: add MMC support
Date: Fri,  7 Dec 2012 11:05:55 +0200
Message-ID: <1354871155-32528-1-git-send-email-grinberg@compulab.co.il>
References: <1354795206-12048-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:39109 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891Ab2LGJGE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Dec 2012 04:06:04 -0500
In-Reply-To: <1354795206-12048-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

cm-t3517 uses two MMC interfaces. Add support for both.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
v2: Use CONFIG_MMC_OMAP_HS instead of plain CONFIG_MMC, so it will be stubbed
    out with the same defines as omap_hsmmc_init() function.
    Fix the !CONFIG_MMC_OMAP_HS case.

 arch/arm/mach-omap2/board-cm-t3517.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index ebbc2ad..792d684 100644
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
@@ -121,6 +123,26 @@ static void cm_t3517_init_hecc(void)
 static inline void cm_t3517_init_hecc(void) {}
 #endif
 
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+static struct omap2_hsmmc_info cm_t3517_mmc[] = {
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
+#else
+#define cm_t3517_mmc NULL
+#endif
+
 #if defined(CONFIG_RTC_DRV_V3020) || defined(CONFIG_RTC_DRV_V3020_MODULE)
 #define RTC_IO_GPIO		(153)
 #define RTC_WR_GPIO		(154)
@@ -271,6 +293,10 @@ static struct omap_board_mux board_mux[] __initdata = {
 	/* CM-T3517 USB HUB nRESET */
 	OMAP3_MUX(MCBSP4_CLKX, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
 
+	/* CD - GPIO144 and WP - GPIO59 for MMC1 - SB-T35 */
+	OMAP3_MUX(UART2_CTS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(GPMC_CLK, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #endif
@@ -286,6 +312,7 @@ static void __init cm_t3517_init(void)
 	cm_t3517_init_usbh();
 	cm_t3517_init_hecc();
 	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);
+	omap_hsmmc_init(cm_t3517_mmc);
 }
 
 MACHINE_START(CM_T3517, "Compulab CM-T3517")
-- 
1.7.3.4

