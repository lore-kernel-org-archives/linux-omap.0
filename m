From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/10] OMAP4: Ethernet: KS8851 Board Support
Date: Fri, 14 May 2010 14:28:03 -0700
Message-ID: <20100514212802.25599.61150.stgit@baageli.muru.com>
References: <20100514212506.25599.98073.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56489 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab0ENV2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 17:28:03 -0400
In-Reply-To: <20100514212506.25599.98073.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Abraham Arce <x0066660@ti.com>

From: Abraham Arce <x0066660@ti.com>

Enable Micrel KS8851 SPI network chip for OMAP4430

Signed-off-by: Abraham Arce <x0066660@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   81 +++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b88f28c..be7a786 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
+#include <linux/spi/spi.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -32,6 +33,75 @@
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 
+#define ETH_KS8851_IRQ			34
+#define ETH_KS8851_POWER_ON		48
+#define ETH_KS8851_QUART		138
+
+static struct spi_board_info sdp4430_spi_board_info[] __initdata = {
+	{
+		.modalias               = "ks8851",
+		.bus_num                = 1,
+		.chip_select            = 0,
+		.max_speed_hz           = 24000000,
+		.irq                    = ETH_KS8851_IRQ,
+	},
+};
+
+static int omap_ethernet_init(void)
+{
+	int status;
+
+	/* Request of GPIO lines */
+
+	status = gpio_request(ETH_KS8851_POWER_ON, "eth_power");
+	if (status) {
+		pr_err("Cannot request GPIO %d\n", ETH_KS8851_POWER_ON);
+		return status;
+	}
+
+	status = gpio_request(ETH_KS8851_QUART, "quart");
+	if (status) {
+		pr_err("Cannot request GPIO %d\n", ETH_KS8851_QUART);
+		goto error1;
+	}
+
+	status = gpio_request(ETH_KS8851_IRQ, "eth_irq");
+	if (status) {
+		pr_err("Cannot request GPIO %d\n", ETH_KS8851_IRQ);
+		goto error2;
+	}
+
+	/* Configuration of requested GPIO lines */
+
+	status = gpio_direction_output(ETH_KS8851_POWER_ON, 1);
+	if (status) {
+		pr_err("Cannot set output GPIO %d\n", ETH_KS8851_IRQ);
+		goto error3;
+	}
+
+	status = gpio_direction_output(ETH_KS8851_QUART, 1);
+	if (status) {
+		pr_err("Cannot set output GPIO %d\n", ETH_KS8851_QUART);
+		goto error3;
+	}
+
+	status = gpio_direction_input(ETH_KS8851_IRQ);
+	if (status) {
+		pr_err("Cannot set input GPIO %d\n", ETH_KS8851_IRQ);
+		goto error3;
+	}
+
+	return 0;
+
+error3:
+	gpio_free(ETH_KS8851_IRQ);
+error2:
+	gpio_free(ETH_KS8851_QUART);
+error1:
+	gpio_free(ETH_KS8851_POWER_ON);
+	return status;
+}
+
 static struct platform_device sdp4430_lcd_device = {
 	.name		= "sdp4430_lcd",
 	.id		= -1,
@@ -113,6 +183,8 @@ static struct omap_musb_board_data musb_board_data = {
 
 static void __init omap_4430sdp_init(void)
 {
+	int status;
+
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
@@ -120,6 +192,15 @@ static void __init omap_4430sdp_init(void)
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
+
+	status = omap_ethernet_init();
+	if (status) {
+		pr_err("Ethernet initialization failed: %d\n", status);
+	} else {
+		sdp4430_spi_board_info[0].irq = gpio_to_irq(ETH_KS8851_IRQ);
+		spi_register_board_info(sdp4430_spi_board_info,
+				ARRAY_SIZE(sdp4430_spi_board_info));
+	}
 }
 
 static void __init omap_4430sdp_map_io(void)

