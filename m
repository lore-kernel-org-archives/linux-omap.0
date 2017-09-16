From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] gpio: omap: omap_gpio_show_rev is not __init
Date: Sat, 16 Sep 2017 22:42:21 +0200
Message-ID: <20170916204234.725130-1-arnd@arndb.de>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The probe function calls omap_gpio_show_rev(), which on most
compilers is inlined, but on the old gcc-4.6 is not, causing
a valid warning about the incorrect __init annotation:

WARNING: vmlinux.o(.text+0x40f614): Section mismatch in reference from the function omap_gpio_probe() to the function .init.text:omap_gpio_show_rev()
The function omap_gpio_probe() references
the function __init omap_gpio_show_rev().
This is often because omap_gpio_probe lacks a __init
annotation or the annotation of omap_gpio_show_rev is wrong.

This removes the __init.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index dbf869fb63ce..22d7d4838265 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1010,7 +1010,7 @@ static void omap_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 /*---------------------------------------------------------------------*/
 
-static void __init omap_gpio_show_rev(struct gpio_bank *bank)
+static void omap_gpio_show_rev(struct gpio_bank *bank)
 {
 	static bool called;
 	u32 rev;
-- 
2.9.0

