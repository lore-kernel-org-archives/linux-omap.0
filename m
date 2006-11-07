From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: PalmTT
Date: Tue, 7 Nov 2006 21:58:15 +0100
Message-ID: <200611072158.15804.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nNPUFNnoC+YeoSD"
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

--Boundary-00=_nNPUFNnoC+YeoSD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I=B4ve pulled latest git snapshot and it seems palmtt is there (all four=20
patches - board, defconfig, lcd, leds), but as Tony wrote I had to fix thos=
e=20
tabs (formating) before it=B4ll be (maybe ;-)) merged. I havent seen any=20
mention about merging TT on gitweb so I was just curious why is it there :)

Well ... doesnt matter ... here=B4s a patch that fixes formating in=20
board-palmtt.c and lcd-palmtt.c (formating - tabs and removing commented=20
code). I=B4ve also made a small change to board-palmz71.c formating.

Plus I changed GPIO 6 name in board-palmz71(tt).h (renamed=20
PALMxxx_PINTDAV_GPIO to PALMxxx_PENIRQ_GPIO, where xxx=3DTT or Z71). Hope i=
t=20
doesnt matter I put it into one patch while it=B4s a small (one line - see =
the=20
bottom of the patch) change.

Patch is enclosed.

BR
Marek

--Boundary-00=_nNPUFNnoC+YeoSD
Content-Type: text/x-diff; charset="iso-8859-1";
	name="palmtt_palmz71_formating_fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="palmtt_palmz71_formating_fixes.patch"

diff -Naur linux-omap-current/arch/arm/mach-omap1/board-palmtt.c linux-omap/arch/arm/mach-omap1/board-palmtt.c
--- linux-omap-current/arch/arm/mach-omap1/board-palmtt.c	2006-11-03 19:30:45.000000000 +0100
+++ linux-omap/arch/arm/mach-omap1/board-palmtt.c	2006-11-03 20:40:38.000000000 +0100
@@ -63,40 +63,40 @@
 
 static struct mtd_partition palmtt_partitions[] = {
 	{
-	      .name		= "write8k",
-	      .offset		= 0,
-	      .size		= SZ_8K,
-	      .mask_flags	= 0,
+	    .name		= "write8k",
+	    .offset		= 0,
+	    .size		= SZ_8K,
+	    .mask_flags		= 0,
 	},
 	{
-	      .name		= "PalmOS-BootLoader(ro)",
-	      .offset		= SZ_8K,
-	      .size		= 7*SZ_8K,
-	      .mask_flags	= MTD_WRITEABLE,
+	    .name		= "PalmOS-BootLoader(ro)",
+	    .offset		= SZ_8K,
+	    .size		= 7*SZ_8K,
+	    .mask_flags		= MTD_WRITEABLE,
 	},
 	{
-	      .name		= "u-boot",
-	      .offset		= MTDPART_OFS_APPEND,
-	      .size		= 8*SZ_8K,
-	      .mask_flags	= 0,
+	    .name		= "u-boot",
+	    .offset		= MTDPART_OFS_APPEND,
+	    .size		= 8*SZ_8K,
+	    .mask_flags		= 0,
 	},
 	{
-	      .name		= "PalmOS-FS(ro)",
-	      .offset		= MTDPART_OFS_APPEND,
-	      .size		= 7*SZ_1M + 4*SZ_64K - 16*SZ_8K,
-	      .mask_flags	= MTD_WRITEABLE,
+	    .name		= "PalmOS-FS(ro)",
+	    .offset		= MTDPART_OFS_APPEND,
+	    .size		= 7*SZ_1M + 4*SZ_64K - 16*SZ_8K,
+	    .mask_flags		= MTD_WRITEABLE,
 	},
 	{
-	      .name		= "u-boot(rez)",
-	      .offset		= MTDPART_OFS_APPEND,
-	      .size		= SZ_128K,
-	      .mask_flags	= 0
+	    .name		= "u-boot(rez)",
+	    .offset		= MTDPART_OFS_APPEND,
+	    .size		= SZ_128K,
+	    .mask_flags		= 0
 	},
 	{
-	      .name		= "empty",
-	      .offset		= MTDPART_OFS_APPEND,
-	      .size		= MTDPART_SIZ_FULL,
-	      .mask_flags	= 0
+	    .name		= "empty",
+	    .offset		= MTDPART_OFS_APPEND,
+	    .size		= MTDPART_SIZ_FULL,
+	    .mask_flags		= 0
 	}
 };
 
