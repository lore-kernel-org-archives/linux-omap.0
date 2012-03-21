From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default pads
Date: Wed, 21 Mar 2012 15:32:29 +0530
Message-ID: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48847 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168Ab2CUKEG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 06:04:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

The following commit:
(7496ba3  ARM: OMAP2+: UART: Add default mux for all uarts)
added default pads for all uarts. But not all boards tend to
use all uarts and most of unused uart pins are muxed for
other purpose. This commit breaks the modules which where trying
to use unused uart pins on their boards.

So remove all default pads except uart1/3 as most boards
tend to use either uart1/3 as console port and use only tx/rx
lines, declare only those pads for uart1/3.
If any boards tend to use any other uart other uart1/3
the mux data should to passed from board file and init individual
uart port using omap_serial_init_port api.

These pads are needed not only for muxing but are also used to specify
pad wakeup capability for console uart, prior to commit specified we used
to do raw_write to mux pin to enable wakeup capability to uart1/2/3 now
with runtime changes we are using the hwmod/mux framework.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
Based on Linux 3.3
Tested on Beagle XM and Zoom3 board.

 arch/arm/mach-omap2/serial.c |   78 ------------------------------------------
 1 files changed, 0 insertions(+), 78 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 83ab5a2..4dccf14 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -124,14 +124,6 @@ static void omap_uart_set_smartidle(struct platform_device *pdev) {}
 #ifdef CONFIG_OMAP_MUX
 static struct omap_device_pad default_uart1_pads[] __initdata = {
 	{
-		.name	= "uart1_cts.uart1_cts",
-		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart1_rts.uart1_rts",
-		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
 		.name	= "uart1_tx.uart1_tx",
 		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
 	},
@@ -143,37 +135,8 @@ static struct omap_device_pad default_uart1_pads[] __initdata = {
 	},
 };
 
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
 static struct omap_device_pad default_uart3_pads[] __initdata = {
 	{
-		.name	= "uart3_cts_rctx.uart3_cts_rctx",
-		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-	{
-		.name	= "uart3_rts_sd.uart3_rts_sd",
-		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
 		.name	= "uart3_tx_irtx.uart3_tx_irtx",
 		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
 	},
@@ -185,32 +148,6 @@ static struct omap_device_pad default_uart3_pads[] __initdata = {
 	},
 };
 
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
 	switch (bdata->id) {
@@ -218,25 +155,10 @@ static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
 		bdata->pads = default_uart1_pads;
 		bdata->pads_cnt = ARRAY_SIZE(default_uart1_pads);
 		break;
-	case 1:
-		bdata->pads = default_uart2_pads;
-		bdata->pads_cnt = ARRAY_SIZE(default_uart2_pads);
-		break;
 	case 2:
 		bdata->pads = default_uart3_pads;
 		bdata->pads_cnt = ARRAY_SIZE(default_uart3_pads);
 		break;
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
 	default:
 		break;
 	}
-- 
1.7.5.4

