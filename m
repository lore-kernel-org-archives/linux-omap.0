From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v5 07/15] OMAP2+: UART: Add default mux for all uarts.
Date: Wed, 21 Sep 2011 17:43:24 +0530
Message-ID: <1316607206-21669-5-git-send-email-govindraj.raja@ti.com>
References: <1316607206-21669-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53753 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab1IUMNu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 08:13:50 -0400
In-Reply-To: <1316607206-21669-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Govindraj R <govindraj.raja@ti.com>

Prior to this change rx-pad wakeup was done by writing to rx-pad offset value
populated in serial.c idle_init. Now with mux framework support we can use
mux_utilities along with hmwod framework to handle io-pad configuration and
enable rx-pad wake-up mechanism.

Add default mux data for all uart's if mux info is not passed from
board file to avoid breaking any board support.
With the default pads we have populated wakeup capability for rx pads
which can be used to enable uart_rx io-pad wakeup from hwmod framework.
The pad values in 3430 board file are same as the default pad values
populated in serial.c. Remove pad values from 3430 board file and use
the default pads from serial.c file.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |  100 +------------------
 arch/arm/mach-omap2/serial.c        |  190 +++++++++++++++++++++++------------
 2 files changed, 128 insertions(+), 162 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index bd600cf..b12b38f 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -482,106 +482,8 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-
