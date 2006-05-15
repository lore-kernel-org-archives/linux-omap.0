From: David Brownell <david-b@pacbell.net>
Subject: Re: is dynamic tick working?
Date: Mon, 15 May 2006 15:11:09 -0700
Message-ID: <200605151511.11836.david-b@pacbell.net>
References: <200605121905.13405.david-b@pacbell.net>
	<446793B2.6040408@nokia.com> <20060515092253.GD8368@atomide.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/xPaEsVWxMQYbvB"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060515092253.GD8368@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_/xPaEsVWxMQYbvB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 15 May 2006 2:22 am, Tony Lindgren wrote:
> 
> OK, I've pushed Imre's patches. Can you check that everything got
> patched OK?

I attach three patches:

 - To make Mistral work better needs new callback), which worked for
   me (modulo writing the "disable" file wedging, gotta retest that);
 
 - A quickie bitbang SPI adapter for the 1510-Innovator FPGA hookup to ads7846,
   untested beyond compiling (no Innovator here!);

 - Removing the old OMAP-specific Mistral and Innovator touchscreen drivers;
   this may be a trifle premature given the lack of Innovator testing

Anyway, with the first of these patches I saw tick rates of about 27 Hz;
the issue seems to be the omap_ts driver keeping a timer active (among
other misbehaviors).

In short:  yes, it's better now.

- Dave


--Boundary-00=_/xPaEsVWxMQYbvB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ads.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ads.patch"

Syncing the ads7846 code with mainstream means that the Mistral support
needs to include a callback to read the pendown state.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/arch/arm/mach-omap1/board-osk.c
===================================================================
--- osk.orig/arch/arm/mach-omap1/board-osk.c	2006-05-03 08:03:40.000000000 -0700
+++ osk/arch/arm/mach-omap1/board-osk.c	2006-05-15 12:44:27.000000000 -0700
@@ -299,12 +299,17 @@ static struct platform_device *mistral_d
 	&osk5912_lcd_device,
 };
 
