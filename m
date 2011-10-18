From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v7 04/21] OMAP2+: UART: Add default mux for all uarts.
Date: Tue, 18 Oct 2011 20:55:59 +0530
Message-ID: <1318951576-10165-5-git-send-email-govindraj.raja@ti.com>
References: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47908 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932495Ab1JRP0z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Oct 2011 11:26:55 -0400
In-Reply-To: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

Padconf wakeup is used to wakeup uart after uart fclks/iclks are gated.
Rx-Pad wakeup was done by writing to rx-pad offset value populated in
serial.c idle_init. Remove the direct reading and writing into rx pad.
Remove the padconf field part of omap_uart_state struct and pad offsets
populated.

Now with mux framework support we can use mux_utilities
along with hmwod framework to handle io-pad configuration and enable rx-pad
wake-up mechanism.

To avoid breaking any board support add default mux data for all uart's
if mux info is not passed from board file.
With the default pads populated in serial.c wakeup capability for
rx pads is set, this can be used to enable uart_rx io-pad wakeup from
hwmod framework. The pad values in 3430sdp/4430sdp/omap4panda board file
are same as the default pad values populated in serial.c. Remove pad values
from 3430sdp/4430sdp/omap4panda board file and use the default pads
from serial.c file.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c    |  100 +--------------------
 arch/arm/mach-omap2/board-4430sdp.c    |   68 +--------------
 arch/arm/mach-omap2/board-omap4panda.c |   68 +--------------
 arch/arm/mach-omap2/serial.c           |  155 ++++++++++++++++++++++++++-----
 4 files changed, 133 insertions(+), 258 deletions(-)

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
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c7cef44..b80e506 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -688,74 +688,8 @@ static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 
-static struct omap_device_pad serial2_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart2_cts.uart2_cts",
-			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rts.uart2_rts",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rx.uart2_rx",
-			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_tx.uart2_tx",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial3_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart3_cts_rctx.uart3_cts_rctx",
-			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rts_sd.uart3_rts_sd",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rx_irrx.uart3_rx_irrx",
-			 OMAP_PIN_INPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial4_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart4_rx.uart4_rx",
-			 OMAP_PIN_INPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart4_tx.uart4_tx",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
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
-static struct omap_board_data serial4_data __initdata = {
-	.id		= 3,
-	.pads		= serial4_pads,
-	.pads_cnt	= ARRAY_SIZE(serial4_pads),
-};
-
-static inline void board_serial_init(void)
-{
-	struct omap_board_data bdata;
-	bdata.flags	= 0;
-	bdata.pads	= NULL;
-	bdata.pads_cnt	= 0;
-	bdata.id	= 0;
-	/* pass dummy data for UART1 */
-	omap_serial_init_port(&bdata);
-
-	omap_serial_init_port(&serial2_data);
-	omap_serial_init_port(&serial3_data);
-	omap_serial_init_port(&serial4_data);
-}
 #else
 #define board_mux	NULL
-
-static inline void board_serial_init(void)
-{
-	omap_serial_init();
-}
  #endif
 
 static void omap4_sdp4430_wifi_mux_init(void)
@@ -808,7 +742,7 @@ static void __init omap_4430sdp_init(void)
 	omap4_i2c_init();
 	omap_sfh7741prox_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
-	board_serial_init();
+	omap_serial_init();
 	omap4_sdp4430_wifi_init();
 	omap4_twl6030_hsmmc_init(mmc);
 
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9aaa960..1410312 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -370,74 +370,8 @@ static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 
-static struct omap_device_pad serial2_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart2_cts.uart2_cts",
-			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rts.uart2_rts",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rx.uart2_rx",
-			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_tx.uart2_tx",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial3_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart3_cts_rctx.uart3_cts_rctx",
-			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rts_sd.uart3_rts_sd",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rx_irrx.uart3_rx_irrx",
-			 OMAP_PIN_INPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial4_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart4_rx.uart4_rx",
-			 OMAP_PIN_INPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart4_tx.uart4_tx",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-};
-
-static struct omap_board_data serial2_data __initdata = {
-	.id             = 1,
-	.pads           = serial2_pads,
-	.pads_cnt       = ARRAY_SIZE(serial2_pads),
-};
-
-static struct omap_board_data serial3_data __initdata = {
-	.id             = 2,
-	.pads           = serial3_pads,
-	.pads_cnt       = ARRAY_SIZE(serial3_pads),
-};
-
-static struct omap_board_data serial4_data __initdata = {
-	.id             = 3,
-	.pads           = serial4_pads,
-	.pads_cnt       = ARRAY_SIZE(serial4_pads),
-};
-
-static inline void board_serial_init(void)
-{
-	struct omap_board_data bdata;
-	bdata.flags     = 0;
-	bdata.pads      = NULL;
-	bdata.pads_cnt  = 0;
-	bdata.id        = 0;
-	/* pass dummy data for UART1 */
-	omap_serial_init_port(&bdata);
-
-	omap_serial_init_port(&serial2_data);
-	omap_serial_init_port(&serial3_data);
-	omap_serial_init_port(&serial4_data);
-}
 #else
 #define board_mux	NULL
