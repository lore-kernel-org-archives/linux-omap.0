From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] gpio: always enable GPIO_OMAP on ARCH_OMAP
Date: Mon, 28 Apr 2014 11:07:03 +0200
Message-ID: <5523458.JVZJJObMjC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:62867 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbaD1JHi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 05:07:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Commit 4df42de9d3e "gpio: omap: add a GPIO_OMAP option instead of using
ARCH_OMAP" made it possible to build OMAP kernels without the GPIO driver,
which at least on OMAP2 and OMAP3 causes build errors because of functions
used by the platform power management code:

arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
arch/arm/mach-omap2/pm24xx.c:129: undefined reference to `omap2_gpio_prepare_for_idle'
arch/arm/mach-omap2/pm24xx.c:129: undefined reference to `omap2_gpio_resume_after_idle'

We presumably always want the GPIO driver on OMAP, so this adds a slightly
broader dependency and only allows disabling the driver only when no
OMAP2PLUS platform is selected.

However, it seems entirely reasonable to include the driver in build tests
on other platforms, so we should also allow building it for COMPILE_TEST
builds and select the required GENERIC_IRQ_CHIP that may not already be
enabled on other platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index c58b828..c8c42be 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -244,9 +244,10 @@ config GPIO_OCTEON
 	  family of SOCs.
 
 config GPIO_OMAP
-	bool "TI OMAP GPIO support"
+	bool "TI OMAP GPIO support" if COMPILE_TEST && !ARCH_OMAP2PLUS
 	default y if ARCH_OMAP
-	depends on ARM && ARCH_OMAP
+	depends on ARM
+	select GENERIC_IRQ_CHIP
 	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to enable GPIO support for TI OMAP SoCs.