+static int mistral_get_pendown_state(void)
+{
+	return !omap_get_gpio_datain(4);
+}
+
 static const struct ads7846_platform_data mistral_ts_info = {
 	.model			= 7846,
 	.vref_delay_usecs	= 100,	/* internal, no capacitor */
 	.x_plate_ohms		= 419,
 	.y_plate_ohms		= 486,
-	// .{x,y,pressure}_{min,max}
+	.get_pendown_state	= mistral_get_pendown_state,
 };
 
 static struct spi_board_info __initdata mistral_boardinfo[] = { {

--Boundary-00=_/xPaEsVWxMQYbvB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="spi-inn1510.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="spi-inn1510.patch"

Add bitbang SPI driver for Innovator 1510 touchscreen, using the new
framework.  Compile-tested only.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/arch/arm/mach-omap1/board-innovator.c
===================================================================
--- osk.orig/arch/arm/mach-omap1/board-innovator.c	2006-05-15 12:46:56.000000000 -0700
+++ osk/arch/arm/mach-omap1/board-innovator.c	2006-05-15 12:46:59.000000000 -0700
@@ -139,6 +139,10 @@ static struct platform_device innovator_
 
 #ifdef CONFIG_ARCH_OMAP15XX
 
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+
+
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
 static struct map_desc innovator1510_io_desc[] __initdata = {
 	{
@@ -174,13 +178,44 @@ static struct platform_device innovator1
 	.id		= -1,
 };
 
+static struct platform_device innovator1510_spi_device = {
+	.name		= "spi_inn1510",
+	.id		= -1,
+};
+
 static struct platform_device *innovator1510_devices[] __initdata = {
 	&innovator_flash_device,
 	&innovator1510_smc91x_device,
 	&innovator_kp_device,
 	&innovator1510_lcd_device,
+	&innovator1510_spi_device,
 };
 
+static int innovator_get_pendown_state(void)
+{
+	return !(fpga_read(OMAP1510_FPGA_TOUCHSCREEN) & (1 << 5));
+}
+
+static const struct ads7846_platform_data innovator1510_ts_info = {
+	.model			= 7846,
+	.vref_delay_usecs	= 100,	/* internal, no capacitor */
+	.x_plate_ohms		= 419,
+	.y_plate_ohms		= 486,
+	.get_pendown_state	= innovator_get_pendown_state,
+};
+
+static struct spi_board_info __initdata innovator1510_boardinfo[] = { {
+	/* FPGA (bus "10") CS0 has an ads7846e */
+	.modalias		= "ads7846",
+	.platform_data		= &innovator1510_ts_info,
+	.irq			= OMAP1510_INT_FPGA_TS,
+	.max_speed_hz		= 120000 /* max sample rate at 3V */
+					* 26 /* command + data + overhead */,
+	.bus_num		= 10,
+	.chip_select		= 0,
+} };
+
+
 #endif /* CONFIG_ARCH_OMAP15XX */
 
 #ifdef CONFIG_ARCH_OMAP16XX
@@ -311,6 +346,8 @@ static void __init innovator_init(void)
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
 		platform_add_devices(innovator1510_devices, ARRAY_SIZE(innovator1510_devices));
+		spi_register_board_info(innovator1510_boardinfo,
+				ARRAY_SIZE(innovator1510_boardinfo));
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP16XX
Index: osk/drivers/spi/Kconfig
===================================================================
--- osk.orig/drivers/spi/Kconfig	2006-05-15 12:46:56.000000000 -0700
+++ osk/drivers/spi/Kconfig	2006-05-15 12:46:59.000000000 -0700
@@ -85,6 +85,13 @@ config SPI_BUTTERFLY
 	  inexpensive battery powered microcontroller evaluation board.
 	  This same cable can be used to flash new firmware.
 
+config SPI_OMAP_INN1510
+	tristate "OMAP Innovator 1510 Bitbang SPI, for touchscreen"
+	depends on SPI_MASTER && MACH_OMAP_INNOVATOR
+	select SPI_BITBANG
+	help
+	  This provides bitbang access to the Innovator touchscreen.
+
 config SPI_OMAP_UWIRE
 	tristate "OMAP MicroWire"
 	depends on SPI_MASTER && ARCH_OMAP
Index: osk/drivers/spi/Makefile
===================================================================
--- osk.orig/drivers/spi/Makefile	2006-05-15 12:46:56.000000000 -0700
+++ osk/drivers/spi/Makefile	2006-05-15 12:46:59.000000000 -0700
@@ -14,6 +14,7 @@ obj-$(CONFIG_SPI_MASTER)		+= spi.o
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
 obj-$(CONFIG_SPI_OMAP24XX)		+= omap2_mcspi.o
+obj-$(CONFIG_SPI_OMAP_INN1510)		+= spi_inn1510.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)		+= omap_uwire.o
 # 	... add above this line ...
 
Index: osk/drivers/spi/spi_inn1510.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ osk/drivers/spi/spi_inn1510.c	2006-05-15 12:46:59.000000000 -0700
@@ -0,0 +1,194 @@
+/*
+ * spi_inn1510.c - spi support for OMAP1510 touchscreen
+ *
+ * Copyright (C) 2006 David Brownell (convert to cross-platform SPI framework)
+ * Copyright (C) 2002 MontaVista Software Inc. (FPGA glue)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+#include <asm/mach-types.h>
+#include <asm/io.h>
+
+#include <asm/arch/fpga.h>
+#include <asm/arch/board.h>
+
+
+struct inn1510_spi {
+	struct spi_bitbang	bitbang;
+	struct platform_device	*pdev;
+};
+
+/* Touchscreen hardware on the Innovator involves an FPGA register
+ * that's bit-banged to generate SPI transactions to an ads7846.
+ */
+#define FPGA_TS_BCLK     (1<<0)
+#define FPGA_TS_BDIN     (1<<1)
+#define FPGA_TS_BCS      (1<<2)
+#define FPGA_TS_BBUSY    (1<<3)		/* we don't use this */
+#define FPGA_TS_BOUT     (1<<4)
+// #define FPGA_TS_BPENUP   (1<<5)
+
+// #define X_PLATE_OHMS 419
+// #define Y_PLATE_OHMS 486
+
+
+static inline u8 fpga_ts_read(void)
+{
+	return fpga_read(OMAP1510_FPGA_TOUCHSCREEN);
+}
+
+static inline void fpga_ts_write(u8 val)
+{
+	fpga_write(val, OMAP1510_FPGA_TOUCHSCREEN);
+}
+
+static inline void fpga_ts_set_bits(u8 mask)
+{
+	fpga_ts_write(fpga_ts_read() | mask);
+}
+
+static inline void fpga_ts_clear_bits(u8 mask)
+{
+	fpga_ts_write(fpga_ts_read() & ~mask);
+}
+
+/*----------------------------------------------------------------------*/
+
+static void inn1510_spi_chipselect(struct spi_device *spi, int is_on)
+{
+	if (is_on) {
+		fpga_ts_clear_bits(FPGA_TS_BCLK);
+		fpga_ts_clear_bits(FPGA_TS_BCS);
+	} else {
+		fpga_ts_set_bits(FPGA_TS_BCS);
+	}
+}
+
+static inline void setsck(struct spi_device *spi, int is_on)
+{
+	if (is_on)
+		fpga_ts_set_bits(FPGA_TS_BCLK);
+	else
+		fpga_ts_clear_bits(FPGA_TS_BCLK);
+}
+
+static inline void setmosi(struct spi_device *spi, int is_on)
+{
+	if (is_on)
+		fpga_ts_set_bits(FPGA_TS_BDIN);
+	else
+		fpga_ts_clear_bits(FPGA_TS_BDIN);
+}
+
+static inline int getmiso(struct spi_device *spi)
+{
+	return ((fpga_ts_read() & FPGA_TS_BOUT) ? 1 : 0) ;
+}
+
+
+#define	spidelay(X)	ndelay(X)
+
+#define	EXPAND_BITBANG_TXRX
+#include <linux/spi/spi_bitbang.h>
+
+static u32
+inn1510_spi_txrx_word_mode0(struct spi_device *spi,
+		unsigned nsecs,
+		u32 word, u8 bits)
+{
+	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, 8);
+}
+
+/*----------------------------------------------------------------------*/
+
+static int __init inn1510_spi_probe(struct platform_device *pdev)
+{
+	int			status;
+	struct spi_master	*master;
+	struct inn1510_spi	*inn1510_spi;
+
+	master = spi_alloc_master(&pdev->dev, sizeof *inn1510_spi);
+	if (!master)
+		return -ENOMEM;
+	inn1510_spi = spi_master_get_devdata(master);
+	inn1510_spi->pdev = pdev;
+	platform_set_drvdata(pdev, inn1510_spi);
+
+	/* SPI and bitbang hookup */
+	master->bus_num = 10;
+	master->num_chipselect = 1;
+
+	inn1510_spi->bitbang.master = spi_master_get(master);
+	inn1510_spi->bitbang.chipselect = inn1510_spi_chipselect;
+	inn1510_spi->bitbang.txrx_word[SPI_MODE_0] = inn1510_spi_txrx_word_mode0;
+
+	status = spi_bitbang_start(&inn1510_spi->bitbang);
+	if (status < 0)
+		(void) spi_master_put(inn1510_spi->bitbang.master);
+
+	return status;
+}
+
+static int __exit inn1510_spi_remove(struct platform_device *pdev)
+{
+	int			status;
+	struct inn1510_spi	*inn1510_spi = platform_get_drvdata(pdev);
+
+	/* stop() unregisters child devices too */
+	status = spi_bitbang_stop(&inn1510_spi->bitbang);
+	(void) spi_master_put(inn1510_spi->bitbang.master);
+	platform_set_drvdata(pdev, NULL);
+	return status;
+}
+
+
+struct platform_driver inn1510_spi_driver = {
+	.driver = {
+		.name =		"inn1510_spi",
+		.owner =	THIS_MODULE,
+	},
+	.probe =	inn1510_spi_probe,
+	.remove =	__exit_p(inn1510_spi_remove),
+};
+
+
+static int __init inn1510_spi_init(void)
+{
+	if (!machine_is_omap_innovator())
+		return -ENODEV;
+
+	/* register driver */
+	return platform_driver_register(&inn1510_spi_driver);
+}
+device_initcall(inn1510_spi_init);
+
+static void __exit inn1510_spi_exit(void)
+{
+	platform_driver_unregister(&inn1510_spi_driver);
+}
+module_exit(inn1510_spi_exit);
+
+MODULE_DESCRIPTION("Innovator 1510 FPGA SPI (for touchscreen)");
+MODULE_LICENSE("GPL");
+

--Boundary-00=_/xPaEsVWxMQYbvB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ts.patch"

Remove OSK/Mistral and Innovator support for the old OMAP-specfic
touchscreen framework; both of those board should be able to use
the new SPI framework with the ads7846 touchscreen driver that's
now in the upstream kernels.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/drivers/input/touchscreen/Kconfig
===================================================================
--- osk.orig/drivers/input/touchscreen/Kconfig	2006-05-03 08:03:40.000000000 -0700
+++ osk/drivers/input/touchscreen/Kconfig	2006-05-15 14:57:27.000000000 -0700
@@ -114,13 +114,13 @@ config TOUCHSCREEN_HP600
 endif
 config TOUCHSCREEN_OMAP
 	tristate "OMAP touchscreen input driver"
-	depends on INPUT && INPUT_TOUCHSCREEN && ARCH_OMAP
+	depends on INPUT && INPUT_TOUCHSCREEN && (MACH_OMAP_H2 || MACH_OMAP_H3)
 	help
 	  Say Y here if you have an OMAP based board with touchscreen
-	  attached to it, e.g. OMAP Innovator, OSK, H2 or H3
+	  attached to it, e.g. OMAP H2 or H3
 
 	  If unsure, or you're using drivers in the newer SPI
-	  framework, say N.
+	  framework (as with Innovator or OSK/Mistral), say N.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap_ts.
Index: osk/drivers/input/touchscreen/omap/Makefile
===================================================================
--- osk.orig/drivers/input/touchscreen/omap/Makefile	2005-09-21 12:54:14.000000000 -0700
+++ osk/drivers/input/touchscreen/omap/Makefile	2006-05-15 14:54:39.000000000 -0700
@@ -6,7 +6,5 @@ obj-$(CONFIG_TOUCHSCREEN_OMAP) += omapts
 
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_H2) += ts_hx.o
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_H3) += ts_hx.o
-objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += ts_inn1510.o
-objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_OSK) += ts_osk.o
 
 omapts-objs := omap_ts.o $(objs-yy)
