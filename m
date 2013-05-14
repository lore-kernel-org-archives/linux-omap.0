From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH v3 2/3] gpio/omap: modify wake-up register with interrupt enable.
Date: Tue, 14 May 2013 22:54:26 +0200
Message-ID: <1368564867-11142-2-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1368564867-11142-1-git-send-email-andreas.fenkart@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:63476 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757791Ab3ENUym (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 May 2013 16:54:42 -0400
Received: from mailout-de.gmx.net ([10.1.76.33]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MDjlo-1UjUr904PW-00H5i2 for
 <linux-omap@vger.kernel.org>; Tue, 14 May 2013 22:54:41 +0200
In-Reply-To: <1368564867-11142-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com
Cc: khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, daniel@zonque.org, jon-hunter@ti.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

OMAP4430 TRM chap. 25.4.5.2
To reduce dynamic consumption, an efficient idle scheme is based on the
following:
=E2=80=A2 An efficient local autoclock gating for each module
=E2=80=A2 The implementation of control sideband signals between the PR=
CM module
  and each module
This enhanced idle control allows clocks to be activated and deactivate=
d
safely without requiring complex software management. The idle mode
request, idle acknowledge, and wake-up request are sideband signals
between the PRCM module and the general-purpose interface

OMAP4430 TRM chap. 25.4.6.2
There must be a correlation between the wake-up enable and interrupt
enable register. If a GPIO pin has a wake-up configured on it, it must
also have the corresponding interrupt enabled. Otherwise, it is possibl=
e
there is a wake-up event, but after exiting the IDLE state, no interrup=
t
is generated; the corresponding bit from the interrupt status register =
is
not cleared, and the module does not acknowledge a future idle request.

Up to now _set_gpio_triggering() is also handling the wake-up enable
register. According the TRM this should be in sync with the interrupt
enable. Wakeup is still enabled by default, since the module would not
wake from idle otherwise.
The enabled_wakeup_gpios was introduced to remember an explicit
_set_gpio_wakeup beyond a mask/unmask cycle. Calling the flag flag
disabled_wakeup_gpios would spare the problem of initializing it, but
feels very unnatural to read.

Wakeup functionality is completely untested, since the AM335x
lacks a IRQWAKEN register.

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 drivers/gpio/gpio-omap.c |   68 ++++++++++++++++++++++++++++++--------=
--------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 082919e..44a93be 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -57,6 +57,7 @@ struct gpio_bank {
 	struct irq_domain *domain;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
+	u32 enabled_wakeup_gpios;
 	struct gpio_regs context;
 	u32 saved_datain;
 	u32 level_mask;
@@ -287,12 +288,6 @@ static inline void set_gpio_trigger(struct gpio_ba=
nk *bank, int gpio,
 		_gpio_rmw(base, bank->regs->fallingdetect,
 			  gpio_bit, trigger & IRQ_TYPE_EDGE_FALLING);
=20
-	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		bank->context.wake_en =3D
-			_gpio_rmw(base, bank->regs->wkup_en, gpio_bit,
-				  trigger !=3D 0);
-	}
-
 	/* This part needs to be executed always for OMAP{34xx, 44xx} */
 	if (!bank->regs->irqctrl) {
 		/* On omap24xx proceed only when valid GPIO bit is set */
@@ -350,12 +345,13 @@ static int _set_gpio_triggering(struct gpio_bank =
*bank, int gpio,
 							unsigned trigger)
 {
 	void __iomem *reg =3D bank->base;
-	void __iomem *base =3D bank->base;
 	u32 l =3D 0;
=20
-	if (bank->regs->leveldetect0 && bank->regs->wkup_en) {
+	if (bank->regs->leveldetect0) {
+		/* edge both flanks simultaneously / plus level */
 		set_gpio_trigger(bank, gpio, trigger);
 	} else if (bank->regs->irqctrl) {
+		/* edge single flank */
 		reg +=3D bank->regs->irqctrl;
=20
 		l =3D __raw_readl(reg);
@@ -370,6 +366,7 @@ static int _set_gpio_triggering(struct gpio_bank *b=
ank, int gpio,
=20
 		__raw_writel(l, reg);
 	} else if (bank->regs->edgectrl1) {
+		/* edge both flanks simultaneously */
 		if (gpio & 0x08)
 			reg +=3D bank->regs->edgectrl2;
 		else
@@ -382,11 +379,6 @@ static int _set_gpio_triggering(struct gpio_bank *=
bank, int gpio,
 			l |=3D 2 << (gpio << 1);
 		if (trigger & IRQ_TYPE_EDGE_FALLING)
 			l |=3D 1 << (gpio << 1);
-
-		/* Enable wake-up during idle for dynamic tick */
-		bank->context.wake_en =3D
-			_gpio_rmw(base, bank->regs->wkup_en, 1 << gpio,
-				  trigger);
 		__raw_writel(l, reg);
 	}
 	return 0;
@@ -485,10 +477,19 @@ static void _disable_gpio_irqbank(struct gpio_ban=
k *bank, int gpio_mask)
=20
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpi=
o, int enable)
 {
+	u32 gpio_bit =3D GPIO_BIT(bank, gpio);
+	void __iomem *base =3D bank->base;
+
 	if (enable)
-		_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+		_enable_gpio_irqbank(bank, gpio_bit);
 	else
-		_disable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+		_disable_gpio_irqbank(bank, gpio_bit);
+
+	if (bank->enabled_wakeup_gpios & gpio_bit) {
+		/* Enable wake-up during idle for dynamic tick */
+		bank->context.wake_en =3D
+			_gpio_rmw(base, bank->regs->wkup_en, gpio_bit, enable);
+	}
 }
=20
 /*
@@ -511,8 +512,27 @@ static int _set_gpio_wakeup(struct gpio_bank *bank=
, int gpio, int enable)
 	}
=20
 	spin_lock_irqsave(&bank->lock, flags);
-	bank->context.wake_en =3D _gpio_rmw(bank->base, bank->regs->wkup_en,
-					  gpio_bit, enable);
+
+	if (enable)
+		bank->enabled_wakeup_gpios |=3D gpio_bit;
+	else
+		bank->enabled_wakeup_gpios &=3D ~gpio_bit;
+
+	/*
+	 * OMAP4430 TRM, 25.4.6.2
+	 * If there is a wake-up event, but after exiting the IDLE
+	 * state, no interrupt is generated; the corresponding bit from
+	 * the interrupt status register is not cleared, and the
+	 * module does not acknowledge a future idle request.
+	 */
+	if (enable && !(bank->context.irqenable1 & gpio_bit))
+		dev_warn(bank->dev, "Wake-up/IRQ enable mismatch for GPIO%d\n",
+			 gpio);
+	else
+		bank->context.wake_en =3D _gpio_rmw(bank->base,
+						  bank->regs->wkup_en,
+						  gpio_bit, enable);
+
 	spin_unlock_irqrestore(&bank->lock, flags);
=20
 	return 0;
@@ -525,6 +545,10 @@ static void _reset_gpio(struct gpio_bank *bank, in=
t gpio)
 	_clear_gpio_irqstatus(bank, gpio);
 	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
 	_clear_gpio_debounce(bank, gpio);
+
+	/* wakeup enabled by default */
+	if (!(bank->non_wakeup_gpios & GPIO_BIT(bank, gpio)))
+		bank->enabled_wakeup_gpios |=3D GPIO_BIT(bank, gpio);
 }
=20
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers=
 */
@@ -554,6 +578,10 @@ static int omap_gpio_request(struct gpio_chip *chi=
p, unsigned offset)
 	 */
 	_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
=20
+	/* wakeup enabled by default */
+	if (!(bank->non_wakeup_gpios & (1 << offset)))
+		bank->enabled_wakeup_gpios |=3D 1 << offset;
+
 	if (bank->regs->pinctrl) {
 		/* Claim the pin for MPU */
 		_gpio_rmw(bank->base, bank->regs->pinctrl, 1 << offset, 1);
@@ -580,12 +608,6 @@ static void omap_gpio_free(struct gpio_chip *chip,=
 unsigned offset)
=20
 	spin_lock_irqsave(&bank->lock, flags);
=20
-	if (bank->regs->wkup_en) {
-		/* Disable wake-up during idle for dynamic tick */
-		bank->context.wake_en =3D
-			_gpio_rmw(base, bank->regs->wkup_en, 1 << offset, 0);
-	}
-
 	bank->mod_usage &=3D ~(1 << offset);
=20
 	if (bank->regs->ctrl && !bank->mod_usage) {
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
