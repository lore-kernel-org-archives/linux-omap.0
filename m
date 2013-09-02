From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC 1/6] reset: is_reset and clear_reset api's
Date: Mon, 2 Sep 2013 19:45:14 +0530
Message-ID: <5dcf227d360f748ddc965f6c13ff0b31c3e90dab.1378129416.git.afzal@ti.com>
References: <cover.1378129416.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1378129416.git.afzal@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Philipp Zabel <p.zabel@pengutronix.de>, Pavel Machek <pavel@ucw.cz>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

Enhance reset framework with "is_reset" and "clear_reset" api's.
is_reset - used by client driver to know reset status
clear_reset - used by client driver to clear reset status

These functionalities may sometimes be achieved by using existing api
like deassert. But in some scenarios, steps to achieve reset requires
clearing reset, deassert reset, enabling clock to module and then
checking reset status. Here enabling clock module is coming in between
reset procedure, hence enhance framework with additional api's.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/reset/core.c             | 32 ++++++++++++++++++++++++++++++++
 include/linux/reset-controller.h |  2 ++
 include/linux/reset.h            |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index d1b6089..ba12171 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -127,6 +127,38 @@ int reset_control_deassert(struct reset_control *rstc)
 EXPORT_SYMBOL_GPL(reset_control_deassert);
 
 /**
+ * reset_control_is_reset - check reset status
+ * @rstc: reset controller
+ *
+ * Returns a boolean or negative error code
+ *
+ */
+int reset_control_is_reset(struct reset_control *rstc)
+{
+	if (rstc->rcdev->ops->is_reset)
+		return rstc->rcdev->ops->is_reset(rstc->rcdev, rstc->id);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(reset_control_is_reset);
+
+/**
+ * reset_control_clear_reset - clear the reset
+ * @rstc: reset controller
+ *
+ * Returns zero on success or negative error code
+ *
+ */
+int reset_control_clear_reset(struct reset_control *rstc)
+{
+	if (rstc->rcdev->ops->clear_reset)
+		return rstc->rcdev->ops->clear_reset(rstc->rcdev, rstc->id);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(reset_control_clear_reset);
+
+/**
  * reset_control_get - Lookup and obtain a reference to a reset controller.
  * @dev: device to be reset by the controller
  * @id: reset line name
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 2f61311..c9bbadb 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -17,6 +17,8 @@ struct reset_control_ops {
 	int (*reset)(struct reset_controller_dev *rcdev, unsigned long id);
 	int (*assert)(struct reset_controller_dev *rcdev, unsigned long id);
 	int (*deassert)(struct reset_controller_dev *rcdev, unsigned long id);
+	int (*is_reset)(struct reset_controller_dev *rcdev, unsigned long id);
+	int (*clear_reset)(struct reset_controller_dev *rcdev, unsigned long i);
 };
 
 struct module;
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 6082247..da59f9f 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -7,6 +7,8 @@ struct reset_control;
 int reset_control_reset(struct reset_control *rstc);
 int reset_control_assert(struct reset_control *rstc);
 int reset_control_deassert(struct reset_control *rstc);
+int reset_control_is_reset(struct reset_control *rstc);
+int reset_control_clear_reset(struct reset_control *rstc);
 
 struct reset_control *reset_control_get(struct device *dev, const char *id);
 void reset_control_put(struct reset_control *rstc);
-- 
1.8.3.4
