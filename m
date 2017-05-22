From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/3] usb: host: ohci-platform: Add basic runtime PM support
Date: Mon, 22 May 2017 09:00:05 -0700
Message-ID: <20170522160007.9264-2-tony@atomide.com>
References: <20170522160007.9264-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170522160007.9264-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is needed in preparation of adding support for omap3 and
later OHCI. The runtime PM will only do something on platforms
that implement it.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---

Alan, do you have some better ideas for the ohci_platform_remove()
path below?

---
 drivers/usb/host/ohci-platform.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/usb.h>
@@ -242,6 +243,8 @@ static int ohci_platform_probe(struct platform_device *dev)
 	}
 #endif
 
+	pm_runtime_set_active(&dev->dev);
+	pm_runtime_enable(&dev->dev);
 	if (pdata->power_on) {
 		err = pdata->power_on(dev);
 		if (err < 0)
@@ -271,6 +274,7 @@ static int ohci_platform_probe(struct platform_device *dev)
 	if (pdata->power_off)
 		pdata->power_off(dev);
 err_reset:
+	pm_runtime_disable(&dev->dev);
 	while (--rst >= 0)
 		reset_control_assert(priv->resets[rst]);
 err_put_clks:
@@ -290,7 +294,14 @@ static int ohci_platform_remove(struct platform_device *dev)
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
 	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
-	int clk, rst;
+	int clk, rst, enabled;
+
+	enabled = pm_runtime_get_sync(&dev->dev);
+	if (enabled < 0) {
+		dev_warn(&dev->dev, "pm_runtime_get failed: %i\n",
+			 enabled);
+		pm_runtime_put_noidle(&dev->dev);
+	}
 
 	usb_remove_hcd(hcd);
 
@@ -305,6 +316,10 @@ static int ohci_platform_remove(struct platform_device *dev)
 
 	usb_put_hcd(hcd);
 
+	if (enabled >= 0)
+		pm_runtime_put_sync(&dev->dev);
+	pm_runtime_disable(&dev->dev);
+
 	if (pdata == &ohci_platform_defaults)
 		dev->dev.platform_data = NULL;
 
-- 
2.13.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
