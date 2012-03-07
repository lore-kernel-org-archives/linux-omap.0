From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 11/13] gpio/omap: fix dataout register overwrite in _set_gpio_dataout_*
Date: Wed, 7 Mar 2012 16:46:01 +0530
Message-ID: <1331118963-26364-12-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33557 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756168Ab2CGLQX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Mar 2012 06:16:23 -0500
In-Reply-To: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

In the existing _set_gpio_dataout_*() implementation, the dataout
register is overwritten every time the function is called. This is
not intended behavior because that would end up one user of a GPIO
line overwriting what is written by another. Fix this so that previous
value is always preserved until explicitly changed by respective
user/driver of the GPIO line.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 04c2677..2e8e476 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -114,6 +114,7 @@ static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
 	else
 		reg += bank->regs->clr_dataout;
 
+	l |= __raw_readl(bank->base + bank->regs->set_dataout);
 	__raw_writel(l, reg);
 	bank->context.dataout = l;
 }
@@ -130,6 +131,8 @@ static void _set_gpio_dataout_mask(struct gpio_bank *bank, int gpio, int enable)
 		l |= gpio_bit;
 	else
 		l &= ~gpio_bit;
+
+	l |= __raw_readl(bank->base + bank->regs->set_dataout);
 	__raw_writel(l, reg);
 	bank->context.dataout = l;
 }
-- 
1.7.0.4

