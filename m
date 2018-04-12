From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 08/14] ARM: OMAP2: Add functions to save and restore pinctrl context.
Date: Thu, 12 Apr 2018 09:23:53 +0530
Message-ID: <1523505239-16229-9-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: j-keerthy@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com, Russ Dill <Russ.Dill@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: Russ Dill <Russ.Dill@gmail.com>

This adds a pair of context save/restore functions to save/restore the
state of a set of pinctrl registers. This simplifies some of the AM33XX
PM code as some of the pinctrl registers are lost when the per power
domain loses power. The pincrtl code can perform the necessary
save/restore.

This will also be necessary for hibernation and RTC only sleep, as all
pinctrl registers all lost.

Signed-off-by: Russ Dill <Russ.Dill@gmail.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/pinctrl/core.c           |  1 +
 drivers/pinctrl/core.h           |  1 -
 drivers/pinctrl/pinctrl-single.c | 50 ++++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinmux.c         | 22 ++++++++++++++++++
 include/linux/pinctrl/pinctrl.h  |  7 ++++++
 include/linux/pinctrl/pinmux.h   | 16 +++++++++++++
 6 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index e5a3030..1a9ae64 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -119,6 +119,7 @@ struct pinctrl_dev *get_pinctrl_dev_from_devname(const char *devname)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(get_pinctrl_dev_from_devname);
 
 struct pinctrl_dev *get_pinctrl_dev_from_of_node(struct device_node *np)
 {
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 8cf2eba..e587c29 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -226,7 +226,6 @@ int pinctrl_generic_remove_group(struct pinctrl_dev *pctldev,
 
 #endif	/* CONFIG_GENERIC_PINCTRL_GROUPS */
 
-struct pinctrl_dev *get_pinctrl_dev_from_devname(const char *dev_name);
 struct pinctrl_dev *get_pinctrl_dev_from_of_node(struct device_node *np);
 int pin_get_from_name(struct pinctrl_dev *pctldev, const char *name);
 const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned pin);
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index a7c5eb3..2fc3317 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -144,6 +144,7 @@ struct pcs_soc_data {
  * struct pcs_device - pinctrl device instance
  * @res:	resources
  * @base:	virtual address of the controller
+ * @saved_vals: saved values for the controller
  * @size:	size of the ioremapped area
  * @dev:	device entry
  * @np:		device tree node
@@ -172,6 +173,7 @@ struct pcs_soc_data {
 struct pcs_device {
 	struct resource *res;
 	void __iomem *base;
+	void *saved_vals;
 	unsigned size;
 	struct device *dev;
 	struct device_node *np;
@@ -372,6 +374,52 @@ static int pcs_set_mux(struct pinctrl_dev *pctldev, unsigned fselector,
 	return 0;
 }
 
+static int pcs_save_context(struct pinctrl_dev *pctldev)
+{
+	struct pcs_device *pcs;
+	int i;
+
+	pcs = pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pcs->saved_vals)
+		pcs->saved_vals = devm_kzalloc(pcs->dev, pcs->size, GFP_ATOMIC);
+
+	switch (pcs->width) {
+	case 32:
+		for (i = 0; i < pcs->size; i += 4)
+			*(u32 *)(pcs->saved_vals + i) =
+				pcs->read(pcs->base + i);
+		break;
+	case 16:
+		for (i = 0; i < pcs->size; i += 2)
+			*(u16 *)(pcs->saved_vals + i) =
+				pcs->read(pcs->base + i);
+		break;
+	}
+	return 0;
+}
+
+static void pcs_restore_context(struct pinctrl_dev *pctldev)
+{
+	struct pcs_device *pcs;
+	int i;
+
+	pcs = pinctrl_dev_get_drvdata(pctldev);
+
+	switch (pcs->width) {
+	case 32:
+		for (i = 0; i < pcs->size; i += 4)
+			pcs->write(*(u32 *)(pcs->saved_vals + i),
+				pcs->base + i);
+		break;
+	case 16:
+		for (i = 0; i < pcs->size; i += 2)
+			pcs->write(*(u16 *)(pcs->saved_vals + i),
+				pcs->base + i);
+		break;
+	}
+}
+
 static int pcs_request_gpio(struct pinctrl_dev *pctldev,
 			    struct pinctrl_gpio_range *range, unsigned pin)
 {
@@ -420,6 +468,8 @@ static int pcs_request_gpio(struct pinctrl_dev *pctldev,
 	.get_function_name = pinmux_generic_get_function_name,
 	.get_function_groups = pinmux_generic_get_function_groups,
 	.set_mux = pcs_set_mux,
+	.save_context = pcs_save_context,
+	.restore_context = pcs_restore_context,
 	.gpio_request_enable = pcs_request_gpio,
 };
 
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index b8e9bda..b144e0d 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -312,6 +312,28 @@ static int pinmux_func_name_to_selector(struct pinctrl_dev *pctldev,
 	return -EINVAL;
 }
 
+int pinmux_save_context(struct pinctrl_dev *pctldev, const char *function)
+{
+	const struct pinmux_ops *pmxops = pctldev->desc->pmxops;
+
+	if (!pmxops || !pmxops->save_context)
+		return -EINVAL;
+
+	return pmxops->save_context(pctldev);
+}
+EXPORT_SYMBOL(pinmux_save_context);
+
+void pinmux_restore_context(struct pinctrl_dev *pctldev, const char *function)
+{
+	const struct pinmux_ops *pmxops = pctldev->desc->pmxops;
+
+	if (!pmxops || !pmxops->restore_context)
+		return;
+
+	pmxops->restore_context(pctldev);
+}
+EXPORT_SYMBOL(pinmux_restore_context);
+
 int pinmux_map_to_setting(const struct pinctrl_map *map,
 			  struct pinctrl_setting *setting)
 {
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 8f5dbb8..c523593 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -198,6 +198,7 @@ struct pinctrl_dev *of_pinctrl_get(struct device_node *np)
 extern const char *pinctrl_dev_get_name(struct pinctrl_dev *pctldev);
 extern const char *pinctrl_dev_get_devname(struct pinctrl_dev *pctldev);
 extern void *pinctrl_dev_get_drvdata(struct pinctrl_dev *pctldev);
+extern struct pinctrl_dev *get_pinctrl_dev_from_devname(const char *dev_name);
 #else
 
 struct pinctrl_dev;
@@ -208,6 +209,12 @@ static inline bool pin_is_valid(struct pinctrl_dev *pctldev, int pin)
 	return pin >= 0;
 }
 
+static inline struct pinctrl_dev *get_pinctrl_dev_from_devname(
+							const char *dev_name)
+{
+	return NULL;
+}
+
 #endif /* !CONFIG_PINCTRL */
 
 #endif /* __LINUX_PINCTRL_PINCTRL_H */
diff --git a/include/linux/pinctrl/pinmux.h b/include/linux/pinctrl/pinmux.h
index ace60d7..f837b8f 100644
--- a/include/linux/pinctrl/pinmux.h
+++ b/include/linux/pinctrl/pinmux.h
@@ -75,6 +75,8 @@ struct pinmux_ops {
 	int (*gpio_request_enable) (struct pinctrl_dev *pctldev,
 				    struct pinctrl_gpio_range *range,
 				    unsigned offset);
+	int (*save_context)(struct pinctrl_dev *pctldev);
+	void (*restore_context)(struct pinctrl_dev *pctldev);
 	void (*gpio_disable_free) (struct pinctrl_dev *pctldev,
 				   struct pinctrl_gpio_range *range,
 				   unsigned offset);
@@ -85,6 +87,20 @@ struct pinmux_ops {
 	bool strict;
 };
 
+int pinmux_save_context(struct pinctrl_dev *pctldev, const char *function);
+void pinmux_restore_context(struct pinctrl_dev *pctldev, const char *function);
+
+#else /* !CONFIG_PINMUX */
+
+static inline int pinmux_save_context(struct pinctrl_dev *pctldev,
+				      const char *function)
+{
+	return 0;
+}
+
+static inline void pinmux_restore_context(struct pinctrl_dev *pctldev,
+					  const char *function) {}
+
 #endif /* CONFIG_PINMUX */
 
 #endif /* __LINUX_PINCTRL_PINMUX_H */
-- 
1.9.1
