From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 RESEND 1/7] gpio/omap: fix wakeup_en register update in _set_gpio_wakeup()
Date: Tue, 20 Mar 2012 16:23:13 +0530
Message-ID: <1332240799-6748-2-git-send-email-tarun.kanti@ti.com>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52144 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759668Ab2CTKxf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 06:53:35 -0400
In-Reply-To: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

There are two ways through which wakeup_en register can be programmed
using gpiolib APIs as shown below. It is seen that in the second case
in _set_gpio_wakeup(), even though bank->suspend_wakeup is updated
correctly, its value is not programmed in wakeup_en register. Fix this.

irq_set_type()->gpio_irq_type()->_set_gpio_triggering()->set_gpio_trigger()
irq_set_wake()->gpio_wake_enable()->_set_gpio_wakeup()

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 7cbad85..1a144ac 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -511,6 +511,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	else
 		bank->suspend_wakeup &= ~gpio_bit;
 
+	__raw_writel(bank->suspend_wakeup, bank->base + bank->regs->wkup_en);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
-- 
1.7.0.4

