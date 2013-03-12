From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/8] usb: phy: nop: Handle power supply regulator for the PHY
Date: Tue, 12 Mar 2013 13:24:22 +0200
Message-ID: <1363087466-32444-5-git-send-email-rogerq@ti.com>
References: <1363087466-32444-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1363087466-32444-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
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
To: balbi-l0cyMroinI0@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We use "vcc" as the supply name for the PHY's power supply.
The power supply will be enabled during .init() and disabled
during .shutdown()

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/nop-usb-xceiv.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index 17c174f..fbdcfef 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -33,11 +33,13 @@
 #include <linux/usb/nop-usb-xceiv.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/regulator/consumer.h>
 
 struct nop_usb_xceiv {
 	struct usb_phy		phy;
 	struct device		*dev;
 	struct clk		*clk;
+	struct regulator	*vcc;
 };
 
 static struct platform_device *pd;
@@ -70,6 +72,11 @@ static int nop_init(struct usb_phy *phy)
 {
 	struct nop_usb_xceiv *nop = dev_get_drvdata(phy->dev);
 
+	if (!IS_ERR(nop->vcc)) {
+		if (regulator_enable(nop->vcc))
+			dev_err(phy->dev, "Failed to enable power\n");
+	}
+
 	if (!IS_ERR(nop->clk))
 		clk_enable(nop->clk);
 
@@ -82,6 +89,11 @@ static void nop_shutdown(struct usb_phy *phy)
 
 	if (!IS_ERR(nop->clk))
 		clk_disable(nop->clk);
+
+	if (!IS_ERR(nop->vcc)) {
+		if (regulator_disable(nop->vcc))
+			dev_err(phy->dev, "Failed to disable power\n");
+	}
 }
 
 static int nop_set_peripheral(struct usb_otg *otg, struct usb_gadget *gadget)
@@ -154,6 +166,12 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
 		}
 	}
 
+	nop->vcc = devm_regulator_get(&pdev->dev, "vcc");
+	if (IS_ERR(nop->vcc)) {
+		dev_dbg(&pdev->dev, "Error getting vcc regulator: %ld\n",
+					PTR_ERR(nop->vcc));
+	}
+
 	nop->dev		= &pdev->dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
-- 
1.7.4.1
