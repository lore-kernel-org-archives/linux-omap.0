From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v8 REPOST 21/24] gpio/omap: save and restore debounce registers
Date: Wed, 12 Oct 2011 18:02:10 +0530
Message-ID: <1318422730-22282-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53175 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab1JLMcT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Oct 2011 08:32:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Nishanth Menon <nm@ti.com>

GPIO debounce registers need to be saved and restored for proper functioning
of driver. To save the registers, we cannot cut the clock before the save,
hence move the clk disable after the save.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Rebased on top of:
[PATCH v8 REPOST 17/24] gpio/omap: fix debounce clock handling

 drivers/gpio/gpio-omap.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d074408..6a89560 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -42,6 +42,8 @@ struct gpio_regs {
 	u32 risingdetect;
 	u32 fallingdetect;
 	u32 dataout;
+	u32 debounce;
+	u32 debounce_en;
 };
 
 struct gpio_bank {
@@ -219,6 +221,9 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 
 	__raw_writel(val, reg);
 	clk_disable(bank->dbck);
+
+	bank->context.debounce = debounce;
+	bank->context.debounce_en = val;
 }
 
 static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
@@ -1350,6 +1355,12 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
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