Index: osk/drivers/input/touchscreen/omap/omap_ts.c
===================================================================
--- osk.orig/drivers/input/touchscreen/omap/omap_ts.c	2006-04-22 14:41:05.000000000 -0700
+++ osk/drivers/input/touchscreen/omap/omap_ts.c	2006-05-15 14:56:39.000000000 -0700
@@ -49,12 +49,6 @@ static struct ts_device *__initdata ts_d
 #if defined(CONFIG_MACH_OMAP_H2) || defined(CONFIG_MACH_OMAP_H3)
 	&hx_ts,
 #endif
-#ifdef CONFIG_MACH_OMAP_OSK
-	&osk_ts,
-#endif
-#if defined(CONFIG_MACH_OMAP_INNOVATOR) && defined(CONFIG_ARCH_OMAP15XX)
-	&innovator1510_ts,
-#endif
 };
 
 static struct omap_ts_t ts_omap;
@@ -245,6 +239,9 @@ static int __init omap_ts_init(void)
 {
 	int ret;
 
+	if (machine_is_omap_osk() || machine_is_omap_innovator())
+		return -ENODEV;
+
 	ret = platform_device_register(&omap_ts_device);
 	if (ret != 0)
 		return -ENODEV;
Index: osk/drivers/input/touchscreen/omap/omap_ts.h
===================================================================
--- osk.orig/drivers/input/touchscreen/omap/omap_ts.h	2006-04-22 14:41:05.000000000 -0700
+++ osk/drivers/input/touchscreen/omap/omap_ts.h	2006-05-15 15:00:23.000000000 -0700
@@ -53,7 +53,5 @@ struct omap_ts_t{
 };
 
 extern struct ts_device hx_ts;
-extern struct ts_device osk_ts;
-extern struct ts_device innovator1510_ts;
 
 #endif /* __OMAP_TS_H */
Index: osk/drivers/input/touchscreen/omap/ts_osk.c
===================================================================
--- osk.orig/drivers/input/touchscreen/omap/ts_osk.c	2006-04-22 14:41:05.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,158 +0,0 @@
-/*
- * ts_osk.c - touchscreen support for OMAP OSK board
- * 
- * Copyright 2002 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	stevel@mvista.com or source@mvista.com
- *
- * The touchscreen hardware on the OSK uses OMAP5912 uWire interface,
- * GPIO4 (/PENIRQ) and GPIO6 (BUSY) to connect to an ADS7846 
- * touch screen controller. GPIO6 doesn't seem to be necessary here.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/input.h>
-#include <linux/device.h>
-#include <asm/arch/mux.h>
-#include <asm/arch/gpio.h>
-#include <asm/mach-types.h>
-
-#include "../drivers/ssi/omap-uwire.h"
-
-#include "omap_ts.h"
-#include "ads7846.h"
-
-// /PENIRQ on GPIO4 on OSK
-#define PEN_IRQ		 OMAP_GPIO_IRQ(4)
-
-// ADS7846 is on OSK uWire CS 0
-#define ADS7846_UWIRE_CS	0
-#define UWIRE_LEAVE_CS		1
-
-#define X_PLATE_OHMS 419
-#define Y_PLATE_OHMS 486
-
-static int osk_ts_penup(void);
-static int osk_ts_probe(struct omap_ts_t *ts);
-static void osk_ts_read(u16 * data);
-static void osk_ts_enable(void);
-static void osk_ts_disable(void);
-#ifdef MODULE
-static void osk_ts_remove(void);
-#endif
-
-struct ts_device osk_ts = {
-        .probe   = osk_ts_probe,
-        .read    = osk_ts_read,
-        .enable  = osk_ts_enable,
-        .disable = osk_ts_disable,
-        .remove  = __exit_p(osk_ts_remove),
-	.penup   = osk_ts_penup,
-};
-
-static u16 ads7846_do(u8 cmd)
-{
-	u16 val = 0;
-	
-	// send the command to the ADS7846, leave CS active after this
-	omap_uwire_data_transfer(ADS7846_UWIRE_CS, cmd, 8, 0, NULL, UWIRE_LEAVE_CS);
-
-	// now read returned data
-        omap_uwire_data_transfer(ADS7846_UWIRE_CS, 0, 0, 16, &val, !UWIRE_LEAVE_CS);
-	
-	return val;
-}
-
-static int osk_ts_penup(void)
-{
-	return (omap_get_gpio_datain(4));
-}
-
-static int  __init osk_ts_probe(struct omap_ts_t *ts)
-{
-#ifdef	CONFIG_OMAP_OSK_MISTRAL
-	if (!machine_is_omap_osk())
-		return -ENODEV;
-
-        /* Configure GPIO4 (pin M17 ZDY) as /PENIRQ interrupt input */
-        omap_cfg_reg(P20_1610_GPIO4);
-	omap_request_gpio(4);
-	omap_set_gpio_direction(4, 1);
-	ts->irq_type = SA_TRIGGER_FALLING;
-
-	ts->irq = PEN_IRQ;
-
-	/* Configure uWire interface. ADS7846 is on CS0 */
-	omap_uwire_configure_mode(ADS7846_UWIRE_CS, UWIRE_READ_RISING_EDGE |
-		                                    UWIRE_WRITE_RISING_EDGE |
-		                                    UWIRE_CS_ACTIVE_LOW |
-				                    UWIRE_FREQ_DIV_2);
-
-	/* FIXME verify there's really a Mistral board:
-	 * see if the AD7846 chip responds.
-	 */
-
-	/* NOTE:  no VREF; must ignore the temp, VBAT, and AUX sensors */
-	return 0;
-#else
-	return -ENODEV;
-#endif
-}
-
-static void osk_ts_read(u16 *data)
-{
-	unsigned int Rt = 0;
-
-	data[0] = ads7846_do(MEASURE_12BIT_X);
-	data[1] = ads7846_do(MEASURE_12BIT_Y); 
-	data[2] = ads7846_do(MEASURE_12BIT_Z1); 
-	data[3] = ads7846_do(MEASURE_12BIT_Z2); 
-
-	// Calculate touch pressure resistance
-	if (data[2]) {
-		Rt = (X_PLATE_OHMS * (u32)data[0] *
-		     ((u32)data[3] - (u32)data[2])) / (u32)data[2];
-
-		Rt = (Rt + 2048) >> 12; // round up to nearest ohm
-	}
-
-	/* 
-	 * Raw OSK touchscreen data values are between ~4000 and
-	 * ~60000. This seems to be to large for calibration 
-	 * systems (e.g. tslib). Make the values smaller.
-	 */
-	data[0] = data[0] >> 4;
-	data[1] = data[1] >> 4;
-
-	data[2] = Rt;
-}
-
-static void osk_ts_enable(void)
-{
-
-}
-
-static void osk_ts_disable(void)
-{
-
-}
-
-#ifdef MODULE
-static void __exit osk_ts_remove(void)
-{
-	omap_free_gpio(4);
-}
-#endif
Index: osk/drivers/input/touchscreen/omap/ts_inn1510.c
===================================================================
--- osk.orig/drivers/input/touchscreen/omap/ts_inn1510.c	2006-04-22 14:41:05.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,219 +0,0 @@
-/*
- * ts_inn1510.c - touchscreen support for OMAP1510 Innovator board
- * 
- * Copyright 2002 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	stevel@mvista.com or source@mvista.com
- *
- * The touchscreen hardware on the Innovator consists of an FPGA
- * register which is bit-banged to generate SPI-like transactions
- * to an ADS7846 touch screen controller.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/input.h>
-#include <linux/device.h>
-#include <asm/io.h>
-#include <asm/mach-types.h>
-#include <asm/arch/fpga.h>
-
-#include "omap_ts.h"
-#include "ads7846.h"
-
-// The Touch Screen Register on Innovator FPGA
-#define FPGA_TS_BCLK     (1<<0)
-#define FPGA_TS_BDIN     (1<<1)
-#define FPGA_TS_BCS      (1<<2)
-#define FPGA_TS_BBUSY    (1<<3)
-#define FPGA_TS_BOUT     (1<<4)
-#define FPGA_TS_BPENUP   (1<<5)
-
-#define X_PLATE_OHMS 419
-#define Y_PLATE_OHMS 486
-
-static int inn1510_ts_penup(void);
-static int inn1510_ts_probe(struct omap_ts_t *ts);
-static void inn1510_ts_read(u16 * data);
-static void inn1510_ts_enable(void);
-static void inn1510_ts_disable(void);
-#ifdef MODULE
-static void inn1510_ts_remove(void);
-#endif
-
-struct ts_device innovator1510_ts = {
-        .probe   = inn1510_ts_probe,
-        .read    = inn1510_ts_read,
-        .enable  = inn1510_ts_enable,
-        .disable = inn1510_ts_disable,
-        .remove  = __exit_p(inn1510_ts_remove),
-	.penup   = inn1510_ts_penup,
-};
-
-static inline u8 fpga_ts_read(void)
-{
-	return fpga_read(OMAP1510_FPGA_TOUCHSCREEN);
-}
-
-static inline void fpga_ts_write(u8 val)
-{
-	fpga_write(val, OMAP1510_FPGA_TOUCHSCREEN);
-}
-
-static inline void fpga_ts_set_bits(u8 mask)
-{
-	fpga_ts_write(fpga_ts_read() | mask);
-}
-
-static inline void fpga_ts_clear_bits(u8 mask)
-{
-	fpga_ts_write(fpga_ts_read() & ~mask);
-}
-
-static inline void CS_H(void)
-{
-	// EPLD inverts active low signals.
-	fpga_ts_clear_bits(FPGA_TS_BCS);
-}
-
-static inline void CS_L(void)
-{
-	fpga_ts_set_bits(FPGA_TS_BCS);
-}
-
-static inline void SCLK_L(void)
-{
-	fpga_ts_clear_bits(FPGA_TS_BCLK);
-}
-
-static inline void SCLK_H(void)
-{
-	fpga_ts_set_bits(FPGA_TS_BCLK);
-}
-
-static inline void SDI_L(void)
-{
-	fpga_ts_clear_bits(FPGA_TS_BDIN);
-}
-
-static inline void SDI_H(void)
-{
-	fpga_ts_set_bits(FPGA_TS_BDIN);
-}
-
-static inline int BUSY(void)
-{
-	return (((fpga_ts_read() & FPGA_TS_BBUSY) == 0) ? 1 : 0) ;
-}
-
-static inline u8 DOUT(void)
-{	 
-	return ((fpga_ts_read() & FPGA_TS_BOUT) ? 1 : 0) ;
-}
-
-static u16 ads7846_do(u8 cmd)
-{  
-	int i;
-	u16 val=0;
-
-	SCLK_L() ;
-	SDI_L();
-	CS_L() ;	// enable the chip select
-
-	// send the command to the ADS7846
-	for (i=0; i<8; i++ ) {
-		if (cmd & 0x80)
-			SDI_H();
-		else
-			SDI_L();   // prepare the data on line sdi OR din
-
-		SCLK_H() ;      // clk in the data
-		cmd <<= 1 ;
-		SCLK_L() ;
-	}
-
-	SDI_L();
-	while (BUSY())
-		;
-
-	// now read returned data
-	for (i=0 ; i<16 ; i++ ) {
-		SCLK_L() ;
-		
-		if (i < 12) {
-			val <<= 1 ;
-			val |= DOUT();
-		}
-		SCLK_H() ;
-	}
-
-	SCLK_L() ;
-	CS_H() ;   // disable the chip select
-
-	return val;
-}
-
-static int inn1510_ts_penup(void)
-{
-	return ((fpga_ts_read() & FPGA_TS_BPENUP) ? 0 : 1) ;
-}
-
-static int __init inn1510_ts_probe(struct omap_ts_t *ts)
-{
-	if (!cpu_is_omap15xx() || !machine_is_omap_innovator())
-		return -ENODEV;
-
-	ts->irq = OMAP1510_INT_FPGA_TS;
-	ts->irq_type = 0;
-	
-	return 0;
-}
-
-static void inn1510_ts_read(u16 *data)
-{
-	unsigned int Rt = 0;
-
-	data[0] = ads7846_do(MEASURE_12BIT_X);
-	data[1] = ads7846_do(MEASURE_12BIT_Y); 
-	data[2] = ads7846_do(MEASURE_12BIT_Z1); 
-	data[3] = ads7846_do(MEASURE_12BIT_Z2); 
-
-	// Calculate touch pressure resistance
-	if (data[2]) {
-		Rt = (X_PLATE_OHMS * (u32)data[0] *
-		     ((u32)data[3] - (u32)data[2])) / (u32)data[2];
-
-		Rt = (Rt + 2048) >> 12; // round up to nearest ohm
-	}
-
-	data[2] = Rt;
-}
-
-static void inn1510_ts_enable(void)
-{
-
-}
-
-static void inn1510_ts_disable(void)
-{
-
-}
-
-#ifdef MODULE
-static void __exit inn1510_ts_remove(void)
-{
-	/* Nothing to do here */
-}
-#endif
Index: osk/drivers/input/touchscreen/omap/ads7846.h
===================================================================
--- osk.orig/drivers/input/touchscreen/omap/ads7846.h	2005-09-21 12:54:14.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,53 +0,0 @@
-/*
- * ads7846.h - header file for ADS7846 touchscreen controller
- * 
- * Copyright 2002 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	stevel@mvista.com or source@mvista.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef __ADS7846_H
-#define __ADS7846_H
-
-// ADS7846 Control Byte bit defines
-#define ADS7846_S         (1<<7)
-#define ADS7846_ADDR_BIT  4
-#define ADS7846_ADDR_MASK (0x7<<ADS7846_ADDR_BIT)
-#define   ADS7846_MEASURE_X  (0x5<<ADS7846_ADDR_BIT)
-#define   ADS7846_MEASURE_Y  (0x1<<ADS7846_ADDR_BIT)
-#define   ADS7846_MEASURE_Z1 (0x3<<ADS7846_ADDR_BIT)
-#define   ADS7846_MEASURE_Z2 (0x4<<ADS7846_ADDR_BIT)
-#define ADS7846_8BITS     (1<<3)
-#define ADS7846_12BITS    0
-#define ADS7846_SER       (1<<2)
-#define ADS7846_DFR       0
-#define ADS7846_PWR_BIT   0
-#define   ADS7846_PD      0
-#define   ADS7846_ADC_ON  (0x1<<ADS7846_PWR_BIT)
-#define   ADS7846_REF_ON  (0x2<<ADS7846_PWR_BIT)
-#define   ADS7846_REF_ADC_ON (0x3<<ADS7846_PWR_BIT)
-
-#define MEASURE_12BIT_X \
-  (ADS7846_S | ADS7846_MEASURE_X | ADS7846_12BITS | ADS7846_DFR | ADS7846_PD)
-#define MEASURE_12BIT_Y \
-  (ADS7846_S | ADS7846_MEASURE_Y | ADS7846_12BITS | ADS7846_DFR | ADS7846_PD)
-#define MEASURE_12BIT_Z1 \
-  (ADS7846_S | ADS7846_MEASURE_Z1 | ADS7846_12BITS | ADS7846_DFR | ADS7846_PD)
-#define MEASURE_12BIT_Z2 \
-  (ADS7846_S | ADS7846_MEASURE_Z2 | ADS7846_12BITS | ADS7846_DFR | ADS7846_PD)
-
-#endif /* __ADS7846_H */

--Boundary-00=_/xPaEsVWxMQYbvB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_/xPaEsVWxMQYbvB--
