From: Tim Niemeyer <tim.niemeyer@corscience.de>
Subject: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Fri, 26 Oct 2012 15:19:13 +0200
Message-ID: <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de>
References: <20121026114250.GA26342@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50327 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758711Ab2JZNTG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 09:19:06 -0400
In-Reply-To: <20121026114250.GA26342@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP List <linux-omap@vger.kernel.org>
Cc: balbi@ti.com, Tim Niemeyer <tim.niemeyer@corscience.de>

Adds support for configuring the omap-gpio driver use autosuspend for
runtime power management. This can reduce the latency in using it by
not suspending the device immediately on idle. If another access takes
place before the autosuspend timeout (2 secs), the call to resume the
device can return immediately saving some save/ restore cycles.

This removes also the bank->mod_usage counter, because this is already
handled in pm_runtime.

I use a gpio to monitor a spi transfer which occurs every 250=C2=B5s. T=
he
suspend overhead is to high, so almost every second transfer is lost.
This patch fixes that.

Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
---
 drivers/gpio/gpio-omap.c |   81 ++++++++++++++++++++++++--------------=
-------
 1 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 94cbc84..708d5a9 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -31,6 +31,7 @@
 #include <asm/mach/irq.h>
=20
 #define OFF_MODE	1
+#define GPIO_AUTOSUSPEND_TIMEOUT                2000
=20
 static LIST_HEAD(omap_gpio_list);
=20
@@ -64,7 +65,6 @@ struct gpio_bank {
 	spinlock_t lock;
 	struct gpio_chip chip;
 	struct clk *dbck;
-	u32 mod_usage;
 	u32 dbck_enable_mask;
 	bool dbck_enabled;
 	struct device *dev;
@@ -557,10 +557,9 @@ static int omap_gpio_request(struct gpio_chip *chi=
p, unsigned offset)
=20
 	/*
 	 * If this is the first gpio_request for the bank,
-	 * enable the bank module.
+	 * resume the bank module.
 	 */
-	if (!bank->mod_usage)
-		pm_runtime_get_sync(bank->dev);
+	pm_runtime_get_sync(bank->dev);
=20
 	spin_lock_irqsave(&bank->lock, flags);
 	/* Set trigger to none. You need to enable the desired trigger with
@@ -575,19 +574,6 @@ static int omap_gpio_request(struct gpio_chip *chi=
p, unsigned offset)
 		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
 	}
=20
-	if (bank->regs->ctrl && !bank->mod_usage) {
-		void __iomem *reg =3D bank->base + bank->regs->ctrl;
-		u32 ctrl;
-
-		ctrl =3D __raw_readl(reg);
-		/* Module is enabled, clocks are not gated */
-		ctrl &=3D ~GPIO_MOD_CTRL_BIT;
-		__raw_writel(ctrl, reg);
-		bank->context.ctrl =3D ctrl;
-	}
-
-	bank->mod_usage |=3D 1 << offset;
-
 	spin_unlock_irqrestore(&bank->lock, flags);
=20
 	return 0;
@@ -608,28 +594,15 @@ static void omap_gpio_free(struct gpio_chip *chip=
, unsigned offset)
 			__raw_readl(bank->base + bank->regs->wkup_en);
 	}
=20
-	bank->mod_usage &=3D ~(1 << offset);
-
-	if (bank->regs->ctrl && !bank->mod_usage) {
-		void __iomem *reg =3D bank->base + bank->regs->ctrl;
-		u32 ctrl;
-
-		ctrl =3D __raw_readl(reg);
-		/* Module is disabled, clocks are gated */
-		ctrl |=3D GPIO_MOD_CTRL_BIT;
-		__raw_writel(ctrl, reg);
-		bank->context.ctrl =3D ctrl;
-	}
-
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
=20
 	/*
 	 * If this is the last gpio to be freed in the bank,
-	 * disable the bank module.
+	 * put the bank module into suspend.
 	 */
-	if (!bank->mod_usage)
-		pm_runtime_put(bank->dev);
+	pm_runtime_mark_last_busy(bank->dev);
+	pm_runtime_put_autosuspend(bank->dev);
 }
