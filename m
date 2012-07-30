From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v6 05/11] drivers: usb: twl6030: Add dt support for twl6030 usb
Date: Mon, 30 Jul 2012 14:39:54 +0530
Message-ID: <1343639400-28725-6-git-send-email-kishon@ti.com>
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

Add device tree support for twl6030 usb driver.
Update the Documentation with device tree binding information.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/usb/twlxxxx-usb.txt        |   21 +++++++++++
 drivers/usb/otg/twl6030-usb.c                      |   39 +++++++++++++-------
 2 files changed, 47 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
new file mode 100644
index 0000000..930f9ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
@@ -0,0 +1,21 @@
+USB COMPARATOR OF TWL CHIPS
+
+TWL6030 USB COMPARATOR
+ - compatible : Should be "ti,twl6030-usb"
+ - interrupts : Two interrupt numbers to the cpu should be specified. First
+   interrupt number is the otg interrupt number that raises ID interrupts when
+   the controller has to act as host and the second interrupt number is the
+   usb interrupt number that raises VBUS interrupts when the controller has to
+   act as device
+ - usb-supply : phandle to the regulator device tree node. It should be vusb
+   if it is twl6030 or ldousb if it is twl6025 subclass.
+
+twl6030-usb {
+	compatible = "ti,twl6030-usb";
+	interrupts = < 4 10 >;
+};
+
+Board specific device node entry
+&twl6030-usb {
+	usb-supply = <&vusb>;
+};
diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/otg/twl6030-usb.c
index 6a361d2..f29c9ef 100644
--- a/drivers/usb/otg/twl6030-usb.c
+++ b/drivers/usb/otg/twl6030-usb.c
@@ -105,7 +105,7 @@ struct twl6030_usb {
 	u8			asleep;
 	bool			irq_enabled;
 	bool			vbus_enable;
-	unsigned long		features;
+	const char		*regulator;
 };
 
 #define	comparator_to_twl(x) container_of((x), struct twl6030_usb, comparator)
@@ -153,13 +153,6 @@ static int twl6030_start_srp(struct phy_companion *comparator)
 
 static int twl6030_usb_ldo_init(struct twl6030_usb *twl)
 {
-	char *regulator_name;
-
-	if (twl->features & TWL6025_SUBCLASS)
-		regulator_name = "ldousb";
-	else
-		regulator_name = "vusb";
-
 	/* Set to OTG_REV 1.3 and turn on the ID_WAKEUP_COMP */
 	twl6030_writeb(twl, TWL6030_MODULE_ID0 , 0x1, TWL6030_BACKUP_REG);
 
@@ -169,7 +162,7 @@ static int twl6030_usb_ldo_init(struct twl6030_usb *twl)
 	/* Program MISC2 register and set bit VUSB_IN_VBAT */
 	twl6030_writeb(twl, TWL6030_MODULE_ID0 , 0x10, TWL6030_MISC2);
 
-	twl->usb3v3 = regulator_get(twl->dev, regulator_name);
+	twl->usb3v3 = regulator_get(twl->dev, twl->regulator);
 	if (IS_ERR(twl->usb3v3))
 		return -ENODEV;
 
@@ -324,9 +317,9 @@ static int __devinit twl6030_usb_probe(struct platform_device *pdev)
 {
 	struct twl6030_usb	*twl;
 	int			status, err;
-	struct twl4030_usb_data *pdata;
-	struct device *dev = &pdev->dev;
-	pdata = dev->platform_data;
+	struct device_node	*np = pdev->dev.of_node;
+	struct device		*dev = &pdev->dev;
+	struct twl4030_usb_data	*pdata = dev->platform_data;
 
 	twl = devm_kzalloc(dev, sizeof *twl, GFP_KERNEL);
 	if (!twl)
@@ -335,13 +328,24 @@ static int __devinit twl6030_usb_probe(struct platform_device *pdev)
 	twl->dev		= &pdev->dev;
 	twl->irq1		= platform_get_irq(pdev, 0);
 	twl->irq2		= platform_get_irq(pdev, 1);
-	twl->features		= pdata->features;
 	twl->linkstat		= OMAP_MUSB_UNKNOWN;
 
 	twl->comparator.set_vbus	= twl6030_set_vbus;
 	twl->comparator.start_srp	= twl6030_start_srp;
 	omap_usb2_set_comparator(&twl->comparator);
 
+	if (np) {
+		twl->regulator = "usb";
+	} else if (pdata) {
+		if (pdata->features & TWL6025_SUBCLASS)
+			twl->regulator = "ldousb";
+		else
+			twl->regulator = "vusb";
+	} else {
+		dev_err(&pdev->dev, "twl6030 initialized without pdata\n");
+		return -EINVAL;
+	}
+
 	/* init spinlock for workqueue */
 	spin_lock_init(&twl->lock);
 
@@ -403,12 +407,21 @@ static int __exit twl6030_usb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id twl6030_usb_id_table[] = {
+	{ .compatible = "ti,twl6030-usb" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, twl6030_usb_id_table);
+#endif
+
 static struct platform_driver twl6030_usb_driver = {
 	.probe		= twl6030_usb_probe,
 	.remove		= __exit_p(twl6030_usb_remove),
 	.driver		= {
 		.name	= "twl6030_usb",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(twl6030_usb_id_table),
 	},
 };
 
-- 
1.7.9.5
