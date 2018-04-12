From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 10/14] gpio: omap: Drop the concept of gpio banks not being able to lose context.
Date: Thu, 12 Apr 2018 09:23:55 +0530
Message-ID: <1523505239-16229-11-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: j-keerthy@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

From: Russ Dill <Russ.Dill@ti.com>

It isn't much of a win, and with hibernation, everything loses context.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/gpio/gpio-omap.c                | 38 ++++++++++++---------------------
 include/linux/platform_data/gpio-omap.h |  1 -
 2 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 35971a3..34fde30 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -68,7 +68,7 @@ struct gpio_bank {
 	bool dbck_enabled;
 	bool is_mpuio;
 	bool dbck_flag;
-	bool loses_context;
+
 	bool context_valid;
 	int stride;
 	u32 width;
@@ -1198,15 +1198,9 @@ static int omap_gpio_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF_GPIO
 	bank->chip.of_node = of_node_get(node);
 #endif
-	if (node) {
-		if (!of_property_read_bool(node, "ti,gpio-always-on"))
-			bank->loses_context = true;
-	} else {
-		bank->loses_context = pdata->loses_context;
-
-		if (bank->loses_context)
-			bank->get_context_loss_count =
-				pdata->get_context_loss_count;
+	if (!node) {
+		bank->get_context_loss_count =
+			pdata->get_context_loss_count;
 	}
 
 	if (bank->regs->set_dataout && bank->regs->clr_dataout)
@@ -1365,7 +1359,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	 * been initialised and so initialise it now. Also initialise
 	 * the context loss count.
 	 */
-	if (bank->loses_context && !bank->context_valid) {
+	if (!bank->context_valid) {
 		omap_gpio_init_context(bank);
 
 		if (bank->get_context_loss_count)
@@ -1386,17 +1380,13 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	writel_relaxed(bank->context.risingdetect,
 		     bank->base + bank->regs->risingdetect);
 
-	if (bank->loses_context) {
-		if (!bank->get_context_loss_count) {
-			omap_gpio_restore_context(bank);
-		} else {
-			c = bank->get_context_loss_count(dev);
-			if (c != bank->context_loss_count) {
-				omap_gpio_restore_context(bank);
-			} else {
-				raw_spin_unlock_irqrestore(&bank->lock, flags);
-				return 0;
-			}
+	if (!bank->get_context_loss_count) {
+		omap_gpio_restore_context(bank);
+	} else {
+		c = bank->get_context_loss_count(bank->chip.parent);
+		if (c != bank->context_loss_count) {
+			raw_spin_unlock_irqrestore(&bank->lock, flags);
+			return 0;
 		}
 	}
 
@@ -1468,7 +1458,7 @@ void omap2_gpio_prepare_for_idle(int pwr_mode)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		if (!BANK_USED(bank) || !bank->loses_context)
+		if (!BANK_USED(bank))
 			continue;
 
 		bank->power_mode = pwr_mode;
@@ -1482,7 +1472,7 @@ void omap2_gpio_resume_after_idle(void)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		if (!BANK_USED(bank) || !bank->loses_context)
+		if (!BANK_USED(bank))
 			continue;
 
 		pm_runtime_get_sync(bank->chip.parent);
diff --git a/include/linux/platform_data/gpio-omap.h b/include/linux/platform_data/gpio-omap.h
index 8612855..77eb187 100644
--- a/include/linux/platform_data/gpio-omap.h
+++ b/include/linux/platform_data/gpio-omap.h
@@ -193,7 +193,6 @@ struct omap_gpio_platform_data {
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
-	bool loses_context;	/* whether the bank would ever lose context */
 	bool is_mpuio;		/* whether the bank is of type MPUIO */
 	u32 non_wakeup_gpios;
 
-- 
1.9.1
