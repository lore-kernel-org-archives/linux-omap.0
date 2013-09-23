From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH] usb: dwc3: Remove additional delay of 100ms when resuming
Date: Mon, 23 Sep 2013 09:08:28 +0530
Message-ID: <1379907508-22492-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This delay got introduced in:
"7415f17 usb: dwc3: core: add power management support"
which reflected similar code in dwc3_core_soft_reset() function.
However, originally the delay of 100ms in dwc3_core_soft_reset() was
meant to assist USB2PHY and USB3PHY reset, not for usb_phy_init()
sequence.

We should get rid of this delay, since things will still work
fine without this.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---

Hi Felipe,

I remember this change for phy_init including msleep(100) was
suggested by me, after testing the patch-series for PM support
to dwc3.
Sorry for that !!

 drivers/usb/dwc3/core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 474162e..e88ffae 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -691,7 +691,6 @@ static int dwc3_resume(struct device *dev)
 
 	usb_phy_init(dwc->usb3_phy);
 	usb_phy_init(dwc->usb2_phy);
-	msleep(100);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-- 
1.7.6.5
