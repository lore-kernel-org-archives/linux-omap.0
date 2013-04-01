From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v3 03/11] usb: dwc3: Enable runtime pm only after PHYs are
 initialized
Date: Mon, 01 Apr 2013 19:24:02 +0530
Message-ID: <1364824448-14732-4-git-send-email-gautam.vivek@samsung.com>
References: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, kishon@ti.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

Allow dwc3 to enable auto power management only after its PHYs
are initialized so that any further PHY handling by dwc3's
runtime power management callbacks is fine.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/core.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3a6993c..e250828 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -491,15 +491,6 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc->needs_fifo_resize = of_property_read_bool(node, "tx-fifo-resize");
 
-	/* Setting device state as 'suspended' initially,
-	 * to make sure we know device state prior to
-	 * pm_runtime_enable
-	 */
-	pm_runtime_set_suspended(dev);
-	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
-	pm_runtime_forbid(dev);
-
 	dwc3_cache_hwparams(dwc);
 
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
@@ -521,6 +512,15 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	/* Setting device state as 'suspended' initially,
+	 * to make sure we know device state prior to
+	 * pm_runtime_enable
+	 */
+	pm_runtime_set_suspended(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+	pm_runtime_forbid(dev);
+
 	if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
 		mode = DWC3_MODE_HOST;
 	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
-- 
1.7.6.5
