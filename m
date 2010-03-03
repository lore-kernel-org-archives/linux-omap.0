From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH] omap: Fix gpio_resume_after_retention
Date: Wed,  3 Mar 2010 10:21:08 -0600
Message-ID: <1267633268-23785-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53404 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746Ab0CCQUq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Mar 2010 11:20:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: santosh.shilimkar@ti.com, Tony Lindgren <tony@atomide.com>, Sergio Aguirre <saaguirre@ti.com>

For omap4 case, this was wrongly writing GPIO_LEVELDETECTx
registers with OMAP24XX_ offset and OMAP4_ offset.

Bug introduced in commit:

  commit 3f1686a9bfe74979c6ad538c78039730f665f77e
  Author: Tony Lindgren <tony@atomide.com>
  Date:   Mon Feb 15 09:27:25 2010 -0800

      omap: Fix gpio.c for multi-omap for omap4

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/plat-omap/gpio.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 337199e..76a347b 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2140,18 +2140,18 @@ void omap2_gpio_resume_after_retention(void)
 		if (gen) {
 			u32 old0, old1;
 
-			if (cpu_is_omap24xx() || cpu_is_omap44xx()) {
+			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 				old0 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
 				old1 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-			__raw_writel(old0 | gen, bank->base +
+				__raw_writel(old0 | gen, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
-			__raw_writel(old1 | gen, bank->base +
+				__raw_writel(old1 | gen, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-			__raw_writel(old0, bank->base +
+				__raw_writel(old0, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
-			__raw_writel(old1, bank->base +
+				__raw_writel(old1, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
 			}
 
-- 
1.6.3.3

