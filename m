From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 06/15] OMAP: GPIO: remove get_gpio_bank()
Date: Fri, 22 Apr 2011 16:01:58 -0700
Message-ID: <1303513327-14532-7-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:41272 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755150Ab1DVXAN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 19:00:13 -0400
Received: by mail-pw0-f45.google.com with SMTP id 6so638712pwj.4
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 16:00:12 -0700 (PDT)
In-Reply-To: <1303513327-14532-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: charu@ti.com

From: Charulatha V <charu@ti.com>

use chip info to get the pointer to the struct gpio_bank for a
given GPIO bank and remove get_gpio_bank().

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |   29 ++---------------------------
 1 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 98f1304..bc5f968 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -191,31 +191,6 @@ int gpio_bank_count;
 #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
 #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
 
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
 static inline int gpio_valid(int gpio)
 {
 	if (gpio < 0)
@@ -1371,7 +1346,7 @@ static struct platform_device omap_mpuio_device = {
 
 static inline void mpuio_init(void)
 {
-	struct gpio_bank *bank = get_gpio_bank(OMAP_MPUIO(0));
+	struct gpio_bank *bank = &gpio_bank[0];
 	platform_set_drvdata(&omap_mpuio_device, bank);
 
 	if (platform_driver_register(&omap_mpuio_driver) == 0)
@@ -1447,7 +1422,7 @@ static int gpio_get(struct gpio_chip *chip, unsigned offset)
 	u32 mask;
 
 	gpio = chip->base + offset;
-	bank = get_gpio_bank(gpio);
+	bank = container_of(chip, struct gpio_bank, chip);
 	reg = bank->base;
 	mask = GPIO_BIT(bank, gpio);
 
-- 
1.7.4

