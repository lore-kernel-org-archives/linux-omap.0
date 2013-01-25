From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 2/2] usb: dwc3: host: Change platform device ID for xhci-hcd to
 AUTO
Date: Fri, 25 Jan 2013 16:52:02 +0530
Message-ID: <1359112922-2247-3-git-send-email-gautam.vivek@samsung.com>
References: <1359112922-2247-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1359112922-2247-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Multiple dwc3 controllers will try to allocate multiple xhci-hcd
interfaces.
Changing platform device IDs from NONE to AUTO to support
such cases.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/host.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 56a6234..0fa1846 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -44,7 +44,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 	struct platform_device	*xhci;
 	int			ret;
 
-	xhci = platform_device_alloc("xhci-hcd", -1);
+	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
 	if (!xhci) {
 		dev_err(dwc->dev, "couldn't allocate xHCI device\n");
 		ret = -ENOMEM;
-- 
1.7.6.5
