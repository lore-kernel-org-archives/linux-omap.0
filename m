From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git 2/4] use gpio_direction_input()
Date: Wed, 22 Oct 2008 23:54:37 -0700
Message-ID: <200810222354.37983.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:27099 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751331AbYJWHCP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2008 03:02:15 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

More switchover to the cross-platform GPIO interface:
use gpio_direction_input(), not an OMAP-specific call.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap1/board-palmte.c     |    4 ++--
 arch/arm/mach-omap1/board-palmz71.c    |    4 ++--
 arch/arm/mach-omap1/board-voiceblue.c  |    2 +-
 arch/arm/mach-omap1/fpga.c             |    2 +-
 arch/arm/mach-omap1/serial.c           |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c    |    4 ++--
 arch/arm/mach-omap2/board-3430sdp.c    |    4 ++--
 arch/arm/mach-omap2/board-apollon.c    |    4 ++--
 arch/arm/mach-omap2/board-ldp.c        |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c   |    4 ++--
 arch/arm/mach-omap2/usb-tusb6010.c     |    2 +-
 arch/arm/plat-omap/debug-devices.c     |    2 +-
 arch/arm/plat-omap/gpio-switch.c       |    5 ++++-
 drivers/bluetooth/brf6150.c            |    2 +-
 drivers/bluetooth/hci_h4p/core.c       |    2 +-
 drivers/cbus/cbus.c                    |    4 ++--
 drivers/cbus/retu.c                    |    2 +-
 drivers/cbus/tahvo.c                   |    2 +-
 drivers/input/touchscreen/omap/ts_hx.c |    2 +-
 drivers/input/touchscreen/tsc2005.c    |    2 +-
 drivers/mtd/onenand/omap2.c            |    2 +-
 drivers/usb/host/ohci-omap.c           |    2 +-
 22 files changed, 32 insertions(+), 29 deletions(-)

--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -373,14 +373,14 @@ static void __init palmte_misc_gpio_setu
 		printk(KERN_ERR "Could not reserve PINTDAV GPIO!\n");
 		return;
 	}
-	omap_set_gpio_direction(PALMTE_PINTDAV_GPIO, 1);
+	gpio_direction_input(PALMTE_PINTDAV_GPIO);
 
 	/* Set USB-or-DC-IN pin as input (unused) */
 	if (omap_request_gpio(PALMTE_USB_OR_DC_GPIO)) {
 		printk(KERN_ERR "Could not reserve cable signal GPIO!\n");
 		return;
 	}
-	omap_set_gpio_direction(PALMTE_USB_OR_DC_GPIO, 1);
+	gpio_direction_input(PALMTE_USB_OR_DC_GPIO);
 }
 
 static void __init omap_palmte_init(void)
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -320,7 +320,7 @@ palmz71_gpio_setup(int early)
 			printk(KERN_ERR "Could not reserve WP GPIO!\n");
 			return;
 		}
-		omap_set_gpio_direction(PALMZ71_MMC_WP_GPIO, 1);
+		gpio_direction_input(PALMZ71_MMC_WP_GPIO);
 
 		/* Monitor the Power-cable-connected signal */
 		if (omap_request_gpio(PALMZ71_USBDETECT_GPIO)) {
@@ -328,7 +328,7 @@ palmz71_gpio_setup(int early)
 				"Could not reserve cable signal GPIO!\n");
 			return;
 		}
-		omap_set_gpio_direction(PALMZ71_USBDETECT_GPIO, 1);
+		gpio_direction_input(PALMZ71_USBDETECT_GPIO);
 		if (request_irq(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
 				palmz71_powercable, IRQF_SAMPLE_RANDOM,
 				"palmz71-cable", 0))
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -247,7 +247,7 @@ void voiceblue_wdt_disable(void)
 	gpio_set_value(0, 0);
 	gpio_set_value(0, 1);
 	gpio_set_value(0, 0);
-	omap_set_gpio_direction(0, 1);
+	gpio_direction_input(0);
 }
 
 void voiceblue_wdt_ping(void)
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -180,7 +180,7 @@ void omap1510_fpga_init_irq(void)
 	 * gpio.[ch]
 	 */
 	omap_request_gpio(13);
-	omap_set_gpio_direction(13, 1);
+	gpio_direction_input(13);
 	set_irq_type(OMAP_GPIO_IRQ(13), IRQ_TYPE_EDGE_RISING);
 	set_irq_chained_handler(OMAP1510_INT_FPGA, innovator_fpga_IRQ_demux);
 }
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -250,7 +250,7 @@ static void __init omap_serial_set_port_
 		       gpio_nr);
 		return;
 	}
