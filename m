From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 2/2] usb: phy: omap-usb2: enable 960Mhz clock for omap5
Date: Fri, 25 Jan 2013 16:29:34 +0530
Message-ID: <1359111574-6613-3-git-send-email-kishon@ti.com>
References: <1359111574-6613-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1359111574-6613-1-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: rob.herring@calxeda.com, rob@landley.net, balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

"usb_otg_ss_refclk960m" is needed for usb2 phy present in omap5. For
omap4, the clk_get of this clock will fail since it does not have this
clock.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/phy/omap-usb2.c |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
index 0cd88ac..844ab68 100644
--- a/drivers/usb/phy/omap-usb2.c
+++ b/drivers/usb/phy/omap-usb2.c
@@ -166,6 +166,12 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 	clk_prepare(phy->wkupclk);
 
+	phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
+	if (IS_ERR(phy->optclk))
+		dev_vdbg(&pdev->dev, "unable to get refclk960m\n");
+	else
+		clk_prepare(phy->optclk);
+
 	usb_add_phy_dev(&phy->phy);
 
 	platform_set_drvdata(pdev, phy);
@@ -180,6 +186,8 @@ static int omap_usb2_remove(struct platform_device *pdev)
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
 
 	clk_unprepare(phy->wkupclk);
+	if (!IS_ERR(phy->optclk))
+		clk_unprepare(phy->optclk);
 	usb_remove_phy(&phy->phy);
 
 	return 0;
@@ -193,6 +201,8 @@ static int omap_usb2_runtime_suspend(struct device *dev)
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
 
 	clk_disable(phy->wkupclk);
+	if (!IS_ERR(phy->optclk))
+		clk_disable(phy->optclk);
 
 	return 0;
 }
@@ -204,9 +214,25 @@ static int omap_usb2_runtime_resume(struct device *dev)
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
 
 	ret = clk_enable(phy->wkupclk);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(phy->dev, "Failed to enable wkupclk %d\n", ret);
+		goto err0;
+	}
+
+	if (!IS_ERR(phy->optclk)) {
+		ret = clk_enable(phy->optclk);
+		if (ret < 0) {
+			dev_err(phy->dev, "Failed to enable optclk %d\n", ret);
+			goto err1;
+		}
+	}
+
+	return 0;
+
+err1:
+	clk_disable(phy->wkupclk);
 
+err0:
 	return ret;
 }
 
-- 
1.7.9.5

