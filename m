From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/11] ARM: OMAP: switch to gpio_direction_input
Date: Fri, 28 Nov 2008 17:10:22 -0800
Message-ID: <20081129011021.12337.25141.stgit@localhost>
References: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57993 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbYK2BKU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:10:20 -0500
In-Reply-To: <20081129010728.12337.8217.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

More switchover to the cross-platform GPIO interface:
use gpio_direction_input(), not an OMAP-specific call.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-palmte.c    |    4 ++--
 arch/arm/mach-omap1/board-palmz71.c   |    4 ++--
 arch/arm/mach-omap1/board-voiceblue.c |    2 +-
 arch/arm/mach-omap1/fpga.c            |    2 +-
 arch/arm/mach-omap1/serial.c          |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c   |    2 +-
 arch/arm/mach-omap2/board-apollon.c   |    8 ++++----
 arch/arm/mach-omap2/usb-tusb6010.c    |    2 +-
 arch/arm/plat-omap/debug-devices.c    |    2 +-
 drivers/mtd/onenand/omap2.c           |    2 +-
 drivers/usb/host/ohci-omap.c          |    2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index df663ba..0995a0f 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -351,14 +351,14 @@ static void __init palmte_misc_gpio_setup(void)
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
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index c33766c..5a232ad 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -331,7 +331,7 @@ palmz71_gpio_setup(int early)
 			printk(KERN_ERR "Could not reserve WP GPIO!\n");
 			return;
 		}
-		omap_set_gpio_direction(PALMZ71_MMC_WP_GPIO, 1);
+		gpio_direction_input(PALMZ71_MMC_WP_GPIO);
 
 		/* Monitor the Power-cable-connected signal */
 		if (omap_request_gpio(PALMZ71_USBDETECT_GPIO)) {
@@ -339,7 +339,7 @@ palmz71_gpio_setup(int early)
 				"Could not reserve cable signal GPIO!\n");
 			return;
 		}
-		omap_set_gpio_direction(PALMZ71_USBDETECT_GPIO, 1);
+		gpio_direction_input(PALMZ71_USBDETECT_GPIO);
 		if (request_irq(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
 				palmz71_powercable, IRQF_SAMPLE_RANDOM,
 				"palmz71-cable", 0))
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index d7ab11a..86e73b7 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -256,7 +256,7 @@ void voiceblue_wdt_disable(void)
 	gpio_set_value(0, 0);
 	gpio_set_value(0, 1);
 	gpio_set_value(0, 0);
-	omap_set_gpio_direction(0, 1);
+	gpio_direction_input(0);
 }
 
 void voiceblue_wdt_ping(void)
diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 0499538..40cf504 100644
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
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 528691d..1a0bc47 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -250,7 +250,7 @@ static void __init omap_serial_set_port_wakeup(int gpio_nr)
 		       gpio_nr);
 		return;
 	}
-	omap_set_gpio_direction(gpio_nr, 1);
+	gpio_direction_input(gpio_nr);
 	ret = request_irq(OMAP_GPIO_IRQ(gpio_nr), &omap_serial_wake_interrupt,
 			  IRQF_TRIGGER_RISING, "serial wakeup", NULL);
 	if (ret) {
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 24688ef..f844a67 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -174,7 +174,7 @@ static inline void __init sdp2430_init_smc91x(void)
 		gpmc_cs_free(eth_cs);
 		goto out;
 	}
-	omap_set_gpio_direction(OMAP24XX_ETHR_GPIO_IRQ, 1);
+	gpio_direction_input(OMAP24XX_ETHR_GPIO_IRQ);
 
 out:
 	clk_disable(gpmc_fck);
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index a4ba52c..abc9167 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -242,7 +242,7 @@ static inline void __init apollon_init_smc91x(void)
 		gpmc_cs_free(APOLLON_ETH_CS);
 		goto out;
 	}
-	omap_set_gpio_direction(APOLLON_ETHR_GPIO_IRQ, 1);
+	gpio_direction_input(APOLLON_ETHR_GPIO_IRQ);
 
 out:
 	clk_disable(gpmc_fck);
@@ -327,15 +327,15 @@ static void __init apollon_sw_init(void)
 	/* Enter SW - Y11 */
 	omap_cfg_reg(Y11_242X_GPIO16);
 	omap_request_gpio(SW_ENTER_GPIO16);
-	omap_set_gpio_direction(SW_ENTER_GPIO16, 1);
+	gpio_direction_input(SW_ENTER_GPIO16);
 	/* Up SW - AA12 */
 	omap_cfg_reg(AA12_242X_GPIO17);
 	omap_request_gpio(SW_UP_GPIO17);
-	omap_set_gpio_direction(SW_UP_GPIO17, 1);
+	gpio_direction_input(SW_UP_GPIO17);
 	/* Down SW - AA8 */
 	omap_cfg_reg(AA8_242X_GPIO58);
 	omap_request_gpio(SW_DOWN_GPIO58);
-	omap_set_gpio_direction(SW_DOWN_GPIO58, 1);
+	gpio_direction_input(SW_DOWN_GPIO58);
 
 	set_irq_type(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), IRQ_TYPE_EDGE_RISING);
 	if (request_irq(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), &apollon_sw_interrupt,
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 10ef464..eb2399d 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -297,7 +297,7 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 		printk(error, 3, status);
 		return status;
 	}
-	omap_set_gpio_direction(irq, 1);
+	gpio_direction_input(irq);
 	tusb_resources[2].start = irq + IH_GPIO_BASE;
 
 	/* set up memory timings ... can speed them up later */
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index e31154b..60076a8 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -77,7 +77,7 @@ int __init debug_card_init(u32 addr, unsigned gpio)
 		printk(KERN_ERR "GPIO%d unavailable for smc91x IRQ\n", gpio);
 		return status;
 	}
-	omap_set_gpio_direction(gpio, 1);
+	gpio_direction_input(gpio);
 
 	led_resources[0].start = addr;
 	led_resources[0].end   = addr + SZ_4K - 1;
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 8dda06c..c7145af 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -635,7 +635,7 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 				"OneNAND\n", c->gpio_irq);
 			goto err_iounmap;
 	}
-	omap_set_gpio_direction(c->gpio_irq, 1);
+	gpio_direction_input(c->gpio_irq);
 
 	if ((r = request_irq(OMAP_GPIO_IRQ(c->gpio_irq),
 			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 91697bd..22f6d19 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -255,7 +255,7 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 			/* gpio9 for overcurrent detction */
 			omap_cfg_reg(W8_1610_GPIO9);
 			omap_request_gpio(9);
-			omap_set_gpio_direction(9, 1 /* IN */);
+			gpio_direction_input(9);
 
 			/* for paranoia's sake:  disable USB.PUEN */
 			omap_cfg_reg(W4_USB_HIGHZ);

