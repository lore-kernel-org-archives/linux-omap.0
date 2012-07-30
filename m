From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v6 07/11] drivers: usb: twl4030: Add device tree support for
 twl4030 usb
Date: Mon, 30 Jul 2012 14:39:56 +0530
Message-ID: <1343639400-28725-8-git-send-email-kishon@ti.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1343639400-28725-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: kishon-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add device tree support for twl4030 usb driver.
Update the Documentation with device tree binding information.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/usb/twlxxxx-usb.txt        |   19 ++++++++++++++
 drivers/usb/otg/twl4030-usb.c                      |   26 +++++++++++++++-----
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
index 930f9ff..36b9aed 100644
--- a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
@@ -19,3 +19,22 @@ Board specific device node entry
 &twl6030-usb {
 	usb-supply = <&vusb>;
 };
+
+TWL4030 USB PHY AND COMPARATOR
+ - compatible : Should be "ti,twl4030-usb"
+ - interrupts : The interrupt numbers to the cpu should be specified. First
+   interrupt number is the otg interrupt number that raises ID interrupts
+   and VBUS interrupts. The second interrupt number is optional.
+ - <supply-name>-supply : phandle to the regulator device tree node.
+   <supply-name> should be vusb1v5, vusb1v8 and vusb3v1
+ - usb_mode : The mode used by the phy to connect to the controller. "1"
+   specifies "ULPI" mode and "2" specifies "CEA2011_3PIN" mode.
+
+twl4030-usb {
+	compatible = "ti,twl4030-usb";
+	interrupts = < 10 4 >;
+	usb1v5-supply = <&vusb1v5>;
+	usb1v8-supply = <&vusb1v8>;
+	usb3v1-supply = <&vusb3v1>;
+	usb_mode = <1>;
+};
diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 523cad5..f0d2e75 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -585,23 +585,28 @@ static int __devinit twl4030_usb_probe(struct platform_device *pdev)
 	struct twl4030_usb	*twl;
 	int			status, err;
 	struct usb_otg		*otg;
-
-	if (!pdata) {
-		dev_dbg(&pdev->dev, "platform_data not available\n");
-		return -EINVAL;
-	}
+	struct device_node	*np = pdev->dev.of_node;
 
 	twl = devm_kzalloc(&pdev->dev, sizeof *twl, GFP_KERNEL);
 	if (!twl)
 		return -ENOMEM;
 
+	if (np)
+		of_property_read_u32(np, "usb_mode",
+				(enum twl4030_usb_mode *)&twl->usb_mode);
+	else if (pdata)
+		twl->usb_mode = pdata->usb_mode;
+	else {
+		dev_err(&pdev->dev, "twl4030 initialized without pdata\n");
+		return -EINVAL;
+	}
+
 	otg = devm_kzalloc(&pdev->dev, sizeof *otg, GFP_KERNEL);
 	if (!otg)
 		return -ENOMEM;
 
 	twl->dev		= &pdev->dev;
 	twl->irq		= platform_get_irq(pdev, 0);
-	twl->usb_mode		= pdata->usb_mode;
 	twl->vbus_supplied	= false;
 	twl->asleep		= 1;
 	twl->linkstat		= OMAP_MUSB_UNKNOWN;
@@ -690,12 +695,21 @@ static int __exit twl4030_usb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id twl4030_usb_id_table[] = {
+	{ .compatible = "ti,twl4030-usb" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, twl4030_usb_id_table);
+#endif
+
 static struct platform_driver twl4030_usb_driver = {
 	.probe		= twl4030_usb_probe,
 	.remove		= __exit_p(twl4030_usb_remove),
 	.driver		= {
 		.name	= "twl4030_usb",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(twl4030_usb_id_table),
 	},
 };
 
-- 
1.7.9.5
