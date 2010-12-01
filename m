From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH v8 01-b/11] OMAP: GPIO: Make omap_gpio_show_rev bank
 specific
Date: Wed, 1 Dec 2010 10:34:35 -0800
Message-ID: <20101201183435.GJ17222@atomide.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
 <1290689318-10191-2-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45446 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618Ab0LASen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 13:34:43 -0500
Content-Disposition: inline
In-Reply-To: <1290689318-10191-2-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, p-basak2@ti.com

Otherwise GPIO init on 16xx may try to access uninitialized GPIO
bank as the MPUIO bank does not have a revision register.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1689,16 +1689,16 @@ static struct clk * gpio5_fck;
 static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
 #endif
 
-static void __init omap_gpio_show_rev(void)
+static void __init omap_gpio_show_rev(struct gpio_bank *bank)
 {
 	u32 rev;
 
-	if (cpu_is_omap16xx())
-		rev = __raw_readw(gpio_bank[1].base + OMAP1610_GPIO_REVISION);
+	if (cpu_is_omap16xx() && !(bank->method != METHOD_MPUIO))
+		rev = __raw_readw(bank->base + OMAP1610_GPIO_REVISION);
 	else if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		rev = __raw_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
+		rev = __raw_readl(bank->base + OMAP24XX_GPIO_REVISION);
 	else if (cpu_is_omap44xx())
-		rev = __raw_readl(gpio_bank[0].base + OMAP4_GPIO_REVISION);
+		rev = __raw_readl(bank->base + OMAP4_GPIO_REVISION);
 	else
 		return;
 
@@ -1958,7 +1958,7 @@ static int __init _omap_gpio_init(void)
 		}
 	}
 
-	omap_gpio_show_rev();
+	omap_gpio_show_rev(bank);
 
 	return 0;
 }
