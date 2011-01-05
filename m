From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio irq chip
Date: Wed,  5 Jan 2011 19:58:03 +0200
Message-ID: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:55480 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324Ab1AESDU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 13:03:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Eduardo Valentin <eduardo.valentin@nokia.com>

Currently, if one calls disable_irq(gpio_irq), the irq
won't get disabled.

This is happening because the omap gpio code defines only
a .mask callback. And the default_disable function is just
a stub. The result is that, when someone calls disable_irq
for an irq in a gpio line, it will be kept enabled.

This patch solves this issue by setting the .disable
callback to point to the same .mask callback.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/gpio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c05c653..033197f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1433,6 +1433,7 @@ static struct irq_chip gpio_irq_chip = {
 	.shutdown	= gpio_irq_shutdown,
 	.ack		= gpio_ack_irq,
 	.mask		= gpio_mask_irq,
+	.disable	= gpio_mask_irq,
 	.unmask		= gpio_unmask_irq,
 	.set_type	= gpio_irq_type,
 	.set_wake	= gpio_wake_enable,
@@ -1469,6 +1470,7 @@ static struct irq_chip mpuio_irq_chip = {
 	.name		= "MPUIO",
 	.ack		= mpuio_ack_irq,
 	.mask		= mpuio_mask_irq,
+	.disable	= mpuio_mask_irq,
 	.unmask		= mpuio_unmask_irq,
 	.set_type	= gpio_irq_type,
 #ifdef CONFIG_ARCH_OMAP16XX
-- 
1.6.3.GIT

