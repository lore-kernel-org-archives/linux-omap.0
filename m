From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 04/10] ARM: OMAP2+: usb-host: Adapt to USB phy-nop RESET line changes
Date: Tue, 24 Sep 2013 11:53:50 +0300
Message-ID: <1380012836-29900-5-git-send-email-rogerq@ti.com>
References: <1380012836-29900-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380012836-29900-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The USB phy-nop nop driver expects the RESET line information
to be sent as a GPIO number via platform data. Adapt to that.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/usb-host.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 78ac1c2..10855eb 100644
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
