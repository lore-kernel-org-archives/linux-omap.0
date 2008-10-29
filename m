From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 09/21] OMAP: USB: Complete gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:17 +0200
Message-ID: <1225280189-6559-10-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34602 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbYJ2Lhr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:47 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBbeGj006893
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:45 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/usb/host/ehci-omap.c |    8 ++++----
 drivers/usb/host/ohci-omap.c |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 4dffba6..1b3266c 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -225,9 +225,9 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 #ifdef EXTERNAL_PHY_RESET
 	/* Refer: ISSUE1 */
-	omap_request_gpio(EXT_PHY_RESET_GPIO_PORT1);
+	gpio_request(EXT_PHY_RESET_GPIO_PORT1, "USB1 PHY reset");
 	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT1, 0);
-	omap_request_gpio(EXT_PHY_RESET_GPIO_PORT2);
+	gpio_request(EXT_PHY_RESET_GPIO_PORT2, "USB2 PHY reset");
 	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT2, 0);
 	/* Hold the PHY in RESET for enough time till DIR is high */
 	udelay(EXT_PHY_RESET_DELAY);
@@ -393,8 +393,8 @@ static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 
 #ifdef EXTERNAL_PHY_RESET
-	omap_free_gpio(EXT_PHY_RESET_GPIO_PORT1);
-	omap_free_gpio(EXT_PHY_RESET_GPIO_PORT2);
+	gpio_free(EXT_PHY_RESET_GPIO_PORT1);
+	gpio_free(EXT_PHY_RESET_GPIO_PORT2);
 #endif
 
 	dev_dbg(hcd->self.controller,
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 22f6d19..267b212 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -18,6 +18,7 @@
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 #include <asm/io.h>
@@ -25,7 +26,6 @@
 
 #include <mach/mux.h>
 #include <mach/irqs.h>
-#include <mach/gpio.h>
 #include <mach/fpga.h>
 #include <mach/usb.h>
 
@@ -254,7 +254,7 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 
 			/* gpio9 for overcurrent detction */
 			omap_cfg_reg(W8_1610_GPIO9);
-			omap_request_gpio(9);
+			gpio_request(9, "USB over current");
 			gpio_direction_input(9);
 
 			/* for paranoia's sake:  disable USB.PUEN */
@@ -407,7 +407,7 @@ usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 		put_device(ohci->transceiver->dev);
 	}
 	if (machine_is_omap_osk())
-		omap_free_gpio(9);
+		gpio_free(9);
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
-- 
1.5.6.5

