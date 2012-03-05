From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] omap3_beagle: Init only uart3 used for console
Date: Mon, 5 Mar 2012 16:42:32 +0530
Message-ID: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45391 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085Ab2CELNL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Mar 2012 06:13:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

On beagle some of uart mux lines are used for other
purpose so init only uart3.

Uart2 rx line clashes with gpio_147 used for usb ehci
phy reset. Initializing uart2 pad_mux lines can break
ehci module on beagle xm.
(gpio_147 is available on uart2_rx in mode4 reference 
mux34xx.c -> uart2_rx.gpio_147)

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   50 ++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 817be06..a2e0052 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -493,6 +493,54 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+
+static struct omap_device_pad uart3_pads[] __initdata = {
+	{
+		.name	= "uart3_cts_rctx.uart3_cts_rctx",
+		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart3_rts_sd.uart3_rts_sd",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart3_tx_irtx.uart3_tx_irtx",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart3_rx_irrx.uart3_rx_irrx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+		.idle	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static inline void board_serial_init(void)
+{
+	struct omap_board_data uart3_bdata;
+	uart3_bdata.flags     = 0;
+	uart3_bdata.pads      = uart3_pads;
+	uart3_bdata.pads_cnt  = ARRAY_SIZE(uart3_pads);
+	uart3_bdata.id        = 2;
+
+	/*
+	 * Init only uart3 used as console
+	 * don't init other uarts as uart mux lines
+	 * might be used for other purpose on beagle board
+	 * ex: uart2_rx used by gpio_147 for usb_ehci phy reset.
+	 */
+	omap_serial_init_port(&uart3_bdata, NULL);
+}
+#else
+
+/*
+ * If mux is disabled from kernel probably we
+ * are relying on boot-loaders so we init all uarts
+ */
+static inline void board_serial_init(void)
+{
+	omap_serial_init();
+}
 #endif
 
 static void __init beagle_opp_init(void)
@@ -549,7 +597,7 @@ static void __init omap3_beagle_init(void)
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_display_init(&beagle_dss_data);
-	omap_serial_init();
+	board_serial_init();
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
 
-- 
1.7.5.4

