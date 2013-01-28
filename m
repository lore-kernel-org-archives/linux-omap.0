From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 2/4] USB: dwc3: Adjust runtime pm the dwc3 driver to allow
 runtime suspend
Date: Mon, 28 Jan 2013 17:12:26 +0530
Message-ID: <1359373348-18320-3-git-send-email-gautam.vivek@samsung.com>
References: <1359373348-18320-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:27128 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757106Ab3A1Lij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jan 2013 06:38:39 -0500
In-reply-to: <1359373348-18320-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, dianders@chromium.org, sylvester.nawrocki@gmail.com, tomasz.figa@gmail.com

The current code in the dwc3 probe effectively disables runtime pm
from ever working because it calls a get() that was never put() until
device removal.  Change the runtime pm code to match the standard
formula and allow runtime pm to function.

Note that this doesn't enable full runtime pm on the DWC3 device in
that the port isn't put into a lower power mode when not used.
However it does allow users of dwc3 (like dwc3-exynos) to do some
amount of runtime power management.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/usb/dwc3/core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3a4004a..59c2494 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -453,6 +453,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (of_get_property(node, "tx-fifo-resize", NULL))
 		dwc->needs_fifo_resize = true;
 
+	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 	pm_runtime_forbid(dev);
@@ -517,6 +518,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	pm_runtime_put(dev);
 	pm_runtime_allow(dev);
 
 	return 0;
@@ -543,6 +545,7 @@ err1:
 
 err0:
 	dwc3_free_event_buffers(dwc);
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
@@ -554,7 +557,6 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	dwc3_debugfs_exit(dwc);
-- 
1.7.6.5

