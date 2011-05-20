From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 06/14] GPIO: OMAP: remove get_gpio_bank()
Date: Fri, 20 May 2011 17:14:49 +0200
Message-ID: <1305904497-26013-7-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:55557 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933413Ab1ETPPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:21 -0400
Received: by mail-ww0-f51.google.com with SMTP id 26so3226600wwf.20
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:20 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

use chip info to get the pointer to the struct gpio_bank for a
given GPIO bank and remove get_gpio_bank().

Signed-off-by: Charulatha V <charu@ti.com>
---
 drivers/gpio/gpio_omap.c |   29 ++---------------------------
 1 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index a7767a4..0fdfb84 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -86,31 +86,6 @@ int gpio_bank_count;
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
@@ -1266,7 +1241,7 @@ static struct platform_device omap_mpuio_device = {
 
 static inline void mpuio_init(void)
 {
-	struct gpio_bank *bank = get_gpio_bank(OMAP_MPUIO(0));
+	struct gpio_bank *bank = &gpio_bank[0];
 	platform_set_drvdata(&omap_mpuio_device, bank);
 
 	if (platform_driver_register(&omap_mpuio_driver) == 0)
@@ -1342,7 +1317,7 @@ static int gpio_get(struct gpio_chip *chip, unsigned offset)
 	u32 mask;
 
 	gpio = chip->base + offset;
-	bank = get_gpio_bank(gpio);
+	bank = container_of(chip, struct gpio_bank, chip);
 	reg = bank->base;
 	mask = GPIO_BIT(bank, gpio);
 
-- 
1.7.3.4

