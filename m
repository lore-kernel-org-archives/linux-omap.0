From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/9] ARM: OMAP2+: usb-host: Adapt to USB phy-nop RESET line changes
Date: Wed, 14 Aug 2013 16:58:08 +0300
Message-ID: <1376488693-31659-5-git-send-email-rogerq@ti.com>
References: <1376488693-31659-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56394 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759961Ab3HNN7T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Aug 2013 09:59:19 -0400
In-Reply-To: <1376488693-31659-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, tony@atomide.com, bcousson@baylibre.com
Cc: p.zabel@pengutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

The USB phy-nop nop driver expects the RESET line information
to be sent as a GPIO number via platform data. Adapt to that.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/usb-host.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 1626801..4528b40 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -460,8 +460,7 @@ int usbhs_init_phys(struct usbhs_phy_data *phy, int num_phys)
 		memset(&nop_pdata, 0, sizeof(nop_pdata));
 		if (gpio_is_valid(phy->vcc_gpio))
 			nop_pdata.needs_vcc = true;
-		if (gpio_is_valid(phy->reset_gpio))
-			nop_pdata.needs_reset = true;
+		nop_pdata.gpio_reset = phy->reset_gpio;
 		nop_pdata.type = USB_PHY_TYPE_USB2;
 
 		/* create a NOP PHY device */
@@ -483,14 +482,6 @@ int usbhs_init_phys(struct usbhs_phy_data *phy, int num_phys)
 
 		usb_bind_phy("ehci-omap.0", phy->port - 1, phy_id);
 
-		/* Do we need RESET regulator ? */
-		if (gpio_is_valid(phy->reset_gpio)) {
-			scnprintf(rail_name, MAX_STR,
-					"hsusb%d_reset", phy->port);
-			usbhs_add_regulator(rail_name, phy_id, "reset",
-						phy->reset_gpio, 1);
-		}
-
 		/* Do we need VCC regulator ? */
 		if (gpio_is_valid(phy->vcc_gpio)) {
 			scnprintf(rail_name, MAX_STR, "hsusb%d_vcc", phy->port);
-- 
1.7.4.1

