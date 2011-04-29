From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2 03/12] OMAP2+: Serial: Add default mux for all uarts.
Date: Fri, 29 Apr 2011 18:09:47 +0530
Message-ID: <1304080796-625-4-git-send-email-govindraj.raja@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Add default mux data for all uarts if mux info is not passed from
board file to avoid breaking any board support.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |  127 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 126 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b16768a..8c1a4c7 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -66,6 +66,129 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
 	},
 };
 
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
+
 static void omap_uart_idle_init(struct omap_uart_port_info *uart,
 				unsigned short num)
 {
@@ -242,6 +365,8 @@ void __init omap_serial_init(void)
 		bdata.flags = 0;
 		bdata.pads = NULL;
 		bdata.pads_cnt = 0;
-		omap_serial_init_port(&bdata);
+
+		if (cpu_is_omap44xx() || cpu_is_omap34xx())
+			omap_serial_fill_default_pads(&bdata);
 	}
 }
-- 
1.7.1

