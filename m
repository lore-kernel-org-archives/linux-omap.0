From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 2/4] arm: omap: gpio: implement set_debounce method
Date: Wed, 31 Mar 2010 15:56:20 +0300
Message-ID: <20100331125620.GA16297@nokia.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270038435-28106-3-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32387 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932619Ab0CaM5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 08:57:34 -0400
Content-Disposition: inline
In-Reply-To: <1270038435-28106-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Mar 31, 2010 at 02:27:13PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
>OMAP support debouncing of gpio lines, implement
>the method using gpiolib.
>
>Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

this one was missing dbck handling. New version attached

-- 
balbi

--SLDf9lqlvOQaIe6s
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-arm-omap-gpio-implement-set_debounce-method.diff"

>From e37f49e1006abde377cf56604077fb20340cca0a Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Wed, 31 Mar 2010 15:17:29 +0300
Subject: [RFC/PATCH 2/4] arm: omap: gpio: implement set_debounce method

OMAP support debouncing of gpio lines, implement
the method using gpiolib.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/gpio.c |   51 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 76a347b..9df434e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -612,6 +612,43 @@ do {	\
 	__raw_writel(l, base + reg); \
 } while(0)
 
+static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio, int value)
+{
+	void __iomem		*reg = bank->base;
+	u32			val;
+	u32			l;
+
+	value &= 0xff;
+	l = 1 << get_gpio_index(gpio);
+
+	if (cpu_is_omap44xx())
+		reg += OMAP4_GPIO_DEBOUNCINGTIME;
+	else
+		reg += OMAP24XX_GPIO_DEBOUNCE_VAL;
+
+	__raw_writel(value, reg);
+
+	reg = bank->base;
+	if (cpu_is_omap44xx())
+		reg += OMAP4_GPIO_DEBOUNCENABLE;
+	else
+		reg += OMAP24XX_GPIO_DEBOUNCE_EN;
+
+	val = __raw_readl(reg);
+
+	if (value) {
+		val |= l;
+		if (cpu_is_omap34xx() || cpu_is_omap44xx())
+			clk_enable(bank->dbck);
+	} else {
+		val &= ~l;
+		if (cpu_is_omap34xx() || cpu_is_omap44xx())
+			clk_disable(bank->dbck);
+	}
+
+	__raw_writel(val, reg);
+}
+
 void omap_set_gpio_debounce(int gpio, int enable)
 {
 	struct gpio_bank *bank;
@@ -1608,6 +1645,19 @@ static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 	return 0;
 }
 
+static int gpio_debounce(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct gpio_bank *bank;
+	unsigned long flags;
+
+	bank = container_of(chip, struct gpio_bank, chip);
+	spin_lock_irqsave(&bank->lock, flags);
+	_set_gpio_debounce(bank, offset, value);
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
+}
+
 static void gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct gpio_bank *bank;
@@ -1860,6 +1910,7 @@ static int __init _omap_gpio_init(void)
 		bank->chip.direction_input = gpio_input;
 		bank->chip.get = gpio_get;
 		bank->chip.direction_output = gpio_output;
+		bank->chip.set_debounce = gpio_debounce;
 		bank->chip.set = gpio_set;
 		bank->chip.to_irq = gpio_2irq;
 		if (bank_is_mpuio(bank)) {
-- 
1.7.0.rc0.33.g7c3932


--SLDf9lqlvOQaIe6s--
