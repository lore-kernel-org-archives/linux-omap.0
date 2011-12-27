From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v9 REPOST 23/25] gpio/omap: enable irq at the end of all configuration in restore
Date: Tue, 27 Dec 2011 21:39:34 +0530
Message-ID: <1325002176-25626-24-git-send-email-tarun.kanti@ti.com>
References: <1325002176-25626-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43099 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754452Ab1L0QJy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 11:09:54 -0500
In-Reply-To: <1325002176-25626-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Nishanth Menon <nm@ti.com>

Setup the interrupt enable registers only after we have configured the
required edge and required configurations, not before, to prevent
spurious events as part of restore routine.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 560567d..36aaea7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1348,10 +1348,6 @@ void omap2_gpio_resume_after_idle(void)
 
 static void omap_gpio_restore_context(struct gpio_bank *bank)
 {
-	__raw_writel(bank->context.irqenable1,
-				bank->base + bank->regs->irqenable);
-	__raw_writel(bank->context.irqenable2,
-				bank->base + bank->regs->irqenable2);
 	__raw_writel(bank->context.wake_en,
 				bank->base + bank->regs->wkup_en);
 	__raw_writel(bank->context.ctrl, bank->base + bank->regs->ctrl);
@@ -1371,6 +1367,11 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 		__raw_writel(bank->context.debounce_en,
 					bank->base + bank->regs->debounce_en);
 	}
+
+	__raw_writel(bank->context.irqenable1,
+				bank->base + bank->regs->irqenable);
+	__raw_writel(bank->context.irqenable2,
+				bank->base + bank->regs->irqenable2);
 }
 #else
 #define omap_gpio_suspend NULL
-- 
1.7.0.4

