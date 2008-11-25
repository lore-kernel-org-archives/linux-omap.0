From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 2/2] USB: OHCI-OMAP: Switch to gpio_request/free calls (OMAP and mainline)
Date: Tue, 25 Nov 2008 16:12:14 +0200
Message-ID: <1227622334-27227-3-git-send-email-jarkko.nikula@nokia.com>
References: <1227622334-27227-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33202 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbYKYONP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 09:13:15 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAPECs5H016610
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 16:13:12 +0200
In-Reply-To: <1227622334-27227-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/usb/host/ohci-omap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 22f6d19..4bbddb7 100644
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
+			gpio_request(9, "OHCI overcurrent");
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

