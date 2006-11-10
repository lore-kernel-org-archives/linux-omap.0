From: David Brownell <david-b@pacbell.net>
Subject: Re: patchs commits
Date: Thu, 09 Nov 2006 17:17:31 -0800
Message-ID: <20061110011731.A67731DA327@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20061109205157.GF16172@atomide.com>
	<002701c7044b$fbf4a100$818310ac@mis.cypress.com>
	<20061109234030.GP16172@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061109234030.GP16172@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com, hkh@cypress.com
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > Do you know if the USB OHCI and Gadget are functional for the OMAP2420 H4?
>
> I think after Kyungmin's and Dave's patches it may be close to working
> in linux-omap tree :)

Well, here's the missing "add H4 USB support" patch ... with one
glitch, "doesn't work yet".

- Dave

[PATCH] USB peripheral support on H4

H4 has two peripheral ports, one for "download" and one for OTG.
The one to use is selected through Kconfig.

Also removes some bad whitespace from isp1301_omap.c

NOTE:  not yet working; I suspect there's a clock still turned off
or something like that, since neither port responds.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: h4/arch/arm/mach-omap2/Kconfig
===================================================================
--- h4.orig/arch/arm/mach-omap2/Kconfig	2006-11-03 11:28:25.000000000 -0800
+++ h4/arch/arm/mach-omap2/Kconfig	2006-11-03 11:28:26.000000000 -0800
@@ -41,6 +41,27 @@ config MACH_OMAP_H4_TUSB
 	  Be sure to select OTG mode operation, not host-only or
 	  peripheral-only.
 
+config MACH_OMAP_H4_OTG
+	bool "Use USB OTG connector, not device connector (S1.10)"
+	depends on MACH_OMAP_H4
+	help
+	  Set this if you've set S1.10 (on the mainboard) to use the
+	  Mini-AB (OTG) connector and OTG transceiver with the USB0
+	  port, instead of the Mini-B ("download") connector with its
+	  non-OTG transceiver.
+
+	  Note that the "download" connector can be used to bootstrap
+	  the system from the OMAP mask ROM.  Also, since this is a
+	  development platform, you can also force the OTG port into
+	  a non-OTG operational mode.
+
+config MACH_OMAP2_H4_USB1
+	bool "Use USB1 port, not UART2 (S3.3)"
+	depends on MACH_OMAP_H4
+	help
+	  Set this if you've set SW3.3 (on the CPU card) so that the
+	  expansion connectors receive USB1 signals instead of UART2.
+
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
Index: h4/drivers/usb/gadget/Kconfig
===================================================================
--- h4.orig/drivers/usb/gadget/Kconfig	2006-11-03 11:27:29.000000000 -0800
+++ h4/drivers/usb/gadget/Kconfig	2006-11-03 11:28:26.000000000 -0800
@@ -168,7 +168,7 @@ config USB_GADGET_MUSB_HDRC
 config USB_GADGET_OMAP
 	boolean "OMAP USB Device Controller"
 	depends on ARCH_OMAP
-	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
+	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_H4_OTG
 	help
 	   Many Texas Instruments OMAP processors have flexible full
 	   speed USB device controllers, with support for up to 30
