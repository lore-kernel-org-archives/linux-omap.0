From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2] gpio/omap: fix off-mode bug: clear debounce clock enable mask on free/reset
Date: Wed, 24 Oct 2012 10:10:41 -0700
Message-ID: <1351098641-23917-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:58310 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756417Ab2JXRKo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 13:10:44 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so339176dak.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Oct 2012 10:10:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Grazvydas Ignotas <notasas@gmail.com>

From: Kevin Hilman <khilman@ti.com>

When a GPIO bank is freed or shutdown, ensure that the banks
dbck_enable_mask is cleared also.  Otherwise, context restore on
subsequent off-mode transition will restore previous value from the
shadow copies (bank->context.debounce*) leading to mismatch state
between driver state and hardware state.

This was discovered when board code was doing

  gpio_request_one()
  gpio_set_debounce()
  gpio_free()

which was leaving the GPIO debounce settings in a confused state.  If
that GPIO bank is subsequently used with off-mode enabled, bogus state
would be restored, leaving GPIO debounce enabled which then prevented
the CORE powerdomain from transitioning.

To fix, ensure that bank->dbck_enable_mask is cleared when the bank
is freed/shutdown so debounce state doesn't persist.

Special thanks to Grazvydas Ignotas for pointing out a bug in an
earlier version that would've disabled debounce on any runtime PM
transition.

Reported-by: Paul Walmsley <paul@pwsan.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
v2: only clear mask in free/shutdown, not in runtime PM paths, 
    clarified changelog   
Applies on v3.7-rc2.

 drivers/gpio/gpio-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 94cbc84..113b167 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -539,6 +539,7 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
 	_set_gpio_irqenable(bank, gpio, 0);
 	_clear_gpio_irqstatus(bank, gpio);
 	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
+	bank->dbck_enable_mask = 0;
 }
 
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
-- 
1.8.0

