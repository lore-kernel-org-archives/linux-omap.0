From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v2 02/10] USB: dwc3: Adjust runtime pm to allow autosuspend
Date: Sat, 02 Mar 2013 18:53:03 +0530
Message-ID: <1362230590-20960-3-git-send-email-gautam.vivek@samsung.com>
References: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, kishon@ti.com, Doug Anderson <dianders@chromium.org>
List-Id: linux-omap@vger.kernel.org

The current code in the dwc3 probe effectively disables runtime pm
from ever working because it calls a get() that was never put() until
device removal.  Change the runtime pm code to match the standard
formula and allow runtime pm to function.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/usb/dwc3/core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index be0672f..85914e0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -528,6 +528,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err3;
 	}
 
+	pm_runtime_put_sync(dev);
 	pm_runtime_allow(dev);
 
 	return 0;
@@ -557,6 +558,7 @@ err1:
 
 err0:
 	dwc3_free_event_buffers(dwc);
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
@@ -568,7 +570,8 @@ static int dwc3_remove(struct platform_device *pdev)
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 
-	pm_runtime_put(&pdev->dev);
+	if (!pm_runtime_suspended(&pdev->dev))
+		pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	dwc3_debugfs_exit(dwc);
-- 
1.7.6.5
