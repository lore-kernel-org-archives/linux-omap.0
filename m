From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.18-omap-git] omap2 fullspeed usb 2/2 (apollon)
Date: Fri, 20 Oct 2006 12:52:01 -0700
Message-ID: <200610201252.01421.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

[PATCH] USB device support on Apollon

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
-----
Needs re-testing ... at this point only Apollon support is expected to behave.

Index: h4/arch/arm/mach-omap2/board-apollon.c
===================================================================
--- h4.orig/arch/arm/mach-omap2/board-apollon.c	2006-10-18 01:40:22.000000000 -0700
+++ h4/arch/arm/mach-omap2/board-apollon.c	2006-10-18 01:41:54.000000000 -0700
@@ -234,6 +234,13 @@ static struct omap_mmc_config apollon_mm
 	},
 };
 
+static struct omap_usb_config apollon_usb_config __initdata = {
+	.register_dev	= 1,
+	.hmc_mode	= 0x14,	/* 0:dev 1:host1 2: disable */
+
+	.pins[0]	= 6,
+};
+
 static struct omap_lcd_config apollon_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -241,6 +248,7 @@ static struct omap_lcd_config apollon_lc
 static struct omap_board_config_kernel apollon_config[] = {
 	{ OMAP_TAG_UART,	&apollon_uart_config },
 	{ OMAP_TAG_MMC,		&apollon_mmc_config },
+	{ OMAP_TAG_USB,		&apollon_usb_config },
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
@@ -292,28 +300,35 @@ static void __init apollon_sw_init(void)
 	omap_request_gpio(SW_DOWN_GPIO58);
 	omap_set_gpio_direction(SW_DOWN_GPIO58, 1);
 
-	set_irq_type(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), IRQT_RISING);
 	if (request_irq(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), &apollon_sw_interrupt,
 				IRQF_SHARED, "enter sw",
 				&apollon_sw_interrupt))
 		return;
-	set_irq_type(OMAP_GPIO_IRQ(SW_UP_GPIO17), IRQT_RISING);
 	if (request_irq(OMAP_GPIO_IRQ(SW_UP_GPIO17), &apollon_sw_interrupt,
 				IRQF_SHARED, "up sw",
 				&apollon_sw_interrupt))
 		return;
-	set_irq_type(OMAP_GPIO_IRQ(SW_DOWN_GPIO58), IRQT_RISING);
 	if (request_irq(OMAP_GPIO_IRQ(SW_DOWN_GPIO58), &apollon_sw_interrupt,
 				IRQF_SHARED, "down sw",
 				&apollon_sw_interrupt))
 		return;
 }
 
+static void __init apollon_usb_init(void)
+{
+	/* USB device */
+	/* DEVICE_SUSPEND */
+	omap_cfg_reg(P21_242X_GPIO12);
+	omap_set_gpio_direction(12, 0);
+	omap_set_gpio_dataout(12, 0);
+}
+
 static void __init omap_apollon_init(void)
 {
 	apollon_led_init();
 	apollon_sw_init();
 	apollon_flash_init();
+	apollon_usb_init();
 
 	/* REVISIT: where's the correct place */
 	omap_cfg_reg(W19_24XX_SYS_NIRQ);
