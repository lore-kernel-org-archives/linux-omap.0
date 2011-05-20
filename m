From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 01/14] GPIO: OMAP: _clear_gpio_irqbank: fix flushing of posted write
Date: Fri, 20 May 2011 17:14:44 +0200
Message-ID: <1305904497-26013-2-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:34787 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933413Ab1ETPPL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:11 -0400
Received: by mail-ww0-f46.google.com with SMTP id 28so3109864wwb.27
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:04 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

In commit 78a1a6d3411de1a8b0dc1cb92754b5f12f251912 (ARM: OMAP4: Update
the GPIO support) braces were mistakenly added to included the
register read-back inside the cpu_is_* checking.

Remove the braces, ensuring that a register read-back is done, even
when the IRQSTATUS2 register is not written.

Note that the register read-back might be IRQSTATUS1 or IRQSTATUS2
depending on the CPU, but a read-back of any register in that region
will cause a flush of the posted writes.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio_omap.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 5d55886..b414644 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -708,12 +708,11 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	else if (cpu_is_omap44xx())
 		reg = bank->base + OMAP4_GPIO_IRQSTATUS1;
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
 		__raw_writel(gpio_mask, reg);
 
 	/* Flush posted write for the irq status to avoid spurious interrupts */
 	__raw_readl(reg);
-	}
 }
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
-- 
1.7.3.4

