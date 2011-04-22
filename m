From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 15/18] OMAP: GPIO: cleanup gpio_show_rev
Date: Fri, 22 Apr 2011 16:38:29 +0530
Message-ID: <1303470512-19671-16-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60462 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755116Ab1DVLE5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 07:04:57 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Remove cpu_is* checks from omap_gpio_show_rev.

Also display GPIO IP version only once as it is not
required to print the IP version of all the banks as
they are the same.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 0f48364..637db76 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1032,12 +1032,10 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
 {
 	u32 rev;
 
-	if (cpu_is_omap16xx() && !(bank->method != METHOD_MPUIO))
-		rev = __raw_readw(bank->base + OMAP1610_GPIO_REVISION);
-	else if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		rev = __raw_readl(bank->base + OMAP24XX_GPIO_REVISION);
-	else if (cpu_is_omap44xx())
-		rev = __raw_readl(bank->base + OMAP4_GPIO_REVISION);
+	if ((bank->method == METHOD_GPIO_24XX) ||
+			(bank->method == METHOD_GPIO_44XX) ||
+			(bank->method == METHOD_GPIO_1610))
+		rev = gpio_fn.gpio_read(bank->base, REV);
 	else
 		return;
 
@@ -1170,6 +1168,7 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 static int __devinit omap_gpio_probe(struct platform_device *pdev)
 {
 	static int gpio_init_done;
+	static int show_rev;
 	struct omap_gpio_platform_data *pdata;
 	struct resource *res;
 	struct gpio_bank *bank;
@@ -1238,7 +1237,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 
 	omap_gpio_mod_init(bank, pdev->id);
 	omap_gpio_chip_init(bank);
-	omap_gpio_show_rev(bank);
 
 	list_add_tail(&bank->node, &omap_gpio_list);
 
@@ -1259,6 +1257,11 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		gpio_init_done = 1;
 	}
 
+	if ((bank->method != METHOD_MPUIO) && (!show_rev)) {
+		omap_gpio_show_rev(bank);
+		show_rev = 1;
+	}
+
 	return 0;
 }
 
-- 
1.7.1