-
-static inline void board_serial_init(void)
-{
-	omap_serial_init();
-}
 #endif
 
 /* Display DVI */
@@ -568,7 +502,7 @@ static void __init omap4_panda_init(void)
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	platform_device_register(&omap_vwlan_device);
-	board_serial_init();
+	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
 	omap4_ehci_init();
 	usb_musb_init(&musb_board_data);
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 5632de5..6d3e228 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -62,7 +62,6 @@ struct omap_uart_state {
 	void __iomem *wk_st;
 	void __iomem *wk_en;
 	u32 wk_mask;
-	u32 padconf;
 	u32 dma_enabled;
 
 	int clocked;
@@ -294,13 +293,6 @@ static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
 		v |= uart->wk_mask;
 		__raw_writel(v, uart->wk_en);
 	}
-
-	/* Ensure IOPAD wake-enables are set */
-	if (cpu_is_omap34xx() && uart->padconf) {
-		u16 v = omap_ctrl_readw(uart->padconf);
-		v |= OMAP3_PADCONF_WAKEUPENABLE0;
-		omap_ctrl_writew(v, uart->padconf);
-	}
 }
 
 static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
@@ -311,13 +303,6 @@ static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
 		v &= ~uart->wk_mask;
 		__raw_writel(v, uart->wk_en);
 	}
-
-	/* Ensure IOPAD wake-enables are cleared */
-	if (cpu_is_omap34xx() && uart->padconf) {
-		u16 v = omap_ctrl_readw(uart->padconf);
-		v &= ~OMAP3_PADCONF_WAKEUPENABLE0;
-		omap_ctrl_writew(v, uart->padconf);
-	}
 }
 
 static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
@@ -380,7 +365,6 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
 		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
 		u32 wk_mask = 0;
-		u32 padconf = 0;
 
 		/* XXX These PRM accesses do not belong here */
 		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
@@ -388,23 +372,18 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		switch (uart->num) {
 		case 0:
 			wk_mask = OMAP3430_ST_UART1_MASK;
-			padconf = 0x182;
 			break;
 		case 1:
 			wk_mask = OMAP3430_ST_UART2_MASK;
-			padconf = 0x17a;
 			break;
 		case 2:
 			wk_mask = OMAP3430_ST_UART3_MASK;
-			padconf = 0x19e;
 			break;
 		case 3:
 			wk_mask = OMAP3630_ST_UART4_MASK;
-			padconf = 0x0d2;
 			break;
 		}
 		uart->wk_mask = wk_mask;
-		uart->padconf = padconf;
 	} else if (cpu_is_omap24xx()) {
 		u32 wk_mask = 0;
 		u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
@@ -434,12 +413,10 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->wk_en = NULL;
 		uart->wk_st = NULL;
 		uart->wk_mask = 0;
-		uart->padconf = 0;
 	}
 }
 
 #else
-static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
 {
 	/* Needed to enable UART clocks when built without CONFIG_PM */
@@ -447,6 +424,130 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 }
 #endif /* CONFIG_PM */
 
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
+
+static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
+{
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
+		}
+		break;
+	default:
+		break;
+	}
+}
+#else
+static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
+#endif
+
 static int __init omap_serial_early_init(void)
 {
 	int i = 0;
@@ -570,8 +671,8 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_uart_block_sleep(uart);
 	console_unlock();
 
-	if ((cpu_is_omap34xx() && uart->padconf) ||
-	    (uart->wk_en && uart->wk_mask))
+	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads) ||
+		(pdata->wk_en && pdata->wk_mask))
 		device_init_wakeup(&pdev->dev, true);
 
 	/* Enable the MDR1 errata for OMAP3 */
@@ -596,6 +697,10 @@ void __init omap_serial_init(void)
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

