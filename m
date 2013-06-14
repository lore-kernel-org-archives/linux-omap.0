From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] USB: ehci-omap: Tweak PHY initialization sequence
Date: Fri, 14 Jun 2013 16:52:07 +0300
Message-ID: <1371217927-5719-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

For PHY mode, the PHYs must be brought out of reset
before the EHCI controller is started.

This patch fixes the issue where USB devices are not found
on Beagleboard/Beagle-xm if USB has been started previously
by the bootloader. (e.g. by "usb start" command in u-boot)

Tested on Beagleboard, Beagleboard-xm and Pandaboard.

Issue present on 3.10 onwards.

Reported-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Tested-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 16d7150..dda408f 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -187,6 +187,12 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		}
 
 		omap->phy[i] = phy;
+
+		if (pdata->port_mode[i] == OMAP_EHCI_PORT_MODE_PHY) {
+			usb_phy_init(omap->phy[i]);
+			/* bring PHY out of suspend */
+			usb_phy_set_suspend(omap->phy[i], 0);
+		}
 	}
 
 	pm_runtime_enable(dev);
@@ -211,13 +217,14 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Bring PHYs out of reset.
+	 * Bring PHYs out of reset for non PHY modes.
 	 * Even though HSIC mode is a PHY-less mode, the reset
 	 * line exists between the chips and can be modelled
 	 * as a PHY device for reset control.
 	 */
 	for (i = 0; i < omap->nports; i++) {
-		if (!omap->phy[i])
+		if (!omap->phy[i] ||
+		     pdata->port_mode[i] == OMAP_EHCI_PORT_MODE_PHY)
 			continue;
 
 		usb_phy_init(omap->phy[i]);
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
