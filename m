From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: 2430SDP: turn off secondary LCD backlight on boot
Date: Mon, 30 Jul 2007 15:55:28 -0700
Message-ID: <20070730225528.778419364@mvista.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

There is not yet any driver for the secondary LCD, so turn off
the backlight on boot.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6.21/arch/arm/mach-omap2/board-2430sdp.c
===================================================================
--- linux-2.6.21.orig/arch/arm/mach-omap2/board-2430sdp.c
+++ linux-2.6.21/arch/arm/mach-omap2/board-2430sdp.c
@@ -55,6 +55,7 @@
 #define TS_GPIO                 24
 
 #define TWL4030_MSECURE_GPIO	118
+#define SECONDARY_LCD_GPIO	147
 
 static struct mtd_partition sdp2430_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
@@ -466,6 +467,10 @@ static void __init omap_2430sdp_init(voi
 	spi_register_board_info(sdp2430_spi_board_info,
 				ARRAY_SIZE(sdp2430_spi_board_info));
 	ads7846_dev_init();
+
+	/* turn off secondary LCD backlight */
+	omap_set_gpio_direction(SECONDARY_LCD_GPIO, 0);
+	omap_set_gpio_dataout(SECONDARY_LCD_GPIO, 0);
 }
 
 static void __init omap_2430sdp_map_io(void)
--
