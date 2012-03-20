From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 RESEND 3/7] gpio/omap: fix _set_gpio_irqenable implementation
Date: Tue, 20 Mar 2012 16:23:15 +0530
Message-ID: <1332240799-6748-4-git-send-email-tarun.kanti@ti.com>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52138 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759667Ab2CTKxd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 06:53:33 -0400
In-Reply-To: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

This function should be capable of both enabling and disabling interrupts
based upon the *enable* parameter. Right now the function only enables
the interrupt and *enable* is not used at all. So add the interrupt
disable capability also using the parameter.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 2042857..8901d57 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -484,7 +484,10 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
 {
-	_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+	if (enable)
+		_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+	else
+		_disable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
 }
 
 /*
-- 
1.7.0.4

