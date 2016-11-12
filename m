From: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] usb: twl6030-usb: make driver DT only
Date: Sat, 12 Nov 2016 12:47:43 +0200
Message-ID: <1478947663-19539-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

All users are DT-only and it makes no sense to keep
unused code

Signed-off-by: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/usb/phy/Kconfig           |  1 +
 drivers/usb/phy/phy-twl6030-usb.c | 23 ++++++-----------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index b9c409a..61cef75 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -84,6 +84,7 @@ config SAMSUNG_USBPHY
 config TWL6030_USB
 	tristate "TWL6030 USB Transceiver Driver"
 	depends on TWL4030_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS
+	depends on OF
 	help
 	  Enable this to support the USB OTG transceiver on TWL6030
 	  family chips. This TWL6030 transceiver has the VBUS and ID GND
diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index a72e8d6..628b600 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -108,7 +108,6 @@ struct twl6030_usb {
 	enum musb_vbus_id_status linkstat;
 	u8			asleep;
 	bool			vbus_enable;
-	const char		*regulator;
 };
 
 #define	comparator_to_twl(x) container_of((x), struct twl6030_usb, comparator)
@@ -166,7 +165,7 @@ static int twl6030_usb_ldo_init(struct twl6030_usb *twl)
 	/* Program MISC2 register and set bit VUSB_IN_VBAT */
 	twl6030_writeb(twl, TWL6030_MODULE_ID0, 0x10, TWL6030_MISC2);
 
-	twl->usb3v3 = regulator_get(twl->dev, twl->regulator);
+	twl->usb3v3 = regulator_get(twl->dev, "usb");
 	if (IS_ERR(twl->usb3v3))
 		return -ENODEV;
 
@@ -341,7 +340,11 @@ static int twl6030_usb_probe(struct platform_device *pdev)
 	int			status, err;
 	struct device_node	*np = pdev->dev.of_node;
 	struct device		*dev = &pdev->dev;
-	struct twl4030_usb_data	*pdata = dev_get_platdata(dev);
+
+	if (!np) {
+		dev_err(dev, "no DT info\n");
+		return -EINVAL;
+	}
 
 	twl = devm_kzalloc(dev, sizeof(*twl), GFP_KERNEL);
 	if (!twl)
@@ -361,18 +364,6 @@ static int twl6030_usb_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	if (np) {
-		twl->regulator = "usb";
-	} else if (pdata) {
-		if (pdata->features & TWL6032_SUBCLASS)
-			twl->regulator = "ldousb";
-		else
-			twl->regulator = "vusb";
-	} else {
-		dev_err(&pdev->dev, "twl6030 initialized without pdata\n");
-		return -EINVAL;
-	}
