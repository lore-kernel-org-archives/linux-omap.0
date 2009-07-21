From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 13/14] OMAP: GPIO: clear/restore level/edge detect settings on mask/unmask
Date: Tue, 21 Jul 2009 15:08:39 -0700
Message-ID: <1248214120-18886-14-git-send-email-khilman@deeprootsystems.com>
References: <1248214120-18886-1-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-2-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-3-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-4-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-5-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-6-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-7-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-8-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-9-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-10-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-11-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-12-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-13-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:42991 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756358AbZGUWJO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 18:09:14 -0400
Received: by mail-pz0-f204.google.com with SMTP id 42so701151pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 15:09:14 -0700 (PDT)
In-Reply-To: <1248214120-18886-13-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

If IRQ triggering is enabled, it can trigger a pending interrupt
even for masked interrupts.  Any pending GPIO interrupts can
prevent the powerdomain from hitting retention.

Problem found, reported and additional review and testing by Chunquiu
Wang.

Tested-by: Chunquiu Wang <cqwang@motorola.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/gpio.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 26b387c..77bad14 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1189,6 +1189,7 @@ static void gpio_mask_irq(unsigned int irq)
 	struct gpio_bank *bank = get_irq_chip_data(irq);
 
 	_set_gpio_irqenable(bank, gpio, 0);
+	_set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
 }
 
 static void gpio_unmask_irq(unsigned int irq)
@@ -1196,6 +1197,11 @@ static void gpio_unmask_irq(unsigned int irq)
 	unsigned int gpio = irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = get_irq_chip_data(irq);
 	unsigned int irq_mask = 1 << get_gpio_index(gpio);
+	struct irq_desc *desc = irq_to_desc(irq);
+	u32 trigger = desc->status & IRQ_TYPE_SENSE_MASK;
+
+	if (trigger)
+		_set_gpio_triggering(bank, get_gpio_index(gpio), trigger);
 
 	/* For level-triggered GPIOs, the clearing must be done after
 	 * the HW source is cleared, thus after the handler has run */
-- 
1.6.3.3

