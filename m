From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 01/11] phy: core add phy_set_netif_mode() api
Date: Mon, 8 Oct 2018 18:49:39 -0500
Message-ID: <20181008234949.15416-2-grygorii.strashko@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008234949.15416-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Add new API phy_set_netif_mode(struct phy *phy, phy_interface_t mode) and
new PHY operation callback .set_netif_mode() which intended to be implemnte
by PHY drivers which supports Network interrfaces mode selection. Both
accepts phy_interface_t vlaue as input parameter.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/phy/phy-core.c  | 15 +++++++++++++++
 include/linux/phy/phy.h | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 35fd38c..d9aba1a 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -377,6 +377,21 @@ int phy_set_mode(struct phy *phy, enum phy_mode mode)
 }
 EXPORT_SYMBOL_GPL(phy_set_mode);
 
+int phy_set_netif_mode(struct phy *phy, phy_interface_t mode)
+{
+	int ret;
+
+	if (!phy || !phy->ops->set_netif_mode)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->set_netif_mode(phy, mode);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_set_netif_mode);
+
 int phy_reset(struct phy *phy)
 {
 	int ret;
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 9713aeb..bc73d2b 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/device.h>
+#include <linux/phy.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
@@ -49,6 +50,7 @@ enum phy_mode {
  * @power_on: powering on the phy
  * @power_off: powering off the phy
  * @set_mode: set the mode of the phy
+ * @set_netif_mode: set the mode of the net interface phy
  * @reset: resetting the phy
  * @calibrate: calibrate the phy
  * @owner: the module owner containing the ops
@@ -59,6 +61,7 @@ struct phy_ops {
 	int	(*power_on)(struct phy *phy);
 	int	(*power_off)(struct phy *phy);
 	int	(*set_mode)(struct phy *phy, enum phy_mode mode);
+	int	(*set_netif_mode)(struct phy *phy, phy_interface_t mode);
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
 	struct module *owner;
@@ -163,6 +166,7 @@ int phy_exit(struct phy *phy);
 int phy_power_on(struct phy *phy);
 int phy_power_off(struct phy *phy);
 int phy_set_mode(struct phy *phy, enum phy_mode mode);
+int phy_set_netif_mode(struct phy *phy, phy_interface_t mode);
 static inline enum phy_mode phy_get_mode(struct phy *phy)
 {
 	return phy->attrs.mode;
@@ -283,6 +287,14 @@ static inline int phy_set_mode(struct phy *phy, enum phy_mode mode)
 	return -ENOSYS;
 }
 
+static inline int phy_set_netif_mode(struct phy *phy,
+				     phy_interface_t mode)
+{
+	if (!phy)
+		return 0;
+	return -ENOTSUPP;
+}
+
 static inline enum phy_mode phy_get_mode(struct phy *phy)
 {
 	return PHY_MODE_INVALID;
-- 
2.10.5
