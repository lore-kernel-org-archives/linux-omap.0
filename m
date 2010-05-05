From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: ARCH_OMAP34XX usage in gpio PM code
Date: Wed, 05 May 2010 16:25:55 +0530
Message-ID: <4BE14EBB.3060205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56036 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab0EEK4E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 06:56:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

Kevin,

Most of the ARCH_OMAP34XX usage has been converted to ARCH_OMAP3,
however there is still a piece of code in gpio on PM branch that refers
ARCH_OMAP34XX

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7b2178c..0c84aae 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2095,7 +2095,7 @@ static int omap_gpio_suspend(struct sys_device
*dev, pm_me
                __raw_writel(bank->suspend_wakeup, wake_set);
                spin_unlock_irqrestore(&bank->lock, flags);

-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
                if (bank->method == METHOD_GPIO_24XX) {
                        int j;
                        for (j = 0; j < 32; j++) {

Shouldn't we be making this change? Let me know and I will include it in
the ads7846 wakeup series.

Just ran into this when testing the ads7846 wakeup support patches and
observing that no gpio wakeup was happening. This part of the code that
was setting the wakeup pad configuration was getting excluded as
ARCH_OMAP34XX is not defined anymore.

Thanks,
Ranjith