=20
 /*
@@ -715,7 +688,8 @@ static void gpio_irq_handler(unsigned int irq, stru=
ct irq_desc *desc)
 exit:
 	if (!unmasked)
 		chained_irq_exit(chip, desc);
-	pm_runtime_put(bank->dev);
+	pm_runtime_mark_last_busy(bank->dev);
+	pm_runtime_put_autosuspend(bank->dev);
 }
=20
 static void gpio_irq_shutdown(struct irq_data *d)
@@ -1132,6 +1106,8 @@ static int __devinit omap_gpio_probe(struct platf=
orm_device *pdev)
=20
 	platform_set_drvdata(pdev, bank);
=20
+	pm_runtime_use_autosuspend(bank->dev);
+	pm_runtime_set_autosuspend_delay(bank->dev, GPIO_AUTOSUSPEND_TIMEOUT)=
;
 	pm_runtime_enable(bank->dev);
 	pm_runtime_irq_safe(bank->dev);
 	pm_runtime_get_sync(bank->dev);
@@ -1146,7 +1122,8 @@ static int __devinit omap_gpio_probe(struct platf=
orm_device *pdev)
 	if (bank->loses_context)
 		bank->get_context_loss_count =3D pdata->get_context_loss_count;
=20
-	pm_runtime_put(bank->dev);
+	pm_runtime_mark_last_busy(bank->dev);
+	pm_runtime_put_autosuspend(bank->dev);
=20
 	list_add_tail(&bank->node, &omap_gpio_list);
=20
@@ -1168,6 +1145,17 @@ static int omap_gpio_runtime_suspend(struct devi=
ce *dev)
=20
 	spin_lock_irqsave(&bank->lock, flags);
=20
+	if (bank->regs->ctrl) {
+		void __iomem *reg =3D bank->base + bank->regs->ctrl;
+		u32 ctrl;
+
+		ctrl =3D __raw_readl(reg);
+		/* Module is disabled, clocks are gated */
+		ctrl |=3D GPIO_MOD_CTRL_BIT;
+		__raw_writel(ctrl, reg);
+		bank->context.ctrl =3D ctrl;
+	}
+
 	/*
 	 * Only edges can generate a wakeup event to the PRCM.
 	 *
@@ -1316,6 +1304,17 @@ static int omap_gpio_runtime_resume(struct devic=
e *dev)
 		__raw_writel(old1, bank->base + bank->regs->leveldetect1);
 	}
=20
+	if (bank->regs->ctrl) {
+		void __iomem *reg =3D bank->base + bank->regs->ctrl;
+		u32 ctrl;
+
+		ctrl =3D __raw_readl(reg);
+		/* Module is enabled, clocks are not gated */
+		ctrl &=3D ~GPIO_MOD_CTRL_BIT;
+		__raw_writel(ctrl, reg);
+		bank->context.ctrl =3D ctrl;
+	}
+
 	bank->workaround_enabled =3D false;
 	spin_unlock_irqrestore(&bank->lock, flags);
=20
@@ -1328,12 +1327,18 @@ void omap2_gpio_prepare_for_idle(int pwr_mode)
 	struct gpio_bank *bank;
=20
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		if (!bank->mod_usage || !bank->loses_context)
+		if (!bank->loses_context)
 			continue;
=20
 		bank->power_mode =3D pwr_mode;
=20
-		pm_runtime_put_sync_suspend(bank->dev);
+		/* direct pm_runtime on pwroff */
+		if (pwr_mode) {
+			pm_runtime_put_sync_suspend(bank->dev);
+		} else {
+			pm_runtime_mark_last_busy(bank->dev);
+			pm_runtime_put_sync_autosuspend(bank->dev);
+		}
 	}
 }
=20
@@ -1342,7 +1347,7 @@ void omap2_gpio_resume_after_idle(void)
 	struct gpio_bank *bank;
=20
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		if (!bank->mod_usage || !bank->loses_context)
+		if (!bank->loses_context)
 			continue;
=20
 		pm_runtime_get_sync(bank->dev);
--=20
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
