From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 2/3] gpio: omap: Remove unneeded include
Date: Fri, 27 Jun 2014 22:17:36 +0200
Message-ID: <1403900258-20717-3-git-send-email-jmartinez@softcrates.net>
References: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33487 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbaF0USB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2014 16:18:01 -0400
Received: by mail-wg0-f43.google.com with SMTP id b13so5588265wgh.26
        for <linux-omap@vger.kernel.org>; Fri, 27 Jun 2014 13:18:00 -0700 (PDT)
In-Reply-To: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <jmartinez@softcrates.net>

The <linux/irqchip/chained_irq.h> header is already included
when selecting GPIOLIB_IRQCHIP so there is no need to do it
in the driver. This is a left over from commit fb655f5
("gpio: omap: convert driver to use gpiolib irqchip").

Signed-off-by: Javier Martinez Canillas <jmartinez@softcrates.net>
---
 drivers/gpio/gpio-omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4b4e1b4..ef461e7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -24,7 +24,6 @@
 #include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/irqchip/chained_irq.h>
 #include <linux/gpio.h>
 #include <linux/bitops.h>
 #include <linux/platform_data/gpio-omap.h>
-- 
2.0.0.rc2

