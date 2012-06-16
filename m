From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] gpio/omap: fix irq loss while in idle with debounce on
Date: Sat, 16 Jun 2012 22:01:25 +0300
Message-ID: <1339873285-8700-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37844 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902Ab2FPTCu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jun 2012 15:02:50 -0400
Received: by weyu7 with SMTP id u7so2771767wey.19
        for <linux-omap@vger.kernel.org>; Sat, 16 Jun 2012 12:02:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Grazvydas Ignotas <notasas@gmail.com>, Kevin Hilman <khilman@ti.com>

It seems that currently GPIO module is not working correctly during idle
when debounce is enabled - the system almost never responds to button
presses (observed on OMAP3530 ES2.1 and OMAP3630 ES1.2 pandora boards).
Even though wakeups are probably working, it seems that the GPIO module
itself is unable to detect input events and generate interrupts.
OMAP35x TRM also states that:
  "If the debounce clock is inactive, the debounce cell gates all
   input signals and thus cannot be used."

So whenever we are disabling debounce clocks (for PM or other reasons),
be sure the module's debounce feature is disabled too.

Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/gpio/gpio-omap.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c4ed172..ff213e7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -174,12 +174,22 @@ static inline void _gpio_dbck_enable(struct gpio_bank *bank)
 	if (bank->dbck_enable_mask && !bank->dbck_enabled) {
 		clk_enable(bank->dbck);
 		bank->dbck_enabled = true;
+
+		__raw_writel(bank->dbck_enable_mask,
+			     bank->base + bank->regs->debounce_en);
 	}
 }
 
 static inline void _gpio_dbck_disable(struct gpio_bank *bank)
 {
 	if (bank->dbck_enable_mask && bank->dbck_enabled) {
+		/*
+		 * Disable debounce before cutting it's clock. If debounce is
+		 * enabled but the clock is not, GPIO module seems to be unable
+		 * to detect events and generate interrupts at least on OMAP3.
+		 */
+		__raw_writel(0, bank->base + bank->regs->debounce_en);
+
 		clk_disable(bank->dbck);
 		bank->dbck_enabled = false;
 	}
-- 
1.7.0.4

