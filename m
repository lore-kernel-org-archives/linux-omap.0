From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 05/11] OMAP2+: Serial: Add default mux for all uarts.
Date: Wed, 7 Sep 2011 18:23:27 +0530
Message-ID: <1315400013-4849-6-git-send-email-govindraj.raja@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add default mux data for all uart's if mux info is not passed from
board file to avoid breaking any board support.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |  132 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 132 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index e732d6c..2e10357 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -62,6 +62,134 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
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
@@ -221,6 +349,10 @@ void __init omap_serial_init(void)
 		bdata.flags = 0;
 		bdata.pads = NULL;
 		bdata.pads_cnt = 0;
+
+		if (cpu_is_omap44xx() || cpu_is_omap34xx())
+			omap_serial_fill_default_pads(&bdata);
+
 		omap_serial_init_port(&bdata);
 	}
 }
-- 
1.7.4.1
