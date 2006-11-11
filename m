From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH 4/4] ARM: OMAP: Palm Zire71 minor fixes
Date: Sun, 12 Nov 2006 00:09:53 +0100
Message-ID: <200611120009.53904.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BhlVFbH9TIY78a9"
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

--Boundary-00=_BhlVFbH9TIY78a9
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
this patch makes minor changes in palmz71 board file (formating changes) an=
d=20
renames one GPIO (PALMZ71_PINTDAV_GPIO to PALMZ71_PENIRQ_GPIO) in=20
board-palmz71.h and board-palmz71.c .

Signed-off-by: Marek Va=B9ut <marek.vasut@gmail.com>

--Boundary-00=_BhlVFbH9TIY78a9
Content-Type: text/x-diff; charset="us-ascii";
	name="4-4_palmz71-misc-small-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="4-4_palmz71-misc-small-fixes.patch"

diff -Naur linux-omap-current/arch/arm/mach-omap1/board-palmz71.c linux-omap/arch/arm/mach-omap1/board-palmz71.c
--- linux-omap-current/arch/arm/mach-omap1/board-palmz71.c	2006-11-11 21:12:59.000000000 +0100
+++ linux-omap/arch/arm/mach-omap1/board-palmz71.c	2006-11-11 22:08:27.000000000 +0100
@@ -182,18 +182,17 @@
 #define DEFAULT_BITPERSAMPLE 16
 
 static struct omap_mcbsp_reg_cfg mcbsp_regs = {
-	.spcr2	= FREE | FRST | GRST | XRST | XINTM(3),
-	.spcr1	= RINTM(3) | RRST,
-	.rcr2	= RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
-			RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
-	.rcr1	= RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
-	.xcr2	= XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
-			XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
-	.xcr1	= XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
-	.srgr1	= FWID(DEFAULT_BITPERSAMPLE - 1),
-	.srgr2	= GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
-	/*.pcr0	= FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP, *//* mcbsp: master */
-	.pcr0 = CLKXP | CLKRP,	/* mcbsp: slave */
+	.spcr2		= FREE | FRST | GRST | XRST | XINTM(3),
+	.spcr1		= RINTM(3) | RRST,
+	.rcr2		= RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
+			  RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
+	.rcr1		= RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
+	.xcr2		= XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
+			  XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
+	.xcr1		= XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
+	.srgr1		= FWID(DEFAULT_BITPERSAMPLE - 1),
+	.srgr2		= GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
+	.pcr0		= CLKXP | CLKRP,	/* mcbsp: slave */
 };
 
 static struct omap_alsa_codec_config alsa_config = {
@@ -240,7 +239,7 @@
 static int
 palmz71_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(6);
+	return !omap_get_gpio_datain(PALMZ71_PENIRQ_GPIO);
 }
 
 static const struct ads7846_platform_data palmz71_ts_info = {
@@ -252,16 +251,17 @@
 };
 
 static struct spi_board_info __initdata palmz71_boardinfo[] = {
-{
+    {
 	/* MicroWire (bus 2) CS0 has an ads7846e */
 	.modalias	= "ads7846",
 	.platform_data	= &palmz71_ts_info,
-	.irq		= OMAP_GPIO_IRQ(6),
-	.max_speed_hz	= 120000 /* max sample rate at 3V */
-				* 26 /* command + data + overhead */,
+	.irq		= OMAP_GPIO_IRQ(PALMZ71_PENIRQ_GPIO),
+	.max_speed_hz	= 120000	/* max sample rate at 3V */
+			  * 26		/* command + data + overhead */,
 	.bus_num	= 2,
 	.chip_select	= 0,
-} };
+    }
+};
 
 static struct omap_usb_config palmz71_usb_config __initdata = {
 	.register_dev	= 1,	/* Mini-B only receptacle */
@@ -288,10 +288,10 @@
 };
 
 static struct omap_board_config_kernel palmz71_config[] = {
-	{OMAP_TAG_USB, &palmz71_usb_config},
-	{OMAP_TAG_MMC, &palmz71_mmc_config},
-	{OMAP_TAG_LCD, &palmz71_lcd_config},
-	{OMAP_TAG_UART, &palmz71_uart_config},
+	{OMAP_TAG_USB,	&palmz71_usb_config},
+	{OMAP_TAG_MMC,	&palmz71_mmc_config},
+	{OMAP_TAG_LCD,	&palmz71_lcd_config},
+	{OMAP_TAG_UART,	&palmz71_uart_config},
 };
 
 static irqreturn_t
@@ -343,10 +343,9 @@
 		}
 		omap_set_gpio_direction(PALMZ71_USBDETECT_GPIO, 1);
 		if (request_irq(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
-			palmz71_powercable, SA_SAMPLE_RANDOM,
-			"palmz71-cable", 0))
-				printk(KERN_ERR
-					"IRQ request for power cable failed!\n");
+		    palmz71_powercable, SA_SAMPLE_RANDOM, "palmz71-cable", 0))
+			printk(KERN_ERR
+				"IRQ request for power cable failed!\n");
 		palmz71_powercable(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO), 0, 0);
 	}
 }
diff -Naur linux-omap-current/drivers/video/omap/lcd_palmz71.c linux-omap/drivers/video/omap/lcd_palmz71.c
--- linux-omap-current/drivers/video/omap/lcd_palmz71.c	2006-11-11 21:13:02.000000000 +0100
+++ linux-omap/drivers/video/omap/lcd_palmz71.c	2006-11-11 22:08:27.000000000 +0100
@@ -30,8 +30,6 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/omapfb.h>
 
-/* #define OMAPFB_DBG 1 */
-
 static int palmz71_panel_init(struct omapfb_device *panel)
 {
 	return 0;
diff -Naur linux-omap-current/include/asm-arm/arch-omap/board-palmz71.h linux-omap/include/asm-arm/arch-omap/board-palmz71.h
--- linux-omap-current/include/asm-arm/arch-omap/board-palmz71.h	2006-11-11 21:13:33.000000000 +0100
+++ linux-omap/include/asm-arm/arch-omap/board-palmz71.h	2006-11-11 22:08:27.000000000 +0100
@@ -14,7 +14,7 @@
 #define __OMAP_BOARD_PALMZ71_H
 
 #define PALMZ71_USBDETECT_GPIO	0
-#define PALMZ71_PINTDAV_GPIO	6
+#define PALMZ71_PENIRQ_GPIO	6
 #define PALMZ71_MMC_WP_GPIO	8
 #define PALMZ71_HDQ_GPIO 	11
 

--Boundary-00=_BhlVFbH9TIY78a9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_BhlVFbH9TIY78a9--