@@ -126,18 +126,20 @@
 #define DEFAULT_BITPERSAMPLE 16
 
 static struct omap_mcbsp_reg_cfg mcbsp_regs = {
-	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
-	.spcr1 = RINTM(3) | RRST,
-	.rcr2 = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
-	    RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
-	.rcr1 = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
-	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
-	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
-	.xcr1 = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
-	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
-	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
-	/*.pcr0 = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,*/ /* mcbsp: master */
-	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
+	.spcr2		= FREE | FRST | GRST | XRST | XINTM(3),
+	.spcr1		= RINTM(3) | RRST,
+	.rcr2		= RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
+	    		  RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
+	.rcr1		= RFRLEN1(OMAP_MCBSP_WORD_8) |
+			  RWDLEN1(OMAP_MCBSP_WORD_16),
+	.xcr2		= XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
+		          XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
+	.xcr1		= XFRLEN1(OMAP_MCBSP_WORD_8) |
+			  XWDLEN1(OMAP_MCBSP_WORD_16),
+	.srgr1		= FWID(DEFAULT_BITPERSAMPLE - 1),
+	.srgr2		= GSYNC | CLKSP | FSGM |
+			  FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
+	.pcr0		= CLKXP | CLKRP,  /* mcbsp: slave */
 };
 
 static struct omap_alsa_codec_config alsa_config = {
@@ -153,8 +155,8 @@
 
 static struct platform_device palmtt_mcbsp1_device = {
 	.name	= "omap_alsa_mcbsp",
- 	.id	= 1,
-	.dev = {
+	.id	= 1,
+	.dev	= {
 		.platform_data	= &alsa_config,
 	},
 };
@@ -188,69 +190,69 @@
 	.id		= -1,
 };
 static struct omap_irda_config palmtt_irda_config = {
-        .transceiver_cap        = IR_SIRMODE,
-        .rx_channel             = OMAP_DMA_UART3_RX,
-        .tx_channel             = OMAP_DMA_UART3_TX,
-        .dest_start             = UART3_THR,
-        .src_start              = UART3_RHR,
-        .tx_trigger             = 0,
-        .rx_trigger             = 0,
+	.transceiver_cap	= IR_SIRMODE,
+	.rx_channel		= OMAP_DMA_UART3_RX,
+	.tx_channel		= OMAP_DMA_UART3_TX,
+	.dest_start		= UART3_THR,
+	.src_start		= UART3_RHR,
+	.tx_trigger		= 0,
+	.rx_trigger		= 0,
 };
 
 static struct resource palmtt_irda_resources[] = {
-        [0]     = {
-            .start  = INT_UART3,
-            .end    = INT_UART3,
-            .flags  = IORESOURCE_IRQ,
-        },
+	[0]	= {
+	    .start	= INT_UART3,
+	    .end	= INT_UART3,
+	    .flags	= IORESOURCE_IRQ,
+	},
 };
 
 static struct platform_device palmtt_irda_device = {
-        .name           = "omapirda",
-        .id             = -1,
-        .dev            = {
-                .platform_data  = &palmtt_irda_config,
-        },
-        .num_resources  = ARRAY_SIZE(palmtt_irda_resources),
-        .resource       = palmtt_irda_resources,
+	.name		= "omapirda",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &palmtt_irda_config,
+	},
+	.num_resources	= ARRAY_SIZE(palmtt_irda_resources),
+	.resource	= palmtt_irda_resources,
 };
 
 static struct platform_device palmtt_spi_device = {
-        .name           = "spi_palmtt",
-        .id             = -1,
+	.name		= "spi_palmtt",
+	.id		= -1,
 };
 
 static struct omap_backlight_config palmtt_backlight_config = {
-        .default_intensity      = 0xa0,
+        .default_intensity	= 0xa0,
 	};
 
 static struct platform_device palmtt_backlight_device = {
-        .name           = "omap-bl",
-        .id             = -1,
-        .dev            = {
-                .platform_data  = &palmtt_backlight_config,
-        },
+	.name		= "omap-bl",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &palmtt_backlight_config,
+	},
 };
 
 static struct omap_led_config palmtt_led_config[] = {
-        {
-		.cdev   = {
-			.name   = "palmtt:led0",
+	{
+		.cdev	= {
+			.name	= "palmtt:led0",
 		},
-		.gpio   = PALMTT_LED_GPIO,
+		.gpio	= PALMTT_LED_GPIO,
 	},
 };
 
 static struct omap_led_platform_data palmtt_led_data = {
-	.nr_leds        = ARRAY_SIZE(palmtt_led_config),
-	.leds           = palmtt_led_config,
+	.nr_leds	= ARRAY_SIZE(palmtt_led_config),
+        .leds		= palmtt_led_config,
 };
 
 static struct platform_device palmtt_led_device = {
-	.name           = "omap-led",
-	.id             = -1,
-	.dev            = {
-		.platform_data  = &palmtt_led_data,
+	.name		= "omap-led",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &palmtt_led_data,
 	},
 };
 
@@ -262,34 +264,34 @@
 	&palmtt_irda_device,
 	&palmtt_spi_device,
 	&palmtt_backlight_device,
-        &palmtt_led_device,
+	&palmtt_led_device,
 };
 
 static int palmtt_get_pendown_state(void)
 {
-    return !omap_get_gpio_datain(6);
+	return !omap_get_gpio_datain(PALMTT_PENIRQ_GPIO);
 }
 
 static const struct ads7846_platform_data palmtt_ts_info = {
-    .model                      = 7846,
-    .vref_delay_usecs           = 100,  /* internal, no capacitor */
-    .x_plate_ohms               = 419,
-    .y_plate_ohms               = 486,
-    .get_pendown_state          = palmtt_get_pendown_state,
-};
-
-static struct spi_board_info __initdata palmtt_boardinfo[] = { {
-    /* MicroWire (bus 2) CS0 has an ads7846e */
-    .modalias                   = "ads7846",
-    .platform_data              = &palmtt_ts_info,
-    .irq                        = OMAP_GPIO_IRQ(6),
-    .max_speed_hz               = 120000 /* max sample rate at 3V */
-                                  * 26 /* command + data + overhead */,
-    .bus_num                    = 2,
-    .chip_select                = 0,
-} };
-
-//static int __initdata palmtt_serial_ports[OMAP_MAX_NR_PORTS] = {1, 1, 1};
+    .model		= 7846,
+    .vref_delay_usecs	= 100,  /* internal, no capacitor */
+    .x_plate_ohms	= 419,
+    .y_plate_ohms	= 486,
+    .get_pendown_state	= palmtt_get_pendown_state,
+};
+
+static struct spi_board_info __initdata palmtt_boardinfo[] = {
+    {
+	/* MicroWire (bus 2) CS0 has an ads7846e */
+        .modalias		= "ads7846",
+	.platform_data		= &palmtt_ts_info,
+        .irq			= OMAP_GPIO_IRQ(PALMTT_PENIRQ_GPIO),
+	.max_speed_hz		= 120000	/* max sample rate at 3V */
+				  * 26		/* command + data + overhead */,
+        .bus_num		= 2,
+	.chip_select		= 0,
+    }
+};
 
 static void __init omap_palmtt_init_irq(void)
 {
@@ -308,7 +310,7 @@
 };
 
 static struct omap_uart_config palmtt_uart_config __initdata = {
-        .enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
+	.enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
 };
 
 static struct omap_board_config_kernel palmtt_config[] = {
@@ -316,19 +318,6 @@
 	{ OMAP_TAG_LCD,		&palmtt_lcd_config  },
         { OMAP_TAG_UART,	&palmtt_uart_config },
 };
