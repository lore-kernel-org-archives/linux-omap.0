From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v3 04/11] usb: dwc3: Add runtime power management callbacks
Date: Mon, 01 Apr 2013 19:24:03 +0530
Message-ID: <1364824448-14732-5-git-send-email-gautam.vivek@samsung.com>
References: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, kishon@ti.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

Right now it doesn't handle full runtime suspend/resume
functionality. However it allows to handle PHYs' sleep
and wakeup across runtime suspend/resume.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/core.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e250828..65a3adf 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -745,11 +745,54 @@ static int dwc3_resume(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int dwc3_runtime_suspend(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = usb_phy_autopm_put_sync(dwc->usb2_phy);
+	if (ret)
+		dev_warn(dev, "Can't autosuspend usb2-phy\n");
+
+	ret = usb_phy_autopm_put_sync(dwc->usb3_phy);
+	if (ret)
+		dev_warn(dev, "Can't autosuspend usb3-phy\n");
+
+	return ret;
+}
+
+static int dwc3_runtime_resume(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = usb_phy_autopm_get_sync(dwc->usb2_phy);
+	if (ret) {
+		dev_err(dev, "usb2-phy: get sync failed with err %d\n", ret);
+		return ret;
+	}
+
+	ret = usb_phy_autopm_get_sync(dwc->usb3_phy);
+	if (ret) {
+		dev_err(dev, "usb3-phy: get sync failed with err %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+#else
+#define dwc3_runtime_suspend		NULL
+#define dwc3_runtime_resume		NULL
+#endif
+
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	.prepare	= dwc3_prepare,
 	.complete	= dwc3_complete,
 
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
+	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend,
+				dwc3_runtime_resume, NULL)
 };
 
 #define DWC3_PM_OPS	&(dwc3_dev_pm_ops)
-- 
1.7.6.5
