From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH]TS: Fix for the TS event issue on  OMAP3 ES2.0
Date: Tue, 4 Dec 2007 23:15:32 -0600
Message-ID: <465714FA584D6D49BD2ADB26BB64FD0D01B1A733@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi,

This patch has the fix for the Touch Screen issue on OMAP3 ES2.0.The IRQ =
for the TS has been defined as 3 and 2 for ES1 and ES2 and the IRQ =
assignment is done at run time.Changed the macro naming conventions for =
TS and Ethernet.

Regards,
Teerth



Fix for the Touch Screen issue on OMAP3 ES2.0.The IRQ for the TS has =
been defined as 3 and 2 for ES1 and ES2 and the IRQ assignment is done =
at run time.Changed the macro naming conventions for TS and Ethernet.

Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c       |   21 +++++++++++++++------
 include/asm-arm/arch-omap/board-3430sdp.h |    3 ++-
 2 files changed, 17 insertions(+), 7 deletions(-)

Index: linux-omap-2.6-lat/include/asm-arm/arch-omap/board-3430sdp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-2.6-lat.orig/include/asm-arm/arch-omap/board-3430sdp.h	=
2007-12-05 10:19:30.324869299 +0530
+++ linux-omap-2.6-lat/include/asm-arm/arch-omap/board-3430sdp.h	=
2007-12-05 10:20:55.988125113 +0530
@@ -34,13 +34,14 @@
 /* Placeholder for 3430SDP specific defines */
=20
 #define OMAP34XX_ETHR_START		DEBUG_BASE
-#define OMAP34XX_ETHR_GPIO_IRQ_SDPV1	29
-#define OMAP34XX_ETHR_GPIO_IRQ_SDPV2	6
+#define OMAP34XX_SDPV1_ETHR_GPIO	29
+#define OMAP34XX_SDPV2_ETHR_GPIO	6
=20
 /*
  * GPIO used for TSC2046, TI's Touchscreen controller
  */
-#define TS_GPIO		3
+#define OMAP34XX_SDPV1_TS_GPIO		3
+#define OMAP34XX_SDPV2_TS_GPIO		2
=20
 /* NAND */
 /* IMPORTANT NOTE ON MAPPING
Index: linux-omap-2.6-lat/arch/arm/mach-omap2/board-3430sdp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-2.6-lat.orig/arch/arm/mach-omap2/board-3430sdp.c	=
2007-12-05 10:19:30.324869299 +0530
+++ linux-omap-2.6-lat/arch/arm/mach-omap2/board-3430sdp.c	2007-12-05 =
10:21:20.771331333 +0530
@@ -120,6 +120,8 @@
 	},
 };
=20
+static int ts_gpio;
+
 #ifdef CONFIG_RTC_DRV_TWL4030
 static int twl4030_rtc_init(void)
 {
@@ -181,20 +183,20 @@
  */
 static void ads7846_dev_init(void)
 {
-	if (omap_request_gpio(TS_GPIO) < 0) {
+	if (omap_request_gpio(ts_gpio) < 0) {
 		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
 		return;
 	}
=20
-	omap_set_gpio_direction(TS_GPIO, 1);
+	omap_set_gpio_direction(ts_gpio, 1);
=20
-	omap_set_gpio_debounce(TS_GPIO, 1);
-	omap_set_gpio_debounce_time(TS_GPIO, 0xa);
+	omap_set_gpio_debounce(ts_gpio, 1);
+	omap_set_gpio_debounce_time(ts_gpio, 0xa);
 }
=20
 static int ads7846_get_pendown_state(void)  {
-	return !omap_get_gpio_datain(TS_GPIO);
+	return !omap_get_gpio_datain(ts_gpio);
 }
=20
 /*
@@ -250,7 +252,7 @@
 		.chip_select		=3D 0,
 		.max_speed_hz		=3D 1500000,
 		.controller_data	=3D &tsc2046_mcspi_config,
-		.irq			=3D OMAP_GPIO_IRQ(TS_GPIO),
+		.irq			=3D 0,
 		.platform_data		=3D &tsc2046_config,
 	},
 };
@@ -281,9 +283,9 @@
 	udelay(100);
=20
 	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0))
-		eth_gpio =3D OMAP34XX_ETHR_GPIO_IRQ_SDPV2;
+		eth_gpio =3D OMAP34XX_SDPV2_ETHR_GPIO;
 	else
-		eth_gpio =3D OMAP34XX_ETHR_GPIO_IRQ_SDPV1;
+		eth_gpio =3D OMAP34XX_SDPV1_ETHR_GPIO;
=20
 	sdp3430_smc91x_resources[1].start =3D OMAP_GPIO_IRQ(eth_gpio);
=20
@@ -325,6 +327,11 @@
 	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
 	omap_board_config =3D sdp3430_config;
 	omap_board_config_size =3D ARRAY_SIZE(sdp3430_config);
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0))
+		ts_gpio =3D OMAP34XX_SDPV2_TS_GPIO;
+	else
+		ts_gpio =3D OMAP34XX_SDPV1_TS_GPIO;
+	sdp3430_spi_board_info[0].irq =3D OMAP_GPIO_IRQ(ts_gpio);
 	spi_register_board_info(sdp3430_spi_board_info,
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	sdp3430_flash_init();
