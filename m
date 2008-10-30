From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc2-omap 4/4] switch to gpio_direction_input (OMAP and mainline)
Date: Wed, 29 Oct 2008 20:42:38 -0700
Message-ID: <200810292042.38281.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:33004 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753086AbYJ3Do3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 23:44:29 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

More switchover to the cross-platform GPIO interface:
use gpio_direction_input(), not an OMAP-specific call.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
 arch/arm/mach-omap1/board-palmte.c    |    4 ++--
 arch/arm/mach-omap1/board-palmz71.c   |    4 ++--
 arch/arm/mach-omap1/board-voiceblue.c |    2 +-
 arch/arm/mach-omap1/fpga.c            |    2 +-
 arch/arm/mach-omap1/serial.c          |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c   |    2 +-
 arch/arm/mach-omap2/board-apollon.c   |    2 +-
 arch/arm/mach-omap2/usb-tusb6010.c    |    2 +-
 arch/arm/plat-omap/debug-devices.c    |    2 +-
 drivers/mtd/onenand/omap2.c           |    2 +-
 drivers/usb/host/ohci-omap.c          |    2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)

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
@@ -248,7 +248,7 @@ void voiceblue_wdt_disable(void)
 	gpio_set_value(0, 0);
 	gpio_set_value(0, 1);
 	gpio_set_value(0, 0);
-	omap_set_gpio_direction(0, 1);
+	gpio_direction_input(0);
 }
 
 void voiceblue_wdt_ping(void)
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -178,7 +178,7 @@ void omap1510_fpga_init_irq(void)
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
@@ -313,7 +313,7 @@ static inline void __init sdp2430_init_s
 		gpmc_cs_free(eth_cs);
 		goto out;
 	}
-	omap_set_gpio_direction(OMAP24XX_ETHR_GPIO_IRQ, 1);
+	gpio_direction_input(OMAP24XX_ETHR_GPIO_IRQ);
 
 out:
 	clk_disable(gpmc_fck);
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -401,7 +401,7 @@ static void __init apollon_tsc_init(void
 	/* TSC2101 */
 	omap_cfg_reg(N15_24XX_GPIO85);
 	omap_request_gpio(85);
-	omap_set_gpio_direction(85, 1);
+	gpio_direction_input(85);
 
 	omap_cfg_reg(W14_24XX_SYS_CLKOUT);	/* mclk */
 }
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
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -635,7 +635,7 @@ static int __devinit omap2_onenand_probe
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