-	omap_set_gpio_direction(gpio_nr, 1);
+	gpio_direction_input(gpio_nr);
 	ret = request_irq(OMAP_GPIO_IRQ(gpio_nr), &omap_serial_wake_interrupt,
 			  IRQF_TRIGGER_RISING, "serial wakeup", NULL);
 	if (ret) {
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -216,7 +216,7 @@ static void ads7846_dev_init(void)
 	if (omap_request_gpio(TS_GPIO) < 0)
 		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
 
-	omap_set_gpio_direction(TS_GPIO, 1);
+	gpio_direction_input(TS_GPIO);
 
 	omap_set_gpio_debounce(TS_GPIO, 1);
 	omap_set_gpio_debounce_time(TS_GPIO, 0xa);
@@ -313,7 +313,7 @@ static inline void __init sdp2430_init_s
 		gpmc_cs_free(eth_cs);
 		goto out;
 	}
-	omap_set_gpio_direction(OMAP24XX_ETHR_GPIO_IRQ, 1);
+	gpio_direction_input(OMAP24XX_ETHR_GPIO_IRQ);
 
 out:
 	clk_disable(gpmc_fck);
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -168,7 +168,7 @@ static void ads7846_dev_init(void)
 		return;
 	}
 
-	omap_set_gpio_direction(ts_gpio, 1);
+	gpio_direction_input(ts_gpio);
 
 	omap_set_gpio_debounce(ts_gpio, 1);
 	omap_set_gpio_debounce_time(ts_gpio, 0xa);
@@ -276,7 +276,7 @@ static inline void __init sdp3430_init_s
 			eth_gpio);
 		return;
 	}
-	omap_set_gpio_direction(eth_gpio, 1);
+	gpio_direction_input(eth_gpio);
 }
 
 static void __init omap_3430sdp_init_irq(void)
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -314,7 +314,7 @@ static inline void __init apollon_init_s
 		gpmc_cs_free(eth_cs);
 		goto out;
 	}
-	omap_set_gpio_direction(APOLLON_ETHR_GPIO_IRQ, 1);
+	gpio_direction_input(APOLLON_ETHR_GPIO_IRQ);
 
 out:
 	clk_disable(gpmc_fck);
@@ -401,7 +401,7 @@ static void __init apollon_tsc_init(void
 	/* TSC2101 */
 	omap_cfg_reg(N15_24XX_GPIO85);
 	omap_request_gpio(85);
-	omap_set_gpio_direction(85, 1);
+	gpio_direction_input(85);
 
 	omap_cfg_reg(W14_24XX_SYS_CLKOUT);	/* mclk */
 }
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -97,7 +97,7 @@ static void ads7846_dev_init(void)
 		return;
 	}
 
-	omap_set_gpio_direction(ts_gpio, 1);
+	gpio_direction_input(ts_gpio);
 
 	omap_set_gpio_debounce(ts_gpio, 1);
 	omap_set_gpio_debounce_time(ts_gpio, 0xa);
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -82,7 +82,7 @@ static inline void __init omap3evm_init_
 		return;
 	}
 
-	omap_set_gpio_direction(OMAP3EVM_ETHR_GPIO_IRQ, 1);
+	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
 }
 
 static struct omap_uart_config omap3_evm_uart_config __initdata = {
@@ -174,7 +174,7 @@ static void ads7846_dev_init(void)
 	if (omap_request_gpio(OMAP3_EVM_TS_GPIO) < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
-	omap_set_gpio_direction(OMAP3_EVM_TS_GPIO, 1);
+	gpio_direction_input(OMAP3_EVM_TS_GPIO);
 
 	omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1);
 	omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa);
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -295,7 +295,7 @@ tusb6010_setup_interface(struct musb_hdr
 		printk(error, 3, status);
 		return status;
 	}
-	omap_set_gpio_direction(irq, 1);
+	gpio_direction_input(irq);
 	tusb_resources[2].start = irq + IH_GPIO_BASE;
 
 	/* set up memory timings ... can speed them up later */
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -77,7 +77,7 @@ int __init debug_card_init(u32 addr, uns
 		printk(KERN_ERR "GPIO%d unavailable for smc91x IRQ\n", gpio);
 		return status;
 	}
-	omap_set_gpio_direction(gpio, 1);
+	gpio_direction_input(gpio);
 
 	led_resources[0].start = addr;
 	led_resources[0].end   = addr + SZ_4K - 1;
