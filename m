From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v2 07/10] usb: phy: samsung: Enable runtime power management on
 usb3phy
Date: Sat, 02 Mar 2013 18:53:08 +0530
Message-ID: <1362230590-20960-8-git-send-email-gautam.vivek@samsung.com>
References: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Enable autosuspending of Samsung usb3.0 PHY

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/phy/samsung-usb3phy.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/samsung-usb3phy.c b/drivers/usb/phy/samsung-usb3phy.c
index 70e2c7b..7594cc7 100644
--- a/drivers/usb/phy/samsung-usb3phy.c
+++ b/drivers/usb/phy/samsung-usb3phy.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/usb/samsung_usb_phy.h>
 #include <linux/platform_data/samsung-usbphy.h>
 
@@ -287,6 +288,8 @@ static int samsung_usb3phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sphy);
 
+	pm_runtime_enable(&pdev->dev);
+
 	return usb_add_phy(&sphy->phy, USB_PHY_TYPE_USB3);
 }
 
@@ -296,6 +299,10 @@ static int samsung_usb3phy_remove(struct platform_device *pdev)
 
 	usb_remove_phy(&sphy->phy);
 
+	if (!pm_runtime_suspended(&pdev->dev))
+		pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	if (sphy->pmuregs)
 		iounmap(sphy->pmuregs);
 	if (sphy->sysreg)
-- 
1.7.6.5
