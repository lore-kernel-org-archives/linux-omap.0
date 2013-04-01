From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v3 08/11] usb: phy: samsung: Enable runtime power management on
 usb3phy
Date: Mon, 01 Apr 2013 19:24:07 +0530
Message-ID: <1364824448-14732-9-git-send-email-gautam.vivek@samsung.com>
References: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, kishon@ti.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

Enable autosuspending of Samsung usb3.0 PHY

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/phy/phy-samsung-usb3.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/phy-samsung-usb3.c b/drivers/usb/phy/phy-samsung-usb3.c
index 54f6418..a713585 100644
--- a/drivers/usb/phy/phy-samsung-usb3.c
+++ b/drivers/usb/phy/phy-samsung-usb3.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/usb/samsung_usb_phy.h>
 #include <linux/platform_data/samsung-usbphy.h>
 
@@ -287,6 +288,9 @@ static int samsung_usb3phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sphy);
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return usb_add_phy(&sphy->phy, USB_PHY_TYPE_USB3);
 }
 
@@ -296,6 +300,8 @@ static int samsung_usb3phy_remove(struct platform_device *pdev)
 
 	usb_remove_phy(&sphy->phy);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (sphy->pmuregs)
 		iounmap(sphy->pmuregs);
 	if (sphy->sysreg)
-- 
1.7.6.5
