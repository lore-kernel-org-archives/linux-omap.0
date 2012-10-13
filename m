From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH] USB: DWC3: Shutdown usb_phy when removing the device
Date: Sat, 13 Oct 2012 19:20:18 +0530
Message-ID: <1350136218-25678-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:20626 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab2JMNo6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Oct 2012 09:44:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: gregkh@linuxfoundation.org, balbi@ti.com, rob.herring@calxeda.com

We do usb_phy_init() while doing core_init() in probe,
so adding usb_phy_shutdown() when we do core_exit()
while removing the device.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b415c0c..c14ebc9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -409,6 +409,10 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 {
 	dwc3_event_buffers_cleanup(dwc);
 	dwc3_free_event_buffers(dwc);
+
+	usb_phy_shutdown(dwc->usb2_phy);
+	usb_phy_shutdown(dwc->usb3_phy);
+
 }
 
 #define DWC3_ALIGN_MASK		(16 - 1)
-- 
1.7.6.5

