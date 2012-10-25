From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v3] gpio/omap: fix off-mode bug: clear debounce clock enable mask on free/reset
Date: Thu, 25 Oct 2012 09:34:18 -0700
Message-ID: <1351182858-14045-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45529 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759668Ab2JYQeV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 12:34:21 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1286361pad.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 09:34:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Grazvydas Ignotas <notasas@gmail.com>

From: Kevin Hilman <khilman@ti.com>

When a GPIO is freed or shutdown, ensure that the proper bit in
dbck_enable_mask is cleared also.  Otherwise, context restore on
subsequent off-mode transition will restore previous debounce values
from the shadow copies (bank->context.debounce*) leading to mismatch
state between driver state and hardware state.

This was discovered when board code was doing

  gpio_request_one()
  gpio_set_debounce()
  gpio_free()

which was leaving the GPIO debounce settings in a confused state.  If
that GPIO bank is subsequently used with off-mode enabled, bogus state
would be restored, leaving GPIO debounce enabled which then prevented
the CORE powerdomain from transitioning.

To fix, ensure that right bit in bank->dbck_enable_mask is cleared
when a GPIO is freed/shutdown so debounce state doesn't persist after
free/reset.  If this GPIO is the last debounce-enabled GPIO in the
bank, the debounce will also be cut.

Special thanks to Grazvydas Ignotas for pointing out a bug in the
first version that would've disabled debounce on any runtime PM
transition.

And, special thanks to Jon Hunter for pointing out a bug in the second
version which was mistakenly clearing all debounce bits on reset
instead of individual GPIOs, as well as suggesting cutting the
debounce clock after all debounce bits are cleared.

Tesed on 37xx/EVM board which configures GPIO debounce for the ads7846
touchscreen in its board file using the above sequence, and so was
failing off-mode tests in dynamic idle.  Verified that off-mode tests
are passing with this patch.

Reported-by: Paul Walmsley <paul@pwsan.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Grazvydas Ignotas <notasas@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio-omap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 94cbc84..ce1da19 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -539,6 +539,8 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
 	_set_gpio_irqenable(bank, gpio, 0);
 	_clear_gpio_irqstatus(bank, gpio);
 	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
+	bank->dbck_enable_mask &= ~(GPIO_BIT(bank, gpio));
+	_gpio_dbck_disable(bank);
 }
 
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
-- 
1.8.0

