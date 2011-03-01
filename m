From: sricharan <r.sricharan@ti.com>
Subject: [PATCH v3 2/5] omap4: board-4430sdp: Initialise the serial pads.
Date: Tue,  1 Mar 2011 23:46:45 +0530
Message-ID: <1299003405-32158-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58535 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab1CASPn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 13:15:43 -0500
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

 arch/arm/mach-omap2/board-4430sdp.c |   81 ++++++++++++++++++++++++++++++++++-
 1 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1a943be..6e8b0ff 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -627,9 +627,86 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
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
+	  .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+	},
+	{ .name   = "uart4_tx.uart4_tx",
+	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_board_data serial2_data = {
+	.id		= 1,
+	.pads		= serial2_pads,
+	.pads_cnt	= ARRAY_SIZE(serial2_pads),
+};
+
+static struct omap_board_data serial3_data = {
+	.id		= 2,
+	.pads		= serial3_pads,
+	.pads_cnt	= ARRAY_SIZE(serial3_pads),
+};
+
+static struct omap_board_data serial4_data = {
+	.id		= 3,
+	.pads		= serial4_pads,
+	.pads_cnt	= ARRAY_SIZE(serial4_pads),
+};
+
+static inline void board_serial_init(void)
+{
+	struct omap_board_data bdata;
+	bdata.flags	= 0;
+	bdata.pads	= NULL;
+	bdata.pads_cnt	= 0;
+	bdata.id	= 0;
+	/* pass dummy data for UART1 */
+	omap_serial_init_port(&bdata);
+
+	omap_serial_init_port(&serial2_data);
+	omap_serial_init_port(&serial3_data);
+	omap_serial_init_port(&serial4_data);
+}
 #else
 #define board_mux	NULL
-#endif
+
+static inline void board_serial_init(void)
+{
+	omap_serial_init();
+}
+ #endif
 
 static void __init omap_4430sdp_init(void)
 {
@@ -643,7 +720,7 @@ static void __init omap_4430sdp_init(void)
 	omap4_i2c_init();
 	omap_sfh7741prox_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
-	omap_serial_init();
+	board_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
 
 	usb_musb_init(&musb_board_data);
-- 
1.7.0.4

