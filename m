From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/8] phy: omap-usb2: Use generic clock names "wkupclk" and "refclk"
Date: Fri, 7 Mar 2014 15:09:07 +0200
Message-ID: <1394197751-28984-5-git-send-email-rogerq@ti.com>
References: <1394197751-28984-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394197751-28984-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, tony@atomide.com
Cc: kishon@ti.com, george.cherian@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

As clocks might be named differently on multiple platforms, use a generic
name in the driver and allow device tree node to specify the platform
specific clock name.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-omap-usb2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index a2205a8..fb5e515 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -275,16 +275,16 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	if (IS_ERR(phy_provider))
 		return PTR_ERR(phy_provider);
 
-	phy->wkupclk = devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
+	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
 	if (IS_ERR(phy->wkupclk)) {
-		dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
+		dev_err(&pdev->dev, "unable to get wkupclk\n");
 		return PTR_ERR(phy->wkupclk);
 	}
 	clk_prepare(phy->wkupclk);
 
-	phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
+	phy->optclk = devm_clk_get(phy->dev, "refclk");
 	if (IS_ERR(phy->optclk))
-		dev_vdbg(&pdev->dev, "unable to get refclk960m\n");
+		dev_dbg(&pdev->dev, "unable to get refclk\n");
 	else
 		clk_prepare(phy->optclk);
 
-- 
1.8.3.2
