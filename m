From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2 2/9] gpio/omap: fix wakeup_en register update in _set_gpio_wakeup()
Date: Thu, 1 Mar 2012 04:14:22 +0530
Message-ID: <1330555469-21260-3-git-send-email-tarun.kanti@ti.com>
References: <1330555469-21260-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32782 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276Ab2B2Wok (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 17:44:40 -0500
In-Reply-To: <1330555469-21260-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

There are two ways through which wakeup_en register can be programmed
using gpiolib APIs as shown below. It is seen that in the second case
in _set_gpio_wakeup(), even though bank->suspend_wakeup is updated
correctly, its value is not programmed in wakeup_en register. Fix this.

chip.irq_set_type()->gpio_irq_type()->_set_gpio_triggering()->set_gpio_trigger()
chip.irq_set_wake()->gpio_wake_enable()->_set_gpio_wakeup()

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c9369d2..895df7f 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -504,6 +504,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	else
 		bank->suspend_wakeup &= ~gpio_bit;
 
+	__raw_writel(bank->suspend_wakeup, bank->base + bank->regs->wkup_en);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
-- 
1.7.0.4

