From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/7] usb: dwc3: omap: add basic pm_runtime support
Date: Thu, 12 Dec 2013 15:38:40 -0600
Message-ID: <1386884325-11440-3-git-send-email-balbi@ti.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1386884325-11440-1-git-send-email-balbi@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: kgene.kim@samsung.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, w-kwok2@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

If we want to suspend/runtime in runtime, we
can do so, in OMAP's case at least, with the
same implementation we use for system pm.

This patch adds basic pm_runtime support with
that in mind.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index b269dbd..aea305d 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -617,20 +617,35 @@ static void dwc3_omap_complete(struct device *dev)
 	dwc3_omap_enable_irqs(omap);
 }
 
-static int dwc3_omap_suspend(struct device *dev)
+static int __dwc3_omap_suspend(struct dwc3_omap *omap)
 {
-	struct dwc3_omap	*omap = dev_get_drvdata(dev);
-
 	omap->utmi_otg_status = dwc3_omap_read_utmi_status(omap);
 
 	return 0;
 }
 
+static int __dwc3_omap_resume(struct dwc3_omap *omap)
+{
+	dwc3_omap_write_utmi_status(omap, omap->utmi_otg_status);
+
+	return 0;
+}
+
+static int dwc3_omap_suspend(struct device *dev)
+{
+	struct dwc3_omap	*omap = dev_get_drvdata(dev);
+
+	return __dwc3_omap_suspend(omap);
+}
+
 static int dwc3_omap_resume(struct device *dev)
 {
 	struct dwc3_omap	*omap = dev_get_drvdata(dev);
+	int			ret;
 
-	dwc3_omap_write_utmi_status(omap, omap->utmi_otg_status);
+	ret = __dwc3_omap_resume(omap);
+	if (ret)
+		return ret;
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
@@ -639,11 +654,27 @@ static int dwc3_omap_resume(struct device *dev)
 	return 0;
 }
 
+static int dwc3_omap_runtime_suspend(struct device *dev)
+{
+	struct dwc3_omap	*omap = dev_get_drvdata(dev);
+
+	return __dwc3_omap_suspend(omap);
+}
+
+static int dwc3_omap_runtime_resume(struct device *dev)
+{
+	struct dwc3_omap	*omap = dev_get_drvdata(dev);
+
+	return __dwc3_omap_resume(omap);
+}
+
 static const struct dev_pm_ops dwc3_omap_dev_pm_ops = {
 	.prepare	= dwc3_omap_prepare,
 	.complete	= dwc3_omap_complete,
 
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_omap_suspend, dwc3_omap_resume)
+	SET_RUNTIME_PM_OPS(dwc3_omap_runtime_suspend, dwc3_omap_runtime_resume,
+			NULL)
 };
 
 #define DEV_PM_OPS	(&dwc3_omap_dev_pm_ops)
-- 
1.8.4.GIT
