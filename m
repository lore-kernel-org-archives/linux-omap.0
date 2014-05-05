From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 1/7] phy: omap-usb2: Use generic clock names "wkupclk" and "refclk"
Date: Mon, 5 May 2014 12:54:40 +0300
Message-ID: <1399283686-6127-2-git-send-email-rogerq@ti.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399283686-6127-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

As clocks might be named differently on multiple platforms, use a generic
name in the driver and allow device tree node to specify the platform
specific clock name.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/phy/phy-omap-usb2.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index a2205a8..7007c11 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -275,18 +275,34 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	if (IS_ERR(phy_provider))
 		return PTR_ERR(phy_provider);
 
-	phy->wkupclk = devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
+	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
 	if (IS_ERR(phy->wkupclk)) {
-		dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
-		return PTR_ERR(phy->wkupclk);
+		dev_warn(&pdev->dev, "unable to get wkupclk, trying old name\n");
+		phy->wkupclk = devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
+		if (IS_ERR(phy->wkupclk)) {
+			dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
+			return PTR_ERR(phy->wkupclk);
+		} else {
+			dev_warn(&pdev->dev,
+				 "found usb_phy_cm_clk32k, please fix DTS\n");
+		}
 	}
 	clk_prepare(phy->wkupclk);
 
-	phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
-	if (IS_ERR(phy->optclk))
-		dev_vdbg(&pdev->dev, "unable to get refclk960m\n");
-	else
+	phy->optclk = devm_clk_get(phy->dev, "refclk");
+	if (IS_ERR(phy->optclk)) {
+		dev_dbg(&pdev->dev, "unable to get refclk, trying old name\n");
+		phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
+		if (IS_ERR(phy->optclk)) {
+			dev_dbg(&pdev->dev,
+				"unable to get usb_otg_ss_refclk960m\n");
+		} else {
+			dev_warn(&pdev->dev,
+				 "found usb_otg_ss_refclk960m, please fix DTS\n");
+		}
+	} else {
 		clk_prepare(phy->optclk);
+	}
 
 	usb_add_phy_dev(&phy->phy);
 
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
