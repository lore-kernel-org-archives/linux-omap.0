From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 RESEND 4/7] gpio/omap: fix missing dataout context save in _set_gpio_dataout_reg
Date: Tue, 20 Mar 2012 16:23:16 +0530
Message-ID: <1332240799-6748-5-git-send-email-tarun.kanti@ti.com>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52139 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759668Ab2CTKxd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 06:53:33 -0400
In-Reply-To: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

There are two functions, _set_gpio_dataout_reg() and _set_gpio_dataout_mask()
which writes to dataout register and the dataout context must be saved.
It is missing in the first function, _set_gpio_dataout_reg(). Fix this.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8901d57..bbe9648 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -120,10 +120,13 @@ static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
 	void __iomem *reg = bank->base;
 	u32 l = GPIO_BIT(bank, gpio);
 
-	if (enable)
+	if (enable) {
 		reg += bank->regs->set_dataout;
-	else
+		bank->context.dataout |= l;
+	} else {
 		reg += bank->regs->clr_dataout;
+		bank->context.dataout &= ~l;
+	}
 
 	__raw_writel(l, reg);
 }
-- 
1.7.0.4

