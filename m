From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH RFC 1/4] phy: Add provision for tuning phy.
Date: Tue, 10 Dec 2013 16:25:23 +0530
Message-ID: <1386672926-26885-2-git-send-email-gautam.vivek@samsung.com>
References: <1386672926-26885-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1386672926-26885-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, kishon@ti.com, jg1.han@samsung.com, jwerner@chromium.org
List-Id: linux-omap@vger.kernel.org

Some PHY controllers may need to tune PHY post-initialization,
so that the PHY consumers can call phy-tuning at appropriate
point of time.

Signed-off-by: vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/phy/phy-core.c  |   20 ++++++++++++++++++++
 include/linux/phy/phy.h |    7 +++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 03cf8fb..68dbb90 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -239,6 +239,26 @@ out:
 }
 EXPORT_SYMBOL_GPL(phy_power_off);
 
+int phy_tune(struct phy *phy)
+{
+	int ret = -ENOTSUPP;
+
+	mutex_lock(&phy->mutex);
+	if (phy->ops->tune) {
+		ret =  phy->ops->tune(phy);
+		if (ret < 0) {
+			dev_err(&phy->dev, "phy tuning failed --> %d\n", ret);
+			goto out;
+		}
+	}
+
+out:
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_tune);
+
 /**
  * of_phy_get() - lookup and obtain a reference to a phy by phandle
  * @dev: device that requests this phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 6d72269..d3b32b0 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -34,6 +34,7 @@ struct phy_ops {
 	int	(*exit)(struct phy *phy);
 	int	(*power_on)(struct phy *phy);
 	int	(*power_off)(struct phy *phy);
+	int	(*tune)(struct phy *phy);
 	struct module *owner;
 };
 
@@ -127,6 +128,7 @@ int phy_init(struct phy *phy);
 int phy_exit(struct phy *phy);
 int phy_power_on(struct phy *phy);
 int phy_power_off(struct phy *phy);
+int phy_tune(struct phy *phy);
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
 void phy_put(struct phy *phy);
@@ -199,6 +201,11 @@ static inline int phy_power_off(struct phy *phy)
 	return -ENOSYS;
 }
 
+static inline int phy_tune(struct phy *phy)
+{
+	return -ENOSYS;
+}
+
 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
 	return ERR_PTR(-ENOSYS);
-- 
1.7.6.5
