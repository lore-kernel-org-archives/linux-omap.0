From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/8] usb: phy: nop: Handle RESET for the PHY
Date: Tue, 12 Mar 2013 13:24:23 +0200
Message-ID: <1363087466-32444-6-git-send-email-rogerq@ti.com>
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

We expect the RESET line to be modeled as a regulator with supply
name "reset". The regulator should be modeled such that enabling
the regulator brings the PHY device out of RESET and disabling the
regulator holds the device in RESET.

They PHY will be held in RESET in .shutdown() and brought out of
RESET in .init().

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/nop-usb-xceiv.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index fbdcfef..6efc9b7 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -40,6 +40,7 @@ struct nop_usb_xceiv {
 	struct device		*dev;
 	struct clk		*clk;
 	struct regulator	*vcc;
+	struct regulator	*reset;
 };
 
 static struct platform_device *pd;
@@ -80,6 +81,12 @@ static int nop_init(struct usb_phy *phy)
 	if (!IS_ERR(nop->clk))
 		clk_enable(nop->clk);
 
+	if (!IS_ERR(nop->reset)) {
+		/* De-assert RESET */
+		if (regulator_enable(nop->reset))
+			dev_err(phy->dev, "Failed to de-assert reset\n");
+	}
+
 	return 0;
 }
 
@@ -87,6 +94,12 @@ static void nop_shutdown(struct usb_phy *phy)
 {
 	struct nop_usb_xceiv *nop = dev_get_drvdata(phy->dev);
 
+	if (!IS_ERR(nop->reset)) {
+		/* Assert RESET */
+		if (regulator_disable(nop->reset))
+			dev_err(phy->dev, "Failed to assert reset\n");
+	}
+
 	if (!IS_ERR(nop->clk))
 		clk_disable(nop->clk);
 
@@ -172,6 +185,12 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
 					PTR_ERR(nop->vcc));
 	}
 
+	nop->reset = devm_regulator_get(&pdev->dev, "reset");
+	if (IS_ERR(nop->reset)) {
+		dev_dbg(&pdev->dev, "Error getting reset regulator: %ld\n",
+					PTR_ERR(nop->reset));
+	}
+
 	nop->dev		= &pdev->dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
-- 
1.7.4.1
