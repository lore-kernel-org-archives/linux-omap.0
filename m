From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 03/10] usb: dwc3: preparation for adapting dwc3 to generic phy framework
Date: Mon, 25 Nov 2013 15:31:23 +0530
Message-ID: <1385373690-12170-4-git-send-email-kishon@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385373690-12170-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, balbi@ti.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, tony@atomide.com, linux@arm.linux.org.uk, kishon@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, s.nawrocki@samsung.com, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

Invoke usb_phy api's only if usb_phy does not have error value. This is
needed for both the legacy usb_phy and generic phy to co-exist in dwc3 core.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/core.c |   42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a49217a..986674f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -80,8 +80,10 @@ static void dwc3_core_soft_reset(struct dwc3 *dwc)
 	reg |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
-	usb_phy_init(dwc->usb2_phy);
-	usb_phy_init(dwc->usb3_phy);
+	if (!IS_ERR(dwc->usb2_phy))
+		usb_phy_init(dwc->usb2_phy);
+	if (!IS_ERR(dwc->usb3_phy))
+		usb_phy_init(dwc->usb3_phy);
 	mdelay(100);
 
 	/* Clear USB3 PHY reset */
@@ -341,8 +343,10 @@ err0:
 
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
+	if (!IS_ERR(dwc->usb2_phy))
+		usb_phy_shutdown(dwc->usb2_phy);
+	if (!IS_ERR(dwc->usb3_phy))
+		usb_phy_shutdown(dwc->usb3_phy);
 }
 
 #define DWC3_ALIGN_MASK		(16 - 1)
@@ -485,8 +489,10 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	usb_phy_set_suspend(dwc->usb2_phy, 0);
-	usb_phy_set_suspend(dwc->usb3_phy, 0);
+	if (!IS_ERR(dwc->usb2_phy))
+		usb_phy_set_suspend(dwc->usb2_phy, 0);
+	if (!IS_ERR(dwc->usb3_phy))
+		usb_phy_set_suspend(dwc->usb3_phy, 0);
 
 	ret = dwc3_event_buffers_setup(dwc);
 	if (ret) {
@@ -569,8 +575,10 @@ err2:
 	dwc3_event_buffers_cleanup(dwc);
 
 err1:
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	if (!IS_ERR(dwc->usb2_phy))
+		usb_phy_set_suspend(dwc->usb2_phy, 1);
+	if (!IS_ERR(dwc->usb3_phy))
+		usb_phy_set_suspend(dwc->usb3_phy, 1);
 	dwc3_core_exit(dwc);
 
 err0:
@@ -583,8 +591,10 @@ static int dwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3	*dwc = platform_get_drvdata(pdev);
 
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	if (!IS_ERR(dwc->usb2_phy))
+		usb_phy_set_suspend(dwc->usb2_phy, 1);
+	if (!IS_ERR(dwc->usb3_phy))
+		usb_phy_set_suspend(dwc->usb3_phy, 1);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -680,8 +690,10 @@ static int dwc3_suspend(struct device *dev)
 	dwc->gctl = dwc3_readl(dwc->regs, DWC3_GCTL);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	usb_phy_shutdown(dwc->usb3_phy);
-	usb_phy_shutdown(dwc->usb2_phy);
+	if (!IS_ERR(dwc->usb3_phy))
+		usb_phy_shutdown(dwc->usb3_phy);
+	if (!IS_ERR(dwc->usb2_phy))
+		usb_phy_shutdown(dwc->usb2_phy);
 
 	return 0;
 }
@@ -691,8 +703,10 @@ static int dwc3_resume(struct device *dev)
 	struct dwc3	*dwc = dev_get_drvdata(dev);
 	unsigned long	flags;
 
-	usb_phy_init(dwc->usb3_phy);
-	usb_phy_init(dwc->usb2_phy);
+	if (!IS_ERR(dwc->usb3_phy))
+		usb_phy_init(dwc->usb3_phy);
+	if (!IS_ERR(dwc->usb2_phy))
+		usb_phy_init(dwc->usb2_phy);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-- 
1.7.10.4