Index: h4/drivers/i2c/chips/isp1301_omap.c
===================================================================
--- h4.orig/drivers/i2c/chips/isp1301_omap.c	2006-11-03 11:27:29.000000000 -0800
+++ h4/drivers/i2c/chips/isp1301_omap.c	2006-11-03 11:28:26.000000000 -0800
@@ -68,7 +68,7 @@ struct isp1301 {
 
 	/* use keventd context to change the state for us */
 	struct work_struct	work;
-	
+
 	unsigned long		todo;
 #		define WORK_UPDATE_ISP	0	/* update ISP from OTG */
 #		define WORK_UPDATE_OTG	1	/* update OTG from ISP */
@@ -306,7 +306,7 @@ static void power_up(struct isp1301 *isp
 {
 	// isp1301_clear_bits(isp, ISP1301_MODE_CONTROL_2, MC2_GLOBAL_PWR_DN);
 	isp1301_clear_bits(isp, ISP1301_MODE_CONTROL_1, MC1_SUSPEND_REG);
-	
+
 	/* do this only when cpu is driving transceiver,
 	 * so host won't see a low speed device...
 	 */
@@ -818,7 +818,7 @@ static irqreturn_t omap_otg_irq(int irq,
 		/* role is host */
 		} else {
 			if (!(otg_ctrl & OTG_ID)) {
-		 		otg_ctrl &= OTG_CTRL_MASK & ~OTG_XCEIV_INPUTS;
+				otg_ctrl &= OTG_CTRL_MASK & ~OTG_XCEIV_INPUTS;
 				OTG_CTRL_REG = otg_ctrl | OTG_A_BUSREQ;
 			}
 
@@ -1245,6 +1245,9 @@ static int isp1301_detach_client(struct 
 	if (machine_is_omap_h3())
 		omap_free_gpio(14);
 
+	if (machine_is_omap_h4())
+		omap_free_gpio(125);
+
 	isp->timer.data = 0;
 	set_bit(WORK_STOP, &isp->todo);
 	del_timer_sync(&isp->timer);
@@ -1266,7 +1269,7 @@ static int isp1301_detach_client(struct 
  *  - DEVICE mode, for when there's a B/Mini-B (device) connector
  *
  * As a rule, you won't have an isp1301 chip unless it's there to
- * support the OTG mode.  Other modes help testing USB controllers 
+ * support the OTG mode.  Other modes help testing USB controllers
  * in isolation from (full) OTG support, or maybe so later board
  * revisions can help to support those feature.
  */
@@ -1282,9 +1285,9 @@ static int isp1301_otg_enable(struct isp
 	 * a few more interrupts than are strictly needed.
 	 */
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_RISING,
-	 	INTR_VBUS_VLD | INTR_SESS_VLD | INTR_ID_GND);
+		INTR_VBUS_VLD | INTR_SESS_VLD | INTR_ID_GND);
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_FALLING,
-	 	INTR_VBUS_VLD | INTR_SESS_VLD | INTR_ID_GND);
+		INTR_VBUS_VLD | INTR_SESS_VLD | INTR_ID_GND);
 
 	dev_info(&isp->client.dev, "ready for dual-role USB ...\n");
 
@@ -1323,14 +1326,15 @@ isp1301_set_host(struct otg_transceiver 
 
 	power_up(isp);
 
+// XXX h4 too?
 	if (machine_is_omap_h2() || machine_is_omap_h3())
 		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1, MC1_DAT_SE0);
 
 	dev_info(&isp->client.dev, "A-Host sessions ok\n");
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_RISING,
-	 	INTR_ID_GND);
+		INTR_ID_GND);
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_FALLING,
-	 	INTR_ID_GND);
+		INTR_ID_GND);
 
 	/* If this has a Mini-AB connector, this mode is highly
 	 * nonstandard ... but can be handy for testing, especially with
@@ -1386,13 +1390,14 @@ isp1301_set_peripheral(struct otg_transc
 	power_up(isp);
 	isp->otg.state = OTG_STATE_B_IDLE;
 
+// XXX h4 too?
 	if (machine_is_omap_h2() || machine_is_omap_h3())
 		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1, MC1_DAT_SE0);
 
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_RISING,
-	 	INTR_SESS_VLD | INTR_VBUS_VLD);
+		INTR_SESS_VLD | INTR_VBUS_VLD);
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_FALLING,
-	 	INTR_VBUS_VLD | INTR_SESS_VLD);
+		INTR_VBUS_VLD | INTR_SESS_VLD);
 	dev_info(&isp->client.dev, "B-Peripheral sessions ok\n");
 	dump_regs(isp, __FUNCTION__);
 
@@ -1589,6 +1594,7 @@ fail1:
 	}
 #endif
 
+// XXX h4 too?
 	if (machine_is_omap_h2() || machine_is_omap_h3()) {
 		/* full speed signaling by default */
 		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1,
