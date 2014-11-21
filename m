From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 02/11] dwc3: exynos: Remove local variable for clock from probe
Date: Fri, 21 Nov 2014 19:05:45 +0530
Message-ID: <1416576954-11997-3-git-send-email-gautam.vivek@samsung.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, balbi@ti.com, kishon@ti.com
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, tomasz.figa@gmail.com, s.nawrocki@samsung.com, robh+dt@kernel.org, stern@rowland.harvard.edu, kgene.kim@samsung.com, Vivek Gautam <gautam.vivek@samsung.com>
List-Id: linux-omap@vger.kernel.org

There's no need to keep one local variable for clock, and
then assign the same to 'clk' member of dwc3_exynos.
Just cleaning it up.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 3951a65..7109de7 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -106,7 +106,6 @@ static int dwc3_exynos_remove_child(struct device *dev, void *unused)
 static int dwc3_exynos_probe(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos;
-	struct clk		*clk;
 	struct device		*dev = &pdev->dev;
 	struct device_node	*node = dev->of_node;
 
@@ -133,15 +132,13 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	clk = devm_clk_get(dev, "usbdrd30");
-	if (IS_ERR(clk)) {
+	exynos->dev	= dev;
+
+	exynos->clk = devm_clk_get(dev, "usbdrd30");
+	if (IS_ERR(exynos->clk)) {
 		dev_err(dev, "couldn't get clock\n");
 		return -EINVAL;
 	}
-
-	exynos->dev	= dev;
-	exynos->clk	= clk;
-
 	clk_prepare_enable(exynos->clk);
 
 	exynos->vdd33 = devm_regulator_get(dev, "vdd33");
@@ -185,7 +182,7 @@ err4:
 err3:
 	regulator_disable(exynos->vdd33);
 err2:
-	clk_disable_unprepare(clk);
+	clk_disable_unprepare(exynos->clk);
 	return ret;
 }
 
-- 
1.7.10.4
