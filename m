From: Roger Quadros <rogerq-mWibgAyQ9RI@public.gmane.org>
Subject: [PATCH v3 4/8] usb: phy: omap-usb3: Don't use omap_get_control_dev()
Date: Fri, 16 Aug 2013 16:09:27 +0300
Message-ID: <1376658571-20992-5-git-send-email-rogerq@ti.com>
References: <1376658571-20992-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376658571-20992-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-mWibgAyQ9RI@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-mWibgAyQ9RI@public.gmane.org, kishon-mWibgAyQ9RI@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-mWibgAyQ9RI@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

omap_get_control_dev() is being deprecated as it doesn't support
multiple instances. As control device is present only from OMAP4
onwards which supports DT only, we use phandles to get the
reference to the control device.

As we don't support non-DT boot, we just bail out on probe
if device node is not present.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/phy/phy-omap-usb3.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-usb3.c b/drivers/usb/phy/phy-omap-usb3.c
index 4a7f27c..981313e 100644
--- a/drivers/usb/phy/phy-omap-usb3.c
+++ b/drivers/usb/phy/phy-omap-usb3.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/usb/omap_control_usb.h>
+#include <linux/of_platform.h>
 
 #define	PLL_STATUS		0x00000004
 #define	PLL_GO			0x00000008
@@ -198,6 +199,12 @@ static int omap_usb3_probe(struct platform_device *pdev)
 {
 	struct omap_usb			*phy;
 	struct resource			*res;
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *control_node;
+	struct platform_device *control_pdev;
+
+	if (!node)
+		return -EINVAL;
 
 	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy) {
@@ -239,11 +246,18 @@ static int omap_usb3_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	phy->control_dev = omap_get_control_dev();
-	if (IS_ERR(phy->control_dev)) {
-		dev_dbg(&pdev->dev, "Failed to get control device\n");
-		return -ENODEV;
+	control_node = of_parse_phandle(node, "ctrl-module", 0);
+	if (!control_node) {
+		dev_err(&pdev->dev, "Failed to get control device phandle\n");
+		return -EINVAL;
 	}
+	control_pdev = of_find_device_by_node(control_node);
+	if (!control_pdev) {
+		dev_err(&pdev->dev, "Failed to get control device\n");
+		return -EINVAL;
+	}
+
+	phy->control_dev = &control_pdev->dev;
 
 	omap_control_usb_phy_power(phy->control_dev, 0);
 	usb_add_phy_dev(&phy->phy);
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
