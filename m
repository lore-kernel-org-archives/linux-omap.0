From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH] ARM: OMAP: PalmZ71 MPUIO monitoring
Date: Sun, 12 Nov 2006 19:34:43 +0100
Message-ID: <200611121934.43701.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Dl2VFOhGJobqmC3"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

--Boundary-00=_Dl2VFOhGJobqmC3
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I=B4ve added some code from board-palmte.c to board-palmz71.c . This code=20
monitors the status of power cable and headphones (plugged/unplugged). I=B4=
ve=20
also added a few new gpio definitions to board-palmz71.h .

Signed-off-by: Marek Va=B9ut <marek.vasut@gmail.com>

--Boundary-00=_Dl2VFOhGJobqmC3
Content-Type: text/x-diff; charset="us-ascii";
	name="palmz71-power-and-headphones-monitor.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="palmz71-power-and-headphones-monitor.patch"

diff -Naur linux-omap-current/arch/arm/mach-omap1/board-palmz71.c linux-omap/arch/arm/mach-omap1/board-palmz71.c
--- linux-omap-current/arch/arm/mach-omap1/board-palmz71.c	2006-11-12 11:24:41.000000000 +0100
+++ linux-omap/arch/arm/mach-omap1/board-palmz71.c	2006-11-12 14:35:03.000000000 +0100
@@ -272,9 +272,8 @@
 static struct omap_mmc_config palmz71_mmc_config __initdata = {
 	.mmc[0] = {
 		.enabled	= 1,
-		.wire4		= 0,
 		.wp_pin		= PALMZ71_MMC_WP_GPIO,
-		.power_pin	= -1,
+		.power_pin	= PALMZ71_MMC_POWER_GPIO,
 		.switch_pin	= PALMZ71_MMC_IN_GPIO,
 	},
 };
@@ -294,21 +293,6 @@
 	{OMAP_TAG_UART,	&palmz71_uart_config},
 };
 
-static irqreturn_t
-palmz71_powercable(int irq, void *dev_id, struct pt_regs *regs)
-{
-	if (omap_get_gpio_datain(PALMZ71_USBDETECT_GPIO)) {
-		printk(KERN_INFO "PM: Power cable connected\n");
-		set_irq_type(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
-				IRQT_FALLING);
-	} else {
-		printk(KERN_INFO "PM: Power cable disconnected\n");
-		set_irq_type(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
-				IRQT_RISING);
-	}
-	return IRQ_HANDLED;
-}
-
 static void __init
 omap_mpu_wdt_mode(int mode)
 {
@@ -320,40 +304,81 @@
 	}
 }
 
