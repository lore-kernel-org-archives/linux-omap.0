From: Adrian Bunk <bunk@kernel.org>
Subject: [RFC: 2.6 patch] fix arch/arm/plat-omap/gpio.c compilation
Date: Fri, 29 Aug 2008 12:23:21 +0300
Message-ID: <20080829092321.GG16462@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:43035 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbYH2JYX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Aug 2008 05:24:23 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

This patch fixes the following compile error:

<--  snip  -->

...
  CC      arch/arm/plat-omap/gpio.o
...
arch/arm/plat-omap/gpio.c: In function '_omap_gpio_init':
arch/arm/plat-omap/gpio.c:1492: error: 'omap_mpuio_device' undeclared (first use in this function)
arch/arm/plat-omap/gpio.c:1492: error: (Each undeclared identifier is reported only once
arch/arm/plat-omap/gpio.c:1492: error: for each function it appears in.)
make[2]: *** [arch/arm/plat-omap/gpio.o] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 3e76ee2..9e1341e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1488,7 +1488,7 @@ static int __init _omap_gpio_init(void)
 		bank->chip.set = gpio_set;
 		if (bank_is_mpuio(bank)) {
 			bank->chip.label = "mpuio";
-#ifdef CONFIG_ARCH_OMAP1
+#ifdef CONFIG_ARCH_OMAP16XX
 			bank->chip.dev = &omap_mpuio_device.dev;
 #endif
 			bank->chip.base = OMAP_MPUIO(0);

