From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 6/6] OMAP: GPIO: remove duplicate debugfs interface
Date: Tue, 11 May 2010 16:30:52 -0700
Message-ID: <1273620652-15927-7-git-send-email-khilman@deeprootsystems.com>
References: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39468 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab0EKXbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:31:09 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so2565614pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:31:09 -0700 (PDT)
In-Reply-To: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The generic gpiolib provides a debugfs interface to GPIOs which
provides identical (but nicer looking) data as the OMAP specific one.

This patch completely drops the OMAP specific interface
(/debug/omap_gpio) in favor of using the generic one (/debug/gpio.)

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/gpio.c |  107 ---------------------------------------------
 1 files changed, 0 insertions(+), 107 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index b895cc9..955597f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2310,110 +2310,3 @@ static int __init omap_gpio_sysinit(void)
 }
 
 arch_initcall(omap_gpio_sysinit);
-
-
-#ifdef	CONFIG_DEBUG_FS
-
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-
-static int dbg_gpio_show(struct seq_file *s, void *unused)
-{
-	unsigned	i, j, gpio;
-
-	for (i = 0, gpio = 0; i < gpio_bank_count; i++) {
-		struct gpio_bank	*bank = gpio_bank + i;
-		unsigned		bankwidth = 16;
-		u32			mask = 1;
-
-		if (bank_is_mpuio(bank))
-			gpio = OMAP_MPUIO(0);
-		else if (cpu_class_is_omap2() || cpu_is_omap7xx())
-			bankwidth = 32;
-
-		for (j = 0; j < bankwidth; j++, gpio++, mask <<= 1) {
-			unsigned	irq, value, is_in, irqstat;
-			const char	*label;
-
-			label = gpiochip_is_requested(&bank->chip, j);
-			if (!label)
-				continue;
-
-			irq = bank->virtual_irq_start + j;
-			value = gpio_get_value(gpio);
-			is_in = gpio_is_input(bank, mask);
-
-			if (bank_is_mpuio(bank))
-				seq_printf(s, "MPUIO %2d ", j);
-			else
-				seq_printf(s, "GPIO %3d ", gpio);
-			seq_printf(s, "(%-20.20s): %s %s",
-					label,
-					is_in ? "in " : "out",
-					value ? "hi"  : "lo");
-
-/* FIXME for at least omap2, show pullup/pulldown state */
-
-			irqstat = irq_desc[irq].status;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-			if (is_in && ((bank->suspend_wakeup & mask)
-					|| irqstat & IRQ_TYPE_SENSE_MASK)) {
-				char	*trigger = NULL;
-
-				switch (irqstat & IRQ_TYPE_SENSE_MASK) {
-				case IRQ_TYPE_EDGE_FALLING:
-					trigger = "falling";
-					break;
-				case IRQ_TYPE_EDGE_RISING:
-					trigger = "rising";
-					break;
-				case IRQ_TYPE_EDGE_BOTH:
-					trigger = "bothedge";
-					break;
-				case IRQ_TYPE_LEVEL_LOW:
-					trigger = "low";
-					break;
-				case IRQ_TYPE_LEVEL_HIGH:
-					trigger = "high";
-					break;
-				case IRQ_TYPE_NONE:
-					trigger = "(?)";
-					break;
-				}
-				seq_printf(s, ", irq-%d %-8s%s",
-						irq, trigger,
-						(bank->suspend_wakeup & mask)
-							? " wakeup" : "");
-			}
-#endif
-			seq_printf(s, "\n");
-		}
-
-		if (bank_is_mpuio(bank)) {
-			seq_printf(s, "\n");
-			gpio = 0;
-		}
-	}
-	return 0;
-}
-
-static int dbg_gpio_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dbg_gpio_show, &inode->i_private);
-}
-
-static const struct file_operations debug_fops = {
-	.open		= dbg_gpio_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int __init omap_gpio_debuginit(void)
-{
-	(void) debugfs_create_file("omap_gpio", S_IRUGO,
-					NULL, NULL, &debug_fops);
-	return 0;
-}
-late_initcall(omap_gpio_debuginit);
-#endif
-- 
1.7.0.2

