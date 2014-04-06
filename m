From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 2/5] gpio: omap: check gpiochip_add() return value
Date: Sun,  6 Apr 2014 16:58:14 +0200
Message-ID: <1396796297-13002-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

The gpiochip_add() function can fail if the chip cannot
be registered so the return value has to be checked and
the error propagated in case it happens.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/gpio/gpio-omap.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 3ee9b8d..e717888 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1081,10 +1081,11 @@ omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
-static void omap_gpio_chip_init(struct gpio_bank *bank)
+static int omap_gpio_chip_init(struct gpio_bank *bank)
 {
 	int j;
 	static int gpio;
+	int ret;
 
 	/*
 	 * REVISIT eventually switch from OMAP-specific gpio structs
@@ -1110,7 +1111,11 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 	}
 	bank->chip.ngpio = bank->width;
 
-	gpiochip_add(&bank->chip);
+	ret = gpiochip_add(&bank->chip);
+	if (ret) {
+		dev_err(bank->dev, "Could not register gpio chip\n", ret);
+		return ret;
+	}
 
 	for (j = 0; j < bank->width; j++) {
 		int irq = irq_create_mapping(bank->domain, j);
@@ -1139,6 +1144,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct gpio_bank *bank;
 	int irq_base = 0;
+	int ret;
 
 	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
 
@@ -1223,7 +1229,11 @@ static int omap_gpio_probe(struct platform_device *pdev)
 		mpuio_init(bank);
 
 	omap_gpio_mod_init(bank);
-	omap_gpio_chip_init(bank);
+
+	ret = omap_gpio_chip_init(bank);
+	if (ret)
+		return ret;
+
 	omap_gpio_show_rev(bank);
 
 	pm_runtime_put(bank->dev);
-- 
1.9.0

