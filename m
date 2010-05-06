From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH] OMAP3: GPIO: Replace CONFIG_ARCH_OMAP34XX with CONFIG_ARCH_OMAP3
Date: Thu,  6 May 2010 16:32:16 +0530
Message-ID: <1273143736-28784-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43623 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab0EFLCY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 May 2010 07:02:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, ranjithl@ti.com

CONFIG_ARCH_OMAP34XX is not defined any more. Replace it with
CONFIG_ARCH_OMAP3.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---

This patch is generated against pm branch.

 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7b2178c..0c84aae 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2095,7 +2095,7 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 		__raw_writel(bank->suspend_wakeup, wake_set);
 		spin_unlock_irqrestore(&bank->lock, flags);
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 		if (bank->method == METHOD_GPIO_24XX) {
 			int j;
 			for (j = 0; j < 32; j++) {
-- 
1.6.2.4

