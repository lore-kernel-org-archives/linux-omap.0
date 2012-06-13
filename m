From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP2: Fix tusb6010 GPIO interrupt for n8x0
Date: Wed, 13 Jun 2012 03:15:12 -0700
Message-ID: <20120613101512.18645.12865.stgit@muffinssi.local>
References: <20120613101303.18645.83320.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27195 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab2FMKPN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 06:15:13 -0400
In-Reply-To: <20120613101303.18645.83320.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Here's one more gpio_to_irq conversion that we missed
earlier. Tested with n800 in gadget mode using USB_ETH.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index db84a46..805bea6 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -300,7 +300,7 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 		printk(error, 3, status);
 		return status;
 	}
-	tusb_resources[2].start = irq + IH_GPIO_BASE;
+	tusb_resources[2].start = gpio_to_irq(irq);
 
 	/* set up memory timings ... can speed them up later */
 	if (!ps_refclk) {

