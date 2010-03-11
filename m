From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/19] omap: Fix gpio_resume_after_retention
Date: Thu, 11 Mar 2010 15:48:34 -0800
Message-ID: <20100311234834.4500.12726.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52633 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0CKXrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:47:11 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sergio Aguirre <saaguirre@ti.com>, linux-omap@vger.kernel.org

From: Tony Lindgren <Aguirre>

For omap4 case, this was wrongly writing GPIO_LEVELDETECTx
registers with OMAP24XX_ offset and OMAP4_ offset.

Bug introduced in commit:

  commit 3f1686a9bfe74979c6ad538c78039730f665f77e
  Author: Tony Lindgren <tony@atomide.com>
  Date:   Mon Feb 15 09:27:25 2010 -0800

      omap: Fix gpio.c for multi-omap for omap4

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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
 

