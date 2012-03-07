From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 13/13] gpio/omap: fix incorrect update to context.irqenable1
Date: Wed, 7 Mar 2012 16:46:03 +0530
Message-ID: <1331118963-26364-14-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33554 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755499Ab2CGLQU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Mar 2012 06:16:20 -0500
In-Reply-To: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

In _enable_gpio_irqbank() when bank->regs->set_irqenable is valid,
gpio_mask can be directly set by writing to set_irqenable register
without overwriting current value. In order to ensure the same is
stored in context.irqenable1, we must read from regs->irqenable
instead of overwriting it with gpio_mask.
The overwriting makes sense only in the second case where irqenable
is explicitly read and updated with new gpio_mask before writing it
back. However, for consistency reading regs->irqenable into the
bank->context.irqenable1 takes care of both the scenarios.

        if (bank->regs->set_irqenable) {
                reg += bank->regs->set_irqenable;
                l = gpio_mask;
        } else {
                reg += bank->regs->irqenable;
                l = __raw_readl(reg);
                if (bank->regs->irqenable_inv)
                        l &= ~gpio_mask;
                else
                        l |= gpio_mask;
        }

Make the same change for _disable_gpio_irqbank().

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ccfbae0..8b0d3ab 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -453,7 +453,8 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	}
 
 	__raw_writel(l, reg);
-	bank->context.irqenable1 = l;
+	bank->context.irqenable1 =
+			__raw_readl(bank->base + bank->regs->irqenable);
 }
 
 static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
@@ -474,7 +475,8 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	}
 
 	__raw_writel(l, reg);
-	bank->context.irqenable1 = l;
+	bank->context.irqenable1 =
+			__raw_readl(bank->base + bank->regs->irqenable);
 }
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
-- 
1.7.0.4