--- a/arch/arm/plat-omap/gpio-switch.c
+++ b/arch/arm/plat-omap/gpio-switch.c
@@ -286,7 +286,10 @@ static int __init new_switch(struct gpio
 
 	/* input: 1, output: 0 */
 	direction = !(sw->flags & OMAP_GPIO_SWITCH_FLAG_OUTPUT);
-	omap_set_gpio_direction(sw->gpio, direction);
+	if (direction)
+		gpio_direction_input(sw->gpio);
+	else
+		gpio_direction_output(sw->gpio, true);
 
 	sw->state = gpio_sw_get_state(sw);
 
--- a/drivers/bluetooth/brf6150.c
+++ b/drivers/bluetooth/brf6150.c
@@ -945,7 +945,7 @@ static int __init brf6150_init(void)
 
 	omap_set_gpio_direction(info->btinfo->reset_gpio, 0);
 	omap_set_gpio_direction(info->btinfo->bt_wakeup_gpio, 0);
-	omap_set_gpio_direction(info->btinfo->host_wakeup_gpio, 1);
+	gpio_direction_input(info->btinfo->host_wakeup_gpio);
 	set_irq_type(OMAP_GPIO_IRQ(info->btinfo->host_wakeup_gpio), IRQ_TYPE_NONE);
 
 	switch (info->btinfo->bt_uart) {
--- a/drivers/bluetooth/hci_h4p/core.c
+++ b/drivers/bluetooth/hci_h4p/core.c
@@ -854,7 +854,7 @@ static int hci_h4p_probe(struct platform
 
 	omap_set_gpio_direction(info->reset_gpio, 0);
 	omap_set_gpio_direction(info->bt_wakeup_gpio, 0);
-	omap_set_gpio_direction(info->host_wakeup_gpio, 1);
+	gpio_direction_input(info->host_wakeup_gpio);
 
 	switch (bt_config->bt_uart) {
 	case 1:
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -112,7 +112,7 @@ static void _cbus_send_bit(struct cbus_h
 
 	/* The data bit is read on the rising edge of CLK */
 	if (set_to_input)
-		omap_set_gpio_direction(host->dat_gpio, 1);
+		gpio_direction_input(host->dat_gpio);
 
 	gpio_set_value(host->clk_gpio, 0);
 }
@@ -264,7 +264,7 @@ int __init cbus_bus_init(void)
 	gpio_set_value(chost->sel_gpio, 1);
 
 	omap_set_gpio_direction(chost->clk_gpio, 0);
-	omap_set_gpio_direction(chost->dat_gpio, 1);
+	gpio_direction_input(chost->dat_gpio);
 	omap_set_gpio_direction(chost->sel_gpio, 0);
 
 	gpio_set_value(chost->clk_gpio, 1);
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -341,7 +341,7 @@ static int __devinit retu_probe(struct d
 	}
 
 	/* Set the pin as input */
-	omap_set_gpio_direction(retu_irq_pin, 1);
+	gpio_direction_input(retu_irq_pin);
 
 	/* Rising edge triggers the IRQ */
 	set_irq_type(OMAP_GPIO_IRQ(retu_irq_pin), IRQ_TYPE_EDGE_RISING);
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -328,7 +328,7 @@ static int __devinit tahvo_probe(struct 
 	}
 
 	/* Set the pin as input */
-	omap_set_gpio_direction(tahvo_irq_pin, 1);
+	gpio_direction_input(tahvo_irq_pin);
 
 	/* Rising edge triggers the IRQ */
 	set_irq_type(OMAP_GPIO_IRQ(tahvo_irq_pin), IRQ_TYPE_EDGE_RISING);
--- a/drivers/input/touchscreen/omap/ts_hx.c
+++ b/drivers/input/touchscreen/omap/ts_hx.c
@@ -97,7 +97,7 @@ static int __init hx_ts_probe(struct oma
 		return -EINVAL;
 	};
 
-	omap_set_gpio_direction(gpio, 1);
+	gpio_direction_input(gpio);
 	ts->irq_type = IRQF_TRIGGER_FALLING;
 	return 0;
 }
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -540,7 +540,7 @@ static int __devinit tsc2005_ts_init(str
 		dev_err(&ts->spi->dev, "unable to get DAV GPIO");
 		goto err1;
 	}
-	omap_set_gpio_direction(dav_gpio, 1);
+	gpio_direction_input(dav_gpio);
 	ts->irq = OMAP_GPIO_IRQ(dav_gpio);
 	dev_dbg(&ts->spi->dev, "TSC2005: DAV IRQ = %d\n", ts->irq);
 #endif
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -615,7 +615,7 @@ static int __devinit omap2_onenand_probe
 				"OneNAND\n", c->gpio_irq);
 			goto err_iounmap;
 	}
-	omap_set_gpio_direction(c->gpio_irq, 1);
+	gpio_direction_input(c->gpio_irq);
 
 	if ((r = request_irq(OMAP_GPIO_IRQ(c->gpio_irq),
 			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -255,7 +255,7 @@ static int ohci_omap_init(struct usb_hcd
 			/* gpio9 for overcurrent detction */
 			omap_cfg_reg(W8_1610_GPIO9);
 			omap_request_gpio(9);
-			omap_set_gpio_direction(9, 1 /* IN */);
+			gpio_direction_input(9);
 
 			/* for paranoia's sake:  disable USB.PUEN */
 			omap_cfg_reg(W4_USB_HIGHZ);