-/*should be fixed soon*/
-/*static irqreturn_t
-palmtt_powercable(int irq, void *dev_id, struct pt_regs *regs)
-{
-        if (omap_get_gpio_datain(PALMTT_USBDETECT_GPIO)) {
-            printk(KERN_INFO "PM: USB cable connected (charging)\n");
-            set_irq_type(OMAP_GPIO_IRQ(PALMTT_USBDETECT_GPIO), IRQT_FALLING);
-        } else {
-            printk(KERN_INFO "PM: USB cable disconnected\n");
-            set_irq_type(OMAP_GPIO_IRQ(PALMTT_USBDETECT_GPIO), IRQT_RISING);
-        }
-        return IRQ_HANDLED;
-}*/
 
 static void __init omap_mpu_wdt_mode(int mode) {
         if (mode)
@@ -338,28 +327,9 @@
             omap_writew(0x00a0, OMAP_WDT_TIMER_MODE);
         }
 }
-/*needs to be fixed, this will be simple*/
-/*static void __init palmtt_gpio_setup(int early)
-{
-    if (early) {
-	omap_set_gpio_dataout(1,1);
-        omap_set_gpio_direction(1,0);
-    } else {
-        if (omap_request_gpio(PALMTT_USBDETECT_GPIO)) {
-            printk(KERN_ERR "Could not reserve cable signal GPIO!\n");
-            return;
-        }
-        omap_set_gpio_direction(PALMTT_USBDETECT_GPIO, 1);
-        if (request_irq(OMAP_GPIO_IRQ(PALMTT_USBDETECT_GPIO), palmtt_powercable,
-            SA_SAMPLE_RANDOM, "palmtt-cable", 0))
-            printk(KERN_ERR "IRQ request for power cable failed!\n");
-        palmtt_powercable(OMAP_GPIO_IRQ(PALMTT_USBDETECT_GPIO), 0, 0);
-    }
-}*/
 
 static void __init omap_palmtt_init(void)
 {
-//	palmtt_gpio_setup(1);
         omap_mpu_wdt_mode(0);
 
 	omap_board_config = palmtt_config;
@@ -369,7 +339,6 @@
 
         spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));
 	omap_serial_init();
