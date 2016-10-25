From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Tue, 25 Oct 2016 14:02:17 -0700
Message-ID: <20161025210221.9150-2-tony@atomide.com>
References: <20161025210221.9150-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161025210221.9150-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Having the pin control framework call pin controller functions
before it's probe has finished is not nice as the pin controller
device driver does not yet have struct pinctrl_dev handle.

Let's fix this issue by adding deferred work for hogs. This is
needed to be able to add pinctrl generic helper functions.

Note that the pinctrl functions already take care of the necessary
locking.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/core.c | 53 +++++++++++++++++++++++++++++++-------------------
 drivers/pinctrl/core.h |  2 ++
 2 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1738,6 +1738,35 @@ static int pinctrl_check_ops(struct pinctrl_dev *pctldev)
 }
 
 /**
+ * pinctrl_hog_work() - delayed work to set pincontroller self-claimed pins
+ * @work: work struct
+ */
+static void pinctrl_hog_work(struct work_struct *work)
+{
+	struct pinctrl_dev *pctldev;
+
+	pctldev = container_of(work, struct pinctrl_dev, hog_work.work);
+
+	pctldev->p = pinctrl_get(pctldev->dev);
+	if (IS_ERR(pctldev->p))
+		return;
+
+	pctldev->hog_default =
+		pinctrl_lookup_state(pctldev->p, PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(pctldev->hog_default)) {
+		dev_dbg(pctldev->dev, "failed to lookup the default state\n");
+	} else {
+		if (pinctrl_select_state(pctldev->p, pctldev->hog_default))
+			dev_err(pctldev->dev, "failed to select default state\n");
+	}
+
+	pctldev->hog_sleep = pinctrl_lookup_state(pctldev->p,
+						  PINCTRL_STATE_SLEEP);
+	if (IS_ERR(pctldev->hog_sleep))
+		dev_dbg(pctldev->dev, "failed to lookup the sleep state\n");
+}
+
+/**
  * pinctrl_register() - register a pin controller device
  * @pctldesc: descriptor for this pin controller
  * @dev: parent device for this pin controller
@@ -1766,6 +1795,7 @@ struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
 	pctldev->driver_data = driver_data;
 	INIT_RADIX_TREE(&pctldev->pin_desc_tree, GFP_KERNEL);
 	INIT_LIST_HEAD(&pctldev->gpio_ranges);
+	INIT_DELAYED_WORK(&pctldev->hog_work, pinctrl_hog_work);
 	pctldev->dev = dev;
 	mutex_init(&pctldev->mutex);
 
@@ -1804,26 +1834,8 @@ struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
 	list_add_tail(&pctldev->node, &pinctrldev_list);
 	mutex_unlock(&pinctrldev_list_mutex);
 
-	pctldev->p = pinctrl_get(pctldev->dev);
-
-	if (!IS_ERR(pctldev->p)) {
-		pctldev->hog_default =
-			pinctrl_lookup_state(pctldev->p, PINCTRL_STATE_DEFAULT);
-		if (IS_ERR(pctldev->hog_default)) {
-			dev_dbg(dev, "failed to lookup the default state\n");
-		} else {
-			if (pinctrl_select_state(pctldev->p,
-						pctldev->hog_default))
-				dev_err(dev,
-					"failed to select default state\n");
-		}
-
-		pctldev->hog_sleep =
-			pinctrl_lookup_state(pctldev->p,
-						    PINCTRL_STATE_SLEEP);
-		if (IS_ERR(pctldev->hog_sleep))
-			dev_dbg(dev, "failed to lookup the sleep state\n");
-	}
+	schedule_delayed_work(&pctldev->hog_work,
+				      msecs_to_jiffies(100));
 
 	pinctrl_init_device_debugfs(pctldev);
 
@@ -1848,6 +1860,7 @@ void pinctrl_unregister(struct pinctrl_dev *pctldev)
 	if (pctldev == NULL)
 		return;
 
+	cancel_delayed_work_sync(&pctldev->hog_work);
 	mutex_lock(&pctldev->mutex);
 	pinctrl_remove_device_debugfs(pctldev);
 	mutex_unlock(&pctldev->mutex);
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -33,6 +33,7 @@ struct pinctrl_gpio_range;
  * @p: result of pinctrl_get() for this device
  * @hog_default: default state for pins hogged by this device
  * @hog_sleep: sleep state for pins hogged by this device
+ * @hog_work: delayed work for pin controller device claimed hog pins
  * @mutex: mutex taken on each pin controller specific action
  * @device_root: debugfs root for this device
  */
@@ -47,6 +48,7 @@ struct pinctrl_dev {
 	struct pinctrl *p;
 	struct pinctrl_state *hog_default;
 	struct pinctrl_state *hog_sleep;
+	struct delayed_work hog_work;
 	struct mutex mutex;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *device_root;
-- 
2.9.3
