From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 01/49] clk: add support for registering clocks from description
Date: Thu, 19 Dec 2013 13:23:32 +0200
Message-ID: <1387452260-23276-2-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38882 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab3LSLZF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 06:25:05 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Mike Turquette <mturquetter@linaro.org>

From: Mike Turquette <mturquetter@linaro.org>

clk_register_desc is the primary interface for populating the clock tree
with new clock nodes. In time, this will replace the various hardware-specific
registration functions (e.g. clk_register_gate).

Signed-off-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk.c            |   71 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |   23 ++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2cf2ea6..29281f6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1905,6 +1905,77 @@ fail_out:
 EXPORT_SYMBOL_GPL(clk_register);
 
 /**
+ * clk_register_desc - register a new clock from its description
+ * @dev: device that is registering this clock
+ * @desc: description of the clock, may be __initdata or otherwise discarded
+ *
+ * clk_register_desc is the primary interface for populating the clock tree
+ * with new clock nodes. In time it will replace the various hardware-specific
+ * registration functions (e.g. clk_register_gate). clk_register_desc returns a
+ * pointer to the newly allocated struct clk which is an opaque cookie. Drivers
+ * must not dereference it except to check with IS_ERR.
+ */
+struct clk *clk_register_desc(struct device *dev, struct clk_desc *desc)
+{
+	int ret, i;
+	struct clk *clk;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+
+	if (!clk)
+		return ERR_PTR(-ENOMEM);
+
+	clk->hw = desc->register_func(dev, desc);
+	clk->hw->clk = clk;
+
+	/* _clk_register */
+	clk->name = kstrdup(desc->name, GFP_KERNEL);
+	if (!clk->name) {
+		ret = -ENOMEM;
+		goto fail_name;
+	}
+
+	clk->ops = desc->ops;
+	clk->flags = desc->flags;
+	clk->num_parents = desc->num_parents;
+
+	/* allocate local copy in case parent_names is __initdata */
+	clk->parent_names = kcalloc(clk->num_parents, sizeof(char *),
+				    GFP_KERNEL);
+
+	if (!clk->parent_names) {
+		ret = -ENOMEM;
+		goto fail_parent_names;
+	}
+
+	/* copy each string name in case parent_names is __initdata */
+	for (i = 0; i < clk->num_parents; i++) {
+		clk->parent_names[i] = kstrdup(desc->parent_names[i],
+					       GFP_KERNEL);
+
+		if (!clk->parent_names[i]) {
+			ret = -ENOMEM;
+			goto fail_parent_names_copy;
+		}
+	}
+
+	ret = __clk_init(dev, clk);
+
+	if (!ret)
+		return clk;
+
+fail_parent_names_copy:
+	while (--i >= 0)
+		kfree(clk->parent_names[i]);
+	kfree(clk->parent_names);
+fail_parent_names:
+	kfree(clk->name);
+fail_name:
+	kfree(clk);
+	return ERR_PTR(ret);
+}
+
+/**
  * clk_unregister - unregister a currently registered clock
  * @clk: clock to unregister
  *
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7e59253..7fddcb3 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -161,6 +161,28 @@ struct clk_init_data {
 };
 
 /**
+ * struct clk_desc - clock init descriptor for providing init time parameters
+ * for a clock.
+ *
+ * @name: clock name
+ * @ops: clock ops
+ * @parent_names: array of string names for all possible parents
+ * @num_parents: number of possible parents
+ * @flags: framework-level hints and quirks
+ * @register_func: function for parsing the clock descriptor and providing
+ *		   ready-to-register clk_hw
+ */
+struct clk_desc {
+	const char		*name;
+	const struct clk_ops	*ops;
+	const char		**parent_names;
+	u8			num_parents;
+	unsigned long		flags;
+	struct clk_hw *(*register_func)(struct device *dev,
+					struct clk_desc *desc);
+};
+
+/**
  * struct clk_hw - handle for traversing from a struct clk to its corresponding
  * hardware-specific structure.  struct clk_hw should be declared within struct
  * clk_foo and then referenced by the struct clk instance that uses struct
@@ -419,6 +441,7 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
  * error code; drivers must test for an error code after calling clk_register.
  */
 struct clk *clk_register(struct device *dev, struct clk_hw *hw);
+struct clk *clk_register_desc(struct device *dev, struct clk_desc *desc);
 struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
 
 void clk_unregister(struct clk *clk);
-- 
1.7.9.5

