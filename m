From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] gpio/omap: fix wakeups on level-triggered GPIOs
Date: Tue, 21 Feb 2012 11:01:18 -0800
Message-ID: <1329850878-22189-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:38675 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754767Ab2BUTAg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 14:00:36 -0500
Received: by mail-pz0-f42.google.com with SMTP id g27so7031258dan.15
        for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 11:00:35 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

While both level- and edge-triggered GPIOs are capable of generating
interrupts, only edge-triggered GPIOs are capable of generating a
module-level wakeup to the PRCM (c.f. 34xx NDA TRM section 25.5.3.2.)

In order to ensure that devices using level-triggered GPIOs as
interrupts can also cause wakeups (e.g. from idle), this patch enables
edge-triggering for wakeup-enabled, level-triggered GPIOs when a GPIO
bank is runtime-suspended (which also happens during idle.)

This fixes a problem found in GPMC-connected network cards with GPIO
interrupts (e.g. smsc911x on Zoom3, Overo, ...) where network booting
with NFSroot was very slow since the GPIO IRQs used by the NIC were
not generating PRCM wakeups, and thus not waking the system from idle.
NOTE: until v3.3, this boot-time problem was somewhat masked because
the UART init prevented WFI during boot until the full serial driver
was available.  Preventing WFI allowed regular GPIO interrupts to fire
and this problem was not seen.  After the UART runtime PM cleanups, we
no longer avoid WFI during boot, so GPIO IRQs that were not causing
wakeups resulted in very slow IRQ response times.

Tested on platforms using level-triggered GPIOs for network IRQs using
the SMSC911x NIC: 3530/Overo and 3630/Zoom3.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
This applies on top of the GPIO cleanup and runtime PM conversion series
which has been submitted for v3.4 and also available here:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/gpio/runtime-pm-cleanup

 drivers/gpio/gpio-omap.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f49bd6f..752ae9b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1196,8 +1196,30 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 	struct gpio_bank *bank = platform_get_drvdata(pdev);
 	u32 l1 = 0, l2 = 0;
 	unsigned long flags;
+	u32 wake_low, wake_hi;
 
 	spin_lock_irqsave(&bank->lock, flags);
+
+	/*
+	 * Only edges can generate a wakeup event to the PRCM.
+	 *
+	 * Therefore, ensure any wake-up capable GPIOs have
+	 * edge-detection enabled before going idle to ensure a wakeup
+	 * to the PRCM is generated on a GPIO transition. (c.f. 34xx
+	 * NDA TRM 25.5.3.1)
+	 *
+	 * The normal values will be restored upon ->runtime_resume()
+	 * by writing back the values saved in bank->context.
+	 */
+	wake_low = bank->context.leveldetect0 & bank->context.wake_en;
+	if (wake_low)
+		__raw_writel(wake_low | bank->context.fallingdetect,
+			     bank->base + bank->regs->fallingdetect);
+	wake_hi = bank->context.leveldetect1 & bank->context.wake_en;
+	if (wake_hi)
+		__raw_writel(wake_hi | bank->context.risingdetect,
+			     bank->base + bank->regs->risingdetect);
+
 	if (bank->power_mode != OFF_MODE) {
 		bank->power_mode = 0;
 		goto update_gpio_context_count;
@@ -1246,6 +1268,18 @@ static int omap_gpio_runtime_resume(struct device *dev)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	_gpio_dbck_enable(bank);
+
+	/*
+	 * In ->runtime_suspend(), level-triggered, wakeup-enabled
+	 * GPIOs were set to edge trigger also in order to be able to
+	 * generate a PRCM wakeup.  Here we restore the
+	 * pre-runtime_suspend() values for edge triggering.
+	 */
+	__raw_writel(bank->context.fallingdetect,
+		     bank->base + bank->regs->fallingdetect);
+	__raw_writel(bank->context.risingdetect,
+		     bank->base + bank->regs->risingdetect);
+
 	if (!bank->enabled_non_wakeup_gpios || !bank->workaround_enabled) {
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
-- 
1.7.9

