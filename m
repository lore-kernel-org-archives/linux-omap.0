From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 17/18] OMAP: GPIO: use dev_err* instead of printk
Date: Fri, 22 Apr 2011 16:38:31 +0530
Message-ID: <1303470512-19671-18-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60453 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755086Ab1DVLEy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 07:04:54 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Use dev_info()/dev_err() instead of printk in OMAP GPIO driver

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 9c3e865..7ae9f6f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -66,7 +66,7 @@ static int omap_gpio_sysinit(void);
 static int check_gpio(int gpio)
 {
 	if (unlikely(gpio_fn.gpio_valid(gpio) < 0)) {
-		printk(KERN_ERR "omap-gpio: invalid GPIO %d\n", gpio);
+		pr_err("omap-gpio: invalid GPIO %d\n", gpio);
 		dump_stack();
 		return -1;
 	}
@@ -470,7 +470,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	case METHOD_GPIO_24XX:
 	case METHOD_GPIO_44XX:
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
-			printk(KERN_ERR "Unable to modify wakeup on "
+			dev_err(bank->dev, "Unable to modify wakeup on "
 					"non-wakeup GPIO%d\n",
 					bank->id * 32 + gpio);
 			return -EINVAL;
@@ -485,7 +485,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 	default:
-		printk(KERN_ERR "Can't enable GPIO wakeup for method %i\n",
+		dev_err(bank->dev, "Can't enable GPIO wakeup for method %i\n",
 		       bank->method);
 		return -EINVAL;
 	}
-- 
1.7.1

