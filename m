From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/11] ARM: OMAP: Switch ohci-omap to gpio_request/free calls
Date: Fri, 28 Nov 2008 17:11:04 -0800
Message-ID: <20081129011104.12337.37890.stgit@localhost>
References: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58550 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928AbYK2BLD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:11:03 -0500
In-Reply-To: <20081129010728.12337.8217.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>, linux-usb@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Switch to gpio_request/free calls

Cc: linux-usb@vger.kernel.org
Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

