From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 09/20] gpio/omap: cleanup omap1 related macros
Date: Wed, 13 Jul 2011 19:24:08 +0530
Message-ID: <1310565259-31267-10-git-send-email-tarun.kanti@ti.com>
References: <1310565259-31267-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40710 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568Ab1GMNzF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 09:55:05 -0400
In-Reply-To: <1310565259-31267-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

mpuio_init() function is defined under #ifdefs. It is required only in case
of MPUIO bank type and only when PM operations are supported by it.
This is applicable only in case of OMAP16xx SoC's MPUIO GPIO bank type.
For all the other cases it is a dummy function. Hence clean up the same
and remove all the OMAP SoC specific #ifdefs.

bank_is_mpuio() is defined as a check to identify if the bank type is MPUIO.
It is not required to define it separately as zero for OMAP2PLUS. Remove this.

Signed-off-by: Charulatha V <charu@ti.com>
---
 drivers/gpio/gpio-omap.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c9d12c5..fe02e7a 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -777,14 +777,8 @@ static struct irq_chip gpio_irq_chip = {
 
 /*---------------------------------------------------------------------*/
 
-#ifdef CONFIG_ARCH_OMAP1
-
 #define bank_is_mpuio(bank)	((bank)->method == METHOD_MPUIO)
 
-#ifdef CONFIG_ARCH_OMAP16XX
-
-#include <linux/platform_device.h>
-
 static int omap_mpuio_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -846,17 +840,6 @@ static inline void mpuio_init(struct gpio_bank *bank)
 		(void) platform_device_register(&omap_mpuio_device);
 }
 
-#else
-static inline void mpuio_init(struct gpio_bank *bank) {}
-#endif	/* 16xx */
-
-#else
-
-#define bank_is_mpuio(bank)	0
-static inline void mpuio_init(struct gpio_bank *bank) {}
-
-#endif
-
 /*---------------------------------------------------------------------*/
 
 /* REVISIT these are stupid implementations!  replace by ones that
@@ -1077,10 +1060,8 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 	bank->chip.to_irq = gpio_2irq;
 	if (bank_is_mpuio(bank)) {
 		bank->chip.label = "mpuio";
-#ifdef CONFIG_ARCH_OMAP16XX
 		if (bank->regs->wkup_status)
 			bank->chip.dev = &omap_mpuio_device.dev;
-#endif
 		bank->chip.base = OMAP_MPUIO(0);
 	} else {
 		bank->chip.label = "gpio";
-- 
1.6.0.4

