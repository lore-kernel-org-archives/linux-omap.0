From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 01/10] usb: phy: omap-control: Get rid of platform data
Date: Wed, 18 Sep 2013 15:48:53 +0300
Message-ID: <1379508542-22389-2-git-send-email-rogerq@ti.com>
References: <1379508542-22389-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379508542-22389-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

omap-control device is present from OMAP4 onwards which
support device tree boots only. So get rid of platform data.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/phy/phy-omap-control.c   |   12 +++---------
 include/linux/usb/omap_control_usb.h |    4 ----
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
index a4dda8e..9772592 100644
--- a/drivers/usb/phy/phy-omap-control.c
+++ b/drivers/usb/phy/phy-omap-control.c
@@ -197,8 +197,6 @@ static int omap_control_usb_probe(struct platform_device *pdev)
 {
 	struct resource	*res;
 	struct device_node *np = pdev->dev.of_node;
-	struct omap_control_usb_platform_data *pdata =
-			dev_get_platdata(&pdev->dev);
 
 	control_usb = devm_kzalloc(&pdev->dev, sizeof(*control_usb),
 		GFP_KERNEL);
@@ -207,14 +205,10 @@ static int omap_control_usb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (np) {
+	if (np)
 		of_property_read_u32(np, "ti,type", &control_usb->type);
-	} else if (pdata) {
-		control_usb->type = pdata->type;
-	} else {
-		dev_err(&pdev->dev, "no pdata present\n");
-		return -EINVAL;
-	}
+	else
+		return -EINVAL;	/* We only support DT boot */
 
 	control_usb->dev	= &pdev->dev;
 
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
-
 enum omap_control_usb_mode {
 	USB_MODE_UNDEFINED = 0,
 	USB_MODE_HOST,
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
