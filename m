From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/8] usb: phy: omap-control: Get rid of platform data
Date: Thu, 15 Aug 2013 16:15:05 +0300
Message-ID: <1376572512-9561-2-git-send-email-rogerq@ti.com>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376572512-9561-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

omap-control device is present from OMAP4 onwards which
support device tree boots only. So get rid of platform data.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/phy/phy-omap-control.c   |   18 +++++++-----------
 include/linux/usb/omap_control_usb.h |    4 ----
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
index a4dda8e..3b9ee83 100644
--- a/drivers/usb/phy/phy-omap-control.c
+++ b/drivers/usb/phy/phy-omap-control.c
@@ -197,8 +197,13 @@ static int omap_control_usb_probe(struct platform_device *pdev)
 {
 	struct resource	*res;
 	struct device_node *np = pdev->dev.of_node;
-	struct omap_control_usb_platform_data *pdata =
-			dev_get_platdata(&pdev->dev);
+
+	if (np) {
+		of_property_read_u32(np, "ti,type", &control_usb->type);
+	} else {
+		/* We only support DT boot */
+		return -ENODEV;
+	}
 
 	control_usb = devm_kzalloc(&pdev->dev, sizeof(*control_usb),
 		GFP_KERNEL);
@@ -207,15 +212,6 @@ static int omap_control_usb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (np) {
-		of_property_read_u32(np, "ti,type", &control_usb->type);
-	} else if (pdata) {
-		control_usb->type = pdata->type;
-	} else {
-		dev_err(&pdev->dev, "no pdata present\n");
-		return -EINVAL;
-	}
-
 	control_usb->dev	= &pdev->dev;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
diff --git a/include/linux/usb/omap_control_usb.h b/include/linux/usb/omap_control_usb.h
index 27b5b8c..e2416b4 100644
--- a/include/linux/usb/omap_control_usb.h
+++ b/include/linux/usb/omap_control_usb.h
@@ -31,10 +31,6 @@ struct omap_control_usb {
 	u32 type;
 };
 
-struct omap_control_usb_platform_data {
-	u8 type;
-};
