From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v9 19/31] gpio/omap: fix debounce clock handling
Date: Wed, 14 Dec 2011 01:50:21 +0530
Message-ID: <1323807633-23713-20-git-send-email-tarun.kanti@ti.com>
References: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46920 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755720Ab1LMUVI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 15:21:08 -0500
In-Reply-To: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

The dbck_enable_mask indicates which all GPIOs within a bank have debounce
enabled and dbck is enabled/disabled based upon this. But there is no
mechanism to track the dbck state. In order to manage the dbck state we need
additional flag and logic so that turning off/on dbck is synchronized with
pm_runtime_put/get_sync calls.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 175a364..3a3e09a 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -67,6 +67,7 @@ struct gpio_bank {
 	struct clk *dbck;
 	u32 mod_usage;
 	u32 dbck_enable_mask;
+	bool dbck_enabled;
 	struct device *dev;
 	bool is_mpuio;
 	bool dbck_flag;
@@ -160,6 +161,22 @@ static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
 	__raw_writel(l, base + reg);
 }
 
+static inline void _gpio_dbck_enable(struct gpio_bank *bank)
+{
+	if (bank->dbck_enable_mask && !bank->dbck_enabled) {
+		clk_enable(bank->dbck);
+		bank->dbck_enabled = true;
+	}
+}
+
+static inline void _gpio_dbck_disable(struct gpio_bank *bank)
+{
+	if (bank->dbck_enable_mask && bank->dbck_enabled) {
+		clk_disable(bank->dbck);
+		bank->dbck_enabled = false;
+	}
+}
+
 /**
  * _set_gpio_debounce - low level gpio debounce time
  * @bank: the gpio bank we're acting upon
@@ -1188,6 +1205,7 @@ save_gpio_context:
 				bank->get_context_loss_count(bank->dev);
 
 	omap_gpio_save_context(bank);
+	_gpio_dbck_disable(bank);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1205,6 +1223,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 		return 0;
 
 	spin_lock_irqsave(&bank->lock, flags);
+	_gpio_dbck_enable(bank);
 	if (!bank->enabled_non_wakeup_gpios || !bank->need_context_restore) {
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
@@ -1284,15 +1303,12 @@ void omap2_gpio_prepare_for_idle(int power_mode)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		int j;
-
 		if (!bank->mod_usage)
 			continue;
 
 		bank->power_mode = power_mode;
 
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_disable(bank->dbck);
+		pm_runtime_put_sync_suspend(bank->dev);
 	}
 }
 
@@ -1301,13 +1317,10 @@ void omap2_gpio_resume_after_idle(void)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		int j;
-
 		if (!bank->mod_usage)
 			continue;
 
-		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
-			clk_enable(bank->dbck);
+		pm_runtime_get_sync(bank->dev);
 	}
 }
 
-- 
1.7.0.4

