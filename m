From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/14] ARM / OMAP: Use struct syscore_ops for "core" power management
Date: Sun, 17 Apr 2011 23:08:07 +0200
Message-ID: <201104172308.08049.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57604 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab1DQVQG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 17 Apr 2011 17:16:06 -0400
In-Reply-To: <201104172301.54115.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Mike Frysinger <vapier@gentoo.org>, Ralf Baechle <ralf@linux-mips.org>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Jiri Kosina <jkosina@suse.cz>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Replace the sysdev class and struct sys_device used for power
management in the OMAP's GPIO code with a struct syscore_ops object
which is simpler.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/gpio.c |   35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

Index: linux-2.6/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/gpio.c
+++ linux-2.6/arch/arm/plat-omap/gpio.c
@@ -17,7 +17,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -1372,9 +1372,7 @@ static const struct dev_pm_ops omap_mpui
 	.resume_noirq = omap_mpuio_resume_noirq,
 };
 
-/* use platform_driver for this, now that there's no longer any
- * point to sys_device (other than not disturbing old code).
- */
+/* use platform_driver for this. */
 static struct platform_driver omap_mpuio_driver = {
 	.driver		= {
 		.name	= "mpuio",
@@ -1745,7 +1743,7 @@ static int __devinit omap_gpio_probe(str
 }
 
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
+static int omap_gpio_suspend(void)
 {
 	int i;
 
@@ -1795,12 +1793,12 @@ static int omap_gpio_suspend(struct sys_
 	return 0;
 }
 
-static int omap_gpio_resume(struct sys_device *dev)
+static void omap_gpio_resume(void)
 {
 	int i;
 
 	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
-		return 0;
+		return;
 
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
@@ -1836,21 +1834,13 @@ static int omap_gpio_resume(struct sys_d
 		__raw_writel(bank->saved_wakeup, wake_set);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
-
-	return 0;
 }
 
-static struct sysdev_class omap_gpio_sysclass = {
-	.name		= "gpio",
+static struct syscore_ops omap_gpio_syscore_ops = {
 	.suspend	= omap_gpio_suspend,
 	.resume		= omap_gpio_resume,
 };
 
-static struct sys_device omap_gpio_device = {
-	.id		= 0,
-	.cls		= &omap_gpio_sysclass,
-};
-
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
@@ -2108,21 +2098,14 @@ postcore_initcall(omap_gpio_drv_reg);
 
 static int __init omap_gpio_sysinit(void)
 {
-	int ret = 0;
-
 	mpuio_init();
 
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
-		if (ret == 0) {
-			ret = sysdev_class_register(&omap_gpio_sysclass);
-			if (ret == 0)
-				ret = sysdev_register(&omap_gpio_device);
-		}
-	}
+	if (cpu_is_omap16xx() || cpu_class_is_omap2())
+		register_syscore_ops(&omap_gpio_syscore_ops);
 #endif
 
-	return ret;
+	return 0;
 }
 
 arch_initcall(omap_gpio_sysinit);

