From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 04/10] usb: dwc3: Add runtime power management callbacks
Date: Sat, 02 Mar 2013 18:53:05 +0530
Message-ID: <1362230590-20960-5-git-send-email-gautam.vivek@samsung.com>
References: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1362230590-20960-1-git-send-email-gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Right now it doesn't handle full runtime suspend/resume
functionality. However it allows to handle PHYs' sleep
and wakeup across runtime suspend/resume.

Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/dwc3/core.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2a77327..45e1aae 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -704,11 +704,38 @@ static int dwc3_resume(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int dwc3_runtime_suspend(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+
+	usb_phy_autopm_put_sync(dwc->usb2_phy);
+	usb_phy_autopm_put_sync(dwc->usb3_phy);
+
+	return 0;
+}
+
+static int dwc3_runtime_resume(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+
+	usb_phy_autopm_get_sync(dwc->usb2_phy);
+	usb_phy_autopm_get_sync(dwc->usb3_phy);
+
+	return 0;
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
