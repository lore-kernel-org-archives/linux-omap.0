From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v3 02/11] USB: dwc3: Adjust runtime pm to allow autosuspend
Date: Mon, 01 Apr 2013 19:24:01 +0530
Message-ID: <1364824448-14732-3-git-send-email-gautam.vivek@samsung.com>
References: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, kishon@ti.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

The current code in the dwc3 probe effectively disables runtime pm
from ever working because it calls a get() that was never put() until
device removal.  Change the runtime pm code to match the standard
formula and allow runtime pm to function.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/usb/dwc3/core.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e2325ad..3a6993c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -491,6 +491,11 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc->needs_fifo_resize = of_property_read_bool(node, "tx-fifo-resize");
 
+	/* Setting device state as 'suspended' initially,
+	 * to make sure we know device state prior to
+	 * pm_runtime_enable
+	 */
+	pm_runtime_set_suspended(dev);
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 	pm_runtime_forbid(dev);
@@ -566,6 +571,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err3;
 	}
 
+	pm_runtime_put_sync(dev);
 	pm_runtime_allow(dev);
 
 	return 0;
@@ -595,6 +601,7 @@ err1:
 
 err0:
 	dwc3_free_event_buffers(dwc);
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
@@ -606,7 +613,6 @@ static int dwc3_remove(struct platform_device *pdev)
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 
-	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	dwc3_debugfs_exit(dwc);
-- 
1.7.6.5
