From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v8 21/24] gpio/omap: save and restore debounce registers
Date: Wed, 5 Oct 2011 14:03:10 +0530
Message-ID: <1317803593-12259-22-git-send-email-tarun.kanti@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33677 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933685Ab1JEIdu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Oct 2011 04:33:50 -0400
In-Reply-To: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Nishanth Menon <nm@ti.com>

GPIO debounce registers need to be saved and restored for proper functioning
of driver. To save the registers, we cannot cut the clock before the save,
hence move the clk disable after the save.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 7fc57a4..1cf7f38 100644
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
@@ -223,6 +225,9 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 		clk_disable(bank->dbck);
 		bank->dbck_enabled = false;
 	}
+
+	bank->context.debounce = debounce;
+	bank->context.debounce_en = val;
 }
 
 static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
@@ -1352,6 +1357,12 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
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

