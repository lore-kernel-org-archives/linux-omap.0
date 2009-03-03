From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH 1/1] OMAP: GPIO: Remove enable_irq_wake() and
	disable_irq_wake() in _set_gpio_wakeup() function
Date: Tue, 3 Mar 2009 11:05:47 +0900
Message-ID: <4d34a0a70903021805l56ebe7e2u277fcdebe01f5693@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:45818 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZCCCFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 21:05:49 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3029809wfa.4
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 18:05:47 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, David Brownell <david-b@pacbell.net>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>

Current omap_irq_chip variable (in arch/arm/mach-omap2/irq.c) doesn't
have set_wake function. So invoking enable_irq_wake() and
disable_irq_wake() for the MPU IRQs always returns -ENXIO and sometime
it generates warning message(Unbalanced IRQ %d wake disable). Actual
enabling and disable IRQ wakeup can be done by enable_irq() and
disable_irq().

Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
---
 arch/arm/plat-omap/gpio.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index f856a90..798a8cd 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -837,13 +837,10 @@ static int _set_gpio_wakeup(struct gpio_bank
*bank, int gpio, int enable)
 	case METHOD_MPUIO:
 	case METHOD_GPIO_1610:
 		spin_lock_irqsave(&bank->lock, flags);
-		if (enable) {
+		if (enable)
 			bank->suspend_wakeup |= (1 << gpio);
-			enable_irq_wake(bank->irq);
-		} else {
-			disable_irq_wake(bank->irq);
+		else
 			bank->suspend_wakeup &= ~(1 << gpio);
-		}
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 #endif
@@ -856,13 +853,10 @@ static int _set_gpio_wakeup(struct gpio_bank
*bank, int gpio, int enable)
 			return -EINVAL;
 		}
 		spin_lock_irqsave(&bank->lock, flags);
-		if (enable) {
+		if (enable)
 			bank->suspend_wakeup |= (1 << gpio);
-			enable_irq_wake(bank->irq);
-		} else {
-			disable_irq_wake(bank->irq);
+		else
 			bank->suspend_wakeup &= ~(1 << gpio);
-		}
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 #endif
-- 
1.5.2.5


-- 
Q1