-static struct omap_device_pad serial1_pads[] __initdata = {
-	/*
-	 * Note that off output enable is an active low
-	 * signal. So setting this means pin is a
-	 * input enabled in off mode
-	 */
-	OMAP_MUX_STATIC("uart1_cts.uart1_cts",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart1_rts.uart1_rts",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart1_rx.uart1_rx",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart1_tx.uart1_tx",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial2_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart2_cts.uart2_cts",
-			 OMAP_PIN_INPUT_PULLUP |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rts.uart2_rts",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rx.uart2_rx",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_tx.uart2_tx",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial3_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart3_cts_rctx.uart3_cts_rctx",
-			 OMAP_PIN_INPUT_PULLDOWN |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rts_sd.uart3_rts_sd",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rx_irrx.uart3_rx_irrx",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-};
-
-static struct omap_board_data serial1_data __initdata = {
-	.id		= 0,
-	.pads		= serial1_pads,
-	.pads_cnt	= ARRAY_SIZE(serial1_pads),
-};
-
-static struct omap_board_data serial2_data __initdata = {
-	.id		= 1,
-	.pads		= serial2_pads,
-	.pads_cnt	= ARRAY_SIZE(serial2_pads),
-};
-
-static struct omap_board_data serial3_data __initdata = {
-	.id		= 2,
-	.pads		= serial3_pads,
-	.pads_cnt	= ARRAY_SIZE(serial3_pads),
-};
-
-static inline void board_serial_init(void)
-{
-	omap_serial_init_port(&serial1_data);
-	omap_serial_init_port(&serial2_data);
-	omap_serial_init_port(&serial3_data);
-}
 #else
 #define board_mux	NULL
-
-static inline void board_serial_init(void)
-{
-	omap_serial_init();
-}
 #endif
 
 /*
@@ -718,7 +620,7 @@ static void __init omap_3430sdp_init(void)
 	else
 		gpio_pendown = SDP3430_TS_GPIO_IRQ_SDPV1;
 	omap_ads7846_init(1, gpio_pendown, 310, NULL);
-	board_serial_init();
+	omap_serial_init();
 	usb_musb_init(NULL);
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index fd0c345..1561140 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -57,11 +57,6 @@
 struct omap_uart_state {
 	int num;
 	int can_sleep;
-
-	void __iomem *wk_st;
-	void __iomem *wk_en;
-	u32 wk_mask;
-	u32 padconf;
 	u32 dma_enabled;
 
 	int clocked;
@@ -326,69 +321,135 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 	uart->can_sleep = 0;
 }
 
-static void omap_uart_idle_init(struct omap_uart_port_info *uart,
-				unsigned short num)
+#ifdef CONFIG_OMAP_MUX
+static struct omap_device_pad default_uart1_pads[] __initdata = {
+	{
+		.name	= "uart1_cts.uart1_cts",
+		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart1_rts.uart1_rts",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart1_tx.uart1_tx",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart1_rx.uart1_rx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+		.idle	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad default_uart2_pads[] __initdata = {
+	{
+		.name	= "uart2_cts.uart2_cts",
+		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart2_rts.uart2_rts",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart2_tx.uart2_tx",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart2_rx.uart2_rx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+		.idle	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad default_uart3_pads[] __initdata = {
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
+static struct omap_device_pad default_omap36xx_uart4_pads[] __initdata = {
+	{
+		.name   = "gpmc_wait2.uart4_tx",
+		.enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "gpmc_wait3.uart4_rx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_PIN_INPUT | OMAP_MUX_MODE2,
+		.idle	= OMAP_PIN_INPUT | OMAP_MUX_MODE2,
+	},
+};
+
+static struct omap_device_pad default_omap4_uart4_pads[] __initdata = {
+	{
+		.name	= "uart4_tx.uart4_tx",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart4_rx.uart4_rx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+		.idle	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+	},
+};
+#else
+static struct omap_device_pad default_uart1_pads[] __initdata = {};
+static struct omap_device_pad default_uart2_pads[] __initdata = {};
+static struct omap_device_pad default_uart3_pads[] __initdata = {};
+static struct omap_device_pad default_omap36xx_uart4_pads[] __initdata = {};
+static struct omap_device_pad default_omap4_uart4_pads[] __initdata = {};
+#endif
+
+static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
 {
-	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
-		u32 mod = (num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
-		u32 wk_mask = 0;
-		u32 padconf = 0;
-
-		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
-		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
-		switch (num) {
-		case 0:
-			wk_mask = OMAP3430_ST_UART1_MASK;
-			padconf = 0x182;
-			break;
-		case 1:
-			wk_mask = OMAP3430_ST_UART2_MASK;
-			padconf = 0x17a;
-			break;
-		case 2:
-			wk_mask = OMAP3430_ST_UART3_MASK;
-			padconf = 0x19e;
-			break;
-		case 3:
-			wk_mask = OMAP3630_ST_UART4_MASK;
-			padconf = 0x0d2;
-			break;
-		}
-		uart->wk_mask = wk_mask;
-	} else if (cpu_is_omap24xx()) {
-		u32 wk_mask = 0;
-		u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
-
-		switch (num) {
-		case 0:
-			wk_mask = OMAP24XX_ST_UART1_MASK;
-			break;
-		case 1:
-			wk_mask = OMAP24XX_ST_UART2_MASK;
-			break;
-		case 2:
-			wk_en = OMAP24XX_PM_WKEN2;
-			wk_st = OMAP24XX_PM_WKST2;
-			wk_mask = OMAP24XX_ST_UART3_MASK;
-			break;
-		}
-		uart->wk_mask = wk_mask;
-		if (cpu_is_omap2430()) {
-			uart->wk_en = OMAP2430_PRM_REGADDR(CORE_MOD, wk_en);
-			uart->wk_st = OMAP2430_PRM_REGADDR(CORE_MOD, wk_st);
-		} else if (cpu_is_omap2420()) {
-			uart->wk_en = OMAP2420_PRM_REGADDR(CORE_MOD, wk_en);
-			uart->wk_st = OMAP2420_PRM_REGADDR(CORE_MOD, wk_st);
+	switch (bdata->id) {
+	case 0:
+		bdata->pads = default_uart1_pads;
+		bdata->pads_cnt = ARRAY_SIZE(default_uart1_pads);
+		break;
+	case 1:
+		bdata->pads = default_uart2_pads;
+		bdata->pads_cnt = ARRAY_SIZE(default_uart2_pads);
+		break;
+	case 2:
+		bdata->pads = default_uart3_pads;
+		bdata->pads_cnt = ARRAY_SIZE(default_uart3_pads);
+		break;
+	case 3:
+		if (cpu_is_omap44xx()) {
+			bdata->pads = default_omap4_uart4_pads;
+			bdata->pads_cnt =
+				ARRAY_SIZE(default_omap4_uart4_pads);
+		} else {
+			bdata->pads = default_omap36xx_uart4_pads;
+			bdata->pads_cnt =
+				ARRAY_SIZE(default_omap36xx_uart4_pads);
 		}
-	} else {
-		uart->wk_en = NULL;
-		uart->wk_st = NULL;
-		uart->wk_mask = 0;
+		break;
+	default:
+		break;
 	}
 }
 
 #else
-static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
 {
 	/* Needed to enable UART clocks when built without CONFIG_PM */
@@ -473,7 +534,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	}
 
 	pdata_size = sizeof(struct omap_uart_port_info);
-	omap_uart_idle_init(pdata, bdata->id);
 
 	pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
 	pdata->flags = UPF_BOOT_AUTOCONF;
@@ -528,6 +588,10 @@ void __init omap_serial_init(void)
 		bdata.flags = 0;
 		bdata.pads = NULL;
 		bdata.pads_cnt = 0;
+
+		if (cpu_is_omap44xx() || cpu_is_omap34xx())
+			omap_serial_fill_default_pads(&bdata);
+
 		omap_serial_init_port(&bdata);
 
 	}
-- 
1.7.4.1