-//        palmtt_gpio_setup(0);
 }
 
 static void __init omap_palmtt_map_io(void)
@@ -377,7 +346,7 @@
 	omap1_map_common_io();
 }
 
-MACHINE_START(OMAP_PALMTT, "PalmTT")
+MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
 	.phys_io	= 0xfff00000,
 	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
 	.boot_params	= 0x10000100,
diff -Naur linux-omap-current/arch/arm/mach-omap1/board-palmz71.c linux-omap/arch/arm/mach-omap1/board-palmz71.c
--- linux-omap-current/arch/arm/mach-omap1/board-palmz71.c	2006-11-03 19:30:45.000000000 +0100
+++ linux-omap/arch/arm/mach-omap1/board-palmz71.c	2006-11-03 20:40:20.000000000 +0100
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
diff -Naur linux-omap-current/drivers/video/omap/lcd_palmtt.c linux-omap/drivers/video/omap/lcd_palmtt.c
--- linux-omap-current/drivers/video/omap/lcd_palmtt.c	2006-11-03 19:31:00.000000000 +0100
+++ linux-omap/drivers/video/omap/lcd_palmtt.c	2006-11-03 20:47:44.000000000 +0100
@@ -60,26 +60,28 @@
 }
 
 struct lcd_panel palmtt_panel = {
-	.name       = "palmtt",
-	.config	    = OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC | OMAP_LCDC_INV_HSYNC | OMAP_LCDC_HSVS_RISING_EDGE | OMAP_LCDC_HSVS_OPPOSITE,
-	.bpp = 16,
-	.data_lines = 16,
-	.x_res = 320,
-	.y_res = 320,
-	.pixel_clock = 10000,
-	.hsw = 4,
-	.hfp = 8,
-	.hbp = 28,
-	.vsw = 1,
-	.vfp = 8,
-	.vbp = 7,
-	.pcd = 0,
-
-	.init	 = palmtt_panel_init,
-	.cleanup = palmtt_panel_cleanup,
-	.enable  = palmtt_panel_enable,
-	.disable = palmtt_panel_disable,
-	.get_caps= palmtt_panel_get_caps,
+	.name		= "palmtt",
+	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_HSYNC | OMAP_LCDC_HSVS_RISING_EDGE |
+			  OMAP_LCDC_HSVS_OPPOSITE,
+	.bpp		= 16,
+	.data_lines	= 16,
+	.x_res		= 320,
+	.y_res		= 320,
+	.pixel_clock	= 10000,
+	.hsw		= 4,
+	.hfp		= 8,
+	.hbp		= 28,
+	.vsw		= 1,
+	.vfp		= 8,
+	.vbp		= 7,
+	.pcd		= 0,
+
+	.init		= palmtt_panel_init,
+	.cleanup	= palmtt_panel_cleanup,
+	.enable		= palmtt_panel_enable,
+	.disable	= palmtt_panel_disable,
+	.get_caps	= palmtt_panel_get_caps,
 };
 
 static int palmtt_panel_probe(struct platform_device *pdev)
