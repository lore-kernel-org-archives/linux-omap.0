From: sricharan <r.sricharan@ti.com>
Subject: [RFC] omap4: Add board_data and initialise the serial pads
Date: Tue, 18 Jan 2011 20:45:12 +0530
Message-ID: <1295363712-5940-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50393 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab1ARPMv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 10:12:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r.sricharan@ti.com, linux-omap@vger.kernel.org
Cc: tony@atomide.com, paul@pwsan.com, santosh.shilimkar@ti.com

Pass the board specific serial pad mux data
to the platform level init code.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
This is a test patch and not intended for a specific use case.

1) The support to add the pad data to the device hwmod entry and to use
   it to dynamically configure the pads based on the state of the
   hwmod is already present.

2) But using that for pads that requires only  initialisation and not 
   dynamic remux, brings in a overhead to iterate over all the
   hwmod signals of the device for every device enable/idle transitions.

3) To avoid 2) 
        (i)  Initialise the pads that do not require remux by setting
             the pads in board_mux array. But this would make the common
             pads across boards also to be present in the board file, which
             is not favoured.

        (ii) Pass the data to the platform init code. If a pad requires
             remux add it to the hwmod data,Otherwise set the pin mux during
             the init itself.

 arch/arm/mach-omap2/board-4430sdp.c |   73 ++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/serial.c        |   11 ++++-
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1cb208b..a61b59e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -537,8 +537,79 @@ static void __init omap_sfh7741prox_init(void)
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+
+static struct omap_device_pad serial2_pads[] __initdata = {
+	{ .name   = "uart2_cts.uart2_cts",
+	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	  .flags  = OMAP_DEVICE_PAD_REMUX,
+	  .idle   = OMAP_MUX_MODE7,
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
 
 static void __init omap_4430sdp_init(void)
@@ -553,7 +624,7 @@ static void __init omap_4430sdp_init(void)
 	omap4_i2c_init();
 	omap_sfh7741prox_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
-	omap_serial_init();
+	board_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
 	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
 	usb_nop_xceiv_register();
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c645788..a12f3d6 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -711,6 +711,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	struct omap_device *od;
 	void *pdata = NULL;
 	u32 pdata_size = 0;
+	int i;
 	char *name;
 #ifndef CONFIG_SERIAL_OMAP
 	struct plat_serial8250_port ports[2] = {
@@ -802,8 +803,14 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	WARN(IS_ERR(od), "Could not build omap_device for %s: %s.\n",
 	     name, oh->name);
 
-	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
-
+	for (i = 0 ; i < bdata->pads_cnt ; i++) {
+		if ((bdata->pads[i].flags) & (OMAP_DEVICE_PAD_REMUX)) {
+			oh->mux = omap_hwmod_mux_init(&bdata->pads[i] , 1);
+		} else {
+			omap_mux_init_signal(bdata->pads[i].name,
+						bdata->pads[i].enable);
+		}
+	}
 	uart->irq = oh->mpu_irqs[0].irq;
 	uart->regshift = 2;
 	uart->mapbase = oh->slaves[0]->addr->pa_start;
-- 
1.7.0.4

