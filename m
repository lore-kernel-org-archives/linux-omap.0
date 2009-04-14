From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/11] ARM: OMAP2/3: GPIO: do not attempt to wake-enable
Date: Tue, 14 Apr 2009 14:58:26 -0700
Message-ID: <20090414215826.9878.86819.stgit@localhost>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63870 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbZDNV6c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 17:58:32 -0400
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

The GPIO IRQ enable/disable path attempts to also enable IRQ wake
support for the parent GPIO bank IRQ as well.  However, since there is
no 'set_wake' hook for the bank IRQs, these calls will always fail.
Also, since the enable will fail on the suspend path, the disable on
the resume path will trigger unbalanced enable/disable warnings.

This was discovered in the suspend/resume path on OMAP3/Beagle using
the gpio-keys driver which disables/re-enables GPIO IRQ wakeups in the
suspend/resume path.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d3fa41e..210a1c0 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -921,13 +921,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
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
@@ -940,13 +937,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
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

