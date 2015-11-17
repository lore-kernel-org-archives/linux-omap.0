From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] clk: gpio: Get parent clk names already in of_gpio_clk_setup()
Date: Tue, 17 Nov 2015 11:10:22 +0200
Message-ID: <1447751422-23711-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>
Cc: tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>, Sergej Sawazki <ce3a@gmx.de>
List-Id: linux-omap@vger.kernel.org

Get parent clk names already in of_gpio_clk_setup() and store the
names in struct clk_gpio_delayed_register_data. of_clk_get_parent_name()
can not be called in struct of_clk_provider's get() callback since it
may make a recursive call to of_clk_get_from_provider() and this in turn
tries to recursively lock of_clk_mutex.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Cc: Sergej Sawazki <ce3a@gmx.de>
---
Something has changed in Linux mainline so that getting the clk
parent names in struct of_clk_provider's get() callback does not work
anymore. This patch should fix the problem.

 drivers/clk/clk-gpio.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 10819e2..335322d 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -209,6 +209,8 @@ EXPORT_SYMBOL_GPL(clk_register_gpio_mux);
 
 struct clk_gpio_delayed_register_data {
 	const char *gpio_name;
+	int num_parents;
+	const char **parent_names;
 	struct device_node *node;
 	struct mutex lock;
 	struct clk *clk;
@@ -222,8 +224,6 @@ static struct clk *of_clk_gpio_delayed_register_get(
 {
 	struct clk_gpio_delayed_register_data *data = _data;
 	struct clk *clk;
-	const char **parent_names;
-	int i, num_parents;
 	int gpio;
 	enum of_gpio_flags of_flags;
 
@@ -248,26 +248,14 @@ static struct clk *of_clk_gpio_delayed_register_get(
 		return ERR_PTR(gpio);
 	}
 
-	num_parents = of_clk_get_parent_count(data->node);
-
-	parent_names = kcalloc(num_parents, sizeof(char *), GFP_KERNEL);
-	if (!parent_names) {
-		clk = ERR_PTR(-ENOMEM);
-		goto out;
-	}
-
-	for (i = 0; i < num_parents; i++)
-		parent_names[i] = of_clk_get_parent_name(data->node, i);
-
-	clk = data->clk_register_get(data->node->name, parent_names,
-			num_parents, gpio, of_flags & OF_GPIO_ACTIVE_LOW);
+	clk = data->clk_register_get(data->node->name, data->parent_names,
+			data->num_parents, gpio, of_flags & OF_GPIO_ACTIVE_LOW);
 	if (IS_ERR(clk))
 		goto out;
 
 	data->clk = clk;
 out:
 	mutex_unlock(&data->lock);
-	kfree(parent_names);
 
 	return clk;
 }
@@ -296,11 +284,24 @@ static void __init of_gpio_clk_setup(struct device_node *node,
 				unsigned gpio, bool active_low))
 {
 	struct clk_gpio_delayed_register_data *data;
+	const char **parent_names;
+	int i, num_parents;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return;
 
+	num_parents = of_clk_get_parent_count(node);
+
+	parent_names = kcalloc(num_parents, sizeof(char *), GFP_KERNEL);
+	if (!parent_names)
+		return;
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	data->num_parents = num_parents;
+	data->parent_names = parent_names;
 	data->node = node;
 	data->gpio_name = gpio_name;
 	data->clk_register_get = clk_register_get;
-- 
1.9.1
