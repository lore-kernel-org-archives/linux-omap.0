From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v1 4/6] drivers: usb: musb: omap: make use of the new PHY lib
 APIs
Date: Tue, 22 Jan 2013 15:28:12 +0530
Message-ID: <1358848694-20145-5-git-send-email-kishon@ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1358848694-20145-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
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
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

New PHY lib APIs like usb_add_phy_dev() and devm_usb_get_phy_dev() are
used in MUSB (OMAP), in order to make use of the binding information
provided in the board file (of OMAP platforms).
All the platforms should be modified similar to this to add and get the
PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/omap2430.c   |    2 +-
 drivers/usb/otg/twl4030-usb.c |    3 ++-
 drivers/usb/phy/omap-usb2.c   |    3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index bf6cfe0..1a8cf6d 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -345,7 +345,7 @@ static int omap2430_musb_init(struct musb *musb)
 	 * up through ULPI.  TWL4030-family PMICs include one,
 	 * which needs a driver, drivers aren't always needed.
 	 */
-	musb->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+	musb->xceiv = devm_usb_get_phy_dev(dev, 0);
 	if (IS_ERR_OR_NULL(musb->xceiv)) {
 		pr_err("HS USB OTG: no transceiver configured\n");
 		return -ENODEV;
diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 0a70193..a994715 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -610,6 +610,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	twl->phy.dev		= twl->dev;
 	twl->phy.label		= "twl4030";
 	twl->phy.otg		= otg;
+	twl->phy.type		= USB_PHY_TYPE_USB2;
 	twl->phy.set_suspend	= twl4030_set_suspend;
 
 	otg->phy		= &twl->phy;
@@ -624,7 +625,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "ldo init failed\n");
 		return err;
 	}
-	usb_add_phy(&twl->phy, USB_PHY_TYPE_USB2);
+	usb_add_phy_dev(&twl->phy);
 
 	platform_set_drvdata(pdev, twl);
 	if (device_create_file(&pdev->dev, &dev_attr_vbus))
diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
index 4b59b39..b5c759c 100644
--- a/drivers/usb/phy/omap-usb2.c
+++ b/drivers/usb/phy/omap-usb2.c
@@ -143,6 +143,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	phy->phy.label		= "omap-usb2";
 	phy->phy.set_suspend	= omap_usb2_suspend;
 	phy->phy.otg		= otg;
+	phy->phy.type		= USB_PHY_TYPE_USB2;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 
@@ -168,7 +169,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 	clk_prepare(phy->wkupclk);
 
-	usb_add_phy(&phy->phy, USB_PHY_TYPE_USB2);
+	usb_add_phy_dev(&phy->phy);
 
 	platform_set_drvdata(pdev, phy);
 
-- 
1.7.9.5
