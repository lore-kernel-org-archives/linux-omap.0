From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable mask on disable
Date: Tue, 23 Oct 2012 11:09:31 -0700
Message-ID: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44273 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932571Ab2JWSJe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 14:09:34 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so616840pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 11:09:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

From: Kevin Hilman <khilman@ti.com>

When debounce clocks are disabled, ensure that the banks
dbck_enable_mask is cleared also.  Otherwise, context restore on
subsequent off-mode transition will restore previous value from the
shadow copies (bank->context.debounce*) leading to mismatch state
between driver state and hardware state.

This was discovered when board code was doing

  gpio_request_one()
  gpio_set_debounce()
  gpio_free()

which was leaving the GPIO debounce settings in a confused state.
Then, enabling off mode causing bogus state to be restored, leaving
GPIO debounce enabled which then prevented the CORE powerdomain from
transitioning.

Reported-by: Paul Walmsley <paul@pwsan.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies on v3.7-rc2, targetted for v3.7.

 drivers/gpio/gpio-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 94cbc84..dee2856 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -187,6 +187,7 @@ static inline void _gpio_dbck_disable(struct gpio_bank *bank)
 		 * to detect events and generate interrupts at least on OMAP3.
 		 */
 		__raw_writel(0, bank->base + bank->regs->debounce_en);
+		bank->dbck_enable_mask = 0;
 
 		clk_disable(bank->dbck);
 		bank->dbck_enabled = false;
-- 
1.8.0

