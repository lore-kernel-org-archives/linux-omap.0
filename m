From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc3-git] omap gpio: minor bugfixes
Date: Fri, 7 Nov 2008 14:40:18 -0800
Message-ID: <200811071440.18526.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:24437 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752129AbYKGWkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 17:40:20 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Minor GPIO fixes:

 - If get_gpio_bank() fails, then BUG() out.

 - In omap_set_gpio_debounce():
    * protect the read/modify/write with the relevant spinlock
    * make the omap3 clock ops pass "sparse" checking

Except for the spinlock problem, these were reported through "make".

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/plat-omap/gpio.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -244,6 +244,8 @@ static inline struct gpio_bank *get_gpio
 		return &gpio_bank[gpio >> 5];
 	if (cpu_is_omap34xx())
 		return &gpio_bank[gpio >> 5];
+	BUG();
+	return NULL;
 }
 
 static inline int get_gpio_index(int gpio)
@@ -447,6 +449,7 @@ void omap_set_gpio_debounce(int gpio, in
 {
 	struct gpio_bank *bank;
 	void __iomem *reg;
+	unsigned long flags;
 	u32 val, l = 1 << get_gpio_index(gpio);
 
 	if (cpu_class_is_omap1())
@@ -454,21 +457,28 @@ void omap_set_gpio_debounce(int gpio, in
 
 	bank = get_gpio_bank(gpio);
 	reg = bank->base;
-
 	reg += OMAP24XX_GPIO_DEBOUNCE_EN;
+
+	spin_lock_irqsave(&bank->lock, flags);
 	val = __raw_readl(reg);
 
 	if (enable && !(val & l))
 		val |= l;
-	else if (!enable && val & l)
+	else if (!enable && (val & l))
 		val &= ~l;
 	else
-		return;
+		goto done;
 
-	if (cpu_is_omap34xx())
-		enable ? clk_enable(bank->dbck) : clk_disable(bank->dbck);
+	if (cpu_is_omap34xx()) {
+		if (enable)
+			clk_enable(bank->dbck);
+		else
+			clk_disable(bank->dbck);
+	}
 
 	__raw_writel(val, reg);
+done:
+	spin_unlock_irqrestore(&bank->lock, flags);
 }
 EXPORT_SYMBOL(omap_set_gpio_debounce);
 
