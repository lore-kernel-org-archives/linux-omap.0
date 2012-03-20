From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 RESEND 7/7] gpio/omap: fix redundant decoding of gpio offset
Date: Tue, 20 Mar 2012 16:23:19 +0530
Message-ID: <1332240799-6748-8-git-send-email-tarun.kanti@ti.com>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52150 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759668Ab2CTKxi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 06:53:38 -0400
In-Reply-To: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

In gpio_get(), _get_gpio_datain() and _get_gpio_dataout() get rid of
un-necessary operation to compute gpio mask. The gpio offset passed
to gpio_get() is sufficient to do that.

Here is Russell's original comment:
Can someone explain to me this:

static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
{
       void __iomem *reg = bank->base + bank->regs->datain;

       return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
}

static int gpio_get(struct gpio_chip *chip, unsigned offset)
{
       struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
       void __iomem *reg = bank->base;
       int gpio = chip->base + offset;
       u32 mask = GPIO_BIT(bank, gpio);

       if (gpio_is_input(bank, mask))
               return _get_gpio_datain(bank, gpio);
       else
               return _get_gpio_dataout(bank, gpio);
}

Given that bank->width on OMAP is either 32 or 16, and GPIO numbers for
any GPIO chip are always aligned to 32 or 16, why does this code bother
adding the chips base gpio number and then modulo the width?

Surely this means if - for argument sake - you registered a GPIO chip
with 8 lines followed by one with 16 lines, GPIO0..7 would be chip 0
bit 0..7, GPIO8..15 would be chip 1 bit 8..15, GPIO16..23 would be
chip 1 bit 0..7.

However, if you registered a GPIO chip with 16 lines first, it would
mean GPIO0..15 would be chip 0 bit 0..15, and GPIO16..31 would be
chip 1 bit 0..15.

Surely this kind of behaviour is not intended?

Is there a reason why the bitmask can't just be (1 << offset) where
offset is passed into these functions as GPIO number - chip->base ?

Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 6c17e58..1adc2ec 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -147,18 +147,18 @@ static void _set_gpio_dataout_mask(struct gpio_bank *bank, int gpio, int enable)
 	bank->context.dataout = l;
 }
 
-static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
+static int _get_gpio_datain(struct gpio_bank *bank, int offset)
 {
 	void __iomem *reg = bank->base + bank->regs->datain;
 
-	return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
+	return (__raw_readl(reg) & (1 << offset)) != 0;
 }
 
-static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
+static int _get_gpio_dataout(struct gpio_bank *bank, int offset)
 {
 	void __iomem *reg = bank->base + bank->regs->dataout;
 
-	return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
+	return (__raw_readl(reg) & (1 << offset)) != 0;
 }
 
 static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
@@ -865,19 +865,15 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
 static int gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
-	void __iomem *reg;
-	int gpio;
 	u32 mask;
 
-	gpio = chip->base + offset;
 	bank = container_of(chip, struct gpio_bank, chip);
-	reg = bank->base;
-	mask = GPIO_BIT(bank, gpio);
+	mask = (1 << offset);
 
 	if (gpio_is_input(bank, mask))
-		return _get_gpio_datain(bank, gpio);
+		return _get_gpio_datain(bank, offset);
 	else
-		return _get_gpio_dataout(bank, gpio);
+		return _get_gpio_dataout(bank, offset);
 }
 
 static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
-- 
1.7.0.4

