From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] gpio/omap: omap_gpio_init_context stub must be inline
Date: Fri, 31 May 2013 17:59:46 +0200
Message-ID: <2942784.trumtc2GjZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51136 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab3EaQAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 12:00:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>

The bug fix 352a2d5bf "gpio/omap: ensure gpio context is initialised"
has caused a new warning for omap1_defconfig:

drivers/gpio/gpio-omap.c:1465:13: warning: 'omap_gpio_init_context' defined but not used [-Wunused-function]
 static void omap_gpio_init_context(struct gpio_bank *p) {}
             ^

The solution is to mark the stub function as 'static inline' so
it gets left out of the build when unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d3f7d2d..e5fba65 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1462,7 +1462,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 #else
 #define omap_gpio_runtime_suspend NULL
 #define omap_gpio_runtime_resume NULL
-static void omap_gpio_init_context(struct gpio_bank *p) {}
+static inline void omap_gpio_init_context(struct gpio_bank *p) {}
 #endif
 
 static const struct dev_pm_ops gpio_pm_ops = {

