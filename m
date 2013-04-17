From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] gpio/omap: ensure gpio context is initialised
Date: Wed, 17 Apr 2013 15:31:47 -0500
Message-ID: <1366230707-32681-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34212 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965318Ab3DQUcB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Apr 2013 16:32:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Commit a2797be (gpio/omap: force restore if context loss is not
detectable) broke gpio support for OMAP when booting with device-tree
because a restore of the gpio context being performed without ever
initialising the gpio context. In other words, the context restored was
bad.

This problem could also occur in the non device-tree case, however, it
is much less likely because when booting without device-tree we can
detect context loss via a platform specific API and so context restore
is performed less often.

Nevertheless we should ensure that the gpio context is initialised
during the probe for gpio banks that could lose their state regardless
of whether we are booting with device-tree or not.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c |   53 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0557529..0ba5cb9 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -70,6 +70,7 @@ struct gpio_bank {
 	bool is_mpuio;
 	bool dbck_flag;
 	bool loses_context;
+	bool context_valid;
 	int stride;
 	u32 width;
 	int context_loss_count;
@@ -1085,6 +1086,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 }
 
 static const struct of_device_id omap_gpio_match[];
+static void omap_gpio_init_context(struct gpio_bank *p);
 
 static int omap_gpio_probe(struct platform_device *pdev)
 {
@@ -1179,8 +1181,10 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
-	if (bank->loses_context)
+	if (bank->loses_context) {
 		bank->get_context_loss_count = pdata->get_context_loss_count;
+		omap_gpio_init_context(bank);
+	}
 
 	pm_runtime_put(bank->dev);
 
@@ -1269,6 +1273,14 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	int c;
 
 	spin_lock_irqsave(&bank->lock, flags);
+
+	/*
+	 * On the first resume during the probe, the context has not
+	 * been initialised and so if the context is not valid return.
+	 */
+	if (!bank->context_valid)
+		goto done;
+
 	_gpio_dbck_enable(bank);
 
 	/*
@@ -1287,19 +1299,15 @@ static int omap_gpio_runtime_resume(struct device *dev)
 			omap_gpio_restore_context(bank);
 		} else {
 			c = bank->get_context_loss_count(bank->dev);
-			if (c != bank->context_loss_count) {
+			if (c != bank->context_loss_count)
 				omap_gpio_restore_context(bank);
-			} else {
-				spin_unlock_irqrestore(&bank->lock, flags);
-				return 0;
-			}
+			else
+				goto done;
 		}
 	}
 
-	if (!bank->workaround_enabled) {
-		spin_unlock_irqrestore(&bank->lock, flags);
-		return 0;
-	}
+	if (!bank->workaround_enabled)
+		goto done;
 
 	l = __raw_readl(bank->base + bank->regs->datain);
 
@@ -1352,6 +1360,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	}
 
 	bank->workaround_enabled = false;
+done:
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1385,6 +1394,29 @@ void omap2_gpio_resume_after_idle(void)
 }
 
 #if defined(CONFIG_PM_RUNTIME)
+static void omap_gpio_init_context(struct gpio_bank *p)
+{
+	struct omap_gpio_reg_offs *regs = p->regs;
+	void __iomem *base = p->base;
+
+	p->context.ctrl		= __raw_readl(base + regs->ctrl);
+	p->context.oe		= __raw_readl(base + regs->direction);
+	p->context.wake_en	= __raw_readl(base + regs->wkup_en);
+	p->context.leveldetect0	= __raw_readl(base + regs->leveldetect0);
+	p->context.leveldetect1	= __raw_readl(base + regs->leveldetect1);
+	p->context.risingdetect	= __raw_readl(base + regs->risingdetect);
+	p->context.fallingdetect = __raw_readl(base + regs->fallingdetect);
+	p->context.irqenable1	= __raw_readl(base + regs->irqenable);
+	p->context.irqenable2	= __raw_readl(base + regs->irqenable2);
+
+	if (regs->set_dataout && p->regs->clr_dataout)
+		p->context.dataout = __raw_readl(base + regs->set_dataout);
+	else
+		p->context.dataout = __raw_readl(base + regs->dataout);
+
+	p->context_valid = true;
+}
+
 static void omap_gpio_restore_context(struct gpio_bank *bank)
 {
 	__raw_writel(bank->context.wake_en,
@@ -1422,6 +1454,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 #else
 #define omap_gpio_runtime_suspend NULL
 #define omap_gpio_runtime_resume NULL
+static void omap_gpio_init_context(struct gpio_bank *p) {}
 #endif
 
 static const struct dev_pm_ops gpio_pm_ops = {
-- 
1.7.10.4

