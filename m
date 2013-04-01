From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v3 01/11] usb: phy: Add APIs for runtime power management
Date: Mon, 01 Apr 2013 19:24:00 +0530
Message-ID: <1364824448-14732-2-git-send-email-gautam.vivek@samsung.com>
References: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, kishon@ti.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

Adding  APIs to handle runtime power management on PHY
devices. PHY consumers may need to wake-up/suspend PHYs
when they work across autosuspend.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 include/linux/usb/phy.h |  141 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 141 insertions(+), 0 deletions(-)

diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 6b5978f..01bf9c1 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -297,4 +297,145 @@ static inline const char *usb_phy_type_string(enum usb_phy_type type)
 		return "UNKNOWN PHY TYPE";
 	}
 }
+
+static inline void usb_phy_autopm_enable(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return;
+		}
+
+	pm_runtime_enable(x->dev);
+}
+
+static inline void usb_phy_autopm_disable(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return;
+	}
+
+	pm_runtime_disable(x->dev);
+}
+
+static inline int usb_phy_autopm_get(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return -ENODEV;
+	}
+
+	return pm_runtime_get(x->dev);
+}
+
+static inline int usb_phy_autopm_get_sync(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return -ENODEV;
+	}
+
+	return pm_runtime_get_sync(x->dev);
+}
+
+static inline int usb_phy_autopm_put(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return -ENODEV;
+	}
+
+	return pm_runtime_put(x->dev);
+}
+
+static inline int usb_phy_autopm_put_sync(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return -ENODEV;
+	}
+
+	return pm_runtime_put_sync(x->dev);
+}
+
+static inline void usb_phy_autopm_allow(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return;
+	}
+
+	pm_runtime_allow(x->dev);
+}
+
+static inline void usb_phy_autopm_forbid(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return;
+	}
+
+	pm_runtime_forbid(x->dev);
+}
+
+static inline int usb_phy_autopm_set_active(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return -ENODEV;
+	}
+
+	return pm_runtime_set_active(x->dev);
+}
+
+static inline void usb_phy_autopm_set_suspended(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return;
+	}
+
+	pm_runtime_set_suspended(x->dev);
+}
+
+static inline bool usb_phy_autopm_suspended(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return 0;
+	}
+
+	return pm_runtime_suspended(x->dev);
+}
+
+static inline bool usb_phy_autopm_active(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return 0;
+	}
+
+	return pm_runtime_active(x->dev);
+}
+
+static inline int usb_phy_autopm_suspend(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return -ENODEV;
+	}
+
+	return pm_runtime_suspend(x->dev);
+}
+
+static inline int usb_phy_autopm_resume(struct usb_phy *x)
+{
+	if (!x || !x->dev) {
+		dev_err(x->dev, "no PHY or attached device available\n");
+		return -ENODEV;
+	}
+
+	return pm_runtime_resume(x->dev);
+}
+
 #endif /* __LINUX_USB_PHY_H */
-- 
1.7.6.5