-static void __init
-palmz71_gpio_setup(int early)
+/* Periodically check for changes on important input pins */
+struct timer_list palmz71_pin_timer;
+int prev_power, prev_headphones;
+
+static void palmz71_pin_handler(unsigned long data) {
+	int power, headphones;
+	
+        power = !omap_get_gpio_datain(PALMZ71_CABLE_GPIO);
+	headphones = omap_get_gpio_datain(PALMZ71_HEADPHONES_GPIO);
+
+        if (power && !prev_power)
+		printk(KERN_INFO "PM: cable connected\n");
+	else if (!power && prev_power)
+		printk(KERN_INFO "PM: cable disconnected\n");
+
+	if (headphones && !prev_headphones) {
+    		/* Headphones connected, disable speaker */
+		omap_set_gpio_dataout(PALMZ71_SPEAKER_GPIO, 0);
+		printk(KERN_INFO "PM: speaker off\n");
+        } else if (!headphones && prev_headphones) {
+		/* Headphones unplugged, re-enable speaker */
+		omap_set_gpio_dataout(PALMZ71_SPEAKER_GPIO, 1);
+		printk(KERN_INFO "PM: speaker on\n");
+	}
+
+	prev_power = power;
+	prev_headphones = headphones;
+	mod_timer(&palmz71_pin_timer, jiffies + msecs_to_jiffies(500));
+}
+
+static void __init palmz71_gpio_setup(void)
 {
-	if (early) {
-		/* Only set GPIO1 so we have a working serial */
-		omap_set_gpio_dataout(1, 1);
-		omap_set_gpio_direction(1, 0);
-	} else {
-		/* Set MMC/SD host WP pin as input */
-		if (omap_request_gpio(PALMZ71_MMC_WP_GPIO)) {
-			printk(KERN_ERR "Could not reserve WP GPIO!\n");
-			return;
-		}
-		omap_set_gpio_direction(PALMZ71_MMC_WP_GPIO, 1);
-
-		/* Monitor the Power-cable-connected signal */
-		if (omap_request_gpio(PALMZ71_USBDETECT_GPIO)) {
-			printk(KERN_ERR
-				"Could not reserve cable signal GPIO!\n");
-			return;
-		}
-		omap_set_gpio_direction(PALMZ71_USBDETECT_GPIO, 1);
-		if (request_irq(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
-		    palmz71_powercable, SA_SAMPLE_RANDOM, "palmz71-cable", 0))
-			printk(KERN_ERR
-				"IRQ request for power cable failed!\n");
-		palmz71_powercable(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO), 0, 0);
+	/* Monitor cable-connected signals */
+	if (omap_request_gpio(PALMZ71_CABLE_GPIO) ||
+    	    omap_request_gpio(PALMZ71_USBDETECT_GPIO)) {
+		printk(KERN_ERR "Could not reserve cable signal GPIO!\n");
+		return;
+	}
+	omap_set_gpio_direction(PALMZ71_CABLE_GPIO, 1);
+	omap_set_gpio_direction(PALMZ71_USBDETECT_GPIO, 1);
+
+        /* Set speaker-enable pin as output */
+	if (omap_request_gpio(PALMZ71_SPEAKER_GPIO)) {
+		printk(KERN_ERR "Could not reserve speaker GPIO!\n");
+		return;
+        }
+	omap_set_gpio_direction(PALMZ71_SPEAKER_GPIO, 0);
+
+        /* Monitor the headphones-connected signal */
+	if (omap_request_gpio(PALMZ71_HEADPHONES_GPIO)) {
+    		printk(KERN_ERR "Could not reserve headphones signal GPIO!\n");
+		return;
+        }
+        omap_set_gpio_direction(PALMZ71_HEADPHONES_GPIO, 1);
+
+	prev_power = omap_get_gpio_datain(PALMZ71_CABLE_GPIO);
+        prev_headphones = !omap_get_gpio_datain(PALMZ71_HEADPHONES_GPIO);
+	setup_timer(&palmz71_pin_timer, palmz71_pin_handler, 0);
+        palmz71_pin_handler(0);
+}
+
+static void palmz71_serial_setup(void) {
+	/* Set GPIO1 so we have a working serial */
+	if (omap_request_gpio(PALMZ71_SERIAL_GPIO)) {
+	    printk(KERN_ERR "Could not reserve serial power GPIO!\n");
+	    return;
 	}
+	omap_set_gpio_dataout(PALMZ71_SERIAL_GPIO, 1);
+	omap_set_gpio_direction(PALMZ71_SERIAL_GPIO, 0);
 }
 
 static void __init
 omap_palmz71_init(void)
 {
-	palmz71_gpio_setup(1);
+	palmz71_serial_setup();
 	omap_mpu_wdt_mode(0);
 
 	omap_board_config = palmz71_config;
@@ -364,7 +389,7 @@
 	spi_register_board_info(palmz71_boardinfo,
 				ARRAY_SIZE(palmz71_boardinfo));
 	omap_serial_init();
-	palmz71_gpio_setup(0);
+	palmz71_gpio_setup();
 }
 
 static void __init
diff -Naur linux-omap-current/include/asm-arm/arch-omap/board-palmz71.h linux-omap/include/asm-arm/arch-omap/board-palmz71.h
--- linux-omap-current/include/asm-arm/arch-omap/board-palmz71.h	2006-11-12 11:25:08.000000000 +0100
+++ linux-omap/include/asm-arm/arch-omap/board-palmz71.h	2006-11-12 14:32:54.000000000 +0100
@@ -13,14 +13,23 @@
 #ifndef __OMAP_BOARD_PALMZ71_H
 #define __OMAP_BOARD_PALMZ71_H
 
+#include <asm/arch/gpio.h>
+
 #define PALMZ71_USBDETECT_GPIO	0
+#define PALMZ71_SERIAL_GPIO	1
 #define PALMZ71_PENIRQ_GPIO	6
 #define PALMZ71_MMC_WP_GPIO	8
+#define PALMZ71_MMC_POWER_GPIO	9
 #define PALMZ71_HDQ_GPIO 	11
+#define PALMZ71_HEADPHONES_GPIO	14
+#define PALMZ71_SPEAKER_GPIO	15
 
 #define PALMZ71_HOTSYNC_GPIO	OMAP_MPUIO(1)
 #define PALMZ71_CABLE_GPIO	OMAP_MPUIO(2)
 #define PALMZ71_SLIDER_GPIO	OMAP_MPUIO(3)
 #define PALMZ71_MMC_IN_GPIO	OMAP_MPUIO(4)
+#define PALMZ71_MMC1_GPIO	OMAP_MPUIO(6)
+#define PALMZ71_MMC2_GPIO	OMAP_MPUIO(7)
+#define PALMZ71_MMC3_GPIO	OMAP_MPUIO(11)
 
 #endif	/* __OMAP_BOARD_PALMZ71_H */

--Boundary-00=_Dl2VFOhGJobqmC3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_Dl2VFOhGJobqmC3--
