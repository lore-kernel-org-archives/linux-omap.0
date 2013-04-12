From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH] gpio/omap: implement irq_enable/disable using mask/unmask.
Date: Fri, 12 Apr 2013 11:13:21 +0200
Message-ID: <1365758001-15562-2-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1365758001-15562-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:65077 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836Ab3DLJNk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Apr 2013 05:13:40 -0400
Received: from mailout-de.gmx.net ([10.1.76.16]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LjP2f-1Uzvrx232N-00dZWq for
 <linux-omap@vger.kernel.org>; Fri, 12 Apr 2013 11:13:38 +0200
In-Reply-To: <1365758001-15562-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com
Cc: khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org, daniel@zonque.org, jon-hunter@ti.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

In PM suspend, some omaps can't detect sdio irqs via the sdio interface.
The way to implement this, is to declare the corresponding pin as part
of the sdio interface and as a gpio input via pinctrl-single states.
The MMC driver request states "default" "active" and "idle" during the
probe, then toggles between active and idle during the runtime. This
requires low overhead functions for enable/disable of gpio irqs.

For level triggered interrupt there is no difference between masking
and disabling an interrupt. For edge interrupt interrupts there is.
When masked, interrupts should still be latched to the interrupt status
register so when unmasked later there is an interrupt straight away.
However, if the interrupt is disabled then gpio events occurring will not
be latched/stored. Hence proposed patch is incomplete for edge type
interrupts.

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 drivers/gpio/gpio-omap.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 159f5c5..69ef2d8 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -815,6 +815,8 @@ static struct irq_chip gpio_irq_chip = {
 	.irq_unmask	= gpio_unmask_irq,
 	.irq_set_type	= gpio_irq_type,
 	.irq_set_wake	= gpio_wake_enable,
+	.irq_disable    = gpio_mask_irq, /* FIXME for edge type IRQ */
+	.irq_enable     = gpio_unmask_irq,
 };
 
 /*---------------------------------------------------------------------*/
-- 
1.7.10.4

