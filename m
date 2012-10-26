From: Tim Niemeyer <tim.niemeyer@corscience.de>
Subject: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Fri, 26 Oct 2012 09:55:30 +0200
Message-ID: <1351238130-7158-1-git-send-email-tim.niemeyer@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64122 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757043Ab2JZHzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 03:55:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP List <linux-omap@vger.kernel.org>
Cc: Tim Niemeyer <tim.niemeyer@corscience.de>

Adds support for configuring the omap-gpio driver use autosuspend for
runtime power management. This can reduce the latency in using it by
not suspending the device immediately on idle. If another access takes
place before the autosuspend timeout (2 secs), the call to resume the
device can return immediately saving some save/ restore cycles.

I use a gpio to monitor a spi transfer which occurs every 250=C2=B5s. T=
he
suspend overhead is to high, so almost every second transfer is lost.
This patch fixes that.

Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
---
 drivers/gpio/gpio-omap.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 94cbc84..92f48cb 100644
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
@@ -628,8 +629,10 @@ static void omap_gpio_free(struct gpio_chip *chip,=
 unsigned offset)
 	 * If this is the last gpio to be freed in the bank,
 	 * disable the bank module.
 	 */
-	if (!bank->mod_usage)
-		pm_runtime_put(bank->dev);
+	if (!bank->mod_usage) {
+		pm_runtime_mark_last_busy(bank->dev);
+		pm_runtime_put_autosuspend(bank->dev);
+	}
 }
=20
 /*
@@ -715,7 +718,8 @@ static void gpio_irq_handler(unsigned int irq, stru=
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
@@ -1132,6 +1136,8 @@ static int __devinit omap_gpio_probe(struct platf=
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
@@ -1146,7 +1152,8 @@ static int __devinit omap_gpio_probe(struct platf=
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
@@ -1333,7 +1340,13 @@ void omap2_gpio_prepare_for_idle(int pwr_mode)
=20
 		bank->power_mode =3D pwr_mode;
=20
-		pm_runtime_put_sync_suspend(bank->dev);
+		/* direct pm_runtime on pwroff */
+		if (pwr_mode)
+			pm_runtime_put_sync_suspend(bank->dev);
+		else {
+			pm_runtime_mark_last_busy(bank->dev);
+			pm_runtime_put_sync_autosuspend(bank->dev);
+		}
 	}
 }
=20
--=20
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
