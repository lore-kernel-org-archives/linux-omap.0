From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 02/18] OMAP: GPIO: remove get_gpio_bank()
Date: Fri, 22 Apr 2011 16:38:16 +0530
Message-ID: <1303470512-19671-3-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60461 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755012Ab1DVLE5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 07:04:57 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

use chip info to get the pointer to the struct gpio_bank for a
given GPIO bank and remove get_gpio_bank().

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |   29 ++---------------------------
 1 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 9164bd4..498e1df 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -189,31 +189,6 @@ static int bank_width;
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
 int gpio_bank_count;
 
-static inline struct gpio_bank *get_gpio_bank(int gpio)
-{
-	if (cpu_is_omap15xx()) {
-		if (OMAP_GPIO_IS_MPUIO(gpio))
-			return &gpio_bank[0];
-		return &gpio_bank[1];
-	}
-	if (cpu_is_omap16xx()) {
-		if (OMAP_GPIO_IS_MPUIO(gpio))
-			return &gpio_bank[0];
-		return &gpio_bank[1 + (gpio >> 4)];
-	}
-	if (cpu_is_omap7xx()) {
-		if (OMAP_GPIO_IS_MPUIO(gpio))
-			return &gpio_bank[0];
-		return &gpio_bank[1 + (gpio >> 5)];
-	}
-	if (cpu_is_omap24xx())
-		return &gpio_bank[gpio >> 5];
-	if (cpu_is_omap34xx() || cpu_is_omap44xx())
-		return &gpio_bank[gpio >> 5];
-	BUG();
-	return NULL;
-}
-
 static inline int get_gpio_index(int gpio)
 {
 	if (cpu_is_omap7xx())
@@ -1393,7 +1368,7 @@ static struct platform_device omap_mpuio_device = {
 
 static inline void mpuio_init(void)
 {
-	struct gpio_bank *bank = get_gpio_bank(OMAP_MPUIO(0));
+	struct gpio_bank *bank = &gpio_bank[0];
 	platform_set_drvdata(&omap_mpuio_device, bank);
 
 	if (platform_driver_register(&omap_mpuio_driver) == 0)
@@ -1469,7 +1444,7 @@ static int gpio_get(struct gpio_chip *chip, unsigned offset)
 	u32 mask;
 
 	gpio = chip->base + offset;
-	bank = get_gpio_bank(gpio);
+	bank = container_of(chip, struct gpio_bank, chip);
 	reg = bank->base;
 	mask = 1 << get_gpio_index(gpio);
 
-- 
1.7.1

