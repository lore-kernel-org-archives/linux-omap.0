From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 2/2] usb: dwc3: exynos: use clk_prepare_enable and
 clk_disable_unprepare
Date: Thu, 14 Mar 2013 16:14:58 +0530
Message-ID: <1363257898-17504-3-git-send-email-gautam.vivek@samsung.com>
References: <1363257898-17504-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1363257898-17504-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, rob.herring@calxeda.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, dianders@chromium.org
List-Id: linux-omap@vger.kernel.org

Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
calls as required by common clock framework.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
CC: Felipe Balbi <balbi@ti.com>
CC: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 66ca9ac..b03f609 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -129,7 +129,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	exynos->dev	= dev;
 	exynos->clk	= clk;
 
-	clk_enable(exynos->clk);
+	clk_prepare_enable(exynos->clk);
 
 	if (node) {
 		ret = of_platform_populate(node, NULL, NULL, dev);
@@ -146,7 +146,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	return 0;
 
 err2:
-	clk_disable(clk);
+	clk_disable_unprepare(clk);
 err1:
 	return ret;
 }
@@ -158,7 +158,7 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 	platform_device_unregister(exynos->usb2_phy);
 	platform_device_unregister(exynos->usb3_phy);
 
-	clk_disable(exynos->clk);
+	clk_disable_unprepare(exynos->clk);
 
 	return 0;
 }
-- 
1.7.6.5