@@ -1615,6 +1621,15 @@ fail1:
 		isp->irq_type = SA_TRIGGER_FALLING;
 	}
 
+	if (machine_is_omap_h4()) {
+		/* IRQ wired at P14 */
+		omap_cfg_reg(P14_24XX_GPIO125);
+		isp->irq = OMAP_GPIO_IRQ(125);
+		omap_request_gpio(125);
+		omap_set_gpio_direction(125, 1);
+		isp->irq_type = IRQF_TRIGGER_LOW;
+	}
+
 	status = request_irq(isp->irq, isp1301_irq,
 			isp->irq_type, DRIVER_NAME, isp);
 	if (status < 0) {
Index: h4/arch/arm/mach-omap2/board-h4.c
===================================================================
--- h4.orig/arch/arm/mach-omap2/board-h4.c	2006-11-03 11:28:25.000000000 -0800
+++ h4/arch/arm/mach-omap2/board-h4.c	2006-11-03 11:28:26.000000000 -0800
@@ -362,7 +362,11 @@ static void __init omap_h4_init_irq(void
 }
 
 static struct omap_uart_config h4_uart_config __initdata = {
+#ifdef	CONFIG_MACH_OMAP2_H4_USB1
+	.enabled_uarts = ((1 << 0) | (1 << 1)),
+#else
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
+#endif
 };
 
 static struct omap_mmc_config h4_mmc_config __initdata = {
@@ -379,10 +383,44 @@ static struct omap_lcd_config h4_lcd_con
 	.ctrl_name	= "internal",
 };
 
+static struct omap_usb_config h4_usb_config __initdata = {
+#ifdef	CONFIG_MACH_OMAP2_H4_USB1
+	/* NOTE:  usb1 could also be used with 3 wire signaling */
+	.pins[1]	= 4,
+#endif
+
+#ifdef	CONFIG_MACH_OMAP_H4_OTG
+	/* S1.10 ON -- USB OTG port
+	 * usb0 switched to Mini-AB port and isp1301 transceiver;
+	 * S2.POS3 = OFF, S2.POS4 = ON ... to allow battery charging
+	 */
+	.otg		= 1,
+	.pins[0]	= 4,
+#ifdef	CONFIG_USB_GADGET_OMAP
+	/* use OTG cable, or standard A-to-MiniB */
+	.hmc_mode	= 0x14,	/* 0:dev/otg 1:host 2:disable */
+#elif	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+	/* use OTG cable, or NONSTANDARD (B-to-MiniB) */
+	.hmc_mode	= 0x11,	/* 0:host 1:host 2:disable */
+#endif	/* XX */
+
+#else
+	/* S1.10 OFF -- usb "download port"
+	 * usb0 switched to Mini-B port and isp1105 transceiver;
+	 * S2.POS3 = ON, S2.POS4 = OFF ... to enable battery charging
+	 */
+	.register_dev	= 1,
+	.pins[0]	= 3,
+//	.hmc_mode	= 0x14,	/* 0:dev 1:host 2:disable */
+	.hmc_mode	= 0x00,	/* 0:dev|otg 1:disable 2:disable */
+#endif
+};
+
 static struct omap_board_config_kernel h4_config[] = {
 	{ OMAP_TAG_UART,	&h4_uart_config },
 	{ OMAP_TAG_MMC,		&h4_mmc_config },
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
+	{ OMAP_TAG_USB,		&h4_usb_config },
 };
 
 #ifdef	CONFIG_MACH_OMAP_H4_TUSB
@@ -471,6 +509,14 @@ static void __init omap_h4_init(void)
 	}
 #endif
 
+#ifdef	CONFIG_MACH_OMAP2_H4_USB1
+	/* S3.3 controls whether these pins are for UART2 or USB1 */
+	omap_cfg_reg(N14_24XX_USB1_SE0);
+	omap_cfg_reg(P15_24XX_USB1_DAT);
+	omap_cfg_reg(W20_24XX_USB1_TXEN);
+	omap_cfg_reg(V19_24XX_USB1_RCV);
+#endif
+
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
