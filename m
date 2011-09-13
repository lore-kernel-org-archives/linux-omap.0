From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v7 25/26] gpio/omap: handle set_dataout reg capable IP on restore
Date: Tue, 13 Sep 2011 18:32:58 +0530
Message-ID: <1315918979-26173-26-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44274 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753527Ab1IMND1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Sep 2011 09:03:27 -0400
In-Reply-To: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Nishanth Menon <nm@ti.com>

GPIO IP revisions such as those used in OMAP4 have a set_dataout
while the previous revisions used a single dataout register.
Depending on what is available restore the dataout settings
to the right register.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 165a598..c597303 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1048,7 +1048,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->get_context_loss_count = pdata->get_context_loss_count;
 	bank->regs = pdata->regs;
 
-	if (bank->regs->set_dataout && bank->regs->clr_dataout)
+	if (bank->regs->set_dataout)
 		bank->set_dataout = _set_gpio_dataout_reg;
 	else
 		bank->set_dataout = _set_gpio_dataout_mask;
@@ -1321,7 +1321,12 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 				bank->base + bank->regs->risingdetect);
 	__raw_writel(bank->context.fallingdetect,
 				bank->base + bank->regs->fallingdetect);
-	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
+	if (bank->regs->set_dataout)
+		__raw_writel(bank->context.dataout,
+				bank->base + bank->regs->set_dataout);
+	else
+		__raw_writel(bank->context.dataout,
+				bank->base + bank->regs->dataout);
 	__raw_writel(bank->context.oe, bank->base + bank->regs->direction);
 
 	if (bank->dbck_enable_mask) {
-- 
1.7.0.4

