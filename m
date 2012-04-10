From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 1/2] OMAP2+: UART: Fix incorrect population of default uart pads
Date: Tue, 10 Apr 2012 19:10:45 +0530
Message-ID: <1334065246-21294-2-git-send-email-govindraj.raja@ti.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43766 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714Ab2DJNlQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 09:41:16 -0400
In-Reply-To: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Russ Dill <russ.dill@gmail.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

The following commit:
(7496ba3  ARM: OMAP2+: UART: Add default mux for all uarts)
added default pads for all uarts. But not all boards tend to
use all uarts and most of unused uart pins are muxed for
other purpose. This commit breaks the modules which where trying
to use unused uart pins on their boards.

So remove the default pads adding.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Russ Dill <russ.dill@gmail.com>
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |  116 ------------------------------------------
 1 files changed, 0 insertions(+), 116 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c9503a7..1554233 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -120,124 +120,8 @@ static void omap_uart_set_smartidle(struct platform_device *pdev) {}
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_OMAP_MUX
-static struct omap_device_pad default_uart1_pads[] __initdata = {
-	{
-		.name	= "uart1_cts.uart1_cts",
-		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart1_rts.uart1_rts",
-		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart1_tx.uart1_tx",
-		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart1_rx.uart1_rx",
-		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-		.idle	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-};
-
-static struct omap_device_pad default_uart2_pads[] __initdata = {
-	{
-		.name	= "uart2_cts.uart2_cts",
-		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart2_rts.uart2_rts",
-		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart2_tx.uart2_tx",
-		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart2_rx.uart2_rx",
-		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-		.idle	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-};
-
-static struct omap_device_pad default_uart3_pads[] __initdata = {
-	{
-		.name	= "uart3_cts_rctx.uart3_cts_rctx",
-		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart3_rts_sd.uart3_rts_sd",
-		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart3_tx_irtx.uart3_tx_irtx",
-		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart3_rx_irrx.uart3_rx_irrx",
-		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
-		.idle	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
-	},
-};
-
-static struct omap_device_pad default_omap36xx_uart4_pads[] __initdata = {
-	{
-		.name   = "gpmc_wait2.uart4_tx",
-		.enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "gpmc_wait3.uart4_rx",
-		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	= OMAP_PIN_INPUT | OMAP_MUX_MODE2,
-		.idle	= OMAP_PIN_INPUT | OMAP_MUX_MODE2,
-	},
-};
-
-static struct omap_device_pad default_omap4_uart4_pads[] __initdata = {
-	{
-		.name	= "uart4_tx.uart4_tx",
-		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart4_rx.uart4_rx",
-		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
-		.idle	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
-	},
-};
-
 static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
 {
-	switch (bdata->id) {
-	case 0:
-		bdata->pads = default_uart1_pads;
-		bdata->pads_cnt = ARRAY_SIZE(default_uart1_pads);
-		break;
-	case 1:
-		bdata->pads = default_uart2_pads;
-		bdata->pads_cnt = ARRAY_SIZE(default_uart2_pads);
-		break;
-	case 2:
-		bdata->pads = default_uart3_pads;
-		bdata->pads_cnt = ARRAY_SIZE(default_uart3_pads);
-		break;
-	case 3:
-		if (cpu_is_omap44xx()) {
-			bdata->pads = default_omap4_uart4_pads;
-			bdata->pads_cnt =
-				ARRAY_SIZE(default_omap4_uart4_pads);
-		} else if (cpu_is_omap3630()) {
-			bdata->pads = default_omap36xx_uart4_pads;
-			bdata->pads_cnt =
-				ARRAY_SIZE(default_omap36xx_uart4_pads);
-		}
-		break;
-	default:
-		break;
-	}
 }
 #else
 static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
-- 
1.7.9

