From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 2/5] omap3: cm-t3517: add support for v3020 rtc.
Date: Thu, 16 Sep 2010 10:54:38 +0200
Message-ID: <1284627281-26059-3-git-send-email-grinberg@compulab.co.il>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:52546 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693Ab0IPIyv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 04:54:51 -0400
In-Reply-To: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t3517.c |   36 ++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 507d2d5..2b41c6d 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
+#include <linux/rtc-v3020.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -69,6 +70,35 @@ static void __init cm_t3517_init_leds(void)
 static inline void cm_t3517_init_leds(void) {}
 #endif
 
+#if defined(CONFIG_RTC_DRV_V3020) || defined(CONFIG_RTC_DRV_V3020_MODULE)
+#define RTC_IO_GPIO		(153)
+#define RTC_WR_GPIO		(154)
+#define RTC_RD_GPIO		(160)
+#define RTC_CS_GPIO		(163)
+
+struct v3020_platform_data cm_t3517_v3020_pdata = {
+	.use_gpio	= 1,
+	.gpio_cs	= RTC_CS_GPIO,
+	.gpio_wr	= RTC_WR_GPIO,
+	.gpio_rd	= RTC_RD_GPIO,
+	.gpio_io	= RTC_IO_GPIO,
+};
+
+static struct platform_device cm_t3517_rtc_device = {
+	.name		= "v3020",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &cm_t3517_v3020_pdata,
+	}
+};
+
+static void __init cm_t3517_init_rtc(void)
+{
+	platform_device_register(&cm_t3517_rtc_device);
+}
+#else
+static inline void cm_t3517_init_rtc(void) {}
+#endif
 
 static struct omap_board_config_kernel cm_t3517_config[] __initdata = {
 };
@@ -86,6 +116,11 @@ static void __init cm_t3517_init_irq(void)
 static struct omap_board_mux board_mux[] __initdata = {
 	/* GPIO186 - Green LED */
 	OMAP3_MUX(SYS_CLKOUT2, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
+	/* RTC GPIOs: IO, WR#, RD#, CS# */
+	OMAP3_MUX(MCBSP4_DR, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP4_DX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP_CLKS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+	OMAP3_MUX(UART3_CTS_RCTX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
 
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
@@ -95,6 +130,7 @@ static void __init cm_t3517_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
 	cm_t3517_init_leds();
+	cm_t3517_init_rtc();
 }
 
 MACHINE_START(CM_T3517, "Compulab CM-T3517")
-- 
1.7.1

