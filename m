From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/11] ARM: OMAP3: Fixed spurious IRQ issue for GPIO interrupts
Date: Tue, 14 Apr 2009 15:01:03 -0700
Message-ID: <20090414220103.9878.60119.stgit@localhost>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50103 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbZDNWBN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 18:01:13 -0400
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Roger Quadros <ext-roger.quadros@nokia.com>

From: Roger Quadros <ext-roger.quadros@nokia.com>

Flush posted write to IRQSTATUS register in GPIO IRQ handler.
This eliminates the below error for all peripherals that use GPIO interrupts.

<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 31

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 210a1c0..17d7afe 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -758,8 +758,12 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+	reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		__raw_writel(gpio_mask, bank->base + OMAP24XX_GPIO_IRQSTATUS2);
+		__raw_writel(gpio_mask, reg);
+
+	/* Flush posted write for the irq status to avoid spurious interrupts */
+	__raw_readl(reg);
 #endif
 }
 

