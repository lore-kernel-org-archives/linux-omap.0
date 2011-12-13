From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v9 22/31] gpio/omap: save and restore debounce registers
Date: Wed, 14 Dec 2011 01:50:24 +0530
Message-ID: <1323807633-23713-23-git-send-email-tarun.kanti@ti.com>
References: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45714 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884Ab1LMUUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 15:20:52 -0500
In-Reply-To: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Nishanth Menon <nm@ti.com>

GPIO debounce registers need to be saved and restored for proper functioning
of driver.

Signed-off-by: Nishanth Menon <nm@ti.com>
tarun.kanti@ti.com: Debounce context save is moved to _set_gpio_debounce()
as part of dynamic context save to remove overhead.
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8fba691..6f8a7d3 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -44,6 +44,8 @@ struct gpio_regs {
 	u32 risingdetect;
 	u32 fallingdetect;
 	u32 dataout;
+	u32 debounce;
+	u32 debounce_en;
 };
 
 struct gpio_bank {
@@ -231,6 +233,10 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	 * that point. Therefore we have to enable dbck here.
 	 */
 	_gpio_dbck_enable(bank);
+	if (bank->dbck_enable_mask) {
+		bank->context.debounce = debounce;
+		bank->context.debounce_en = val;
+	}
 }
 
 static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
@@ -1372,6 +1378,12 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 	__raw_writel(bank->context.fallingdetect,
 				bank->base + bank->regs->fallingdetect);
 	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
+	if (bank->dbck_enable_mask) {
+		__raw_writel(bank->context.debounce, bank->base +
+					bank->regs->debounce);
+		__raw_writel(bank->context.debounce_en,
+					bank->base + bank->regs->debounce_en);
+	}
 }
 #else
 #define omap_gpio_suspend NULL
-- 
1.7.0.4

