From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] ARM: OMAP: Fix GPIO IRQ unmask
Date: Thu, 13 Mar 2008 17:45:15 +0200
Message-ID: <1205423119-22292-3-git-send-email-tony@atomide.com>
References: omap-fixes-2008-03-13
 <1205423119-22292-1-git-send-email-tony@atomide.com>
 <1205423119-22292-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:59084 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbYCMPpl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 11:45:41 -0400
In-Reply-To: <1205423119-22292-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>

From: Kevin Hilman <khilman@mvista.com>

GPIO IRQ unmask doesn't actually do anything useful.  The problem is
hidden by a separate explicit mass unmask at the end of the chained
bank handler.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 66a1455..8c78e4e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1134,10 +1134,9 @@ static void gpio_mask_irq(unsigned int irq)
 static void gpio_unmask_irq(unsigned int irq)
 {
 	unsigned int gpio = irq - IH_GPIO_BASE;
-	unsigned int gpio_idx = get_gpio_index(gpio);
 	struct gpio_bank *bank = get_irq_chip_data(irq);
 
-	_set_gpio_irqenable(bank, gpio_idx, 1);
+	_set_gpio_irqenable(bank, gpio, 1);
 }
 
 static struct irq_chip gpio_irq_chip = {
-- 
1.5.3.6

