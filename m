From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/11] ARM: OMAP: gpios implement new to_irq()
Date: Fri, 28 Nov 2008 17:10:04 -0800
Message-ID: <20081129011004.12337.33627.stgit@localhost>
References: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57789 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbYK2BKF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:10:05 -0500
In-Reply-To: <20081129010728.12337.8217.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Make OMAP use the new __gpio_to_irq() hook, to make it easier to
support IRQs coming in from off-chip gpio controllers like the
TWL4030/TPS65930 chip used on OMAP3 boads like Beagleboard.org and
the Gumstix Overo.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c              |    9 +++++++++
 arch/arm/plat-omap/include/mach/gpio.h |   16 ++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 8ff225b..e07ab23 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1285,6 +1285,14 @@ static void gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct gpio_bank *bank;
+
+	bank = container_of(chip, struct gpio_bank, chip);
+	return bank->virtual_irq_start + offset;
+}
+
 /*---------------------------------------------------------------------*/
 
 static int initialized;
@@ -1480,6 +1488,7 @@ static int __init _omap_gpio_init(void)
 		bank->chip.get = gpio_get;
 		bank->chip.direction_output = gpio_output;
 		bank->chip.set = gpio_set;
+		bank->chip.to_irq = gpio_2irq;
 		if (bank_is_mpuio(bank)) {
 			bank->chip.label = "mpuio";
 #ifdef CONFIG_ARCH_OMAP16XX
diff --git a/arch/arm/plat-omap/include/mach/gpio.h b/arch/arm/plat-omap/include/mach/gpio.h
index 98e9008..5f996f3 100644
--- a/arch/arm/plat-omap/include/mach/gpio.h
+++ b/arch/arm/plat-omap/include/mach/gpio.h
@@ -109,16 +109,24 @@ static inline int gpio_cansleep(unsigned gpio)
 
 static inline int gpio_to_irq(unsigned gpio)
 {
-	if (gpio < (OMAP_MAX_GPIO_LINES + 16))
-		return OMAP_GPIO_IRQ(gpio);
-	return -EINVAL;
+	return __gpio_to_irq(gpio);
 }
 
 static inline int irq_to_gpio(unsigned irq)
 {
+	int tmp;
+
+	/* omap1 SOC mpuio */
 	if (cpu_class_is_omap1() && (irq < (IH_MPUIO_BASE + 16)))
 		return (irq - IH_MPUIO_BASE) + OMAP_MAX_GPIO_LINES;
-	return irq - IH_GPIO_BASE;
+
+	/* SOC gpio */
+	tmp = irq - IH_GPIO_BASE;
+	if (tmp < OMAP_MAX_GPIO_LINES)
+		return tmp;
+
+	/* we don't supply reverse mappings for non-SOC gpios */
+	return -EIO;
 }
 
 #endif

