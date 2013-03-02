From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v2 03/10] usb: dwc3: Enable runtime pm only after PHYs are
 initialized
Date: Sat, 02 Mar 2013 18:53:04 +0530
Message-ID: <1362230590-20960-4-git-send-email-gautam.vivek@samsung.com>
References: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Allow dwc3 to enable auto power management only after its PHYs
are initialized so that any further PHY handling by dwc3's
runtime power management callbacks is fine.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 85914e0..2a77327 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -453,10 +453,6 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc->needs_fifo_resize = of_property_read_bool(node, "tx-fifo-resize");
 
-	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
-	pm_runtime_forbid(dev);
-
 	dwc3_cache_hwparams(dwc);
 
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
@@ -478,6 +474,10 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+	pm_runtime_forbid(dev);
+
 	if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
 		mode = DWC3_MODE_HOST;
 	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
-- 
1.7.6.5
