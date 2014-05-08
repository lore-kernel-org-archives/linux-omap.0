From: George Cherian <george.cherian@ti.com>
Subject: [PATCH 5/5] usb: dwc3: dwc3-omap: Disable/Enable core interrupts in Suspend/Resume
Date: Thu, 8 May 2014 15:03:07 +0530
Message-ID: <1399541587-14067-6-git-send-email-george.cherian@ti.com>
References: <1399541587-14067-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399541587-14067-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: balbi@ti.com, gregkh@linuxfoundation.org, rogerq@ti.com, kishon@ti.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Enabling the core interrupts in complete is too late for XHCI, and stops
xhci from proper operation. So remove prepare and complete and disable/enable
interrupts in suspend/resume

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 82b20d8f..0916c4b 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -622,27 +622,12 @@ static const struct of_device_id of_dwc3_match[] = {
 MODULE_DEVICE_TABLE(of, of_dwc3_match);
 
 #ifdef CONFIG_PM_SLEEP
-static int dwc3_omap_prepare(struct device *dev)
-{
-	struct dwc3_omap	*omap = dev_get_drvdata(dev);
-
-	dwc3_omap_disable_irqs(omap);
-
-	return 0;
-}
-
-static void dwc3_omap_complete(struct device *dev)
-{
-	struct dwc3_omap	*omap = dev_get_drvdata(dev);
-
-	dwc3_omap_enable_irqs(omap);
-}
-
 static int dwc3_omap_suspend(struct device *dev)
 {
 	struct dwc3_omap	*omap = dev_get_drvdata(dev);
 
 	omap->utmi_otg_status = dwc3_omap_read_utmi_status(omap);
+	dwc3_omap_disable_irqs(omap);
 
 	return 0;
 }
@@ -652,6 +637,7 @@ static int dwc3_omap_resume(struct device *dev)
 	struct dwc3_omap	*omap = dev_get_drvdata(dev);
 
 	dwc3_omap_write_utmi_status(omap, omap->utmi_otg_status);
+	dwc3_omap_enable_irqs(omap);
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
@@ -661,8 +647,6 @@ static int dwc3_omap_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops dwc3_omap_dev_pm_ops = {
-	.prepare	= dwc3_omap_prepare,
-	.complete	= dwc3_omap_complete,
 
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_omap_suspend, dwc3_omap_resume)
 };
-- 
1.8.3.1
