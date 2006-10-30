From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH] Palm Tungsten|T LEDs
Date: Mon, 30 Oct 2006 06:27:07 +0100
Message-ID: <200610300627.07622.marek.vasut@gmail.com>
References: <200610290100.04584.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_r0YRFaxWUwbjZ86"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200610290100.04584.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_r0YRFaxWUwbjZ86
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
this patch adds LED support for Palm Tungsten|T. Apply on top of previous=20
three patches (PalmTT support, lcd and defconfig).

Signed-off-by: Marek Va=B9ut <marek.vasut@gmail.com>

--Boundary-00=_r0YRFaxWUwbjZ86
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="palmtt-leds.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="palmtt-leds.patch"

diff -Naur linux-omap-current/arch/arm/configs/palmtt_defconfig linux-omap/arch/arm/configs/palmtt_defconfig
--- linux-omap-current/arch/arm/configs/palmtt_defconfig	2006-10-29 21:34:38.000000000 +0100
+++ linux-omap/arch/arm/configs/palmtt_defconfig	2006-10-30 06:02:01.000000000 +0100
@@ -561,15 +561,20 @@
 #
 # LED devices
 #
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
 
 #
 # LED drivers
 #
+CONFIG_LEDS_OMAP=y
 
 #
 # LED Triggers
 #
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 
 #
 # Multimedia devices
diff -Naur linux-omap-current/arch/arm/mach-omap1/board-palmtt.c linux-omap/arch/arm/mach-omap1/board-palmtt.c
--- linux-omap-current/arch/arm/mach-omap1/board-palmtt.c	2006-10-29 21:34:39.000000000 +0100
+++ linux-omap/arch/arm/mach-omap1/board-palmtt.c	2006-10-30 06:02:28.000000000 +0100
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/leds.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -28,6 +29,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
+#include <asm/arch/led.h>
 #include <asm/arch/mcbsp.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
@@ -229,8 +231,29 @@
                 .platform_data  = &palmtt_backlight_config,
         },
 };
-							
-		
+
+static struct omap_led_config palmtt_led_config[] = {
+        {
+                .cdev   = {
+                        .name   = "palmtt:led0",
+                },
+                .gpio   = PALMTT_LED_GPIO,
+        },
+};
+
+static struct omap_led_platform_data palmtt_led_data = {
+        .nr_leds        = ARRAY_SIZE(palmtt_led_config),
+        .leds           = palmtt_led_config,
+};
+
+static struct platform_device palmtt_led_device = {
+        .name           = "omap-led",
+        .id             = -1,
+        .dev            = {
+                .platform_data  = &palmtt_led_data,
+        },
+};
+
 static struct platform_device *palmtt_devices[] __initdata = {
 	&palmtt_flash_device,
 	&palmtt_mcbsp1_device,
@@ -239,7 +262,9 @@
 	&palmtt_irda_device,
 	&palmtt_spi_device,
 	&palmtt_backlight_device,
+        &palmtt_led_device,
 };
+
 static int palmtt_get_pendown_state(void)
 {
     return !omap_get_gpio_datain(6);
diff -Naur linux-omap-current/include/asm-arm/arch-omap/board-palmtt.h linux-omap/include/asm-arm/arch-omap/board-palmtt.h
--- linux-omap-current/include/asm-arm/arch-omap/board-palmtt.h	2006-10-29 21:35:06.000000000 +0100
+++ linux-omap/include/asm-arm/arch-omap/board-palmtt.h	2006-10-30 06:02:01.000000000 +0100
@@ -15,6 +15,7 @@
 
 #define PALMTT_USBDETECT_GPIO	0
 #define PALMTT_CABLE_GPIO	1
+#define PALMTT_LED_GPIO		3
 #define PALMTT_PINTDAV_GPIO	6
 #define PALMTT_MMC_WP_GPIO	8
 #define PALMTT_HDQ_GPIO 	11

--Boundary-00=_r0YRFaxWUwbjZ86
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_r0YRFaxWUwbjZ86--
