From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v9 20/31] gpio/omap: fix incorrect access of debounce module
Date: Wed, 14 Dec 2011 01:50:22 +0530
Message-ID: <1323807633-23713-21-git-send-email-tarun.kanti@ti.com>
References: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46909 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755915Ab1LMUVG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 15:21:06 -0500
In-Reply-To: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Enable debounce clock before writing/reading debounce registers.
Disable the clock at the end so that it is synchronized with the
pm_runtime_get/put_sync calls.

Enable debounce clock per module. This call is mandatory because
in omap_gpio_request() when *_runtime_get_sync() is called,
_gpio_dbck_enable() within runtime callbck fails to turn on dbck
 because dbck_enable_mask used within _gpio_dbck_enable() is still
not initialized at that point. Therefore we have to enable dbck here.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 3a3e09a..7f32391 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -205,22 +205,30 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 
 	l = GPIO_BIT(bank, gpio);
 
+	clk_enable(bank->dbck);
 	reg = bank->base + bank->regs->debounce;
 	__raw_writel(debounce, reg);
 
 	reg = bank->base + bank->regs->debounce_en;
 	val = __raw_readl(reg);
 
-	if (debounce) {
+	if (debounce)
 		val |= l;
-		clk_enable(bank->dbck);
-	} else {
+	else
 		val &= ~l;
-		clk_disable(bank->dbck);
-	}
 	bank->dbck_enable_mask = val;
 
 	__raw_writel(val, reg);
+	clk_disable(bank->dbck);
+	/*
+	 * Enable debounce clock per module.
+	 * This call is mandatory because in omap_gpio_request() when
+	 * *_runtime_get_sync() is called,  _gpio_dbck_enable() within
+	 * runtime callbck fails to turn on dbck because dbck_enable_mask
+	 * used within _gpio_dbck_enable() is still not initialized at
+	 * that point. Therefore we have to enable dbck here.
+	 */
+	_gpio_dbck_enable(bank);
 }
 
 static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
-- 
1.7.0.4

