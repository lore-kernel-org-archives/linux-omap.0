From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH omap-fixes v2] OMAP2/3: GPIO: do not attempt to wake-enable GPIO bank IRQ
Date: Mon,  9 Mar 2009 15:14:20 -0700
Message-ID: <1236636860-2804-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:38607 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZCIWO2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 18:14:28 -0400
Received: by ewy25 with SMTP id 25so1037422ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2009 15:14:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The GPIO IRQ enable/disable path attempts to also enable IRQ wake
support for the parent GPIO bank IRQ as well.  However, since there is
no 'set_wake' hook for the bank IRQs, these calls will always fail.
Also, since the enable will fail on the suspend path, the disable on
the resume path will trigger unbalanced enable/disable warnings.

This was discovered in the suspend/resume path on OMAP3/Beagle using
the gpio-keys driver which disables/re-enables GPIO IRQ wakeups in the
suspend/resume path.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
This patch was sent on 28 jan 2009 as:
[PATCH omap-fixes] OMAP2/3: GPIO: remove recursion in IRQ wakeup path

This version simply updates the description to better describe the problem
and solution.

 arch/arm/plat-omap/gpio.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index f856a90..798a8cd 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -837,13 +837,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
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
@@ -856,13 +853,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
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
1.6.1.2

