From: sricharan <r.sricharan@ti.com>
Subject: [PATCH v3 4/5] omap4: board-omap4panda: Initialise the serial pads.
Date: Tue,  1 Mar 2011 23:47:23 +0530
Message-ID: <1299003443-32192-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48443 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756491Ab1CASQT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 13:16:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, paul@pswan.com, santosh.shilimkar@ti.com

Use the mux framework to initialise the serial pads.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
v1: Initial patch
v2: Remove flags that were to be used for only testing.
v3: Add dummy initialisation for uart0.

 arch/arm/mach-omap2/board-omap4panda.c |   80 +++++++++++++++++++++++++++++++-
 1 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 3dd241b..0794d3c 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -452,8 +452,86 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP4_MUX(SDMMC5_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+
+
+static struct omap_device_pad serial2_pads[] __initdata = {
+	{ .name   = "uart2_cts.uart2_cts",
+	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart2_rts.uart2_rts",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart2_rx.uart2_rx",
+	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart2_tx.uart2_tx",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad serial3_pads[] __initdata = {
+	{ .name   = "uart3_cts_rctx.uart3_cts_rctx",
+	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart3_rts_sd.uart3_rts_sd",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart3_rx_irrx.uart3_rx_irrx",
+	  .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart3_tx_irtx.uart3_tx_irtx",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad serial4_pads[] __initdata = {
+	{ .name   = "uart4_rx.uart4_rx",
+	.enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart4_tx.uart4_tx",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_board_data serial2_data = {
+	.id             = 1,
+	.pads           = serial2_pads,
+	.pads_cnt       = ARRAY_SIZE(serial2_pads),
+};
+
+static struct omap_board_data serial3_data = {
+	.id             = 2,
+	.pads           = serial3_pads,
+	.pads_cnt       = ARRAY_SIZE(serial3_pads),
+};
+
+static struct omap_board_data serial4_data = {
+	.id             = 3,
+	.pads           = serial4_pads,
+	.pads_cnt       = ARRAY_SIZE(serial4_pads),
+};
+
+static inline void board_serial_init(void)
+{
+	struct omap_board_data bdata;
+	bdata.flags     = 0;
+	bdata.pads      = NULL;
+	bdata.pads_cnt  = 0;
+	bdata.id        = 0;
+	/* pass dummy data for UART1 */
+	omap_serial_init_port(&bdata);
+
+	omap_serial_init_port(&serial2_data);
+	omap_serial_init_port(&serial3_data);
+	omap_serial_init_port(&serial4_data);
+}
 #else
 #define board_mux	NULL
+
+static inline void board_serial_init(void)
+{
+	omap_serial_init();
+}
 #endif
 
 static void __init omap4_panda_init(void)
@@ -470,7 +548,7 @@ static void __init omap4_panda_init(void)
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	platform_device_register(&omap_vwlan_device);
-	omap_serial_init();
+	board_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
 	omap4_ehci_init();
 	usb_musb_init(&musb_board_data);
-- 
1.7.0.4

