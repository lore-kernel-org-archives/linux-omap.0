From: "Arce, Abraham" <x0066660@ti.com>
Subject: [PATCH v1 2/3] OMAP4: Ethernet: KS8851 Board Support
Date: Wed, 5 May 2010 02:10:22 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DEEB8C1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52932 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756431Ab0EEHKb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 03:10:31 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>


Enable Micrel KS8851 SPI network chip for OMAP4430

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b88f28c..801c2a7 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
+#include <linux/spi/spi.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -32,6 +33,30 @@
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 
+#define ETHERNET_KS8851_IRQ		34
+#define ETHERNET_KS8851_POWER_ENABLE	48
+#define ETHERNET_KS8851_QUART		138
+
+static struct spi_board_info sdp4430_spi_board_info[] __initdata = {
+	{
+		.modalias               = "ks8851",
+		.bus_num                = 1,
+		.chip_select            = 0,
+		.max_speed_hz           = 24000000,
+		.irq                    = ETHERNET_KS8851_IRQ,
+	},
+};
+
+static void omap_ethernet_init(void)
+{
+	gpio_request(ETHERNET_KS8851_POWER_ENABLE, "ethernet");
+	gpio_direction_output(ETHERNET_KS8851_POWER_ENABLE, 1);
+	gpio_request(ETHERNET_KS8851_QUART, "quart");
+	gpio_direction_output(ETHERNET_KS8851_QUART, 1);
+	gpio_request(ETHERNET_KS8851_IRQ, "ks8851");
+	gpio_direction_input(ETHERNET_KS8851_IRQ);
+}
+
 static struct platform_device sdp4430_lcd_device = {
 	.name		= "sdp4430_lcd",
 	.id		= -1,
@@ -120,6 +145,11 @@ static void __init omap_4430sdp_init(void)
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
+
+	omap_ethernet_init();
+	sdp4430_spi_board_info[0].irq = gpio_to_irq(ETHERNET_KS8851_IRQ);
+	spi_register_board_info(sdp4430_spi_board_info,
+			ARRAY_SIZE(sdp4430_spi_board_info));
 }
 
 static void __init omap_4430sdp_map_io(void)
-- 
1.5.4.3

