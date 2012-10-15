From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 6/7] usb: dwc3-omap: Minor fixes to get dt working
Date: Mon, 15 Oct 2012 18:57:59 +0530
Message-ID: <1350307680-24938-7-git-send-email-kishon@ti.com>
References: <1350307680-24938-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350307680-24938-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, balbi@ti.com, gregkh@linuxfoundation.org, kishon@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: sshtylyov@mvista.com
List-Id: linux-omap@vger.kernel.org

Includes few minor fixes in dwc3-omap like populating the compatible
string in a correct way, extracting the utmi-mode property properly and
changing the index of get_irq since irq of core is removed from hwmod
entry.
Also updated the documentation with dwc3-omap device tree binding
information.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index b84ddf3..10aad46 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -318,11 +318,10 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 	struct resource		*res;
 	struct device		*dev = &pdev->dev;
 
-	int			size;
 	int			ret = -ENOMEM;
 	int			irq;
 
-	const u32		*utmi_mode;
+	u32			utmi_mode;
 	u32			reg;
 
 	void __iomem		*base;
@@ -336,13 +335,13 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, omap);
 
-	irq = platform_get_irq(pdev, 1);
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "missing IRQ resource\n");
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "missing memory base resource\n");
 		return -EINVAL;
@@ -389,9 +388,8 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_UTMI_OTG_STATUS);
 
-	utmi_mode = of_get_property(node, "utmi-mode", &size);
-	if (utmi_mode && size == sizeof(*utmi_mode)) {
-		reg |= *utmi_mode;
+	if (!of_property_read_u32(node, "utmi-mode", &utmi_mode)) {
+		reg |= utmi_mode;
 	} else {
 		if (!pdata) {
 			dev_dbg(dev, "missing platform data\n");
@@ -469,7 +467,7 @@ static int __devexit dwc3_omap_remove(struct platform_device *pdev)
 
 static const struct of_device_id of_dwc3_matach[] = {
 	{
-		"ti,dwc3",
+		.compatible =	"ti,dwc3"
 	},
 	{ },
 };
-- 
1.7.9.5