@@ -126,4 +128,3 @@
 
 module_init(palmtt_panel_drv_init);
 module_exit(palmtt_panel_drv_cleanup);
-
diff -Naur linux-omap-current/drivers/video/omap/lcd_palmz71.c linux-omap/drivers/video/omap/lcd_palmz71.c
--- linux-omap-current/drivers/video/omap/lcd_palmz71.c	2006-11-03 19:31:00.000000000 +0100
+++ linux-omap/drivers/video/omap/lcd_palmz71.c	2006-11-03 20:47:52.000000000 +0100
@@ -30,8 +30,6 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/omapfb.h>
 
-/* #define OMAPFB_DBG 1 */
-
 static int palmz71_panel_init(struct omapfb_device *panel)
 {
 	return 0;
diff -Naur linux-omap-current/include/asm-arm/arch-omap/board-palmtt.h linux-omap/include/asm-arm/arch-omap/board-palmtt.h
--- linux-omap-current/include/asm-arm/arch-omap/board-palmtt.h	2006-11-03 19:31:16.000000000 +0100
+++ linux-omap/include/asm-arm/arch-omap/board-palmtt.h	2006-11-03 20:24:51.000000000 +0100
@@ -16,8 +16,8 @@
 #define PALMTT_USBDETECT_GPIO	0
 #define PALMTT_CABLE_GPIO	1
 #define PALMTT_LED_GPIO		3
-#define PALMTT_PINTDAV_GPIO	6
+#define PALMTT_PENIRQ_GPIO	6
 #define PALMTT_MMC_WP_GPIO	8
-#define PALMTT_HDQ_GPIO 	11
+#define PALMTT_HDQ_GPIO		11
 
 #endif	/* __OMAP_BOARD_PALMTT_H */
diff -Naur linux-omap-current/include/asm-arm/arch-omap/board-palmz71.h linux-omap/include/asm-arm/arch-omap/board-palmz71.h
--- linux-omap-current/include/asm-arm/arch-omap/board-palmz71.h	2006-11-03 19:31:16.000000000 +0100
+++ linux-omap/include/asm-arm/arch-omap/board-palmz71.h	2006-11-03 20:34:43.000000000 +0100
@@ -14,7 +14,7 @@
 #define __OMAP_BOARD_PALMZ71_H
 
 #define PALMZ71_USBDETECT_GPIO	0
-#define PALMZ71_PINTDAV_GPIO	6
+#define PALMZ71_PENIRQ_GPIO	6
 #define PALMZ71_MMC_WP_GPIO	8
 #define PALMZ71_HDQ_GPIO 	11
 

--Boundary-00=_nNPUFNnoC+YeoSD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_nNPUFNnoC+YeoSD--
