From: "Arce, Abraham" <x0066660@ti.com>
Subject: [PATCH v3 2/3] OMAP4: Ethernet: KS8851 Board Support
Date: Mon, 10 May 2010 20:42:47 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DFD52D8@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47364 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab0EKBm4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 21:42:56 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>

Enable Micrel KS8851 SPI network chip for OMAP4430

Signed-off-by: Abraham Arce <x0066660@ti.com>
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
-- 
1.5.4.3

