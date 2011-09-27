From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v7 REPOST 21/24] gpio/omap: save and restore debounce registers
Date: Tue, 27 Sep 2011 05:44:17 +0530
Message-ID: <1317082460-31706-22-git-send-email-tarun.kanti@ti.com>
References: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36872 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174Ab1I0AOm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 20:14:42 -0400
In-Reply-To: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
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
 drivers/gpio/gpio-omap.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ad37379..981a1c1 100644
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
@@ -202,6 +204,8 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	bank->dbck_enable_mask = val;
 
 	__raw_writel(val, reg);
+	bank->context.debounce = debounce;
+	bank->context.debounce_en = val;
 }
 
 static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
@@ -1323,6 +1327,12 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
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

