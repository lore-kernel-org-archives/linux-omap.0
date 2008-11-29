From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/11] ARM: OMAP: minor gpio bugfixes
Date: Fri, 28 Nov 2008 17:10:50 -0800
Message-ID: <20081129011050.12337.46685.stgit@localhost>
References: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58388 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466AbYK2BKs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:10:48 -0500
In-Reply-To: <20081129010728.12337.8217.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Minor GPIO fixes:

 - If get_gpio_bank() fails, then BUG() out.

 - In omap_set_gpio_debounce():
    * protect the read/modify/write with the relevant spinlock
    * make the omap3 clock ops pass "sparse" checking

Except for the spinlock problem, these were reported through "make".

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index e8aae2a..07b6968 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -245,6 +245,8 @@ static inline struct gpio_bank *get_gpio_bank(int gpio)
 		return &gpio_bank[gpio >> 5];
 	if (cpu_is_omap34xx())
 		return &gpio_bank[gpio >> 5];
+	BUG();
+	return NULL;
 }
 
 static inline int get_gpio_index(int gpio)
@@ -448,6 +450,7 @@ void omap_set_gpio_debounce(int gpio, int enable)
 {
 	struct gpio_bank *bank;
 	void __iomem *reg;
+	unsigned long flags;
 	u32 val, l = 1 << get_gpio_index(gpio);
 
 	if (cpu_class_is_omap1())
@@ -455,21 +458,28 @@ void omap_set_gpio_debounce(int gpio, int enable)
 
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
 

